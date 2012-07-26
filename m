From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] difftool: Wrap long lines for readability
Date: Wed, 25 Jul 2012 23:07:57 -0700
Message-ID: <1343282878-86431-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:08:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuHFA-0006xQ-Py
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 08:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab2GZGIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 02:08:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57479 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab2GZGIC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 02:08:02 -0400
Received: by pbbrp8 with SMTP id rp8so2688521pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qnLvnQyx7jMi9R7oDFjCYe38ETBtLcaXIjsjlB1SknQ=;
        b=lotDFFUMQmUlOHmEJ8f2fZ0rLi3CSnCxrGKHQsRszW9KCVYiJSCXQ7Rej64b6zc4Oi
         DchH4xi7Ktndzho27w6gCb0agaCJLWkC+Yc6PKpHFSWs/EclBuOeYpsgdjuCAY5eWHWP
         dzibOYrx3TNIjlpU/nLH7Sb2OSUXums5S+TVPbF3fPMi5Te+2wXTtNLJox04HPkLWorw
         0v0WObmaVi6wkYNitPbx8lslvEHymfU5CbtEySKw0UaneuYwyzg/ex+xYiBsuJ7SKnWo
         xGXXu8qRVpGj522mj+Dh6tksj5Ebb9cKIZB3aqR/WV6S/6M6ewN1JgP5UrU0ckpixDcB
         LoDQ==
Received: by 10.68.222.40 with SMTP id qj8mr2140184pbc.139.1343282881599;
        Wed, 25 Jul 2012 23:08:01 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id nj4sm15881623pbc.5.2012.07.25.23.08.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 23:08:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.11.g3fd941e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202225>

Keep everything within 80 columns.  Wrap the user-facing messages too.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
The only remaining long lines were touched in 2/2.

 git-difftool.perl | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 10d3d97..8e51238 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -93,15 +93,22 @@ sub print_tool_help
 		}
 	}
 
-	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
+	print << 'EOF';
+'git difftool --tool=<tool>' may be set to one of the following:
+EOF
 	print "\t$_\n" for (sort(@found));
 
-	print "\nThe following tools are valid, but not currently available:\n";
+	print << 'EOF';
+
+The following tools are valid, but not currently available:
+EOF
 	print "\t$_\n" for (sort(@notfound));
 
-	print "\nNOTE: Some of the tools listed above only work in a windowed\n";
-	print "environment. If run in a terminal-only session, they will fail.\n";
+	print << 'EOF';
 
+NOTE: Some of the tools listed above only work in a windowed
+environment. If run in a terminal-only session, they will fail.
+EOF
 	exit(0);
 }
 
@@ -114,8 +121,11 @@ sub setup_dir_diff
 	# if $GIT_DIR and $GIT_WORK_TREE are set in ENV, they are actually used
 	# by Git->repository->command*.
 	my $repo_path = $repo->repo_path();
-	my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
-	my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
+	my %repo_args = (Repository => $repo_path, WorkingCopy => $workdir);
+	my $diffrepo = Git->repository(%repo_args);
+
+	my @gitargs = ('diff', '--raw', '--no-abbrev', '-z', @ARGV);
+	my $diffrtn = $diffrepo->command_oneline(@gitargs);
 	exit(0) if (length($diffrtn) == 0);
 
 	# Setup temp directories
@@ -140,11 +150,15 @@ sub setup_dir_diff
 	my $i = 0;
 	while ($i < $#rawdiff) {
 		if ($rawdiff[$i] =~ /^::/) {
-			print "Combined diff formats ('-c' and '--cc') are not supported in directory diff mode.\n";
+			warn << 'EOF';
+Combined diff formats ('-c' and '--cc') are not supported in
+directory diff mode ('-d' and '--dir-diff').
+EOF
 			exit(1);
 		}
 
-		my ($lmode, $rmode, $lsha1, $rsha1, $status) = split(' ', substr($rawdiff[$i], 1));
+		my ($lmode, $rmode, $lsha1, $rsha1, $status) =
+			split(' ', substr($rawdiff[$i], 1));
 		my $src_path = $rawdiff[$i + 1];
 		my $dst_path;
 
@@ -156,7 +170,7 @@ sub setup_dir_diff
 			$i += 2;
 		}
 
-		if (($lmode eq $submodule_mode) or ($rmode eq $submodule_mode)) {
+		if ($lmode eq $submodule_mode or $rmode eq $submodule_mode) {
 			$submodule{$src_path}{left} = $lsha1;
 			if ($lsha1 ne $rsha1) {
 				$submodule{$dst_path}{right} = $rsha1;
@@ -167,14 +181,16 @@ sub setup_dir_diff
 		}
 
 		if ($lmode eq $symlink_mode) {
-			$symlink{$src_path}{left} = $diffrepo->command_oneline('show', "$lsha1");
+			$symlink{$src_path}{left} =
+				$diffrepo->command_oneline('show', "$lsha1");
 		}
 
 		if ($rmode eq $symlink_mode) {
-			$symlink{$dst_path}{right} = $diffrepo->command_oneline('show', "$rsha1");
+			$symlink{$dst_path}{right} =
+				$diffrepo->command_oneline('show', "$rsha1");
 		}
 
-		if (($lmode ne $null_mode) and ($status !~ /^C/)) {
+		if ($lmode ne $null_mode and $status !~ /^C/) {
 			$lindex .= "$lmode $lsha1\t$src_path\0";
 		}
 
@@ -199,14 +215,16 @@ sub setup_dir_diff
 	# Populate the left and right directories based on each index file
 	my ($inpipe, $ctx);
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/lindex";
-	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	($inpipe, $ctx) =
+		$repo->command_input_pipe(qw(update-index -z --index-info));
 	print($inpipe $lindex);
 	$repo->command_close_pipe($inpipe, $ctx);
 	my $rc = system('git', 'checkout-index', '--all', "--prefix=$ldir/");
 	exit($rc | ($rc >> 8)) if ($rc != 0);
 
 	$ENV{GIT_INDEX_FILE} = "$tmpdir/rindex";
-	($inpipe, $ctx) = $repo->command_input_pipe(qw/update-index -z --index-info/);
+	($inpipe, $ctx) =
+		$repo->command_input_pipe(qw(update-index -z --index-info));
 	print($inpipe $rindex);
 	$repo->command_close_pipe($inpipe, $ctx);
 	$rc = system('git', 'checkout-index', '--all', "--prefix=$rdir/");
-- 
1.7.11.11.g72d9886.dirty
