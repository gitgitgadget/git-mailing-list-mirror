From: Jeff Muizelaar <jmuizelaar@mozilla.com>
Subject: [PATCH] Add diff.context option to specify default context
Date: Fri, 14 Sep 2012 14:16:03 -0400
Message-ID: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/mixed; boundary=Apple-Mail-4--27823757
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 20:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCaaL-0000f1-0k
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 20:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab2INSZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 14:25:40 -0400
Received: from mx2.corp.phx1.mozilla.com ([63.245.216.70]:57180 "EHLO
	smtp.mozilla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2INSZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 14:25:40 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2012 14:25:40 EDT
Received: from [10.242.28.29] (unknown [66.207.208.98])
	(Authenticated sender: jmuizelaar@mozilla.com)
	by mx2.mail.corp.phx1.mozilla.com (Postfix) with ESMTPSA id DFD3EF260D
	for <git@vger.kernel.org>; Fri, 14 Sep 2012 11:16:04 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205524>


--Apple-Mail-4--27823757
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

This adds a diff.context config option to allow specifying
the number of lines of context. This is similar to Mercurial's
'unified' option.


--Apple-Mail-4--27823757
Content-Disposition: attachment;
	filename=add-context-option
Content-Type: application/octet-stream;
	name="add-context-option"
Content-Transfer-Encoding: 7bit

commit 1bd81c75de6824c39852bc8516acd0733737ed83
Author: Jeff Muizelaar <jmuizelaar@mozilla.com>
Date:   Fri Sep 14 13:55:02 2012 -0400

    [PATCH] Add diff.context option to specify default context
    
    This adds a diff.context config option to allow specifying
    the number of lines of context. This is similar to Mercurial's
    'unified' option.

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 67a90a8..028ff14 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -56,6 +56,10 @@ diff.statGraphWidth::
 	Limit the width of the graph part in --stat output. If set, applies
 	to all commands generating --stat output except format-patch.
 
+diff.context::
+	Generate diffs with <n> lines of context instead of the default of
+	3.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/diff.c b/diff.c
index e6846ca..b5cd8be 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@ static int diff_detect_rename_default;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
+int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
@@ -141,6 +142,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.context")) {
+		diff_context_default = git_config_int(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.renames")) {
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
@@ -3172,7 +3177,7 @@ void diff_setup(struct diff_options *options)
 	options->break_opt = -1;
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
-	options->context = 3;
+	options->context = diff_context_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
 
 	options->change = diff_change;

--Apple-Mail-4--27823757--
