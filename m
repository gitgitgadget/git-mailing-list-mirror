Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DF0C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbiCGMoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiCGMoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39288344CE
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n15so8950123wra.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdVU8jYQxYaz/fFx8Jtd+W3UfzrvK7ikWzseBQJyAh4=;
        b=MalenUqjhYsbnJYycpA021+qjnhVNCQ+hUCTVYpf87c6oXiKCDVh68jUNM1E54FSjq
         bBLAdy1bDCwRWVOpBf8P1ubgWISY9F6xYsSHQ0RrB1BHbOh+BUv43mYgYZVQ2bzuHmfP
         mEoKEJHLzIkzkt4nsjk3QiVla6lwXcMCeZVeM9rBTE2vxfAeAU+4avguZ59VR5Jsv8nD
         O8EQG/VfzSYpdyrle4SVrj7SYv3SLATJI8i0BABmLJxXuPRQZZlgwCdxkAEDXLrxzrIg
         RsZk+P2TDK1Hig1HZOAsM0ulcAJFypIbg3UNoQFAFz/OOG153w6tYS4zby+GuOPLdVeh
         nr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdVU8jYQxYaz/fFx8Jtd+W3UfzrvK7ikWzseBQJyAh4=;
        b=ouf6+8L+wnGuItv5nBPfp61tlZmOQkGGzUtJzyapjpE4swdCL0G4iE57cCzQShTcDI
         ZL+bVmuVNhzb+t4GUJFxT3UDi2WXTbugkP2UPYWM1G00RMhz9f1Q9tZ+ZfQehEWaANhI
         /ke0IWW4b+wGus852iD4i6TF2t2iIWhsF/0X2hraoCf3S3btnym9W6lt2YqhBxXbspmR
         Dfd0QRYjrkOo5pzyANBlUFYTe2aPNJ6uRU3C/0QQUZ9Q3TmEzz7EePbOp2x0kM/G+zdH
         0TalWlfgUhmQ3uXwhBNmiY7za5LJhEXT0HsW/WMana9kVP5h6zpzd2ulw72SR2W3URcg
         /AJA==
X-Gm-Message-State: AOAM531DF3BxbO5HECut5UAf3vVif8UtckQeJJUckH1lYPEVvnTIKKPe
        OlPR39llps7TEEXQrvKq4tjznns3AIo+AA==
X-Google-Smtp-Source: ABdhPJwPOCaD63Vdgub/Fpu9fd+ZTWuTUiYphxRLGkK6o6/fpO8UOWCWK27HlFRauPSalH9aa3CEPQ==
X-Received: by 2002:a5d:64e9:0:b0:1f1:e729:1f3a with SMTP id g9-20020a5d64e9000000b001f1e7291f3amr5106413wri.387.1646657028522;
        Mon, 07 Mar 2022 04:43:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] hook tests: turn exit code assertions into a loop
Date:   Mon,  7 Mar 2022 13:43:32 +0100
Message-Id: <patch-v2-01.10-706460d10b9-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) to use a for-loop instead of a copy/pasting the same test
for the four exit codes we test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 29718aa9913..ff64597e959 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -53,31 +53,16 @@ test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
 	test_must_be_empty stdout.actual
 '
 
-test_expect_success 'git hook run: exit codes are passed along' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 1
-	EOF
-
-	test_expect_code 1 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 2
-	EOF
-
-	test_expect_code 2 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 128
-	EOF
-
-	test_expect_code 128 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 129
-	EOF
-
-	test_expect_code 129 git hook run test-hook
-'
+for code in 1 2 128 129
+do
+	test_expect_success "git hook run: exit code $code is passed along" '
+		write_script .git/hooks/test-hook <<-EOF &&
+		exit $code
+		EOF
+
+		test_expect_code $code git hook run test-hook
+	'
+done
 
 test_expect_success 'git hook run arg u ments without -- is not allowed' '
 	test_expect_code 129 git hook run test-hook arg u ments
-- 
2.35.1.1242.gfeba0eae32b

