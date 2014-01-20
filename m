From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 0/4] `log -c` speedup
Date: Mon, 20 Jan 2014 20:20:37 +0400
Message-ID: <cover.1390234183.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 17:34:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Hnu-00036L-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 17:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbaATQeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 11:34:23 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60901 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbaATQeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 11:34:21 -0500
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2014 11:34:21 EST
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1W5HYu-0007VY-4p; Mon, 20 Jan 2014 20:18:56 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1W5Han-0001Ps-VT; Mon, 20 Jan 2014 20:20:54 +0400
X-Mailer: git-send-email 1.9.rc0.143.g6fd479e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240713>

Hello up there,

I'm using `git log --raw` to reconstruct file dates (readonly filesystem for
git archives) and, as it turned out, for --raw to emit diffs for merges we need
to explicitly activate combine-diff via -c.

The combined-diff turned out to be slow, I'm trying to optimize it. Please apply.

Thanks beforehand,
Kirill


Kirill Smelkov (4):
  diffcore-order: Export generic ordering interface
  diff test: Add tests for combine-diff with orderfile
  combine-diff: Optimize combine_diff_path sets intersection
  combine-diff: combine_diff_path.len is not needed anymore

 combine-diff.c        | 121 +++++++++++++++++++++++++++++++++-----------------
 diff-lib.c            |   2 -
 diff.h                |   1 -
 diffcore-order.c      |  53 ++++++++++++++--------
 diffcore.h            |  15 +++++++
 t/t4056-diff-order.sh |  21 +++++++++
 6 files changed, 151 insertions(+), 62 deletions(-)

-- 
1.9.rc0.143.g6fd479e
