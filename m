From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/6] Improve "git log --graph" output of merges
Date: Thu,  7 Feb 2013 20:15:22 +0000
Message-ID: <cover.1360267849.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 21:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Y0W-0001X8-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179Ab3BGUXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:23:10 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:37246 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759357Ab3BGUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:23:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4C6CB161E336;
	Thu,  7 Feb 2013 20:15:25 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiKkOHvhz3w8; Thu,  7 Feb 2013 20:15:24 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id AA8CD161E2AE;
	Thu,  7 Feb 2013 20:15:19 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215725>

This series changes a couple of places that do not currently indent
their output when being shown with a graph.

The first patch was already posted [1] and addresses the output of "git
log --graph -c -p".  Patch 2 is an independent fix I noticed while
working on the later patches.

Patches 3-5 introduce a helper function and change existing sites using
diff_options->output_prefix to use it, resulting in a net reduction by
about 60 lines.  There is no functional change here.

The final patch uses the helper introduced in patch 4 to make combined
diffs should the output prefix before each line.  This affects the
output of "git log --graph --cc [-p|--raw]".

[1] http://article.gmane.org/gmane.comp.version-control.git/215630

John Keeping (6):
  graph: output padding for merge subsequent parents
  diff: write prefix to the correct file
  diff.c: make constant string arguments const
  diff: add diff_line_prefix function
  diff.c: use diff_line_prefix() where applicable
  combine-diff.c: teach combined diffs about line prefix

 combine-diff.c |  47 +++++++++++++--------
 diff.c         | 131 +++++++++++++++------------------------------------------
 diff.h         |   3 ++
 graph.c        |  10 +++++
 4 files changed, 77 insertions(+), 114 deletions(-)

-- 
1.8.1.2
