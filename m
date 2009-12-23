From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 2/2] git-difftool: Add '--gui' for selecting a GUI tool
Date: Tue, 22 Dec 2009 21:27:14 -0800
Message-ID: <1261546034-7780-2-git-send-email-davvid@gmail.com>
References: <1261546034-7780-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 06:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNJlD-0007IQ-0t
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 06:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbZLWF1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 00:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbZLWF1c
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 00:27:32 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:59476 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZLWF1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 00:27:31 -0500
Received: by mail-yw0-f182.google.com with SMTP id 12so7511788ywh.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 21:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CCgiARisP+h9b4YAWFb069iS1s1FQ2+fwKzzjOQgG+g=;
        b=tjiWv/VQngxM5SW/GWAvyODgWs4Ro7fxA1nabmm6LZHznPZ5Ta7UuLhhQPMgRITbvp
         qwnekxxHArmvhPeYbjGQOfqLL2dLpVzQPouI4BBizGus8E3XAqcQBCwM+A8fYSKsqEiI
         muwqgDl4+TPT3nqg9Kz3UfBmFhA/Stzo06xiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jkW8op3Ns33gIUrqszlMJrWPEOW81D7sAiM3zMsYPLxKk+HZhDmLYz+Iyj6kJyGWZV
         ls7qmzvw5SXKlwS3VLz2bsv5sTBNDOkPTI4L82kT/HdjTznRKo2YCGp6iHVQZseHDG8x
         pbeOIzc3eac9fz3GKq0HWMkrC0GZLKA4hnbTY=
Received: by 10.150.48.40 with SMTP id v40mr14951938ybv.142.1261546050204;
        Tue, 22 Dec 2009 21:27:30 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 34sm3115332yxf.47.2009.12.22.21.27.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Dec 2009 21:27:29 -0800 (PST)
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1261546034-7780-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135612>

Users might prefer to have git-difftool use a different
tool when run from a Git GUI.

This teaches git-difftool to honor 'diff.guitool' when
the '--gui' option is specified.  This allows users to
configure their preferred command-line diff tool in
'diff.tool' and a GUI diff tool in 'diff.guitool'.

Reference: http://article.gmane.org/gmane.comp.version-control.git/133386
Signed-off-by: David Aguilar <davvid@gmail.com>
---

This is an RFC patch for a number of reasons.

* We're in RC freeze
* This introduces a new 'diff.guitool' variable.
  I don't know if the name of the variable is desirable as-is.

So, I figured it's best to mark it as an RFC for now.

 Documentation/git-difftool.txt |    9 +++++++++
 git-difftool.perl              |   13 ++++++++++++-
 t/t7800-difftool.sh            |   12 ++++++++++++
 3 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 8e9aed6..a5bce62 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -58,6 +58,12 @@ is set to the name of the temporary file containing the contents
 of the diff post-image.  `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$LOCAL`.
 
+-g::
+--gui::
+	When 'git-difftool' is invoked with the `-g` or `--gui` option
+	the default diff tool will be read from the configured
+	`diff.guitool` variable instead of `diff.tool`.
+
 See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIG VARIABLES
@@ -68,6 +74,9 @@ difftool equivalents have not been defined.
 diff.tool::
 	The default diff tool to use.
 
+diff.guitool::
+	The default diff tool to use when `--gui` is specified.
+
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
diff --git a/git-difftool.perl b/git-difftool.perl
index ba5e60a..8c836e4 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -15,13 +15,16 @@ use warnings;
 use Cwd qw(abs_path);
 use File::Basename qw(dirname);
 
+require Git;
+
 my $DIR = abs_path(dirname($0));
 
 
 sub usage
 {
 	print << 'USAGE';
-usage: git difftool [--tool=<tool>] [-y|--no-prompt] ["git diff" options]
+usage: git difftool [-g|--gui] [-t|--tool=<tool>] [-y|--no-prompt]
+                    ["git diff" options]
 USAGE
 	exit 1;
 }
@@ -63,6 +66,14 @@ sub generate_command
 			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
 			next;
 		}
+		if ($arg eq '-g' || $arg eq '--gui') {
+			my $tool = Git::command_oneline('config',
+			                                'diff.guitool');
+			if (length($tool)) {
+				$ENV{GIT_DIFF_TOOL} = $tool;
+			}
+			next;
+		}
 		if ($arg eq '-y' || $arg eq '--no-prompt') {
 			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
 			delete $ENV{GIT_DIFFTOOL_PROMPT};
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 707a0f5..9bf6c98 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -19,6 +19,7 @@ remove_config_vars()
 {
 	# Unset all config variables used by git-difftool
 	git config --unset diff.tool
+	git config --unset diff.guitool
 	git config --unset difftool.test-tool.cmd
 	git config --unset difftool.prompt
 	git config --unset merge.tool
@@ -77,6 +78,17 @@ test_expect_success 'difftool ignores bad --tool values' '
 	test "$diff" = ""
 '
 
+test_expect_success 'difftool honors --gui' '
+	git config merge.tool bogus-tool &&
+	git config diff.tool bogus-tool &&
+	git config diff.guitool test-tool &&
+
+	diff=$(git difftool --no-prompt --gui branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success 'GIT_DIFF_TOOL variable' '
 	git config --unset diff.tool
-- 
1.6.2.5
