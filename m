Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D69C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE0E61BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhKQKYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbhKQKXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8AC061746
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso4315499wms.2
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTjT96qnyBSEcU3Fx1eEPGSBOZakTKcXTsEmD7bMox4=;
        b=l8/AuIyc4PqrKw+oryJ6oqbcmqIz/O7oJangZPCrna4qQhcgDkLOT7rM2KvmmtFHt1
         DowYVriYzYEwPnkjK/pBpEX/rAoHN8iwHdIJfAeULqTMvrkEPnn2QstWVLzLylaBy8cq
         bnVsiKcLzOlugQCS8Pqn2M8D+Bf8mzGWX6h2r52uIFJcOWPa9XroqnCSgsfiIbE8BJOH
         cGsEELuVo38D6rEiq8H0G/HP5R9Y78AZDzRGb+0bkwoDPEvp921MpxxgwTi1XKTXJx3H
         M5SPoZKY7MJkLFRprUUwFGOuG5ttwSOAHMMiI3vMEamYyV5g56eAHBiZZb4JQnBAjDYA
         UYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTjT96qnyBSEcU3Fx1eEPGSBOZakTKcXTsEmD7bMox4=;
        b=HBxHArvsxe+TN6M/PaOzt5pr7UZDt3rALuCTpmnLj9223joP9OPbepWszt2n85ImG5
         BMeMKG/0JWSUwK9dUCAJOl0+0pvYRrnJaaNg+dUXZH3j/ax0mevukdSZRvQQMYoPi+O4
         VRjjCxVGZec9wvQ3dDcmtHMp7uB/wJplQRCru67/N2dBcHcGLXm3XYyL9IVbjN7bHAJE
         YKh8eMmyzjTx8wzKpRwdEp0PNuE77LktMVPszW/5A0G9lGC9jrVRLFAtX3zRCTd9b3pN
         lB7xTYK90oita/oj8L4JBdX70f6ONAvZOtFTfEZ6Aqay0qMfSx1BDIERDZ/2UAukE3Il
         a3GQ==
X-Gm-Message-State: AOAM533jxWrDxzXcemunNt71XL+VwvFYIZlD6fRXRsZpaQ8TyPdE8nkC
        XcoMJL8ZxbR7J471Q6BdkKddnryKnZx5YA==
X-Google-Smtp-Source: ABdhPJzkpLTy7fx5kHjDCZMbDP29A9RID4TaLc0/p/VCFUSA1Il3+/3CgD21khNn9J8o3WALduFD/g==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr16040291wmb.146.1637144434829;
        Wed, 17 Nov 2021 02:20:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/23] Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
Date:   Wed, 17 Nov 2021 11:20:10 +0100
Message-Id: <patch-v4-11.23-17b30e96057-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
2.34.0.796.g2c87ed6146a

