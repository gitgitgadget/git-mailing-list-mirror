Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D40BC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDFB610F8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbhIGK7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbhIGK7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4137CC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v10so13781197wrd.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHYIxajtkUyojn1F4BH6Y2hATQ5sJwhM+//9NYKMkaU=;
        b=Dzn+GeMHDPJGUDt+8C1GSDuSNSKfG1H1f62aStYlvwO5WeMlScKnPndglukeLsGH8u
         6XpXJ+cc7al59uyxoV5HLRsZ1DyZ4RxRVUWRU48/JvsHlPQiD4FycckXGFBp8/E8XVtT
         P6y8B3MEpO4DZ3WnA6Vlh+hpmp/b4HPMCfder+z0A5yA/0ZJF67DUTcT64KOgJioa5bf
         lQElu8WPgPvDYeCLhV9XeIH0zadeHAzSyHGKyLGN1eo/aZPAFCNFdQS47b3fDAK2Oq9R
         UOUsKgqanDcp+ea4fMjtGEU4aQv3NlNNj695uKCeceUbIuctvrcRL77HrvbGVyLebVEQ
         /SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHYIxajtkUyojn1F4BH6Y2hATQ5sJwhM+//9NYKMkaU=;
        b=rQLHWmXBzfTfk6KWPh8tOqcipbThehV301MExPNJZriRGYDAFLumcrT9yHhPernzHY
         GywVI6ECX3I0+CeyEfw1wA1Kr1yz5tIUSqvczuhQbvlEW3ewRcwq95MnqMXdasIguNX7
         qMHmxO6WVRXaEkMtaFIz9OEuWL3GVjQmQWgDbJtSX4u28hVXzSfZteNyF8Sfy5xmbP7j
         IiZ8g+3bHF7PKeLpj1G39NJy0fEXKYJtti4Hbuq40H6QAIoE/XQHhD9bRQzTfFTwvgI0
         ZwI3SvUfb8MeW13dy/mSa4AYiwzTo4EAoMw2r25N5v2TnXb2rSFWbtItT1ZCh/L4mDrC
         zH0w==
X-Gm-Message-State: AOAM532C7zVJw3jKypDGN3os+iAvh9ChD4tVVXCxShTFbKAlz28ZVmU7
        ce/bFfngr77umZIco1eNk4Lbz/Onw9kPTA==
X-Google-Smtp-Source: ABdhPJwoJBZTe0oro777mwRgj0fG896vG/widTiDkRD2fYaBPLD+HPStxuwcYnYb31Hkb8+pYYD/Zw==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr17764836wrs.436.1631012305625;
        Tue, 07 Sep 2021 03:58:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 02/22] fsck tests: add test for fsck-ing an unknown type
Date:   Tue,  7 Sep 2021 12:57:57 +0200
Message-Id: <patch-v6-02.22-9072eef3be3-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 7becab5ba1e..f10d6f7b7e8 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -863,4 +863,16 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	git init --bare garbage-type &&
+	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
+	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_done
-- 
2.33.0.815.g21c7aaf6073

