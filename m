Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E80C43461
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D7C61040
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhELNtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhELNtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7ABC06175F
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m9so23710166wrx.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMgRY/qFTXx07gCuW4jeZkIVQvuzzQG9omrKIRfRDuU=;
        b=cej/fkcUq7s8ItOMWdCgXIxfp9mY68tU/LyxELnGiFElQYYTuzGmxVYYrYsBUoAN6w
         nPnJjhalOzK9phDeHUbEGtmseaupUlPOmoofVTmwb+KqH7XfTM0rZTTNAYqVJoVrZ0Ba
         FnlBQFhbq9VG0FaBdugT7DG6w8cmxjw2fgkUR8FjKkDuPxfZqfJvbAQyosqB3Y1iuokM
         AA3tzoPJeSA+RmNaGQ52AiyX4Reh4Y8UcbkBjmUH5a+AI8Mnv1kQggrq/7OTNCuJuDWS
         ZTnpt8gCV3ZRFe/Ny8wFObi7wLiPW7pd0wTDbk4ooLUR5pK1BhXwTxOhWmaN4A5YCxTW
         Ql+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMgRY/qFTXx07gCuW4jeZkIVQvuzzQG9omrKIRfRDuU=;
        b=aBdPy5Pa1lfRKnv6Cqi0RAJBfVAXBNMKXoSiqBuYkOTcS78KBEICFtXFAunl/wpsA3
         KyAecb3tuxA+e3/jTSnd+92UMM9beHHsVjBYieC72x3kGniWu/ytoP6l2SsWoAqh3b7D
         WGJblxFYh49+avoKTCRHtORGHVrrIiqGycGf+24veRLOz/QQ5FX/1KAvgHe2VviiQeSO
         v8001wNtfTcAwI+hyOZDYZaok79hvpTlIuH6P06Q4/dT2KOxzDLLIkvwzxzyribkb34+
         Ihhg0QcoqgFWUre7wEqqpaR8yVsea6dqu0NHzcryEQDR7CnVvViLSZ2hywAGGyg/SUyj
         FnQw==
X-Gm-Message-State: AOAM531s+jDGR98yVen4liA7K0EQb4kLEvXX4dSJC6sjt/NMiynE0nQU
        hbg+AjAoYWPi49SQFvp1VCb3YIfRsDIKQw==
X-Google-Smtp-Source: ABdhPJwS1/cjquS03YLO0L0ChcobUixvQ/8iYi7kAZ0ft3B7QrFrQlGRayCi9ey4/RSOkm8vIlo66Q==
X-Received: by 2002:adf:b30a:: with SMTP id j10mr40927272wrd.417.1620827309843;
        Wed, 12 May 2021 06:48:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/9] send-email: lazily load config for a big speedup
Date:   Wed, 12 May 2021 15:48:19 +0200
Message-Id: <patch-3.9-1e14d32253-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the time it takes git-send-email to get to even the most
trivial of tasks (such as serving up its "-h" output) by first listing
config keys that exist, and only then only call e.g. "git config
--bool" on them if they do.

Over a lot of runs this speeds the time to "-h" up for me from ~250ms
to ~150ms, and the runtime of t9001-send-email.sh goes from ~25s to
~20s.

This introduces a race condition where we'll do the "wrong" thing if a
config key were to be inserted between us discovering the list and
calling read_config(), i.e. we won't know about the racily added
key. In theory this is a change in behavior, in practice it doesn't
matter.

The config_regexp() function being changed here was added in
dd84e528a34 (git-send-email: die if sendmail.* config is set,
2020-07-23) for use by git-send-email. So we can change its odd return
value in the case where no values are found by "git config". The
difference in the *.pm code would matter if it was invoked in scalar
context, but now it no longer is.

Arguably this caching belongs in Git.pm itself, but in lieu of
modifying it for all its callers let's only do this for "git
send-email". The other big potential win would be "git svn", but
unlike "git send-email" it doesn't check tens of config variables one
at a time at startup (in my brief testing it doesn't check any).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 35 ++++++++++++++++++++++++++---------
 perl/Git.pm         |  4 ++--
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f9d859da3e..5b0b7c33ec 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -337,11 +337,13 @@ sub signal_handler {
 
 # Read our sendemail.* config
 sub read_config {
-	my ($configured, $prefix) = @_;
+	my ($known_keys, $configured, $prefix) = @_;
 
 	foreach my $setting (keys %config_bool_settings) {
 		my $target = $config_bool_settings{$setting};
-		my $v = Git::config_bool(@repo, "$prefix.$setting");
+		my $key = "$prefix.$setting";
+		next unless exists $known_keys->{$key};
+		my $v = Git::config_bool(@repo, $key);
 		next unless defined $v;
 		next if $configured->{$setting}++;
 		$$target = $v;
@@ -349,8 +351,10 @@ sub read_config {
 
 	foreach my $setting (keys %config_path_settings) {
 		my $target = $config_path_settings{$setting};
+		my $key = "$prefix.$setting";
+		next unless exists $known_keys->{$key};
 		if (ref($target) eq "ARRAY") {
-			my @values = Git::config_path(@repo, "$prefix.$setting");
+			my @values = Git::config_path(@repo, $key);
 			next unless @values;
 			next if $configured->{$setting}++;
 			@$target = @values;
@@ -365,14 +369,16 @@ sub read_config {
 
 	foreach my $setting (keys %config_settings) {
 		my $target = $config_settings{$setting};
+		my $key = "$prefix.$setting";
+		next unless exists $known_keys->{$key};
 		if (ref($target) eq "ARRAY") {
-			my @values = Git::config(@repo, "$prefix.$setting");
+			my @values = Git::config(@repo, $key);
 			next unless @values;
 			next if $configured->{$setting}++;
 			@$target = @values;
 		}
 		else {
-			my $v = Git::config(@repo, "$prefix.$setting");
+			my $v = Git::config(@repo, $key);
 			next unless defined $v;
 			next if $configured->{$setting}++;
 			$$target = $v;
@@ -380,9 +386,20 @@ sub read_config {
 	}
 }
 
+# Save ourselves a lot of work of shelling out to 'git config' (it
+# parses 'bool' etc.) by only doing so for config keys that exist.
+my %known_config_keys;
+{
+	my @known_config_keys = Git::config_regexp("^sende?mail[.]");
+	@known_config_keys{@known_config_keys} = ();
+}
+
 # sendemail.identity yields to --identity. We must parse this
 # special-case first before the rest of the config is read.
-$identity = Git::config(@repo, "sendemail.identity");
+{
+	my $key = "sendemail.identity";
+	$identity = Git::config(@repo, $key) if exists $known_config_keys{$key};
+}
 my $rc = GetOptions(
 	"identity=s" => \$identity,
 	"no-identity" => \$no_identity,
@@ -393,8 +410,8 @@ sub read_config {
 # Now we know enough to read the config
 {
     my %configured;
-    read_config(\%configured, "sendemail.$identity") if defined $identity;
-    read_config(\%configured, "sendemail");
+    read_config(\%known_config_keys, \%configured, "sendemail.$identity") if defined $identity;
+    read_config(\%known_config_keys, \%configured, "sendemail");
 }
 
 # Begin by accumulating all the variables (defined above), that we will end up
@@ -478,7 +495,7 @@ sub read_config {
     usage();
 }
 
-if ($forbid_sendmail_variables && (scalar Git::config_regexp("^sendmail[.]")) != 0) {
+if ($forbid_sendmail_variables && grep { /^sendmail/s } keys %known_config_keys) {
 	die __("fatal: found configuration options for 'sendmail'\n" .
 		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
 		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
diff --git a/perl/Git.pm b/perl/Git.pm
index 73ebbf80cc..06a10b175a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -754,8 +754,8 @@ sub config_regexp {
 	} catch Git::Error::Command with {
 		my $E = shift;
 		if ($E->value() == 1) {
-			my @matches = ();
-			return @matches;
+			# Key(s) not found.
+			return;
 		} else {
 			throw $E;
 		}
-- 
2.31.1.909.g789bb6d90e

