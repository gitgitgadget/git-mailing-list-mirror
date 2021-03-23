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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AD3C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14270600EF
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCWRdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhCWRdm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 13:33:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933CAC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 10:33:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso13465536wmi.3
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHKjq+sx++2VIHUtHq1WIcRqQnpcK15kXxpDu5bcxZc=;
        b=p+lM6lFntv/IzguXYLTleaQxEceXJTtoD58KZXHBPfMdpOWoCtzwxTQhGv9C/Vs32V
         NM1iA2NtBk0NnAwHXNoU/zyE5pA5s6FonOvo/yvxzTsdopl3JgaSCqnpBE9ZoyYrweoV
         pczq2QLOh4M9SLI2YYRanwaNM/q5ZengVOFXlaa5T9J/uBlagnZgsSQL9jOLL6DYSARm
         PyjLZ2zn0o7y81wPWtRuLNfghdCETYJMW9fsZCR8p6ODQ4yZ/9AxdrAk+0ieOIhQhohE
         C0yxtOKhzbexhe6oxQfQvr23fsk8OIjSANQeU+VRipLvQLg7lTYT42Z2wx1UvjpnJuuJ
         IzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHKjq+sx++2VIHUtHq1WIcRqQnpcK15kXxpDu5bcxZc=;
        b=N/fAhOz8IpBJlPrjdwDBGBf2CewzFNLenxbLorZViajE47NIPnPYn6Zan1g/KS9XrU
         p96qgnjnIceReXoXwn9SXQFuHVBhsqcj15O9QTrPMnUg3bn6qP9VtaR2W7xb3XndNWOw
         KE4EerXUImEv5MtMCIBAVqGPDYwqG5E0Pgq4aEYKFzXy9VRWnLbbUkyjqPzdyo5ZTMSr
         xNChONuJZEz9qtZR4CpKJ0/M/bOG5Ag3yLPyF5tgSPTNn00cl4GvfnVLxgytvevZHCg8
         oMtxx2Mnsb9c+P12kwnAHmN0Y4epnhjos8Xn4Pewmuhc8UCjsB53yCUdnoE0PQm+hG4D
         4SEw==
X-Gm-Message-State: AOAM531ZRCfzEv2fMhsha6J+R8MErCMQYcjHIok+IMwd4rhuxZtwy4Qe
        +2tR/hB+5C96BMnvvfCHyVejYbJuEEwuyA==
X-Google-Smtp-Source: ABdhPJzJps9JDKIj7fmkW40cB+/SK5il2tiNYDwkNiynbNf/Ey6QUlvfWWkuWOv8yV/kuu5fS5dlyg==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr4345020wmo.8.1616520819887;
        Tue, 23 Mar 2021 10:33:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p27sm3179337wmi.12.2021.03.23.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:33:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Robert Foss <robert.foss@linaro.org>,
        Drew DeVault <sir@cmpwn.com>,
        Rafael Aquini <aquini@redhat.com>,
        =?UTF-8?q?Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] git-send-email: Respect core.hooksPath setting
Date:   Tue, 23 Mar 2021 18:33:27 +0100
Message-Id: <patch-1.1-cc0ba73974a-20210323T173032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <20210323162718.1143982-1-robert.foss@linaro.org>
References: <20210323162718.1143982-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Foss <robert.foss@linaro.org>

get-send-email currently makes the assumption that the
'sendemail-validate' hook exists inside of the repository.

Since the introduction of 'core.hooksPath' configuration option in
867ad08a261 (hooks: allow customizing where the hook directory is,
2016-05-04), this is no longer true.

Instead of assuming a hardcoded repo relative path, query
git for the actual path of the hooks directory.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Here's a v3 that fixes various issues with Robert's v2. Range-diff &
updated patch below.

The advice I had in the v1 feedback about GetHooksPath was bad, just
having it be a new accessor is better. It's not like anyone is calling
this in a loop.

Range-diff:
1:  56c181cf091 ! 1:  cc0ba73974a git-send-email: Respect core.hooksPath setting
    @@ Commit message
         'sendemail-validate' hook exists inside of the repository.
     
         Since the introduction of 'core.hooksPath' configuration option in
    -    v2.9, this is no longer true.
    +    867ad08a261 (hooks: allow customizing where the hook directory is,
    +    2016-05-04), this is no longer true.
     
         Instead of assuming a hardcoded repo relative path, query
         git for the actual path of the hooks directory.
     
         Signed-off-by: Robert Foss <robert.foss@linaro.org>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-send-email.perl ##
     @@ git-send-email.perl: sub validate_patch {
    @@ git-send-email.perl: sub validate_patch {
      
      	if ($repo) {
     -		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
    --					    'sendemail-validate');
    -+		my $hook_path = $repo->hooks_path();
    -+		my $validate_hook = catfile($hook_path, 'sendemail-validate');
    ++		my $validate_hook = catfile($repo->hooks_path(),
    + 					    'sendemail-validate');
      		my $hook_error;
      		if (-x $validate_hook) {
    - 			my $target = abs_path($fn);
     
      ## perl/Git.pm ##
    -@@ perl/Git.pm: sub repository {
    - 			$opts{Repository} = abs_path($dir);
    - 		}
    - 
    -+                $opts{HooksPath} = $search->command_oneline('rev-parse', '--git-path', 'hooks');
    -+
    - 		delete $opts{Directory};
    - 	}
    - 
     @@ perl/Git.pm: sub _prompt {
      
      sub repo_path { $_[0]->{opts}->{Repository} }
    @@ perl/Git.pm: sub _prompt {
     +
     +=cut
     +
    -+sub hooks_path { $_[0]->{opts}->{HooksPath} }
    ++sub hooks_path {
    ++	my ($self) = @_;
    ++
    ++	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
    ++	my $abs = abs_path($dir);
    ++	return $abs;
    ++}
      
      =item wc_path ()
      
    @@ t/t9001-send-email.sh: do
      
      done
      
    -+test_expect_success $PREREQ "--validate respects core.hooksPath path" '
    ++test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
     +	clean_fake_sendmail &&
    -+	tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX) &&
    -+	printf "#!/bin/sh" >> $tmp_dir/sendemail-validate &&
    -+	printf "return 1" >> $tmp_dir/sendemail-validate &&
    -+	chmod a+x $tmp_dir/sendemail-validate &&
    -+	git -c core.hooksPath=$tmp_dir send-email \
    ++	mkdir my-hooks &&
    ++	test_when_finished "rm my-hooks.ran" &&
    ++	write_script my-hooks/sendemail-validate <<-\EOF &&
    ++	>my-hooks.ran
    ++	exit 1
    ++	EOF
    ++	test_config core.hooksPath "my-hooks" &&
    ++	test_must_fail git send-email \
    ++		--from="Example <nobody@example.com>" \
    ++		--to=nobody@example.com \
    ++		--smtp-server="$(pwd)/fake.sendmail" \
    ++		--validate \
    ++		longline.patch 2>err &&
    ++	test_path_is_file my-hooks.ran &&
    ++	grep "rejected by sendemail-validate" err
    ++'
    ++
    ++test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
    ++	test_config core.hooksPath "$(pwd)/my-hooks" &&
    ++	test_when_finished "rm my-hooks.ran" &&
    ++	test_must_fail git send-email \
     +		--from="Example <nobody@example.com>" \
     +		--to=nobody@example.com \
     +		--smtp-server="$(pwd)/fake.sendmail" \
     +		--validate \
    -+		longline.patch \
    -+		2>&1 >/dev/null | \
    -+	grep "rejected by sendemail-validate"
    ++		longline.patch 2>err &&
    ++	test_path_is_file my-hooks.ran &&
    ++	grep "rejected by sendemail-validate" err
     +'
     +
      for enc in 7bit 8bit quoted-printable base64

 git-send-email.perl   |  2 +-
 perl/Git.pm           | 13 +++++++++++++
 t/t9001-send-email.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1f425c08091..f5bbf1647e3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1942,7 +1942,7 @@ sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
-		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
+		my $validate_hook = catfile($repo->hooks_path(),
 					    'sendemail-validate');
 		my $hook_error;
 		if (-x $validate_hook) {
diff --git a/perl/Git.pm b/perl/Git.pm
index 02eacef0c2a..73ebbf80cc6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -619,6 +619,19 @@ sub _prompt {
 
 sub repo_path { $_[0]->{opts}->{Repository} }
 
+=item hooks_path ()
+
+Return path to the hooks directory. Must be called on a repository instance.
+
+=cut
+
+sub hooks_path {
+	my ($self) = @_;
+
+	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
+	my $abs = abs_path($dir);
+	return $abs;
+}
 
 =item wc_path ()
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4eee9c3dcb5..1a1caf8f2ed 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -513,6 +513,38 @@ do
 
 done
 
+test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
+	clean_fake_sendmail &&
+	mkdir my-hooks &&
+	test_when_finished "rm my-hooks.ran" &&
+	write_script my-hooks/sendemail-validate <<-\EOF &&
+	>my-hooks.ran
+	exit 1
+	EOF
+	test_config core.hooksPath "my-hooks" &&
+	test_must_fail git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--validate \
+		longline.patch 2>err &&
+	test_path_is_file my-hooks.ran &&
+	grep "rejected by sendemail-validate" err
+'
+
+test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
+	test_config core.hooksPath "$(pwd)/my-hooks" &&
+	test_when_finished "rm my-hooks.ran" &&
+	test_must_fail git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--validate \
+		longline.patch 2>err &&
+	test_path_is_file my-hooks.ran &&
+	grep "rejected by sendemail-validate" err
+'
+
 for enc in 7bit 8bit quoted-printable base64
 do
 	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '
-- 
2.31.0.366.ga80606b22c1

