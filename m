Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525281F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbcJERWq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:22:46 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:54798 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754738AbcJERWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:22:45 -0400
Received: (qmail 25556 invoked from network); 5 Oct 2016 17:22:44 -0000
Received: (qmail 16949 invoked from network); 5 Oct 2016 17:22:43 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 5 Oct 2016 17:22:38 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/14] i18n: difftool: mark warnings for translation
Date:   Wed,  5 Oct 2016 17:21:10 +0000
Message-Id: <20161005172110.30801-15-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.366.g8a57a7a
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-difftool.perl | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index a5790d0..8d3632e 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -22,6 +22,7 @@ use File::Path qw(mkpath rmtree);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
+use Git::I18N;
 
 sub usage
 {
@@ -122,7 +123,7 @@ sub setup_dir_diff
 	my $i = 0;
 	while ($i < $#rawdiff) {
 		if ($rawdiff[$i] =~ /^::/) {
-			warn << 'EOF';
+			warn __ <<'EOF';
 Combined diff formats ('-c' and '--cc') are not supported in
 directory diff mode ('-d' and '--dir-diff').
 EOF
@@ -338,7 +339,7 @@ sub main
 		if (length($opts{difftool_cmd}) > 0) {
 			$ENV{GIT_DIFF_TOOL} = $opts{difftool_cmd};
 		} else {
-			print "No <tool> given for --tool=<tool>\n";
+			print __("No <tool> given for --tool=<tool>\n");
 			usage(1);
 		}
 	}
@@ -346,7 +347,7 @@ sub main
 		if (length($opts{extcmd}) > 0) {
 			$ENV{GIT_DIFFTOOL_EXTCMD} = $opts{extcmd};
 		} else {
-			print "No <cmd> given for --extcmd=<cmd>\n";
+			print __("No <cmd> given for --extcmd=<cmd>\n");
 			usage(1);
 		}
 	}
@@ -419,11 +420,11 @@ sub dir_diff
 		}
 
 		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
-			my $errmsg = "warning: Both files modified: ";
-			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
-			$errmsg .= "warning: Working tree file has been left.\n";
-			$errmsg .= "warning:\n";
-			warn $errmsg;
+			warn sprintf(__(
+				"warning: Both files modified:\n" .
+				"'%s/%s' and '%s/%s'.\n" .
+				"warning: Working tree file has been left.\n" .
+				"warning:\n"), $workdir, $file, $b, $file);
 			$error = 1;
 		} elsif (exists $tmp_modified{$file}) {
 			my $mode = stat("$b/$file")->mode;
@@ -435,8 +436,9 @@ sub dir_diff
 		}
 	}
 	if ($error) {
-		warn "warning: Temporary files exist in '$tmpdir'.\n";
-		warn "warning: You may want to cleanup or recover these.\n";
+		warn sprintf(__(
+			"warning: Temporary files exist in '%s'.\n" .
+			"warning: You may want to cleanup or recover these.\n"), $tmpdir);
 		exit(1);
 	} else {
 		exit_cleanup($tmpdir, $rc);
-- 
2.7.4

