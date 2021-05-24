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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A2C47084
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFC2610C7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhEXHzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhEXHyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BDCC06138B
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n2so27581371wrm.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80+EYW6NjM60Uen6XNL/0YtPdzV4f5qP4D1wZu5x0Bg=;
        b=tqoQwwN+ghfGJbLRCLsi0zNGUQ1WFqvZlFY6hvOT7bO40LFoOi/WdqHx0GZDF4VGWZ
         mXRVTHU350EBRm7oGMib47VsMzHUexiK9+25xiTNHkwgRole36ys1bantmQIi2wu/PkU
         4w7SWzSyswqT+/5Av4ge1DTeuVaD8j6XsEXmS9cWoQG6j3710T+nIK3lqgsTYr2cEB5c
         1Y6S1TXIG++gTjpPtx5KwsvdOfudtBavG8wGSt3eGCVdR0Q8VJqLQZtmORDP2zc8/O3O
         PG5S7ZQvKgPQtFClveW8kXmb/kEmjU8YMiIm6o96GL8gB55R1oimMrX4gl6pw4k/N6M7
         N/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80+EYW6NjM60Uen6XNL/0YtPdzV4f5qP4D1wZu5x0Bg=;
        b=HTYMNELPxtnzAO4fInIDGv20Eq95bV/nL+SaEoQ/r5utG0HBp2ByxPGaff+oPWMHWi
         8C9cdKZ6Yndp0foxy3rxMIpHCGsLSiz6maQEQbfK4ffcQFi37vkFQXWdu86j2N8I7XuC
         AZ1w9RySKCvAWIPDt3aXbi41AfZrvCdgdv5pFQDBLGmdbPeLwdhde9mI9hqDDiIfxnjQ
         +xh4SHTEnoF1dCuPtYcIB6/vquNgoU4XHQYmFgwq3WaSF/DZzVEsLg+vjR2v7flX/8Pi
         2CjlQnpYfidoWlYeLLKp1Tx2s+NgmDJF444kc233UOfysOaOYv8kqI8skH5AhfYTacB7
         dtrg==
X-Gm-Message-State: AOAM530kS1WIALbGqaj2Idt5ZXpf23ZQRHVrAeuS1qmQfKPi0F0d/oyA
        vhgj00yg+0DXNpa6OyUYETm/ekHXpb8tYUIH
X-Google-Smtp-Source: ABdhPJyH6rfmp9KAuDxGIQ12unZSmouqr36hzhfoqiXJ/LcSkPPTjJrfEyBl06I1SUoipiWALPHDwg==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr21141501wrs.154.1621842795641;
        Mon, 24 May 2021 00:53:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/13] send-email: move trivial config handling to Perl
Date:   Mon, 24 May 2021 09:53:01 +0200
Message-Id: <patch-12.13-3818000bfba-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
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
other "--bool" cases to "git config". I'm not bothering with the
"undef" or "" case (true and false, respectively), let's just punt on
those and others and have "git config --type=bool" handle it.

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
 git-send-email.perl | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1e9273fd4f5..1ea4d9589d8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -324,7 +324,11 @@ sub read_config {
 		my $target = $config_bool_settings{$setting};
 		my $key = "$prefix.$setting";
 		next unless exists $known_keys->{$key};
-		my $v = Git::config_bool(@repo, $key);
+		my $v = (@{$known_keys->{$key}} == 1 &&
+			 (defined $known_keys->{$key}->[0] &&
+			  $known_keys->{$key}->[0] =~ /^(?:true|false)$/s))
+			? $known_keys->{$key}->[0] eq 'true'
+			: Git::config_bool(@repo, $key);
 		next unless defined $v;
 		next if $configured->{$setting}++;
 		$$target = $v;
@@ -353,14 +357,12 @@ sub read_config {
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
@@ -371,12 +373,19 @@ sub config_regexp {
 	my ($regex) = @_;
 	my @ret;
 	eval {
-		@ret = Git::command(
+		my $ret = Git::command(
 			'config',
-			'--name-only',
+			'--null',
 			'--get-regexp',
 			$regex,
 		);
+		@ret = map {
+			# We must always return ($k, $v) here, since
+			# empty config values will be just "key\0",
+			# not "key\nvalue\0".
+			my ($k, $v) = split /\n/, $_, 2;
+			($k, $v);
+		} split /\0/, $ret;
 		1;
 	} or do {
 		# If we have no keys we're OK, otherwise re-throw
@@ -389,8 +398,10 @@ sub config_regexp {
 # parses 'bool' etc.) by only doing so for config keys that exist.
 my %known_config_keys;
 {
-	my @known_config_keys = config_regexp("^sende?mail[.]");
-	@known_config_keys{@known_config_keys} = ();
+	my @kv = config_regexp("^sende?mail[.]");
+	while (my ($k, $v) = splice @kv, 0, 2) {
+		push @{$known_config_keys{$k}} => $v;
+	}
 }
 
 # sendemail.identity yields to --identity. We must parse this
-- 
2.32.0.rc1.385.g46e826f1e55

