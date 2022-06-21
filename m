Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB40CCA473
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiFUWVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiFUWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:21:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D583135A
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g27so14171773wrb.10
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWsDK28mCl0sErmJFrqa4bPLeo7EIeG7oSD3TXqnP2k=;
        b=dxirYjF49EZnDSegjNuR/u1GHHFuRfbvi38f85dfekkIHe+kbcpANODusssaBJoo1g
         5phNxAwO8vVqB5KAxk1nX9XOARQ7A5T777ETs48We6ZQ2jhnsGCrsLBrlFMfyCfR+OTK
         yNmmnShpllo0ViPQZHAj9za4FxWMK5SmV8x0ruyhBo7bEjEvuxOCMckqABlSECAz3iIP
         aXu8YCwEht0jhscsVdYGqeaxsTKrdHzkQe3QY8xPizg6rnFL/LjHsjYAMYq0NLjFjizh
         kZu+zb8K3c+Y1uCT8DZt5EdHGKLcGtubP3jMfm55Oxvjh/2jElOdzj0BidSdgIxhDESN
         IgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWsDK28mCl0sErmJFrqa4bPLeo7EIeG7oSD3TXqnP2k=;
        b=RkXwbagVzmPQWkhKOkDqQaGehrXkYnMmRO6TSzFecYzcu9MkxxnpGymXLGEVAd7u4m
         R23i0twW0OG0ZvBA6ODaNn4qKuSL5SyuZ8UvQsN3hYnK+qlep1xAM9Fxc9wbC04IIttW
         SZFm0IJwGZAXQx4XE07Qc0aHUt7F2IzSETEELC2ZI3437wxUjjwIabiEdMsnfHD2H1wJ
         opIsdsGvIJ8pWiuFhyjrTTH0vvLbkcSc+bHT2sXhu+X0uUfFfzeVAfeee3zRUgom+5S6
         EtAguODmfLjP9faw34Uvr0WEB6t7AKKev4TeC5FCu7EqcZqJ8vK8EplhFMyBYMaYjoQM
         1A1w==
X-Gm-Message-State: AJIora9gTti9sbVMT3F9csZo68g93o/65X6vqE3lrJ/8DYXhObTI1ZQv
        OHAKATWizdDQG535FgqrHsvxicRjhHsAAg==
X-Google-Smtp-Source: AGRyM1tBi0V7TSd0tncMUvpJ4kvKuPTLEY4P1B6yPQasjTfdkiEHFHxIVbd/sDWGluZvxWPwqYzRyA==
X-Received: by 2002:a5d:4352:0:b0:213:4910:6616 with SMTP id u18-20020a5d4352000000b0021349106616mr196235wrr.226.1655850105506;
        Tue, 21 Jun 2022 15:21:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b0020fe61acd09sm17547431wrr.12.2022.06.21.15.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:21:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] config tests: fix harmless but broken "rm -r" cleanup
Date:   Wed, 22 Jun 2022 00:21:40 +0200
Message-Id: <patch-3.3-f787b19f8c2-20220621T221928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "test_when_finished" cleanup phase added in 4179b4897f2 (config:
allow overriding of global and system configuration, 2021-04-19) has
never worked as intended, firstly the ".config/git" is a directory, so
we'd need the "-r" flag, but more importantly the $HOME variable
wasn't properly quoted.

We'd thus end up trying to remove the "trash" part of "trash
directory", which wouldn't fail with "-f", since "rm -f" won't fail on
non-existing files.

It's possible that this would have caused an actual failure if someone
had a $HOME with a space character in it, such that our "rm -f" would
fail to remove an existing directory, but in practice that probably
never happened.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1300-config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index d3d9adbb3db..da4d03813f1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2083,7 +2083,7 @@ test_expect_success '--show-scope with --show-origin' '
 '
 
 test_expect_success 'override global and system config' '
-	test_when_finished rm -f "$HOME"/.config/git &&
+	test_when_finished "rm -rf \"$HOME\"/.config/git" &&
 
 	cat >"$HOME"/.gitconfig <<-EOF &&
 	[home]
-- 
2.36.1.1239.gfba91521d90

