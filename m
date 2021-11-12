Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B78DC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471DD60FBF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhKLVw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbhKLVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A350AC061228
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s13so17927153wrb.3
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmI0SEV8DeLiSGYzeXUFBvjBY/5DdNrk3RC1rvGPekA=;
        b=aM/aGLc8qpdY2GuJIFRIw5WlYtjRPGSGdNzm6QnDKvSJh1SC3LAIFWbJegHWxyKO99
         iEosM7/XneFGUYaZQy+u2mZs8MveCfM1kcZQR8jM9YM/LSByDhelV7KFS+pFrF3WuGiY
         w8h/PGSUAndp/rvXFH48qwau7kw7/uBb1xjPKJjgzBauF81oltGha7c/Ten7NyjvtSWO
         /Hri3eLuSZ6v1VAUFz9ABCn7qaU+nbEyuK8C5DCH9sXEpeRrW85YAn2E1BxH1nCPO8Sq
         wASTSUeuo0QHh+6LRv8pmPZjUDKiJhn9gkB/GApXKcPCiZxsUBK0eq//tf5L62Kd+/f7
         bAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmI0SEV8DeLiSGYzeXUFBvjBY/5DdNrk3RC1rvGPekA=;
        b=b4bvZtvGCu3WjxqZKt5jFa6SBkAlNXDmPjBNSAsvOoY6Ka3kv8yxSOHo8nTBpRx5ju
         KAyFlFne/ZHmD46mJh00dAno/ocJeT3sS0QX+/3b3H7cs4WiNntI2KJYMH+76RFv+4GO
         /y7jcBZFFa+10Rbcd8yR2fDQ0456Artk9yhVCMNNQED7mgV0E/JpqzUjTvRWV6iBboXC
         3eFTuvB0BM+Dg2YpA6EQfL7n2sLg7TsABdQ1QGtpeSHUZ3XbFZhkq+NXm02BYPJOhjPI
         +By8KnqU/bJDG2A30O3qZTYWvx3WDfbk3W5SqGGloQzK+GxTs9vIWIjQQ+KAeIATJrzW
         rBFQ==
X-Gm-Message-State: AOAM5303pROAF1hQ3KMwqYF3Y8zy2DdlufdkpELx3XrKFWThsKXx5jwE
        2Eu7ChesFQaEt8mj4oFiInC3yePrSIM2xA==
X-Google-Smtp-Source: ABdhPJxtLXV5aK1ndpGVIYnuIv23b6sngP8vs+UaoVtIBT92/ZQXFfobj0+tSaQwquOlEydkwv8WTA==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr22213303wrt.41.1636753756994;
        Fri, 12 Nov 2021 13:49:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/18] Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
Date:   Fri, 12 Nov 2021 22:48:55 +0100
Message-Id: <patch-v2-11.18-bfa15059d60-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

