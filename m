From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 2/3] git-svn info: implement info command
Date: Tue, 20 Nov 2007 22:43:18 -0800
Message-ID: <1195627399-25209-3-git-send-email-ddkilzer@kilzer.net>
References: <20071117225402.GC28755@muzzle>
 <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net>
 <1195627399-25209-2-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujJG-0003I2-2I
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbXKUGn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbXKUGnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:43:25 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:55947 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbXKUGnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:43:21 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id C54A019CCE02;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id A558928057;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
X-AuditID: 1180711d-9dab8bb0000008bf-d8-4743d3887fe2
Received: from localhost.localdomain (unknown [17.151.112.145])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 2FF0B2804F;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1195627399-25209-2-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65597>

Implement "git-svn info" for files and directories based on the
"svn info" command.  Note that the -r/--revision argument is not
supported yet.

Added 18 tests in t/t9117-git-svn-info.sh.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 Documentation/git-svn.txt                       |    5 +
 git-svn.perl                                    |  132 ++++++++++++++++
 t/t9117-git-svn-info.sh                         |  186 +++++++++++++++++++++++
 t/t9117/expected.info-added-directory           |    7 +
 t/t9117/expected.info-added-file                |    8 +
 t/t9117/expected.info-added-symlink-directory   |    8 +
 t/t9117/expected.info-added-symlink-file        |    8 +
 t/t9117/expected.info-deleted-directory         |   11 ++
 t/t9117/expected.info-deleted-file              |   14 ++
 t/t9117/expected.info-deleted-symlink-directory |   14 ++
 t/t9117/expected.info-deleted-symlink-file      |   14 ++
 t/t9117/expected.info-directory                 |   11 ++
 t/t9117/expected.info-dot                       |   11 ++
 t/t9117/expected.info-file                      |   14 ++
 t/t9117/expected.info-no-arguments              |   11 ++
 t/t9117/expected.info-symlink-directory         |   14 ++
 t/t9117/expected.info-symlink-file              |   14 ++
 t/t9117/expected.info-unknown-directory         |    2 +
 t/t9117/expected.info-unknown-file              |    2 +
 t/t9117/expected.info-unknown-symlink-directory |    2 +
 t/t9117/expected.info-unknown-symlink-file      |    2 +
 t/t9117/regenerate.sh                           |  186 +++++++++++++++++++++++
 22 files changed, 676 insertions(+), 0 deletions(-)
 create mode 100644 t/t9117-git-svn-info.sh
 create mode 100644 t/t9117/expected.info-added-directory
 create mode 100644 t/t9117/expected.info-added-file
 create mode 100644 t/t9117/expected.info-added-symlink-directory
 create mode 100644 t/t9117/expected.info-added-symlink-file
 create mode 100644 t/t9117/expected.info-deleted-directory
 create mode 100644 t/t9117/expected.info-deleted-file
 create mode 100644 t/t9117/expected.info-deleted-symlink-directory
 create mode 100644 t/t9117/expected.info-deleted-symlink-file
 create mode 100644 t/t9117/expected.info-directory
 create mode 100644 t/t9117/expected.info-dot
 create mode 100644 t/t9117/expected.info-file
 create mode 100644 t/t9117/expected.info-no-arguments
 create mode 100644 t/t9117/expected.info-symlink-directory
 create mode 100644 t/t9117/expected.info-symlink-file
 create mode 100644 t/t9117/expected.info-unknown-directory
 create mode 100644 t/t9117/expected.info-unknown-file
 create mode 100644 t/t9117/expected.info-unknown-symlink-directory
 create mode 100644 t/t9117/expected.info-unknown-symlink-file
 create mode 100755 t/t9117/regenerate.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 488e4b1..c3fc878 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -193,6 +193,11 @@ Any other arguments are passed directly to `git log'
 	repository (that has been init-ed with git-svn).
 	The -r<revision> option is required for this.
 
+'info'::
+	Shows information about a file or directory similar to what
+	`svn info' provides.  Does not currently support a -r/--revision
+	argument.
+
 --
 
 OPTIONS
diff --git a/git-svn.perl b/git-svn.perl
index aff429a..406ee6f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -178,6 +178,10 @@ my %cmd = (
 			  'file|F=s' => \$_file,
 			  'revision|r=s' => \$_revision,
 			%cmt_opts } ],
+	'info' => [ \&cmd_info,
+		    "Show info about the latest SVN revision
+		     on the current branch",
+		    { } ],
 );
 
 my $cmd;
@@ -583,12 +587,18 @@ sub cmd_create_ignore {
 
 sub canonicalize_path {
 	my ($path) = @_;
+	my $dot_slash_added = 0;
+	if (substr($path, 0, 1) ne "/") {
+		$path = "./" . $path;
+		$dot_slash_added = 1;
+	}
 	# File::Spec->canonpath doesn't collapse x/../y into y (for a
 	# good reason), so let's do this manually.
 	$path =~ s#/+#/#g;
 	$path =~ s#/\.(?:/|$)#/#g;
 	$path =~ s#/[^/]+/\.\.##g;
 	$path =~ s#/$##g;
+	$path =~ s#^\./## if $dot_slash_added;
 	return $path;
 }
 
@@ -740,6 +750,104 @@ sub cmd_commit_diff {
 	}
 }
 
+sub cmd_info {
+	my $path = canonicalize_path(shift or ".");
+	unless (scalar(@_) == 0) {
+		die "Too many arguments specified\n";
+	}
+
+	my ($file_type, $diff_status) = find_file_type_and_diff_status($path);
+
+	if (!$file_type && !$diff_status) {
+		print STDERR "$path:  (Not a versioned resource)\n\n";
+		return;
+	}
+
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	unless ($gs) {
+		die "Unable to determine upstream SVN information from ",
+		    "working tree history\n";
+	}
+	my $full_url = $url . ($path eq "." ? "" : "/$path");
+
+	my $result = "Path: $path\n";
+	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
+	$result .= "URL: " . $full_url . "\n";
+
+	my $repos_root = $gs->ra->{repos_root};
+	Git::SVN::remove_username($repos_root);
+	$result .= "Repository Root: $repos_root\n";
+	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A";
+	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
+
+	$result .= "Node Kind: " .
+		   ($file_type eq "dir" ? "directory" : "file") . "\n";
+
+	my $schedule = $diff_status eq "A"
+		       ? "add"
+		       : ($diff_status eq "D" ? "delete" : "normal");
+	$result .= "Schedule: $schedule\n";
+
+	if ($diff_status eq "A") {
+		print $result, "\n";
+		return;
+	}
+
+	my ($lc_author, $lc_rev, $lc_date_utc);
+	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $path);
+	my $log = command_output_pipe(@args);
+	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
+	while (<$log>) {
+		if (/^${esc_color}author (.+) <[^>]+> (\d+) ([\-\+]?\d+)$/o) {
+			$lc_author = $1;
+			$lc_date_utc = Git::SVN::Log::parse_git_date($2, $3);
+		} elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
+			(undef, $lc_rev, undef) = ::extract_metadata($1);
+		}
+	}
+	close $log;
+
+	Git::SVN::Log::set_local_timezone();
+
+	$result .= "Last Changed Author: $lc_author\n";
+	$result .= "Last Changed Rev: $lc_rev\n";
+	$result .= "Last Changed Date: " .
+		   Git::SVN::Log::format_svn_date($lc_date_utc) . "\n";
+
+	if ($file_type ne "dir") {
+		my $text_last_updated_date =
+		    ($diff_status eq "D" ? $lc_date_utc : (stat $path)[9]);
+		$result .=
+		    "Text Last Updated: " .
+		    Git::SVN::Log::format_svn_date($text_last_updated_date) .
+		    "\n";
+		my $checksum;
+		if ($diff_status eq "D") {
+			my ($fh, $ctx) =
+			    command_output_pipe(qw(cat-file blob), "HEAD:$path");
+			if ($file_type eq "link") {
+				my $file_name = <$fh>;
+				$checksum = Git::SVN::Util::md5sum("link $file_name");
+			} else {
+				$checksum = Git::SVN::Util::md5sum($fh);
+			}
+			command_close_pipe($fh, $ctx);
+		} elsif ($file_type eq "link") {
+			my $file_name =
+			    command(qw(cat-file blob), "HEAD:$path");
+			$checksum =
+			    Git::SVN::Util::md5sum("link " . $file_name);
+		} else {
+			open FILE, "<", $path or die $!;
+			$checksum = Git::SVN::Util::md5sum(\*FILE);
+			close FILE or die $!;
+		}
+		$result .= "Checksum: " . $checksum . "\n";
+	}
+
+	print $result, "\n";
+}
+
 ########################### utility functions #########################
 
 sub rebase_cmd {
@@ -1047,6 +1155,30 @@ sub linearize_history {
 	(\@linear_refs, \%parents);
 }
 
+sub find_file_type_and_diff_status {
+	my ($path) = @_;
+
+	my $diff_output =
+	    command_oneline(qw(diff --cached --name-status --), $path) || "";
+	my $diff_status = (split(' ', $diff_output))[0] || "";
+
+	my $ls_tree = command_oneline(qw(ls-tree HEAD), $path) || "";
+
+	return (undef, undef) if !$diff_status && !$ls_tree;
+
+	if ($diff_status eq "A") {
+		return ("link", $diff_status) if -l $path;
+		return ("dir", $diff_status) if -d $path;
+		return ("file", $diff_status);
+	}
+
+	my $mode = (split(' ', $ls_tree))[0] || "";
+
+	return ("link", $diff_status) if $mode eq "120000";
+	return ("dir", $diff_status) if $mode eq "040000";
+	return ("file", $diff_status);
+}
+
 package Git::SVN::Util;
 use strict;
 use warnings;
diff --git a/t/t9117-git-svn-info.sh b/t/t9117-git-svn-info.sh
new file mode 100644
index 0000000..c7ca006
--- /dev/null
+++ b/t/t9117-git-svn-info.sh
@@ -0,0 +1,186 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 David D. Kilzer
+
+test_description='git-svn info'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup repository and import' "
+	mkdir info &&
+	cd info &&
+		echo one > file &&
+		ln -s file symlink-file &&
+		mkdir directory &&
+		touch directory/.placeholder &&
+		ln -s directory symlink-directory &&
+		svn import -m 'initial' . $svnrepo &&
+	cd .. &&
+	mkdir gitwc &&
+	cd gitwc &&
+		git-svn init $svnrepo &&
+		git-svn fetch &&
+	cd ..
+	"
+
+test_expect_success 'info no arguments' "
+	(cd gitwc; git-svn info) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' |
+	git-diff ../t9117/expected.info-no-arguments -
+	"
+
+test_expect_success 'info dot' "
+	(cd gitwc; git-svn info .) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' |
+	git-diff ../t9117/expected.info-dot -
+	"
+
+test_expect_success 'info file' "
+	(cd gitwc; git-svn info file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' |
+	git-diff ../t9117/expected.info-file -
+	"
+
+test_expect_success 'info directory' "
+	(cd gitwc; git-svn info directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' |
+	git-diff ../t9117/expected.info-directory -
+	"
+
+test_expect_success 'info symlink-file' "
+	(cd gitwc; git-svn info symlink-file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' |
+	git-diff ../t9117/expected.info-symlink-file -
+	"
+
+test_expect_success 'info symlink-directory' "
+	(cd gitwc; git-svn info symlink-directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' |
+	git-diff ../t9117/expected.info-symlink-directory -
+	"
+
+test_expect_success 'info added-file' "
+	echo two > gitwc/added-file &&
+	cd gitwc &&
+		git add added-file &&
+	cd .. &&
+	(cd gitwc; git-svn info added-file) |
+	git-diff ../t9117/expected.info-added-file -
+	"
+
+test_expect_success 'info added-directory' "
+	mkdir gitwc/added-directory &&
+        touch gitwc/added-directory/.placeholder &&
+	cd gitwc &&
+		git add added-directory &&
+	cd .. &&
+	(cd gitwc; git-svn info added-directory) |
+	git-diff ../t9117/expected.info-added-directory -
+	"
+
+test_expect_success 'info added-symlink-file' "
+	cd gitwc &&
+		ln -s added-file added-symlink-file &&
+		git add added-symlink-file &&
+	cd .. &&
+	(cd gitwc; git-svn info added-symlink-file) |
+	git-diff ../t9117/expected.info-added-symlink-file -
+	"
+
+test_expect_success 'info added-symlink-directory' "
+	cd gitwc &&
+		ln -s added-directory added-symlink-directory &&
+		git add added-symlink-directory &&
+	cd .. &&
+	(cd gitwc; git-svn info added-symlink-directory) |
+	git-diff ../t9117/expected.info-added-symlink-directory -
+	"
+
+test_expect_success 'info deleted-file' "
+	cd gitwc &&
+		git rm -f file > /dev/null &&
+	cd .. &&
+	(cd gitwc; git-svn info file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' |
+	git-diff ../t9117/expected.info-deleted-file -
+	"
+
+test_expect_success 'info deleted-directory' "
+	cd gitwc &&
+		git rm -r -f directory > /dev/null &&
+	cd .. &&
+	(cd gitwc; git-svn info directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' |
+	git-diff ../t9117/expected.info-deleted-directory -
+	"
+
+test_expect_success 'info deleted-symlink-file' "
+	cd gitwc &&
+		git rm -f symlink-file > /dev/null &&
+	cd .. &&
+	(cd gitwc; git-svn info symlink-file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' |
+	git-diff ../t9117/expected.info-deleted-symlink-file -
+	"
+
+test_expect_success 'info deleted-symlink-directory' "
+	cd gitwc &&
+		git rm -f symlink-directory > /dev/null &&
+	cd .. &&
+	(cd gitwc; git-svn info symlink-directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' |
+	git-diff ../t9117/expected.info-deleted-symlink-directory -
+	"
+
+# NOTE: git does not have the concept of replaced objects,
+# so we can't test for them.
+#test_expect_success 'info replaced-file' "/usr/bin/true"
+#test_expect_success 'info replaced-directory' "/usr/bin/true"
+#test_expect_success 'info replaced-symlink-file' "/usr/bin/true"
+#test_expect_success 'info replaced-symlink-directory' "/usr/bin/true"
+
+test_expect_success 'info unknown-file' "
+	echo two > gitwc/unknown-file &&
+	(cd gitwc; git-svn info unknown-file) 2>&1 |
+	git-diff ../t9117/expected.info-unknown-file -
+	"
+
+test_expect_success 'info unknown-directory' "
+	mkdir gitwc/unknown-directory &&
+	(cd gitwc; git-svn info unknown-directory) 2>&1 |
+	git-diff ../t9117/expected.info-unknown-directory -
+	"
+
+test_expect_success 'info unknown-symlink-file' "
+	cd gitwc &&
+		ln -s unknown-file unknown-symlink-file &&
+	cd .. &&
+	(cd gitwc; git-svn info unknown-symlink-file) 2>&1 |
+	git-diff ../t9117/expected.info-unknown-symlink-file -
+	"
+
+test_expect_success 'info unknown-symlink-directory' "
+	cd gitwc &&
+		ln -s unknown-directory unknown-symlink-directory &&
+	cd .. &&
+	(cd gitwc; git-svn info unknown-symlink-directory) 2>&1 |
+	git-diff ../t9117/expected.info-unknown-symlink-directory -
+	"
+
+test_done
diff --git a/t/t9117/expected.info-added-directory b/t/t9117/expected.info-added-directory
new file mode 100644
index 0000000..2622900
--- /dev/null
+++ b/t/t9117/expected.info-added-directory
@@ -0,0 +1,7 @@
+Path: added-directory
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/added-directory
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Revision: 0
+Node Kind: directory
+Schedule: add
+
diff --git a/t/t9117/expected.info-added-file b/t/t9117/expected.info-added-file
new file mode 100644
index 0000000..2881f93
--- /dev/null
+++ b/t/t9117/expected.info-added-file
@@ -0,0 +1,8 @@
+Path: added-file
+Name: added-file
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/added-file
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Revision: 0
+Node Kind: file
+Schedule: add
+
diff --git a/t/t9117/expected.info-added-symlink-directory b/t/t9117/expected.info-added-symlink-directory
new file mode 100644
index 0000000..fa3d511
--- /dev/null
+++ b/t/t9117/expected.info-added-symlink-directory
@@ -0,0 +1,8 @@
+Path: added-symlink-directory
+Name: added-symlink-directory
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/added-symlink-directory
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Revision: 0
+Node Kind: file
+Schedule: add
+
diff --git a/t/t9117/expected.info-added-symlink-file b/t/t9117/expected.info-added-symlink-file
new file mode 100644
index 0000000..cd14e62
--- /dev/null
+++ b/t/t9117/expected.info-added-symlink-file
@@ -0,0 +1,8 @@
+Path: added-symlink-file
+Name: added-symlink-file
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/added-symlink-file
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Revision: 0
+Node Kind: file
+Schedule: add
+
diff --git a/t/t9117/expected.info-deleted-directory b/t/t9117/expected.info-deleted-directory
new file mode 100644
index 0000000..ec8bda5
--- /dev/null
+++ b/t/t9117/expected.info-deleted-directory
@@ -0,0 +1,11 @@
+Path: directory
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/directory
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: directory
+Schedule: delete
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+
diff --git a/t/t9117/expected.info-deleted-file b/t/t9117/expected.info-deleted-file
new file mode 100644
index 0000000..7951183
--- /dev/null
+++ b/t/t9117/expected.info-deleted-file
@@ -0,0 +1,14 @@
+Path: file
+Name: file
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/file
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: file
+Schedule: delete
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+Text Last Updated: TEXT-LAST-UPDATED-STRING
+Checksum: 5bbf5a52328e7439ae6e719dfe712200
+
diff --git a/t/t9117/expected.info-deleted-symlink-directory b/t/t9117/expected.info-deleted-symlink-directory
new file mode 100644
index 0000000..2fb452d
--- /dev/null
+++ b/t/t9117/expected.info-deleted-symlink-directory
@@ -0,0 +1,14 @@
+Path: symlink-directory
+Name: symlink-directory
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/symlink-directory
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: file
+Schedule: delete
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+Text Last Updated: TEXT-LAST-UPDATED-STRING
+Checksum: 7f5674b838ad799ab8962413b1f84095
+
diff --git a/t/t9117/expected.info-deleted-symlink-file b/t/t9117/expected.info-deleted-symlink-file
new file mode 100644
index 0000000..c2945f9
--- /dev/null
+++ b/t/t9117/expected.info-deleted-symlink-file
@@ -0,0 +1,14 @@
+Path: symlink-file
+Name: symlink-file
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/symlink-file
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: file
+Schedule: delete
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+Text Last Updated: TEXT-LAST-UPDATED-STRING
+Checksum: 73f9c467f93002e83dc229a229bbc4cb
+
diff --git a/t/t9117/expected.info-directory b/t/t9117/expected.info-directory
new file mode 100644
index 0000000..29dfa37
--- /dev/null
+++ b/t/t9117/expected.info-directory
@@ -0,0 +1,11 @@
+Path: directory
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/directory
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: directory
+Schedule: normal
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+
diff --git a/t/t9117/expected.info-dot b/t/t9117/expected.info-dot
new file mode 100644
index 0000000..c3bf061
--- /dev/null
+++ b/t/t9117/expected.info-dot
@@ -0,0 +1,11 @@
+Path: .
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: directory
+Schedule: normal
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+
diff --git a/t/t9117/expected.info-file b/t/t9117/expected.info-file
new file mode 100644
index 0000000..9350107
--- /dev/null
+++ b/t/t9117/expected.info-file
@@ -0,0 +1,14 @@
+Path: file
+Name: file
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/file
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: file
+Schedule: normal
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+Text Last Updated: TEXT-LAST-UPDATED-STRING
+Checksum: 5bbf5a52328e7439ae6e719dfe712200
+
diff --git a/t/t9117/expected.info-no-arguments b/t/t9117/expected.info-no-arguments
new file mode 100644
index 0000000..c3bf061
--- /dev/null
+++ b/t/t9117/expected.info-no-arguments
@@ -0,0 +1,11 @@
+Path: .
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: directory
+Schedule: normal
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+
diff --git a/t/t9117/expected.info-symlink-directory b/t/t9117/expected.info-symlink-directory
new file mode 100644
index 0000000..70255ac
--- /dev/null
+++ b/t/t9117/expected.info-symlink-directory
@@ -0,0 +1,14 @@
+Path: symlink-directory
+Name: symlink-directory
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/symlink-directory
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: file
+Schedule: normal
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+Text Last Updated: TEXT-LAST-UPDATED-STRING
+Checksum: 7f5674b838ad799ab8962413b1f84095
+
diff --git a/t/t9117/expected.info-symlink-file b/t/t9117/expected.info-symlink-file
new file mode 100644
index 0000000..8465c1d
--- /dev/null
+++ b/t/t9117/expected.info-symlink-file
@@ -0,0 +1,14 @@
+Path: symlink-file
+Name: symlink-file
+URL: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo/symlink-file
+Repository Root: file:///Users/ddkilzer/Projects/C/git/t/trash/svnrepo
+Repository UUID: REPOSITORY-UUID
+Revision: 1
+Node Kind: file
+Schedule: normal
+Last Changed Author: ddkilzer
+Last Changed Rev: 1
+Last Changed Date: LAST-CHANGED-DATE-STRING
+Text Last Updated: TEXT-LAST-UPDATED-STRING
+Checksum: 73f9c467f93002e83dc229a229bbc4cb
+
diff --git a/t/t9117/expected.info-unknown-directory b/t/t9117/expected.info-unknown-directory
new file mode 100644
index 0000000..b5eef7d
--- /dev/null
+++ b/t/t9117/expected.info-unknown-directory
@@ -0,0 +1,2 @@
+unknown-directory:  (Not a versioned resource)
+
diff --git a/t/t9117/expected.info-unknown-file b/t/t9117/expected.info-unknown-file
new file mode 100644
index 0000000..89f102e
--- /dev/null
+++ b/t/t9117/expected.info-unknown-file
@@ -0,0 +1,2 @@
+unknown-file:  (Not a versioned resource)
+
diff --git a/t/t9117/expected.info-unknown-symlink-directory b/t/t9117/expected.info-unknown-symlink-directory
new file mode 100644
index 0000000..37d3106
--- /dev/null
+++ b/t/t9117/expected.info-unknown-symlink-directory
@@ -0,0 +1,2 @@
+unknown-symlink-directory:  (Not a versioned resource)
+
diff --git a/t/t9117/expected.info-unknown-symlink-file b/t/t9117/expected.info-unknown-symlink-file
new file mode 100644
index 0000000..cae9ab0
--- /dev/null
+++ b/t/t9117/expected.info-unknown-symlink-file
@@ -0,0 +1,2 @@
+unknown-symlink-file:  (Not a versioned resource)
+
diff --git a/t/t9117/regenerate.sh b/t/t9117/regenerate.sh
new file mode 100755
index 0000000..16d039d
--- /dev/null
+++ b/t/t9117/regenerate.sh
@@ -0,0 +1,186 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 David D. Kilzer
+
+test_description='regenerate results for git-svn info'
+
+cd `dirname $0`/..
+. ./lib-git-svn.sh
+
+test_expect_success 'setup repository and import' "
+	mkdir info &&
+	cd info &&
+		echo one > file &&
+		ln -s file symlink-file &&
+		mkdir directory &&
+		touch directory/.placeholder &&
+		ln -s directory symlink-directory &&
+		svn import -m 'initial' . $svnrepo &&
+	cd .. &&
+	svn co $svnrepo svnwc
+	"
+
+test_expect_success 'info no arguments' "
+	(cd svnwc; svn info) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+	>../t9117/expected.info-no-arguments
+	"
+
+test_expect_success 'info dot' "
+	(cd svnwc; svn info .) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+	>../t9117/expected.info-dot
+	"
+
+test_expect_success 'info file' "
+	(cd svnwc; svn info file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+	>../t9117/expected.info-file
+	"
+
+test_expect_success 'info directory' "
+	(cd svnwc; svn info directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+	>../t9117/expected.info-directory
+	"
+
+test_expect_success 'info symlink-file' "
+	(cd svnwc; svn info symlink-file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+	>../t9117/expected.info-symlink-file
+	"
+
+test_expect_success 'info symlink-directory' "
+	(cd svnwc; svn info symlink-directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+	>../t9117/expected.info-symlink-directory
+	"
+
+test_expect_success 'info added-file' "
+	echo two > svnwc/added-file &&
+	cd svnwc &&
+		svn add added-file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info added-file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+	>../t9117/expected.info-added-file
+	"
+
+test_expect_success 'info added-directory' "
+	mkdir svnwc/added-directory &&
+	cd svnwc &&
+		svn add added-directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info added-directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+	>../t9117/expected.info-added-directory
+	"
+
+test_expect_success 'info added-symlink-file' "
+	cd svnwc &&
+		ln -s added-file added-symlink-file &&
+		svn add added-symlink-file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info added-symlink-file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+	>../t9117/expected.info-added-symlink-file
+	"
+
+test_expect_success 'info added-symlink-directory' "
+	cd svnwc &&
+		ln -s added-directory added-symlink-directory &&
+		svn add added-symlink-directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info added-symlink-directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+	>../t9117/expected.info-added-symlink-directory
+	"
+
+test_expect_success 'info deleted-file' "
+	cd svnwc &&
+		svn rm --force file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+	>../t9117/expected.info-deleted-file
+	"
+
+test_expect_success 'info deleted-directory' "
+	cd svnwc &&
+		svn rm --force directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+	>../t9117/expected.info-deleted-directory
+	"
+
+test_expect_success 'info deleted-symlink-file' "
+	cd svnwc &&
+		svn rm --force symlink-file > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info symlink-file) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+	>../t9117/expected.info-deleted-symlink-file
+	"
+
+test_expect_success 'info deleted-symlink-directory' "
+	cd svnwc &&
+		svn rm --force symlink-directory > /dev/null &&
+	cd .. &&
+	(cd svnwc; svn info symlink-directory) |
+	sed	-e 's/^\(Repository UUID:\).*/\1 REPOSITORY-UUID/' \
+		-e 's/^\(Last Changed Date:\).*/\1 LAST-CHANGED-DATE-STRING/' \
+		-e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
+	>../t9117/expected.info-deleted-symlink-directory
+	"
+
+# NOTE: git does not have the concept of replaced objects,
+# so we can't test for them.
+#test_expect_success 'info replaced-file' "/usr/bin/true"
+#test_expect_success 'info replaced-directory' "/usr/bin/true"
+#test_expect_success 'info replaced-symlink-file' "/usr/bin/true"
+#test_expect_success 'info replaced-symlink-directory' "/usr/bin/true"
+
+test_expect_success 'info unknown-file' "
+	echo two > svnwc/unknown-file &&
+	(cd svnwc; svn info unknown-file) \
+	2>../t9117/expected.info-unknown-file
+	"
+
+test_expect_success 'info unknown-directory' "
+	mkdir svnwc/unknown-directory &&
+	(cd svnwc; svn info unknown-directory) \
+	2>../t9117/expected.info-unknown-directory
+	"
+
+test_expect_success 'info unknown-symlink-file' "
+	cd svnwc &&
+		ln -s unknown-file unknown-symlink-file &&
+	cd .. &&
+	(cd svnwc; svn info unknown-symlink-file) \
+	2>../t9117/expected.info-unknown-symlink-file
+	"
+
+test_expect_success 'info unknown-symlink-directory' "
+	cd svnwc &&
+		ln -s unknown-directory unknown-symlink-directory &&
+	cd .. &&
+	(cd svnwc; svn info unknown-symlink-directory) \
+	2>../t9117/expected.info-unknown-symlink-directory
+	"
+
+test_done
-- 
1.5.3.4
