Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B427C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiF3KTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiF3KS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:18:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA9544A3F
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e28so21399804wra.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jijudV3EPmTrM0hNX0/0aAAkSegXMslW5NECjX1PsQ=;
        b=PUWZghWWJjO/H1vNEv6/jp8QQnZOp8J5Jyk0YG+P21JGjPbehTpkc05vqpAWN9k1iE
         kkd2kPDe2++kicevo6xxpYnOAB+552WpbHb7ZtogRiNvW4uxGR7L3cKVcgsYyk1VOXfc
         bCwBHhGolQcGPoMWsHNxcXQouYRgi4D7JypxdghWJNggL50A74Yn3eg/RFFfTogmNyDd
         OIwHNrTWdGminbNEfMc+iBPNAw3FE548i9TmXwd5fwzDQxpIfk0g3NyFA/0N9ztOUT5W
         M2QNQjH27Jrggsqq5otXAEwO0GrhkVYMtUm9gl14lGKmY59+5I/acFqWpEIzJD0kfBB1
         JLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jijudV3EPmTrM0hNX0/0aAAkSegXMslW5NECjX1PsQ=;
        b=GMup6OyD97SE6V7op0o0QnB4S7i4pKvzJjz3wxRN6XzlqdCnm3ZQBThuxKjhi3Fhhn
         ps90WK6+kGjUqsads4+nz9XS9nW4OgCoNBS6E7zru+KDk1jzniWmRoXxIzFJ9MvwyLN6
         VehM7ARxVzfsTzlLMbOG62GU9vRaoBCoq5kAyl5XFOIg9gtyDjVzCqTp5ahYNbWBgtFR
         pBnEdfwUhDhqzVLOGc1dcEtXz110V6faKIQfIisaFJL/tUrmfQgu+2MIxc/lehfLS1+s
         Ubv65/lYfHi3fqqVtrF21vYb2fHhajU3qNJPl2K7SeZv0JACm80iH0afij5JXliGLMvn
         4Hgg==
X-Gm-Message-State: AJIora9FHkssKoLuEO3jBO3EporV/oIC/RJHQ+Sn79QR7cEH/jISGeU0
        uRgRt53dwtnCNAR8lEsWaAnz5Hvq1M5PwQ==
X-Google-Smtp-Source: AGRyM1sStTVtZqC23ENOjlOA2XxSNhoSodMlj7eqdb+XWq5G37ZCxM4ATF/i3RFnPKva5GgO7VO91g==
X-Received: by 2002:a5d:5885:0:b0:21b:c665:13f7 with SMTP id n5-20020a5d5885000000b0021bc66513f7mr7768137wrf.427.1656584336010;
        Thu, 30 Jun 2022 03:18:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm5978427wmi.29.2022.06.30.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:18:55 -0700 (PDT)
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
Subject: [PATCH v2 3/3] config tests: fix harmless but broken "rm -r" cleanup
Date:   Thu, 30 Jun 2022 12:18:36 +0200
Message-Id: <patch-v2-3.3-d3f65326701-20220630T101646Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
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

Let's fix both the quoting issue, and the other issue cleanup issue in
4179b4897f2, which is that we were attempting to clean up
~/.config/git, but weren't cleaing up ~/.gitconfig.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1300-config.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index d3d9adbb3db..c6661e61af5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2083,12 +2083,13 @@ test_expect_success '--show-scope with --show-origin' '
 '
 
 test_expect_success 'override global and system config' '
-	test_when_finished rm -f "$HOME"/.config/git &&
-
+	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
 	cat >"$HOME"/.gitconfig <<-EOF &&
 	[home]
 		config = true
 	EOF
+
+	test_when_finished rm -rf \"\$HOME\"/.config/git &&
 	mkdir -p "$HOME"/.config/git &&
 	cat >"$HOME"/.config/git/config <<-EOF &&
 	[xdg]
-- 
2.37.0.880.gf07d56b18ba

