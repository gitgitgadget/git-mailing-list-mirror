Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CF71F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbcFULqb (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:46:31 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52357 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752350AbcFULqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:46:25 -0400
Received: (qmail 10945 invoked from network); 21 Jun 2016 11:46:23 -0000
Received: (qmail 8713 invoked from network); 21 Jun 2016 11:46:23 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:46:21 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/11] i18n: difftool: mark warnings for translation
Date:	Tue, 21 Jun 2016 11:44:13 +0000
Message-Id: <20160621114413.9467-11-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-difftool.perl | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ebd13ba..fe7f003 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -22,6 +22,7 @@ use File::Path qw(mkpath rmtree);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
+use Git::I18N;
 
 sub usage
 {
@@ -144,7 +145,7 @@ sub setup_dir_diff
 	my $i = 0;
 	while ($i < $#rawdiff) {
 		if ($rawdiff[$i] =~ /^::/) {
-			warn << 'EOF';
+			warn __ <<'EOF';
 Combined diff formats ('-c' and '--cc') are not supported in
 directory diff mode ('-d' and '--dir-diff').
 EOF
@@ -451,11 +452,11 @@ sub dir_diff
 		}
 
 		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
-			my $errmsg = "warning: Both files modified: ";
-			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
-			$errmsg .= "warning: Working tree file has been left.\n";
-			$errmsg .= "warning:\n";
-			warn $errmsg;
+			warn sprintf __(
+"warning: Both files modified:
+'%s/%s' and '%s/%s'.
+warning: Working tree file has been left.
+warning:\n"), $workdir, $file, $b, $file;
 			$error = 1;
 		} elsif (exists $tmp_modified{$file}) {
 			my $mode = stat("$b/$file")->mode;
@@ -467,8 +468,9 @@ sub dir_diff
 		}
 	}
 	if ($error) {
-		warn "warning: Temporary files exist in '$tmpdir'.\n";
-		warn "warning: You may want to cleanup or recover these.\n";
+		warn sprintf __(
+"warning: Temporary files exist in '%s'.
+warning: You may want to cleanup or recover these.\n"), $tmpdir;
 		exit(1);
 	} else {
 		exit_cleanup($tmpdir, $rc);
-- 
2.6.6

