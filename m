From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 9/9 v6] difftool: print list of valid tools with '--tool-help'
Date: Thu, 22 Mar 2012 15:52:24 -0400
Message-ID: <1332445944-10944-10-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:54:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo5R-0005yN-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385Ab2CVTyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:54:12 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35572 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030360Ab2CVTyK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:54:10 -0400
Received: by mail-qa0-f46.google.com with SMTP id b19so544975qae.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i1vx1MCDUxzwfd4ygpVtmfSdIG2zqV9WmP9ei1/k/Sk=;
        b=guvYhSblyD1A7y/Yf7GZvMhVhnuY8QTTLM55VwRpEeNmDvvSfaamxx5YY+RUDhEuQb
         swqEBV4eSgMEDEcNzzAqk871LqtIneaplhOTdNfcuJpJ1g9QD64At52+prADvKlHW54V
         KCUc39RXDNjj3WjDFsfz6K3R7ro5+kd+mWtN1XZPw/TNoRsGIYGIoFtgflj7VIzH/Quc
         hUfJ8X6WP8eW7jT3kITKsWL71hQ8AFXLaNTFnHoMtBdMMXcPDwFqqxdi0D9AhFoM0cPY
         od7+p4kuqMAKRSIgIt3drt1kF1HG5uP4K/MA/Hua8w/5OWv07kTTzkvWdz84H5UwFe75
         1DRg==
Received: by 10.229.135.145 with SMTP id n17mr3624924qct.105.1332446049963;
        Thu, 22 Mar 2012 12:54:09 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id f12sm10030779qan.1.2012.03.22.12.54.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:54:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193708>

Since bc7a96a (mergetool--lib: Refactor tools into separate files,
2011-08-18), it is possible to add a new diff tool by creating a simple
script in the '$(git --exec-path)/mergetools' directory.  Updating the
difftool help text is still a manual process, and the documentation can
easily go out of sync.

Teach the command to read the list of valid tools from the 'mergetools'
directory and print them for the user when the '--tool-help' option is
given.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v6:
  - Squashed "added test for difftool --tool-help" into this commit.


 Documentation/git-difftool.txt |   11 ++++++-----
 git-difftool.perl              |   16 +++++++++++++---
 t/t7800-difftool.sh            |    5 +++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index aba5e76..31fc2e3 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -36,11 +36,9 @@ OPTIONS
 
 -t <tool>::
 --tool=<tool>::
-	Use the diff tool specified by <tool>.
-	Valid diff tools are:
-	araxis, bc3, deltawalker, diffuse, emerge, ecmerge, gvimdiff,
-	kdiff3,	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and
-	xxdiff.
+	Use the diff tool specified by <tool>.  Valid values include
+	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
+	for the list of valid <tool> settings.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
@@ -68,6 +66,9 @@ of the diff post-image.  `$MERGED` is the name of the file which is
 being compared. `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$MERGED`.
 
+--tool-help::
+	Print a list of diff tools that may be used with `--tool`.
+
 -x <command>::
 --extcmd=<command>::
 	Specify a custom command for viewing diffs.
diff --git a/git-difftool.perl b/git-difftool.perl
index 0fa131c..d9be7d6 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -14,7 +14,7 @@
 use 5.008;
 use strict;
 use warnings;
-use File::Basename qw(dirname);
+use File::Basename qw(dirname basename);
 use File::Copy;
 use File::stat;
 use File::Path qw(mkpath);
@@ -28,7 +28,7 @@ sub usage
 {
 	my $exitcode = shift;
 	print << 'USAGE';
-usage: git difftool [-t|--tool=<tool>]
+usage: git difftool [-t|--tool=<tool>] [--tool-help]
                     [-x|--extcmd=<cmd>]
                     [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
@@ -132,18 +132,28 @@ sub setup_dir_diff
 
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
-my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt);
+my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
 GetOptions('g|gui!' => \$gui,
 	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
 	'prompt!' => \$prompt,
 	'y' => sub { $prompt = 0; },
 	't|tool:s' => \$difftool_cmd,
+	'tool-help' => \$tool_help,
 	'x|extcmd:s' => \$extcmd);
 
 if (defined($help)) {
 	usage(0);
 } 
+if (defined($tool_help)) {
+	my $gitpath = Git::exec_path();
+	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
+	for (glob "$gitpath/mergetools/*") {
+		next if /defaults$/;
+		print "\t" . basename($_) . "\n";
+	}
+	exit(0);
+}
 if (defined($difftool_cmd)) {
 	if (length($difftool_cmd) > 0) {
 		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 478c1be..bbe71e5 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -319,6 +319,11 @@ test_expect_success PERL 'say no to the second file' '
 	echo "$diff" | stdin_doesnot_contain br2
 '
 
+test_expect_success PERL 'difftool --tool-help' '
+	tool_help=$(git difftool --tool-help) &&
+	echo "$tool_help" | stdin_contains tool
+'
+
 test_expect_success PERL 'setup change in subdirectory' '
 	git checkout master &&
 	mkdir sub &&
-- 
1.7.10.rc1.36.g15e879
