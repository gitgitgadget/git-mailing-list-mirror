Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17AEC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A7A61184
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhETIUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhETIUj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A0C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j14so14922979wrq.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjWYfUkOLhfBqzRrvPIkPY20lr+lidbzK5DR35M+UHs=;
        b=kNApqOByEccrSeK4YTf/Iwu9m0zcexpaIseTZw6WQRg0z9KXLrJ3G87grho2kpqsgl
         HwFmCN1EUzJA0WkAntAuY6Dbr//db13Rh9+qcNey3pNmLcXw0EFdCWPCtbyUKE9uNyi1
         aQpDeSLhPnxkUHE3WorOwmIpvxAGpapmmsMF3mGlxWLeR9NsVUBuMNMkn532ANt1Kx+o
         P16PLkzOGwLnkY3Y6taUMyB7wpyEZX/KcVfayTsK8u2NZ95c02oly04B6QoTeuSq1hdk
         Oks/R8OQMvvH3OOEw9o6sL6j4PPA0/P92ZDoqEHrMQAnTcKVBwcrUmh6RudU6VfuLIdu
         jXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjWYfUkOLhfBqzRrvPIkPY20lr+lidbzK5DR35M+UHs=;
        b=nlbKjLrtNgopJn0/wjH+QDmhYWjsNgHQ+uBomR5UpoS1XcfeipsgpvipZxc4CFqThF
         Z8kwCCZ3+v9hj69vMP+ipUI6p5Hci721/xZo3MfxcuBr5htR78LvzahGZ9ZKDFYSp7xx
         tBce48hGeiZNd0nAUXQqvt7HPhoQLHckKfk3IyaNLOzOVyNpVkfx8IBZ3ZxIn7y4lUuS
         N2dvJBLKTNwRHKWY1Es6Nhe8EkDiK5ytIjs/oY3p4UB/pQtWrD/oEbJJKOMVkF2liowE
         pgTsG3oGh9jqQyjL6M7aIT1tzWZIMf1zFZfABADzthuWnepWt1nhrnkZ5MhmxHQA5RA3
         GKfQ==
X-Gm-Message-State: AOAM532P2S6f9DRJQWUqjzKu1X5LBmGTEWI8HCIHLg0Rr3RbOEGh9iqY
        xfd4UbJzLiaXrWzPTy8uyyTMMnkUUDJYyQ==
X-Google-Smtp-Source: ABdhPJwoWuymEsBkI0Gn2r3yL6eWRykEJrWWuAk5mVrAmz87HrtHaByqczf5sF6Npl65VcZu8enn5Q==
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr3002802wrx.222.1621498755672;
        Thu, 20 May 2021 01:19:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] send-email: lazily load config for a big speedup
Date:   Thu, 20 May 2021 10:19:00 +0200
Message-Id: <patch-03.10-1b27a393ae3-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
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
index f9d859da3ed..5b0b7c33ec6 100755
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
index 73ebbf80cc6..06a10b175a7 100644
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
2.32.0.rc0.405.g5d387561bb3

