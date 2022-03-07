Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A8AC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbiCGMo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242009AbiCGMos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4F3617A
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q20so6769025wmq.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDIe8o6Z+fh3mHSscQLrFTm9C+Vzi5B6ANToWE0fH/A=;
        b=iyOgBFrv6P7yZZnM97AZSA4J+hvwxr+26rTcoGGVew1qsMyLwI6HLtph+krQ4oHPXC
         aGpDVqX99MrVbgkBUm++M8CP4naZO6dpRu/D9m1sjSjQn0W2Tr3a/rHT6vW8/tQLVPR9
         spgCXKOz3vZg3ipPwFPCEaIZe+YqMtmU9S6jkBwv7LhpXeka/oKJ35s0j/R7NCGIIsGL
         bdYDru24d5n9IE/d5MIFKVDkgYugCUiJN0AyMKQe9TaAEiqi7kP/1rF5+xG8AR+p+W1j
         MUtnZ3xSiXrQB4AO5vq5froWS+RT/R+ZenBRFjuf0n7zvBlZXkhYeQiRiRrVanFJ0Rwc
         VuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDIe8o6Z+fh3mHSscQLrFTm9C+Vzi5B6ANToWE0fH/A=;
        b=dVR1MXoqGKLtdY4PAQRKqs4tE9XPy2LEPeGm6uOHrVMUcJGBlOY53z0mcZjYTiXr8D
         VBsed8B2rW3FHUbtNSvdflChT1Oc5IrrWhNQPdHvExG6bVQURGgOiDlBAmbk7q+ddJLD
         flYRZ7zx8sqTYMWd7RD3NBxKziIO5HQQqUEzMWMhLxp1uxbQtXh6qDnEZgPy0ZJoFiYe
         hdbRI3WXuYBXLmrcbWJWlx2eGCJRAxjyggb+ZyYdStn8QHi98AFhdTjMeC3UymyOTnQ6
         His5Yf4JnKxcyG30e/E5iTdVW2bZwVk0LFQ6oq2IFHQKXrbWsPgQowxos1bX6zwy5+E2
         fsBw==
X-Gm-Message-State: AOAM531jvmglAljjGGPJypENZupKLTptqP0Om87qPD72l0Y6zjoS1LLk
        a4IB14AB+DoOZJ4FmamquiWyza82gpfEww==
X-Google-Smtp-Source: ABdhPJzZJGw/s6WNj7Xsw4XOrKgXTnURPmZvp2M9Htg1GDgjQsl8Zb582vEEo6ffED4RQ9Wj4K7iyQ==
X-Received: by 2002:a05:600c:205a:b0:380:d03d:9cd5 with SMTP id p26-20020a05600c205a00b00380d03d9cd5mr18214672wmg.89.1646657031781;
        Mon, 07 Mar 2022 04:43:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] bugreport tests: tighten up "git bugreport -s hooks" test
Date:   Mon,  7 Mar 2022 13:43:35 +0100
Message-Id: <patch-v2-04.10-8dd7b40e510-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 788a776069b (bugreport: collect list of
populated hooks, 2020-05-07) to "test_cmp" for the expected output,
instead of selectively using "grep" to check for specific things we
either expect or don't expect in the output.

As noted in a preceding commit our .git/hooks directory already
contains *.sample hooks, so we have no need to clobber the
prepare-commit-msg.sample hook in particular.

Instead we should assert that those *.sample hooks are not included in
the output, and for good measure let's add a new "unknown-hook", to
check that we only look through our own known hooks. See
cfe853e66be (hook-list.h: add a generated list of hooks, like
config-list.h, 2021-09-26) for how we generate that data.

We're intentionally not piping the "actual" output through "sort" or
similar, we'd also like to check that our reported hooks are sorted.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0091-bugreport.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index eeedbfa9193..d51e18b0bb9 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -60,18 +60,22 @@ test_expect_success 'can create leading directories outside of a git dir' '
 
 test_expect_success 'indicates populated hooks' '
 	test_when_finished rm git-bugreport-hooks.txt &&
-	test_when_finished rm -fr .git/hooks &&
-	rm -fr .git/hooks &&
-	mkdir .git/hooks &&
-	for hook in applypatch-msg prepare-commit-msg.sample
-	do
-		write_script ".git/hooks/$hook" <<-EOF || return 1
-		echo "hook $hook exists"
-		EOF
-	done &&
+
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	true
+	EOF
+	write_script .git/hooks/unknown-hook <<-\EOF &&
+	true
+	EOF
 	git bugreport -s hooks &&
-	grep applypatch-msg git-bugreport-hooks.txt &&
-	! grep prepare-commit-msg git-bugreport-hooks.txt
+
+	sort >expect <<-\EOF &&
+	[Enabled Hooks]
+	applypatch-msg
+	EOF
+
+	sed -ne "/^\[Enabled Hooks\]$/,/^$/p" <git-bugreport-hooks.txt >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.35.1.1242.gfeba0eae32b

