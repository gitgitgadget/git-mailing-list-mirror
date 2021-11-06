Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1AC43217
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C455860F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhKFVGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbhKFVGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B076C06120A
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s13so19546174wrb.3
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFOfQcxCZdsgiELoIo5S+tgOTSd+1LeSxM7+zJGxeZA=;
        b=SosqKozhbtGI8iRTUiANWE/6QRABbHCkWZsROBXBcllJnsQ9aZyWjv9Sjwzb1o6n2d
         XT/p7AEdTF+GofWF9APprbx48TSzDSel+pxWguQ5/JPmb9WYAyO4ojp6Qe0TrPvB9ljq
         3amEJZlRX8js/uJvYnyaCzFpqz/l9uKdmUL0su2mPwxVlbeRabKHr+ETlexBiSCyWOeE
         nO1tpPv2Zi+pVzXSKKIDrg8DyXMr+nma/EvJQ5BYrRQgTWR9yp6X1TVvccahXNFc0r9+
         p7PlxClHcW0PRhjQi62SYxtjP+m4qFLRg4eKnZsTNjxyLz3UuQa+IGZwXHXsmNxDoRIC
         lRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFOfQcxCZdsgiELoIo5S+tgOTSd+1LeSxM7+zJGxeZA=;
        b=7PFPe/ynM3Ljc0Q0kw42dYOwD0Y0I1/eMcVbv3WBk9VciDCbozjnj+/Z6rjidR8sB1
         E2WKr1bE1wLB33c1n/nQfaB9QltYQFIbErX81Usjg7eF/cuRtjOINNGVWRYvAnqHE4pd
         zGGoyZmDXI94lrt6AHOUbBWT9RAFLTs2Xif4Lj43o3zg1/UCctnaKf0qp5oQuz7lXlPt
         hspFrDhg9epId5uDLa9fvM+IWhqCk2TkwjA3lbH7MfpqYKaVCPshA9JpPv/gHyahHTJO
         0PXPJovtIz7fleHFHWpW/gumtXumLn6GXClLh3zstXndXPgV3XPzJPTvcYxwYnebFT9L
         H94Q==
X-Gm-Message-State: AOAM533o5bix3GlPQXZJs9rXXshwMCNSL76pIVcgLAlWUpqR/HioHafd
        fHy5foUTFbFQfGT4jcTLHOL6XImT/q4lzg==
X-Google-Smtp-Source: ABdhPJxfKXg30RoaSfS/RTuxlgF9aoq3MYNheYNYBSclA1hap6agcHCwWcuqP3gJu7oVdp79DRt/bw==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr56043445wrw.104.1636232606885;
        Sat, 06 Nov 2021 14:03:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/16] Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
Date:   Sat,  6 Nov 2021 22:03:09 +0100
Message-Id: <patch-08.16-e3b52cf8da5-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hardcoding of @@GIT_VERSION@@ in generated *.perl scripts
to instead shell out to "git version". This means that we can stop
re-building during development every time the HEAD changes.

These codepaths are not "hot", so shelling out to get the version
shouldn't matter to users, in the one case where it potentially would
in send-email (the loop for each E-Mail we send) we now cache the
value, so we'll only retrieve it once.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile            | 2 +-
 git-cvsserver.perl  | 6 +++---
 git-send-email.perl | 7 ++-----
 git-svn.perl        | 2 +-
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 42eb15dc09c..b2970c6ded9 100644
--- a/Makefile
+++ b/Makefile
@@ -2324,7 +2324,7 @@ else
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 endif
 
-$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
+$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER
 	$(QUIET_GEN) \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 64319bed43f..76f0e8bbbef 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -26,8 +26,6 @@
 use File::Basename;
 use Getopt::Long qw(:config require_order no_ignore_case);
 
-my $VERSION = '@@GIT_VERSION@@';
-
 my $log = GITCVS::log->new();
 my $cfg;
 
@@ -126,7 +124,9 @@
     or die $usage;
 
 if ($state->{version}) {
-    print "git-cvsserver version $VERSION\n";
+    my $version = qx[git version];
+    $version =~ s/^(git)\b/$1-cvsserver/;
+    print $version;
     exit;
 }
 if ($state->{help}) {
diff --git a/git-send-email.perl b/git-send-email.perl
index 5262d88ee32..041cd2fb96d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1468,6 +1468,7 @@ sub file_name_is_absolute {
 #
 # If an error occurs sending the email, this just dies.
 
+my $gitversion;
 sub send_message {
 	my @recipients = unique_email_list(@to);
 	@cc = (grep { my $cc = extract_valid_address_or_die($_);
@@ -1478,11 +1479,6 @@ sub send_message {
 	@recipients = unique_email_list(@recipients,@cc,@initial_bcc);
 	@recipients = (map { extract_valid_address_or_die($_) } @recipients);
 	my $date = format_2822_time($time++);
-	my $gitversion = '@@GIT_VERSION@@';
-	if ($gitversion =~ m/..GIT_VERSION../) {
-	    $gitversion = Git::version();
-	}
-
 	my $cc = join(",\n\t", unique_email_list(@cc));
 	my $ccline = "";
 	if ($cc ne '') {
@@ -1497,6 +1493,7 @@ sub send_message {
 Message-Id: $message_id
 ";
 	if ($use_xmailer) {
+		$gitversion ||= Git::version();
 		$header .= "X-Mailer: git-send-email $gitversion\n";
 	}
 	if ($in_reply_to) {
diff --git a/git-svn.perl b/git-svn.perl
index be987e316f9..727431412be 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -9,7 +9,6 @@
 		$_revision $_repository
 		$_q $_authors $_authors_prog %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '@@GIT_VERSION@@';
 
 use Carp qw/croak/;
 use File::Basename qw/dirname basename/;
@@ -47,6 +46,7 @@
 	command_close_bidi_pipe
 	get_record
 );
+$VERSION = Git::version();
 
 BEGIN {
 	Memoize::memoize 'Git::config';
-- 
2.34.0.rc1.741.gab7bfd97031

