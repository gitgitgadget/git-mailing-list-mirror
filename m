Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE1C4160E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99F864FC2
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhCPVST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhCPVRb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC1C061763
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so161778wmj.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uWFiWZazMc1ep/99DAdd+eR2g4kuGtDSHhnvoXTfuXc=;
        b=KH5rz5/mXRLqP6ZJrT+Od+9ovANHnBXRig7vdXCFU+ukVuHpiW6mlNYwQ4l7WMuY7P
         tWE/0vUxi7ZbZiQq5F+EW5GX3hC79DDOAZcy07DK2VRLNwVj21sdBTcggTqzVOhtGCBo
         i9R3GkBbZfHnW1jWFmK+KtJRLCvyzmnZxzINUWTiXpmHF5F5pSlu85Tzi9Vx4J5vu6l4
         o50iBAaWiQxdDqTN0eh1ujQJ30WFcmA4ilTauHkYwiGLaRnW9PNfe8E3SHIX+twtDMrE
         NsvBY9FQffSBp3vPEn8cr74MwtU9IpPqFWkQQdSfFX+5CMYAhHKEjP6GihqFMFsc0pCb
         rTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uWFiWZazMc1ep/99DAdd+eR2g4kuGtDSHhnvoXTfuXc=;
        b=TND6ZGO3A7R6QLMX0wtlTvH4vuS2VRBwN4m8SQOKw6mJ4M7ZJmQOiXKrIKeSUflxko
         159C+oSy2R8a4IP62Ykz2ZB8cLkLgO/qaYTcdxzfd4Ix/ACl+WPo/vtPoflNS9Ygi18Z
         3h5cNM+k296OVpVNMWMlVNSOtR5IZg3Mrh+bJ0wbN3+0ilRumOHdzTONy2hmEFz257Tc
         CuV9ejIsxZNrGA8FkYx88/D0Asz6fbcgMaMktQr4FlnHadYZR3X4kaEpj4cyQ+cTN5J1
         pfiBORx/2nTcSRIGAr7Dhfo3BGMk7tS/bk0u2Jn29O5B6CGKswLRrQ65wVILqQ3nU968
         Qn0Q==
X-Gm-Message-State: AOAM530gKpHm4rDlSM5zTFDqoF/1p/+Htqm7h4vI6DcQGmluEIfmbXZJ
        a+NJO1k4guVJnfV7WgUPfYEn+TyiOP4=
X-Google-Smtp-Source: ABdhPJzwhSK83z5DWgm3Aa4+B8PMQ3peX8stTXDUONTeRkTpEMG1re38j6D/zqFMOJhlGz2KQTpzwg==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr676640wmi.76.1615929449870;
        Tue, 16 Mar 2021 14:17:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm522481wmh.0.2021.03.16.14.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:29 -0700 (PDT)
Message-Id: <6e0b452f44c1b8f8a5f9c0478b05a7d9248f69ad.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:07 +0000
Subject: [PATCH 19/27] entry: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 entry.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/entry.c b/entry.c
index 7b9f43716f76..e55a2af867cf 100644
--- a/entry.c
+++ b/entry.c
@@ -412,6 +412,7 @@ static void mark_colliding_entries(const struct checkout *state,
 
 	ce->ce_flags |= CE_MATCHED;
 
+	ensure_full_index(state->istate);
 	for (i = 0; i < state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
-- 
gitgitgadget

