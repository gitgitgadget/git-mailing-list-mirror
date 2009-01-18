From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/2] move the color variables to color.c
Date: Sun, 18 Jan 2009 21:39:12 +0100
Message-ID: <200901182139.13995.markus.heidelberg@web.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net> <200901182137.16562.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 21:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOeQw-0001P0-MR
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 21:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbZARUi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbZARUi1
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 15:38:27 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:53828 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbZARUi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 15:38:26 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2E9B2FBEA112;
	Sun, 18 Jan 2009 21:38:25 +0100 (CET)
Received: from [89.59.120.98] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOePZ-0005uA-00; Sun, 18 Jan 2009 21:38:25 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200901182137.16562.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18qNLiaqlIwJQCSiaH7P7AAzoRqiLitUDkUVwLQ
	qKmYQA7OPG6qC2viWR55GTbfit79W08E6V4UbpvO/0ecZVRKra
	/AL9HzH19TZQOPqHR54A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106278>

To be consistent with where the branch color variable is located now,
move the variables for diff and status color to the same place.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 color.c     |    4 ++--
 color.h     |    2 ++
 diff.c      |    1 -
 diff.h      |    1 -
 wt-status.c |    1 -
 wt-status.h |    1 -
 6 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/color.c b/color.c
index 7a8bf6e..b23c39c 100644
--- a/color.c
+++ b/color.c
@@ -1,12 +1,12 @@
 #include "cache.h"
 #include "color.h"
-#include "diff.h"
-#include "wt-status.h"
 
 #define COLOR_RESET "\033[m"
 
 int git_use_color_default = 0;
 int branch_use_color = -1;
+int diff_use_color_default = -1;
+int wt_status_use_color = -1;
 
 static int parse_color(const char *name, int len)
 {
diff --git a/color.h b/color.h
index 6924848..3b47d99 100644
--- a/color.h
+++ b/color.h
@@ -10,6 +10,8 @@
 extern int git_use_color_default;
 
 extern int branch_use_color;
+extern int diff_use_color_default;
+extern int wt_status_use_color;
 
 /*
  * Use this instead of git_default_config if you need the value of color.ui.
diff --git a/diff.c b/diff.c
index d235482..4bd068c 100644
--- a/diff.c
+++ b/diff.c
@@ -22,7 +22,6 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 200;
 static int diff_suppress_blank_empty;
-int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
diff --git a/diff.h b/diff.h
index 4d5a327..f2c9984 100644
--- a/diff.h
+++ b/diff.h
@@ -188,7 +188,6 @@ extern void diff_unmerge(struct diff_options *,
 
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
-extern int diff_use_color_default;
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern int diff_setup_done(struct diff_options *);
diff --git a/wt-status.c b/wt-status.c
index 96ff2f8..5c3742b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -12,7 +12,6 @@
 #include "remote.h"
 
 int wt_status_relative_paths = 1;
-int wt_status_use_color = -1;
 int wt_status_submodule_summary;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
diff --git a/wt-status.h b/wt-status.h
index 78add09..6258fd0 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -36,7 +36,6 @@ struct wt_status {
 };
 
 int git_status_config(const char *var, const char *value, void *cb);
-extern int wt_status_use_color;
 extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-- 
1.6.1.208.g3a5f4
