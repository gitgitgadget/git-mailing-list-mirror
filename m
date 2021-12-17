Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA6C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhLQA1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhLQA0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0103C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id b73so561953wmd.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJYs2SDrQRyIpTzu7QVknpbO0e0Qwn+2Z4z2dPvaVeQ=;
        b=BwJ3yZ8GdGUjeiH0GJF6phui6Xwk8KEZvhH5+2DJbPejoFXFk+vl90NhgxvbJ3y9Mi
         BSt9JDKaSUQxF4ItWxRHmG02EmiTT/uYVeOHtKw6NWHzFqhhjFYTGHalCQ/3KnoKL4Rs
         lQPsQBUH18h4+ZKsWo7C0CXr1X/NrGK30I6zZKKlmuf3cYdip8iG37pCUsdZXGipLX9/
         T1JVqQPWSfwUarih6mMvBNECt2PPTixloZP24cAOedI8X+wR8Dzz0DYKaGT/gl3yc9ux
         7qF1mXhl9sggs+sjYJMH5j+A2shagWYhMbni0qfj3jn4k/+ASxc2yB2cjx/W+ez5P6Rw
         LnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJYs2SDrQRyIpTzu7QVknpbO0e0Qwn+2Z4z2dPvaVeQ=;
        b=Sw5+0bNFGHNH6+BQM+0SSgXareFjtmuVxbzb5vDoiJPpjp5Pm2owskj3EXOJHsLZqr
         BztdovfLgjVD/KAJd4EoR7O0NX+MPN3lsb/5dkMyRLPbpamWuwWZ644oT4BsyiPdps8y
         Q+Oksa5RACx+7CCYa5g+3azcHTY2qS8+nqDnGBzlqraCETmdXswaJHJI0vPBaDqDoLjE
         fk6xoL4qp6O3v71wKSMRTMXbgwhCs7qjsth2LFbt+tsfUss1KkXJMhqaahOx8OIWja+2
         m60BN1cY0z3DFPRhlNZxOAcZ9uVReh4OYeZMNHCG4BseJKQV8TvxO86WvL3pfZiqkE+7
         w3MQ==
X-Gm-Message-State: AOAM5325m/ekCF/WfqWs/zLp7UKAHZDKnBMYlYJFkwsw0JUAtKRonPxX
        yl+uDuT4z1OWx9Ijd2LRfEOwlbpEga1Ltw==
X-Google-Smtp-Source: ABdhPJy6oImUrWR1JqWBtz0JiFoIS81m2bjvTZEIPVeQLcG26D0XrIUHigESHJ1aKeOkqhNQJ3TOOQ==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr7502281wmh.158.1639700802208;
        Thu, 16 Dec 2021 16:26:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/11] Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
Date:   Fri, 17 Dec 2021 01:26:27 +0100
Message-Id: <patch-11.11-defbd9b6db2-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
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
index f2cee13ea5d..9ccfb1109f5 100644
--- a/Makefile
+++ b/Makefile
@@ -2343,7 +2343,7 @@ PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
 perl_localedir_SQ =
 endif
 
-$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
+$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER
 	$(QUIET_GEN) \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4c8118010a8..4ec0cc1cc3c 100755
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
index 04087221aa7..390e8512627 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1504,6 +1504,7 @@ sub file_name_is_absolute {
 #
 # If an error occurs sending the email, this just dies.
 
+my $gitversion;
 sub send_message {
 	my @recipients = unique_email_list(@to);
 	@cc = (grep { my $cc = extract_valid_address_or_die($_);
@@ -1514,11 +1515,6 @@ sub send_message {
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
@@ -1533,6 +1529,7 @@ sub send_message {
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
2.34.1.1119.g7a3fc8778ee

