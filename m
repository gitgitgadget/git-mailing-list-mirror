Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B3C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D512761040
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhKPMGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbhKPMEg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE6C06122A
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r8so36984856wra.7
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZey/9m9V78NBW8cceKwNGYYQTDQ7ngcgVlzXdWjcu8=;
        b=b+vpS8zRPHsuySrm2DvFAIKDFlhFwELyaXnRt2hTgw2Pn+dyp6qr5tdZNr3IyvVLQE
         ubLn2C0s6yNjJQJY7YuqzpbNTfO4AzM5NqkmQxL41sNsuik1G0QuS97In1IYQloCrc0W
         o5CuvBHDCRk9p34kj8sed+KkqNt+46PoRlGfMShvhKXonNJHLfIGOLdEcoHi5glhOt4Y
         TRJl8SGG90s5Mp5UAhXCPPCz0Jt/iDOnScbRgTaQzaqTisP3RoNVrNyUTNqhUo3HHPuN
         VuHr7rXIWbp2HGotCW3/KaFCM1qGYH6FMFHapan5lvfMypYgLfAZLTeITV62Jd5ZxB9E
         zX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZey/9m9V78NBW8cceKwNGYYQTDQ7ngcgVlzXdWjcu8=;
        b=7FAbW9SnqB9kxR9Z4Q4lXeLVgBpmyJFyb9r62AuTrasfclh5KkGVpcTpEF3/17PYz5
         mCGXE4ii2dS3AzUmErQMFgOUh9HdL4O37IX25gC6AEsQJBDEPOsP5u9Hcx+D3nQC7GwK
         NGz+3NV/H+i6vpaarRpS4Q+JQo/2B+sQ2laGfjZqsgUiK86KwxHa60w4WHqnlZde0BLP
         5g0QigPpOoxiCaXWKRbp3jfanmPcvO6mV1F/ZYfJQnuFnwU/Iy/oE3lkSjwip4lPDvR7
         yRbidw1i8hXoaPtHMm8Ugv4j1Ew0DQLdVLXIXpYKjSJI2IiVzWYQDRqAvbKvAGWwOS4O
         9lBA==
X-Gm-Message-State: AOAM532cokiFGoq8ZurwbnpBFn8ksh9CYyGCAeA7ikIuSPlvbL/vpVCy
        0XcIwtBZ2vhvWtdgARWy4Ycm21OB7DAUfw==
X-Google-Smtp-Source: ABdhPJx9m4xmQ0ZOkuFaJLg2fcFHTf83ZRu2sYQcT+AxxfkPeu74/+XyFh5GnHRNI06B/0XUI2uKmg==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr8722037wrz.76.1637064043627;
        Tue, 16 Nov 2021 04:00:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/23] Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
Date:   Tue, 16 Nov 2021 13:00:11 +0100
Message-Id: <patch-v3-11.23-b020f8e3257-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
index c698c5b058a..8205614c6ec 100644
--- a/Makefile
+++ b/Makefile
@@ -2333,7 +2333,7 @@ PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
 perl_localedir_SQ =
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
2.34.0.795.g1e9501ab396

