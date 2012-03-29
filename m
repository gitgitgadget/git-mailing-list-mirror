From: Victor Engmark <victor.engmark@gmail.com>
Subject: [PATCH] Add diff.minimal configuration setting
Date: Thu, 29 Mar 2012 22:26:48 +0200
Message-ID: <20120329202648.GA27318@l0b0x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 29 22:27:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDLvz-0001pK-1i
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 22:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759536Ab2C2U0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 16:26:55 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64353 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759367Ab2C2U0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 16:26:54 -0400
Received: by wejx9 with SMTP id x9so1257154wej.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=L6T8Dy46IgYJMxtp/7HQbEqh4dSKDWHg+RMGjxRqmYQ=;
        b=FNdQloFwyWN9pywIJ1fA7PyP/Qep082ESR8QCsvuZH7r0pYQCYmjzjSKnO3rzclNnJ
         I3C8eXF8tEOwupl/5Zo/jAN3VtIEynf9FJ0CidV/TarbUppvl5sodehl6RLM7qJArGY9
         fFTkE8WTU0kfT4NMQSl1d3RPdNEs1shzyJ0Es71DBHcmYfyoiTh8oZRz9WO0mQxLedMF
         MZLOjz3rKbal9EfVcR2yJHxDCd5bN4p1awwxdQ1LsRQ/bpRrmSnWvak+rGOtkNiRITnB
         4Q3TLdGAHbwGRA9flovmdFZ1R5Zt/HXTgEnBTZEE5ezmukxn29sZv17gOoH9xqfRPVWD
         4Ccw==
Received: by 10.180.24.66 with SMTP id s2mr9065942wif.7.1333052813307;
        Thu, 29 Mar 2012 13:26:53 -0700 (PDT)
Received: from l0b0x (131-164.62-188.cust.bluewin.ch. [188.62.164.131])
        by mx.google.com with ESMTPS id fz9sm69852254wib.3.2012.03.29.13.26.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 13:26:52 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194291>

Complements the --minimal and --no-minimal options.

Signed-off-by: Victor Engmark <victor.engmark@gmail.com>
---

Follow-up from 8762g7u60j.fsf@thomas.inf.ethz.ch, for those with small
projects or cycles to spare. Since I couldn't `find t -iname
'*minimal*'`, I'm a bit at a loss for how to test this - Does anyone
have a test diff that will for sure show up differently with
--minimal?

Cheers,
V

 Documentation/diff-config.txt          |    4 ++++
 Documentation/diff-options.txt         |    4 +++-
 contrib/completion/git-completion.bash |    1 +
 diff.c                                 |    6 ++++++
 diff.h                                 |    1 +
 5 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6aa1be0..6fcc070 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -71,6 +71,10 @@ diff.ignoreSubmodules::
 	commands such as 'git diff-files'. 'git checkout' also honors
 	this setting when reporting uncommitted changes.
 
+diff.minimal::
+	If set, 'git diff' spends extra time to make sure the smallest
+	possible diff is produced.
+
 diff.mnemonicprefix::
 	If set, 'git diff' uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 378f19f..879e2fd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -47,7 +47,9 @@ endif::git-format-patch[]
 
 --minimal::
 	Spend extra time to make sure the smallest possible
-	diff is produced.
+	diff is produced. The default is controlled by the
+	`diff.minimal` configuration variable (see
+	linkgit:git-config[1]).
 
 --patience::
 	Generate a diff using the "patience diff" algorithm.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..33ff2f4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2096,6 +2096,7 @@ _git_config ()
 		diff.statGraphWidth
 		diff.external
 		diff.ignoreSubmodules
+		diff.minimal
 		diff.mnemonicprefix
 		diff.noprefix
 		diff.renameLimit
diff --git a/diff.c b/diff.c
index 377ec1e..e3add82 100644
--- a/diff.c
+++ b/diff.c
@@ -29,6 +29,7 @@ int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
+static int diff_minimal;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
 static int diff_stat_graph_width;
@@ -157,6 +158,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_no_prefix = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.minimal")) {
+		diff_minimal = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.statgraphwidth")) {
 		diff_stat_graph_width = git_config_int(var, value);
 		return 0;
@@ -3141,6 +3146,7 @@ void diff_setup(struct diff_options *options)
 	options->add_remove = diff_addremove;
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
+	options->minimal = diff_minimal;
 
 	if (diff_no_prefix) {
 		options->a_prefix = options->b_prefix = "";
diff --git a/diff.h b/diff.h
index cb68743..9bc67a8 100644
--- a/diff.h
+++ b/diff.h
@@ -118,6 +118,7 @@ struct diff_options {
 	int rename_score;
 	int rename_limit;
 	int needed_rename_limit;
+	int minimal;
 	int degraded_cc_to_c;
 	int show_rename_progress;
 	int dirstat_permille;
-- 
1.7.5.4
