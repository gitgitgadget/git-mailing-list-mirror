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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E49C4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57643613DA
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhE1JZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhE1JZf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9CC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z17so2578152wrq.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Lgez7bXRJfnEo5NZCxZLVUuigKOPiYSLOjMB29Vs5E=;
        b=Wo2vMuo2HxwIvr6KbyIewRtI5161vZXqvVVYGvgzmYiUY1XVqz6/NmNRRjK4dDqPJk
         UoAmkrR7crg3Vv1HxxdQisNvKSF6KQvDzINAX7eLUxxfG7ARUj/oIPPkEo7beM8kKq7H
         05RjqnfxVnS+hSV2muT9c/U3Q+PH4dslICxMTRcrKYqyHv8MAFPM2JscAHxvFGIHXXZA
         q8wRGDEOZRnfGtDOdfFmfX0tU8ICjYwVs/ztjii8tXNPpr0YgzhchZIfjHf+od0sFQ04
         BLEPRobD1/TytI1H3TvzpkSO5E4wDhsbcg8uIs7Z0WTPLOLoDFQpUXkuyUSsLihN1bQR
         2I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Lgez7bXRJfnEo5NZCxZLVUuigKOPiYSLOjMB29Vs5E=;
        b=lgR8T9ge9knAEZrgrj4MRWJ0LV0/j53lpVvopum5DDAmnJ/RqeAOGm/rnZc7k6lG6c
         PHP4h0XnEB4zlqDAFlVtHfcNGyrnvonkmb3y9LtLJUu/c5vupGRFS9QWr1LeETN4vLt+
         Uph4qNMe7F8KNDrLMkPRbgmkp3ClDkUNPzD6kFsmoodkmhVQPg+VSVUBujDUcrb5wJCy
         cSlDLWL1zNNgSwNDsn3+C3qg2C7K2/6EQWy80R/FBMLuPsI4JTNtCugDQDeyYwt74jKe
         PbeFrEQ6AwY3dFfr30/tPExWzQxTfsA+If/nnlVDcpgl4FgcFAYRcZjKjw0D7sD0lkpI
         2zTg==
X-Gm-Message-State: AOAM530lPEM4R8JR9ENjVJw/NWqG9lz52mpviR6nuuv50cqp+i3T/eF4
        v7RIt7R6BqSj5HerwFTnUNIBwXimzv8hwQ==
X-Google-Smtp-Source: ABdhPJxRJzKmBkEjCmqSkYR7nHyvkzULdfA6rCHuZO1Xov8geBalrhPvuKTWELPuQEOvEPaW9U780A==
X-Received: by 2002:a5d:678d:: with SMTP id v13mr7715137wru.83.1622193839657;
        Fri, 28 May 2021 02:23:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:59 -0700 (PDT)
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
Subject: [PATCH v5 06/13] send-email: lazily load config for a big speedup
Date:   Fri, 28 May 2021 11:23:45 +0200
Message-Id: <patch-06.13-4cf70c6f97e-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 73e3d3fd26e..de62cbf2506 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -347,11 +347,13 @@ sub signal_handler {
 
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
@@ -359,8 +361,10 @@ sub read_config {
 
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
@@ -375,14 +379,16 @@ sub read_config {
 
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
@@ -408,9 +414,20 @@ sub config_regexp {
 	return @ret;
 }
 
+# Save ourselves a lot of work of shelling out to 'git config' (it
+# parses 'bool' etc.) by only doing so for config keys that exist.
+my %known_config_keys;
+{
+	my @known_config_keys = config_regexp("^sende?mail[.]");
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
@@ -421,8 +438,8 @@ sub config_regexp {
 # Now we know enough to read the config
 {
     my %configured;
-    read_config(\%configured, "sendemail.$identity") if defined $identity;
-    read_config(\%configured, "sendemail");
+    read_config(\%known_config_keys, \%configured, "sendemail.$identity") if defined $identity;
+    read_config(\%known_config_keys, \%configured, "sendemail");
 }
 
 # Begin by accumulating all the variables (defined above), that we will end up
@@ -506,7 +523,7 @@ sub config_regexp {
     usage();
 }
 
-if ($forbid_sendmail_variables && (scalar config_regexp("^sendmail[.]")) != 0) {
+if ($forbid_sendmail_variables && grep { /^sendmail/s } keys %known_config_keys) {
 	die __("fatal: found configuration options for 'sendmail'\n" .
 		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
 		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
-- 
2.32.0.rc1.458.gd885d4f985c

