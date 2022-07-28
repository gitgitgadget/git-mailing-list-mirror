Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926D0C19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiG1QRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiG1QRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C06FA37
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2805288wma.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3BFnMlEZs5zGB98nHzW/PkAKlkjBf8SoEBqAgosDV7A=;
        b=TBhgs81qQtzLm+vgKlwnO9Car3kw0NOjdn6XucgL8R8hmz8P4ogumrzJXOb6nNLhZP
         Pi3+NWGe13ibrcVpoy+t3U8KgI2+69Yk8xN9W/EeA58WJugVm4mUWg5gAQPWPoJ3WYjD
         haYeXzvZyIC9X/I/xXgqwfetVeSd8ROfQyhT/cByBtEDnHOmPzC2I+nidUNxt637hL/B
         ScmIKtTpRRdo54UAxOt6nT9z7H1/fY9vBgalfwZ+vTEt64ELl3s7Ly3LpjthA8E06BoJ
         hdjfLJl+3hE++Kv8ntqy8soE3hE2UC2BBp9zYHO7TUYMwM2JPbmvk6pxOotn4Xvb0oNM
         zPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3BFnMlEZs5zGB98nHzW/PkAKlkjBf8SoEBqAgosDV7A=;
        b=llG8ge/skAjFzZmdKMR0JKq0jwPxYV9cAEEQk/tBy5yTnA8590UfTW6apRov3lL91g
         Sv1AKTVJIQfoP9IUyn42MqPazcxiPHJLXriEjxTi1Ma63zVOKcHjEHjrpeAo2B7te4kv
         zybTiaZcFxzApxaEJP14nVCQA6GHZhgfWLTD5oG/P073QILVQ9DeNvCC73x7uBU3a48q
         zBVYA7f7kQ67ZXtTiLb1DAqHYIHOX/8n41LdrRG/0CSB3TlUtBEbGMbx+5vCRZcrl6P1
         qfYuiI5jeEPWtx0R+M8aq3KEJtjSgJOBS9JrfApQZZ5NmaZyiGmhfV8yKN4sFPDBg2bX
         hflQ==
X-Gm-Message-State: AJIora9MUOBNJ/ChpQgYB0q5gbbypkNJ0TspOv5A/AhyHy4l/3h31QSy
        48rHpOMfBnyIug0WqSW2pCCrIMPfshbE4g==
X-Google-Smtp-Source: AGRyM1u0gaLulDO0Ctp6rN09JqRR1paQ1Mq4I6CS84jJPHbKzOxv2zsDTV/mCzI8x8A/gwoJ+xr1VQ==
X-Received: by 2002:a05:600c:2652:b0:3a3:2a3e:a2de with SMTP id 18-20020a05600c265200b003a32a3ea2demr110762wmy.174.1659025031765;
        Thu, 28 Jul 2022 09:17:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/20] submodule tests: test for "add <repository> <abs-path>"
Date:   Thu, 28 Jul 2022 18:16:47 +0200
Message-Id: <patch-02.20-9671169e348-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for ""add <repository> <path>" where "<path>" is an
absolute path. This tests code added in [1] and later turned into an
"else" branch in clone_submodule() in [2] that's never been tested.

This needs to be skipped on WINDOWS because all of $PWD, $(pwd) and
the "$(pwd -P)" we get via "$submodurl" would fail in CI with e.g.:

	fatal: could not create directory 'D:/a/git/git/t/trash
	directory.t7400-submodule-basic/.git/modules/D:/a/git/git/t/trash
	directory.t7400-submodule-basic/add-abs'

I.e. we can't handle these sorts of paths in this context on that
platform.

I'm not sure where we run into the edges of "$PWD" behavior on
Windows (see [1] for a previous loose end on the topic), but for the
purposes of this test it's sufficient that we test this on other
platforms.

1. ee8838d1577 (submodule: rewrite `module_clone` shell function in C,
   2015-09-08)
2. f8eaa0ba98b (submodule--helper, module_clone: always operate on
   absolute paths, 2016-03-31)

1. https://lore.kernel.org/git/220630.86edz6c75c.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7400-submodule-basic.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b858871a953..6a77d817a82 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -178,6 +178,11 @@ test_expect_success 'submodule add' '
 	test_must_be_empty untracked
 '
 
+test_expect_success !WINDOWS 'submodule add (absolute path)' '
+	test_when_finished "git reset --hard" &&
+	git submodule add "$submodurl" "$submodurl/add-abs"
+'
+
 test_expect_success 'setup parent and one repository' '
 	test_create_repo parent &&
 	test_commit -C parent one
-- 
2.37.1.1167.g38fda70d8c4

