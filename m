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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8561C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F18D64F96
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhCPVRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhCPVR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A2C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so2237382wmy.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ie5hLTKjz7h8tXcyAD8irVVXJrCXs3DtCWQjYNbWlEg=;
        b=IIW1A6yLqQcwl2f0kgXz9VJJwQhTlUt7M8HQwg97sHWzzhGd8Br/JrMUNCbALSrCV/
         sLnXKx6c/n64u9pKiGfmskPlKpxmMjCmX7XVAmsBFgneA+rjfE/QJGW+LdS+RMTVP60f
         Pb5xIeOuyKLZHmGIpRtD8G+vUqSlS3uzINTKhwMIXPtkW9ZzojdjtVPMbmsq9pwxkUlu
         /SZ0VPYNG4uOoY2qKIGNSv7EtRVtqa95PfVT5B5QPdbnZyy2Fe4mwwy5ajy1XMUuUfXH
         EMOx2bsVKPRFU44KjITyRtvd2wCv5rrydRAU9ZsfEkLgFsCyeTZ1IgxFhzFAhwpnRvWh
         VDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ie5hLTKjz7h8tXcyAD8irVVXJrCXs3DtCWQjYNbWlEg=;
        b=UiD6bvbxhgVY7GWKJQCUhmrCdhS1uhzhLIzxNTomJGepqSLR+Ls3ACtv0EK5LKCKYf
         qYFLbHUbHRkwN00rC+pa6UIO7cVwCI0Wg+7QqEZW+lvTKPQ/FPEdsSZFsNPvseFjo6yA
         D7jy9m79dc+ma23NIWosl9JY/wzTSvS9gKbyoARMIFkFPdZ7vbcMASqc7247Ik9G6O/t
         QWPzpZx9l88ePihyn4LLMiqTXZkevEVa5a1G2mVG9oqHo2n/PvXuyceb2Aq8UGQAnQDv
         nhxXivX1fsOymHhaUbYHj6HBl0Y7vkMV0jh3gf3GB5nAnZXao7vFIMe2uKeZW0gaEurB
         bpSA==
X-Gm-Message-State: AOAM533zBMsmJDqP39yQR56DeF4oHv9hk4hFZvCeSlFXSHKto8B+UEc+
        3Qp34BELeutE8kYyGJjtZVfDRMhw4A8=
X-Google-Smtp-Source: ABdhPJw8Y++0w4WeKEavnc5aHB97fXkOEvxg3oFLH0kanLCs+UjZt50Cjob5tKUQIAAEDUhlof5jyg==
X-Received: by 2002:a1c:650a:: with SMTP id z10mr688323wmb.154.1615929446059;
        Tue, 16 Mar 2021 14:17:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm23812296wrt.1.2021.03.16.14.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:25 -0700 (PDT)
Message-Id: <1288f02177d2275937fa4f0928b437756cdaf712.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:01 +0000
Subject: [PATCH 13/27] merge-index: ensure full index
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
expanded to a full one to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge-index.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca25..c1c4409b536d 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -58,6 +58,7 @@ static void merge_one_path(const char *path)
 static void merge_all(void)
 {
 	int i;
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
@@ -80,6 +81,8 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 
 	read_cache();
 
+	ensure_full_index(&the_index);
+
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
 		one_shot = 1;
-- 
gitgitgadget

