Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14793C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiCGMur (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbiCGMul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168AD4E396
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:34 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so10756650wmj.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GoKKRtU6gX1nUM+GRJALpcEW8iAysiQJVsRlCCXvnU=;
        b=YB0y+qOaVKD/06UL/7evlXvFyw4tlrtPrj6Y9Vcdv1rzlQRQ1BNAOI6Aeuw9S1dbjP
         OxrgIjcYauvsaNG7rJ7ZjRvZfd4Q+OWekq524hVEEh89OBMFQolMHhnslTs81omiMwgV
         qoE/RIjOowEnJwA5aZQySxOb02vuUXa5wfeOk11y/OUAZgZabr9e9QB2b0mYd7y9Td+t
         siZDii26Su5vW/MbhDOTZbmjjykCcZl5HRRKaVYPr+P+tCkatkOEU1B4pMPt5HxNVD47
         NY2U/GumGWLfDrVU+B6dP6uexHLoAgfp1WRtW8+j6pa5AmSi9ceZ8O3F7Iv7mv+vGN8i
         89Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GoKKRtU6gX1nUM+GRJALpcEW8iAysiQJVsRlCCXvnU=;
        b=V1NJXRsdXauht8yswteUhNsVoykemBC5PPi98Ve5LVE/COVwHlgh2bNqmdY3fCFR7o
         Ck+TNVjKhz7I8a/L3jprGd2hLdnlYDcIym94OE25tamtu6c8TdMqPqCxABHs3forKbNo
         TEn2uDJVPbTNPOhAaucPmxHaq3wAuNZdmns0lVc7Kpfgoau+Qaz5ugZBOf/+r1mjQ1Yr
         vI6TNWKHJqa6NNip3/xfu5vJYLlL3HECGt9hIqajYNQdl9cKeOd3r/2bHGUdrKdyuTxS
         qHss5Na6oTQx5RdirFb9cAiD+IMh8/04RyqOvJOp7nurt8OhtE0h8qQYyXjlDyX00/2A
         1SmA==
X-Gm-Message-State: AOAM530+3IWJXnqtKOr+4xWQ8QdWtnS9Z/xOEaOuz92g3aaCnLXQxs5h
        nyzj7WxRBgOcioWpzQxCqCCm0rpqltsEcw==
X-Google-Smtp-Source: ABdhPJyjMcNePvA3O8l8rcFNYez4e57vHbtAhgp6JcBtXZrejUCxodWQu377Li6/W01KI3WRCT847A==
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id o24-20020a1c7518000000b0037c07ebf255mr18148269wmc.29.1646657372392;
        Mon, 07 Mar 2022 04:49:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/15] rev-parse tests: don't ignore "git reflog" exit code
Date:   Mon,  7 Mar 2022 13:48:59 +0100
Message-Id: <patch-v2-08.15-dca2ac3a171-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 9c46c054ae4 (rev-parse: tests git rev-parse
--verify master@{n}, for various n, 2010-08-24) so that we'll stop
ignoring the exit code of "git reflog" by having it on the
left-hand-side of a pipe.

Because of this I'd marked this test as passing under SANITIZE=leak in
f442c94638d (leak tests: mark some rev-parse tests as passing with
SANITIZE=leak, 2021-10-31). As all of it except this specific test
will now pass, let's skip it under the !SANITIZE_LEAK prerequisite.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1503-rev-parse-verify.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 94fe413ee37..ba43168d123 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -132,8 +132,9 @@ test_expect_success 'use --default' '
 	test_must_fail git rev-parse --verify --default bar
 '
 
-test_expect_success 'main@{n} for various n' '
-	N=$(git reflog | wc -l) &&
+test_expect_success !SANITIZE_LEAK 'main@{n} for various n' '
+	git reflog >out &&
+	N=$(wc -l <out) &&
 	Nm1=$(($N-1)) &&
 	Np1=$(($N+1)) &&
 	git rev-parse --verify main@{0} &&
-- 
2.35.1.1242.gfeba0eae32b

