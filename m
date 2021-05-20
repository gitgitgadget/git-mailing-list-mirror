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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD0C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3C860698
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhETIUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhETIUn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E5DC061760
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i17so16641764wrq.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oI+zdh2LxK7O2FozgT3O2YS+T0pHSpp8BMngjmveJRA=;
        b=Elqqhd1vkw70X4+KREiycBxPSM9E3CRwPaUde0oOWinMOeEORPuxNU6PPkAyVNTswy
         ljc4eVRHpGfLZNZbfM+gbyzC4KNL1m4acxCIesdDK7u5+ZufUEsIKuJkcVflvBgCLLAT
         ONmkWiyJujmABdea4ebEDVXqCyb34zvWyZeWajT663nk5g9EAKq7GA9/poWTEQbEzCuD
         Vm4kJFQbaLVSX68QK7tGGkima9V4Y0emQPRkxe7vknF/gqbjy/W/8H3ua20JW1oawKaX
         1qXhZdxyj5fCg1FOOyRSGuDXyxXwK/QkOPIaXZvjkdHoMDp2BbODixypRAOAW7NG06U5
         NwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oI+zdh2LxK7O2FozgT3O2YS+T0pHSpp8BMngjmveJRA=;
        b=rdW7s1vayFcEZ0/AUn6E/jkncCEzuIQd3gWF3J8O2s4gzu0S+zWv70+ACh9Mckwthc
         nxaOIpcjJetLnSV1zND4XaX97hdTrnwnrt339Cv6f7StcDVFisklnZw4+n3LrMNxjkVx
         FtOrGGsiHMkmpVZdzawCBPCin1HKHhXpOzLCdj60MLmzzrSaBx/9uLcTcAM/8OnlYUwE
         sEeYslILhWY9F3FYgr7XfNUZSwQfmmrJuZXein6NxopydJvbLfrMZ88iLQ4p+N0SHSrN
         prdJbSUqdl3xiDd+Q0iAaISIxFA5JwYjFt7Tm69zwPErwJtOuEleaX7hAfn9UsyXYXwp
         AThw==
X-Gm-Message-State: AOAM5302jckvm7Bgp8ULKsUKmI9IRyoOOggbV2I637x/E/Bi4pKFtTFh
        F5pk6UVHP1N/DVpzX7bTKsema2M2N0JKnw==
X-Google-Smtp-Source: ABdhPJw/XWsCJWKrb1JWGyssmLBRYcuscbRLGpY+XLKksHgVb81YKz0E7UWjCfkGnL402KlyJ8Jr2g==
X-Received: by 2002:adf:dd4c:: with SMTP id u12mr2994157wrm.224.1621498761118;
        Thu, 20 May 2021 01:19:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:20 -0700 (PDT)
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
Subject: [PATCH v2 09/10] send-email: move trivial config handling to Perl
Date:   Thu, 20 May 2021 10:19:06 +0200
Message-Id: <patch-09.10-895c9e29a96-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize the startup time of git-send-email by using an amended
config_regexp() function to retrieve the list of config keys and
values we're interested in. See the earlier "send-email: lazily load
config for a big speedup" commit for why changing its interface is OK.

For boolean keys we can handle the [true|false] case ourselves, and
the "--get" case didn't need any parsing. Let's leave "--path" and
other "--bool" cases to "git config". As noted in a preceding commit
we're free to change the config_regexp() function, it's only used by
"git send-email".

This brings the runtime of "git send-email" from ~60-~70ms to a very
steady ~40ms on my test box. We now run just one "git config"
invocation on startup instead of 8, the exact number will differ based
on the local sendemail.* config. I happen to have 8 of those set.

This brings the runtime of t9001-send-email.sh from ~13s down to ~12s
for me. The change there is less impressive as many of those tests set
various config values, and we're also getting to the point of
diminishing returns for optimizing "git send-email" itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 17 ++++++++++-------
 perl/Git.pm         | 10 +++++-----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a521f37c341..28b9a20a7f2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -324,7 +324,10 @@ sub read_config {
 		my $target = $config_bool_settings{$setting};
 		my $key = "$prefix.$setting";
 		next unless exists $known_keys->{$key};
-		my $v = Git::config_bool(@repo, $key);
+		my $v = (@{$known_keys->{$key}} == 1 &&
+			 $known_keys->{$key}->[0] =~ /^(?:true|false)$/s)
+			? $known_keys->{$key}->[0] eq 'true'
+			: Git::config_bool(@repo, $key);
 		next unless defined $v;
 		next if $configured->{$setting}++;
 		$$target = $v;
@@ -353,14 +356,12 @@ sub read_config {
 		my $key = "$prefix.$setting";
 		next unless exists $known_keys->{$key};
 		if (ref($target) eq "ARRAY") {
-			my @values = Git::config(@repo, $key);
-			next unless @values;
+			my @values = @{$known_keys->{$key}};
 			next if $configured->{$setting}++;
 			@$target = @values;
 		}
 		else {
-			my $v = Git::config(@repo, $key);
-			next unless defined $v;
+			my $v = $known_keys->{$key}->[0];
 			next if $configured->{$setting}++;
 			$$target = $v;
 		}
@@ -371,8 +372,10 @@ sub read_config {
 # parses 'bool' etc.) by only doing so for config keys that exist.
 my %known_config_keys;
 {
-	my @known_config_keys = Git::config_regexp("^sende?mail[.]");
-	@known_config_keys{@known_config_keys} = ();
+	my @kv = Git::config_regexp("^sende?mail[.]");
+	while (my ($k, $v) = splice @kv, 0, 2) {
+		push @{$known_config_keys{$k}} => $v;
+	}
 }
 
 # sendemail.identity yields to --identity. We must parse this
diff --git a/perl/Git.pm b/perl/Git.pm
index f18852fb09c..a9020d0d01f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -739,18 +739,18 @@ sub config_int {
 =item config_regexp ( RE )
 
 Retrieve the list of configuration key names matching the regular
-expression C<RE>. The return value is a list of strings matching
-this regex.
+expression C<RE>. The return value is an ARRAY of key-value pairs.
 
 =cut
 
 sub config_regexp {
 	my ($self, $regex) = _maybe_self(@_);
 	try {
-		my @cmd = ('config', '--name-only', '--get-regexp', $regex);
+		my @cmd = ('config', '--null', '--get-regexp', $regex);
 		unshift @cmd, $self if $self;
-		my @matches = command(@cmd);
-		return @matches;
+		my $data = command(@cmd);
+		my (@kv) = map { split /\n/, $_, 2 } split /\0/, $data;
+		return @kv;
 	} catch Git::Error::Command with {
 		my $E = shift;
 		if ($E->value() == 1) {
-- 
2.32.0.rc0.405.g5d387561bb3

