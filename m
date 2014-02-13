From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 0/2] Multiparent diff tree-walker + combine-diff speedup
Date: Thu, 13 Feb 2014 18:02:53 +0400
Message-ID: <cover.1392299516.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 15:01:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDwrG-0005w8-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 15:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbaBMOBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 09:01:21 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:38025 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbaBMOBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 09:01:20 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WDwqp-0000pw-MY; Thu, 13 Feb 2014 18:01:15 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WDwsZ-0001Dv-Rv; Thu, 13 Feb 2014 18:03:03 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242062>

Here go combine-diff speedup patches in form of first reworking diff
tree-walker to work in general case - when a commit have several parents, not
only one - we are traversing all 1+nparent trees in parallel.

Then we are taking advantage of the new diff tree-walker for speeding up
combine-diff, which for linux.git results in ~14 times speedup.

I understand v1.9.0 is going to be released first, but wanted to finally send
the patches, so that people could start reviewing them.

Please apply on top of ks/tree-diff-more and thanks beforehand,

Kirill



Kirill Smelkov (2):
  tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
  combine-diff: speed it up, by using multiparent diff tree-walker directly

 combine-diff.c |  85 +++++++++-
 diff.c         |   2 +
 diff.h         |  10 ++
 tree-diff.c    | 501 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 529 insertions(+), 69 deletions(-)

-- 
1.9.rc1.181.g641f458
