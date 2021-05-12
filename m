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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE038C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91F9613DE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhELNtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhELNtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B053C06174A
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so2543460wmk.1
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPqhES7iLH/XzpFLmkAnSQsFzxlm2Z5XcL2ZrDZRsd8=;
        b=TUgdE1zf30JYdRlrY1n0PIeGDMLWA+uQ2WUM73v4nFTucfkXhZ5OdRbA0As44+Ld4Q
         m4fyOFjszSE5N2Xl0mven1hLxXRw3FrsML7mI0U71ixTuYY9I8PIj29y0yURknuPXOvr
         HXzOqAutplYFOuBNdG1rHYBBLk0uJXPGS1ZjfnZuIlJmHbNrZuZvtUNR14YMqHnZLX93
         b+r0jZMVPGKTcMCw0jVKGOErzx9WMSN4/JSJfCvvoQbt9zwP8T4B4/2+E0UMxsXIAY6Q
         mhe/hw36ENhqDwCBprF2ACP+IytIYB8+KtLsR8YMAmnWJoPqgUgpeIImU30+R29G2yl6
         ZqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPqhES7iLH/XzpFLmkAnSQsFzxlm2Z5XcL2ZrDZRsd8=;
        b=ktWUkJjA2zS0rGZ/2hkvup17sEOpOzK9tfJBF+yjaui8mgfAcFWLCMKnSu6XcRPlWq
         93feny+H6ynSvvFReWwucNs+juX/gyLWaUVT1TGSQHedAT3niL6G8gzYeQfLvKOf9fX/
         Cb5QW6JWkFg766poY21wj4jdLxFlFM7voA+CsZ79mpiYQWHzXgiT7H46NE4zF+vO3lei
         42/NuGMeeo5sd19VZAspB/EgYxlhfvvU0dwqkn0Lj9VQdEdKEQVOIIeP5D2IylTqSBxd
         +huw6vFOKgduU0MYc8eXouBCA5XWOUQhx6lCQOsNt88sfGcru4FQHyhQA0MAvBjShnJc
         LZjw==
X-Gm-Message-State: AOAM532tBU7K73OakzidhVkot2nIAF761T37MECJij/peOfgEtIVw67Y
        9g3PfaU3xCKkMtMocC/1n/Kk0BfUhDtCvA==
X-Google-Smtp-Source: ABdhPJxElEkXIoRy51wR7WYhH9plp43v8sY5QygJtS7MEumCNqAFh8cYC7q6UIhG8EzTaYsV3p+LuA==
X-Received: by 2002:a1c:a94a:: with SMTP id s71mr8692192wme.15.1620827314751;
        Wed, 12 May 2021 06:48:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 9/9] send-email: move trivial config handling to Perl
Date:   Wed, 12 May 2021 15:48:25 +0200
Message-Id: <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize the startup time of git-send-email by using an amended
config_regexp() function to retrieve the list of config keys and
values we're interested in.

For boolean keys we can handle the [true|false] case ourselves, and
the "--get" case didn't need any parsing. Let's leave "--path" and
other "--bool" cases to "git config". As noted in a preceding commit
we're free to change the config_regexp() function, it's only used by
"git send-email".

This brings the runtime of "git send-email" from ~60-~70ms to a very
steady ~40ms on my test box. We no run just one "git config"
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
index 907dc1425f..35ba19470d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -325,7 +325,10 @@ sub read_config {
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
@@ -354,14 +357,12 @@ sub read_config {
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
@@ -372,8 +373,10 @@ sub read_config {
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
index f18852fb09..a9020d0d01 100644
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
2.31.1.909.g789bb6d90e

