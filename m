From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] bump rename limit defaults
Date: Wed, 30 Apr 2008 13:24:43 -0400
Message-ID: <20080430172443.GB23747@sigill.intra.peff.net>
References: <20080430172136.GA22601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:25:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrG3g-0004P4-M5
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130AbYD3RYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758125AbYD3RYp
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:24:45 -0400
Received: from peff.net ([208.65.91.99]:3521 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758070AbYD3RYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:24:44 -0400
Received: (qmail 27981 invoked by uid 111); 30 Apr 2008 17:24:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 13:24:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 13:24:43 -0400
Content-Disposition: inline
In-Reply-To: <20080430172136.GA22601@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80855>

The current rename limit default of 100 was arbitrarily
chosen. Testing[1] has shown that on modern hardware, a
limit of 200 adds about a second of computation time, and a
limit of 500 adds about 5 seconds of computation time.

This patch bumps the default limit to 200 for viewing diffs,
and to 500 for performing a merge. The limit for generating
git-status templates is set independently; we bump it up to
200 here, as well, to match the diff limit.

[1]: See <20080211113516.GB6344@coredump.intra.peff.net>

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-merge-recursive.c |    2 +-
 diff.c                    |    2 +-
 wt-status.c               |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 1293e3d..3902e91 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -364,7 +364,7 @@ static struct path_list *get_renames(struct tree *tree,
 	opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = merge_rename_limit >= 0 ? merge_rename_limit :
 			    diff_rename_limit >= 0 ? diff_rename_limit :
-			    100;
+			    500;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
diff --git a/diff.c b/diff.c
index 3632b55..f735519 100644
--- a/diff.c
+++ b/diff.c
@@ -19,7 +19,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_rename_limit_default = 100;
+static int diff_rename_limit_default = 200;
 int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
diff --git a/wt-status.c b/wt-status.c
index 532b4ea..a44c543 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -206,7 +206,7 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
-	rev.diffopt.rename_limit = 100;
+	rev.diffopt.rename_limit = 200;
 	rev.diffopt.break_opt = 0;
 	run_diff_index(&rev, 1);
 }
-- 
1.5.5.1.177.g8182d.dirty
