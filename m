Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6EC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4963161157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhDSKy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbhDSKxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6DC061342
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so5690453wmi.5
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UQVnjhcNUk8a599g09NcER4MfyNVsn5mTMW/7v1P3qk=;
        b=X3AzV8uMcOp5xOAGzsccXH2L7GzdREzwUfw5AaaPXn2va3/EcKwMlzLHPWhVNpICnv
         OIefoOm9u8hKB9jIiPakRYC7Y0E6zkvMadKDxtZAgKEVlkuFI87tysQxAOKjK2pOElde
         Eid8Gv4/7I4vZfYR63U1YoLw3uTGmVTWKfM2FhncAksYqsB0Gmb5L3LyzbAG4z0KKUGY
         C5isMDIvcN7vqsWrAVO9VgZ583im3Q6Sdif4QIMxiOz8zDZZIPc3Yyjl2mPNCJZAcqCQ
         4wFu73TFnME9nJN+govcsa7V+k0tjbwa+1DcX51Myr4wP4Xuu9UPzm6eQx47ZRlw1HAr
         aiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UQVnjhcNUk8a599g09NcER4MfyNVsn5mTMW/7v1P3qk=;
        b=kWCO0/mzxbgy1nyf1NmUyWGEaRi/vbR768c0Kdhq7dBU0WlMYQvaoVAuYfYhk73P7y
         oIYk+SN++2zLjBsp9DgtHOXcSuJIsgmcDnaMiuqdO5T2aV7ostoDUYZUrYJemAgRyhnU
         jwjTJMLuKnzPo9vx44lwomY2GL9Arn1y4IDlIC55ArTJkPuPuFLCeVpt4KhzfWIE6EUL
         hSFYZRQ+H0ovrxPT7LEwLwZaKsFS9sBct9faT29dmCYlMKkedGOuJLMUcYYDQjVgEMdq
         zDkKVuCYPX+xcOSWCUqc3BIdJujFf4/Jl2iyFAXAwLOHASutHDrMRj6eYQR5YaEGikA6
         1K9A==
X-Gm-Message-State: AOAM533ELjsCD535Wz/uErbozA6URXK3CZTJ/ry4d7y9PUj+g1K6odUo
        LjggqXbegrGrYnWsQit9ceUycbr9S9c=
X-Google-Smtp-Source: ABdhPJxuwLs/JJ9O+AoUhcD15AdRy31hp6TJklOaZ+gBoJatOEnRMfR0aG8Ft6iy6zlg8SVZuni8DA==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr20737817wml.92.1618829593220;
        Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm22146925wmm.5.2021.04.19.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
Message-Id: <a5b9439192db3ad3c01db0e67cc1f60bad9109e8.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:53:01 +0000
Subject: [PATCH 16/18] t7003: check reflog existence only for REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7003-filter-branch.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index cf30055c88dd..380bdf934317 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -396,7 +396,9 @@ test_expect_success '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
 	test_must_fail git rev-parse refs/heads/prune-entire &&
-	test_must_fail git reflog exists refs/heads/prune-entire
+	if test_have_prereq REFFILES ; then
+		test_must_fail git reflog exists refs/heads/prune-entire
+	fi
 '
 
 test_expect_success '--remap-to-ancestor with filename filters' '
-- 
gitgitgadget

