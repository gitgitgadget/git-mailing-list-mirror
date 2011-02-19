From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] bump rename limit defaults (again)
Date: Sat, 19 Feb 2011 05:21:28 -0500
Message-ID: <20110219102128.GB22508@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 11:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqjwW-0003tS-3p
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 11:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab1BSKVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 05:21:32 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37592 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab1BSKVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 05:21:30 -0500
Received: (qmail 8640 invoked by uid 111); 19 Feb 2011 10:21:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 10:21:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 05:21:28 -0500
Content-Disposition: inline
In-Reply-To: <20110219101936.GB20577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167266>

We did this once before in 5070591 (bump rename limit
defaults, 2008-04-30). Back then, we were shooting for about
1 second for a diff/log calculation, and 5 seconds for a
merge.

There are a few new things to consider, though:

  1. Average processors are faster now.

  2. We've seen on the mailing list some ugly merges where
     not using inexact rename detection leads to many more
     conflicts. Merges of this size take a long time
     anyway, so users are probably happy to spend a little
     bit of time computing the renames.

Let's bump the diff/merge default limits from 200/500 to
400/1000. Those are 2 seconds and 10 seconds respectively on
my modern hardware.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c            |    2 +-
 merge-recursive.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 5422c43..869cca7 100644
--- a/diff.c
+++ b/diff.c
@@ -23,7 +23,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_rename_limit_default = 200;
+static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
diff --git a/merge-recursive.c b/merge-recursive.c
index 2ecd456..089aa10 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -439,7 +439,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
-			    500;
+			    1000;
 	opts.rename_score = o->rename_score;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
-- 
1.7.4.1.26.g5e991
