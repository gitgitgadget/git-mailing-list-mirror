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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B836C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360ED613F9
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhEZLXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhEZLXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 07:23:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B416C061756
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:21:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z17so712155wrq.7
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=macHCRmTdzghw0+6GUNGcAhiN6h3WAeXYz1F08uLUso=;
        b=OxuHrVRuiMd3W+OBYaWkKX8sHFZXUtxvr/c7oHyGKKF0Pc3V5PH93bCahWcUZaIi+j
         ejDyKvbqgtz3KdeYxMCEByHQcOgQ4r7M2XePXh5TJ4dkVZreGj1Qq2p+FQ2Yy/j8ImNC
         TeMyOgqVh0mlK3mffwCn7FT+bWB//OUExCunMkPcIJyMx2YXeVYDpZ+G/fGQKxuSETUY
         26liPH8lx8DbQ30oZb9sreSO5sA5mF1C+Ug9/6uweTmwrpA2WYGYlyqbIqgFmyteI0lo
         /f2n4cIfrETBcJEcJuJHFU/y5EnmFtvUDFEvJREXwzAWzs2Kswf4rEFanHhf3qjvUNGZ
         iOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=macHCRmTdzghw0+6GUNGcAhiN6h3WAeXYz1F08uLUso=;
        b=JIMv1XBJfULIr5azu0L9yQTcU9sZdjyzuiObHfNv2DNHNeMP2X5C0jBG1G9OJuh0pQ
         2oCGEJ2tTaAqNQkY0YxY9z3PLeeN9xl5PmeYXeGCr7Cf5RgGZP/IPRl3ECpYvSrE0iyk
         KuQt7u9EAuuSJMOT6zR6b6t3UY569lhfEfTw9AHBsxppkDZ1fDuKqVkJG6DPa6v6JaZB
         Pbp8/qfejkKrxTwcs4twzpWVcx+WN4A1GSonRVu1iyakmC636yxby1Ltq4S74beuSMRQ
         uBzygbFMYLpSaThkZnAvHD5BZI64Y8yAOOjUXTZ9Mbto6/uzpdUR/+A2T1oQkEpQ+CqR
         plbg==
X-Gm-Message-State: AOAM532JQ7kyQD6UQyh03B+ey5JYnc+5Ur2YwHs7U+EHOy61dYO/CINx
        xfKTsmwwWStVB3y/uR38z/xqGBdig5JzXQ==
X-Google-Smtp-Source: ABdhPJwLAqeu9gSCbRCJRXeOl7WRVGl+hAVk6C6/s0r0ZygGLYHYHUoC7pdxzqudB15gMrs+zX2yHQ==
X-Received: by 2002:adf:9069:: with SMTP id h96mr31978043wrh.322.1622028074437;
        Wed, 26 May 2021 04:21:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v15sm6163144wmj.39.2021.05.26.04.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 04:21:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] send-email: don't needlessly abs_path() the core.hooksPath
Date:   Wed, 26 May 2021 13:21:06 +0200
Message-Id: <patch-1.2-ff01d4619ea-20210526T111558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.400.g0a5a93401d3
In-Reply-To: <cover-0.2-00000000000-20210526T111558Z-avarab@gmail.com>
References: <xmqq5yz6ehpk.fsf@gitster.g> <cover-0.2-00000000000-20210526T111558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c8243933c74 (git-send-email: Respect core.hooksPath setting,
2021-03-23) we started supporting core.hooksPath in "send-email". It's
been reported that on Windows[1] doing this by calling abs_path()
results in different canonicalizations of the absolute path.

This wasn't an issue in c8243933c74 itself, but was revealed by my
ea7811b37e0 (git-send-email: improve --validate error output,
2021-04-06) when we started emitting the path to the hook, which was
previously only internal to git-send-email.perl.

The just-landed 53753a37d09 (t9001-send-email.sh: fix expected
absolute paths on Windows, 2021-05-24) narrowly fixed this issue, but
I believe we can do better here. We should not be relying on whatever
changes Perl's abs_path() makes to the path "rev-parse --git-path
hooks" hands to us. Let's instead trust it, and hand it to Perl's
system() in git-send-email.perl. It will handle either a relative or
absolute path.

So let's revert most of 53753a37d09 and just have "hooks_path" return
what we get from "rev-parse" directly without modification. This has
the added benefit of making the error message friendlier in the common
case, we'll no longer print an absolute path for repository-local hook
errors.

1. http://lore.kernel.org/git/bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm           | 3 +--
 t/t9001-send-email.sh | 7 ++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 73ebbf80cc6..df6280ebab5 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -629,8 +629,7 @@ sub hooks_path {
 	my ($self) = @_;
 
 	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
-	my $abs = abs_path($dir);
-	return $abs;
+	return $dir;
 }
 
 =item wc_path ()
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index aa603cf4d07..3b7540050ca 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,14 +539,15 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
+	hooks_path="$(pwd)/my-hooks" &&
+	test_config core.hooksPath "$hooks_path" &&
 	test_when_finished "rm my-hooks.ran" &&
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
@@ -557,7 +558,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
-- 
2.32.0.rc1.400.g0a5a93401d3

