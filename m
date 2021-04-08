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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDACAC43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2FF61151
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhDHNez (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhDHNex (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:34:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D1C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:34:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g17so310210ejp.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxpqbkfOso1eomi+QsRD2k2ij49MteA8Y4vVVC6iab4=;
        b=A/RCorgghPRt/jdSfmLJrnjrA17ZOmBQRhfLfvlV1/Qeh+ATYKB8nK/CUXYrZdmmt6
         qcv4e/21153L/NVC+hYMtLzemtGSq5uPodelYgB97tZVGp08HoxaJRo6J8ZtALS1hNBt
         NyVGdZli7dYNsmt8LtGxRdYA4KJoC802D2gOkFUjGFH6CY87cau2qSCe3n9SSKIw8+T5
         dPnwP1k69Cc5cLPQMwU25P7arqW1/UVRVcL8g0dJGR/fBcZCs66+IQsZzVWRv/C8wMpL
         C1N7p4Ea8iyBtW9flDon44FTvZJNTJpsUSxXMz1pMiUHWgucOZt8mHmsG/Ysj3JJQnfc
         HEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxpqbkfOso1eomi+QsRD2k2ij49MteA8Y4vVVC6iab4=;
        b=ZAE9gGYndzb+hj6KY09ss3DOtsZt1+0bloBuj9Z636H3MJ6+AGYd7TSdYmUESqNpjw
         tmaLGLMlu2vNeP2TQoQXbcM4QYp4xOYFS75nG7V25K9R9bYCaYKzD92lSFqm2pFNpned
         5ahiLC119x7WEDhTm9G8sSZuLpQTcWvcMrxbbuzT9MrrJrDe2LIlFACQgzClS8EmQ7xq
         MJrAEsXTbCIrL6S9xSGyuFbPnGGZ2LimP9kz+E4Lg/169asrG25VNVZXz4OqJdAuHnoI
         nsFfYidAz4AOqAc/Qa0NzuGVPafHjaya90MEAY+nbWrdTnJxxs/02PyB82ngm6+SLYv7
         HrxQ==
X-Gm-Message-State: AOAM530XVAAAD6TB7jyp5abCEN27pkAVnAy2NZ48bxb8vx7kU1coLefH
        +svP1o3dYr2FCJWZfW1kekmLN2QML0x1+w==
X-Google-Smtp-Source: ABdhPJy7iIUzqsRC14w6D+Vu4FmUKduqYybE2htGIZoyKDbgTfQf+NhYzkV6nKyP+SCZ8TFI8sAzKA==
X-Received: by 2002:a17:906:32cb:: with SMTP id k11mr10602985ejk.158.1617888880539;
        Thu, 08 Apr 2021 06:34:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x24sm12441621edr.36.2021.04.08.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:34:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lin Sun <lin.sun@zoom.us>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] config tests: test for --bool-or-str
Date:   Thu,  8 Apr 2021 15:34:26 +0200
Message-Id: <patch-2.6-2f6c2de050-20210408T133125Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing tests for the --bool-or-str code added in
dbd8c09bfe (mergetool: allow auto-merge for meld to follow the
vim-diff behavior, 2020-05-07).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1300-config.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e0dd5d65ce..a002ec5644 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -802,6 +802,78 @@ test_expect_success 'get --bool-or-int' '
 	test_cmp expect actual
 '
 
+test_expect_success 'get --bool-or-str' '
+	cat >.git/config <<-\EOF &&
+	[bool]
+	true1
+	true2 = true
+	true3 = TRUE
+	true4 = yes
+	true5 = YES
+	true6 = on
+	true7 = ON
+	false1 =
+	false2 = false
+	false3 = FALSE
+	false4 = no
+	false5 = NO
+	false6 = off
+	false7 = OFF
+	[int]
+	int1 = 0
+	int2 = 1
+	int3 = -1
+	[string]
+	string1 = hello
+	string2 = there you
+	EOF
+	cat >expect <<-\EOF &&
+	true
+	true
+	true
+	true
+	true
+	true
+	true
+	false
+	false
+	false
+	false
+	false
+	false
+	false
+	false
+	false
+	true
+	true
+	hello
+	there you
+	EOF
+	{
+		git config --type=bool-or-str bool.true1 &&
+		git config --bool-or-str bool.true2 &&
+		git config --bool-or-str bool.true3 &&
+		git config --bool-or-str bool.true4 &&
+		git config --bool-or-str bool.true5 &&
+		git config --bool-or-str bool.true6 &&
+		git config --bool-or-str bool.true7 &&
+		git config --bool-or-str bool.false1 &&
+		git config --bool-or-str bool.false2 &&
+		git config --bool-or-str bool.false3 &&
+		git config --bool-or-str bool.false4 &&
+		git config --bool-or-str bool.false5 &&
+		git config --bool-or-str bool.false6 &&
+		git config --bool-or-str bool.false6 &&
+		git config --bool-or-str bool.false7 &&
+		git config --bool-or-str int.int1 &&
+		git config --bool-or-str int.int2 &&
+		git config --bool-or-str int.int3 &&
+		git config --bool-or-str string.string1 &&
+		git config --bool-or-str string.string2
+	} >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<\EOF
 [bool]
 	true1 = true
-- 
2.31.1.527.g9b8f7de2547

