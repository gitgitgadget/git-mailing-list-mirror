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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCECC4361A
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89D1610A6
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhDABuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhDABuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13485C061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so185464wrt.6
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y3kBuuE1kqkzlxpCDekvhONE9z9UoTHKBwBc33s5cD4=;
        b=LH6xeNoYQBh3O51dRTxElDIlcxulpEi78vEq2FrXi78qytlBv9vzHpbLfxQpZ8ChS3
         P2YC384rYHf0DcK/c7F90KboBZgkevO1p+38W1mEkORmaZqHSFnRV08Xkfo2++0I5146
         CR81bSZBdVJE1U+w+zafR6Niu3e9pTV4LR196Rh/fc2+gC19NvegqgT+SH8sDaPNgKMI
         TVYnVlnLfeaOhTHVEAp8lWB3XNq+ugN/3dMhVWhxCrGfPhbHZqT3JR3v0HuQ6bd/xc9v
         OVyJBVnjN/vxnYjukEP0OBiLH1sGOmvhmwUXMpQyF4/szIFfiVg9J6alsoHZIGSZt1St
         L5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y3kBuuE1kqkzlxpCDekvhONE9z9UoTHKBwBc33s5cD4=;
        b=Plfgtoi+QNV6opcCwzC2UAQMqE+GLrzfowZIB0kn2KUGCc4bzsncgKWLIC1Em1F/Jp
         s/NOTU/tT3vkbivtyCSiWyXBscKLmhI3kmPoV0CodbB6+34INJcFm69z6TK5wTvENtmK
         baU/MqOtUCMUyqB3mdb4qGoXH9EUxXmL8FLcu3ns/sU8GJhqdue/HyoB//iGc6lFDynT
         7kYBW1dp9beOLAZnKBAx4rW8Uwu/U1zp5xfXNHIsoJffz6KoeRDDeotrhiGTNQrLLKHz
         2begwsejMUQi79JDPLJiD1dlYzJHMVVJ/GATHN8Se7Q7RkOOeWK/enX/UGP9sjS0bkVv
         4AuA==
X-Gm-Message-State: AOAM5320WeGuzFK+5YurAavPt+gmn3W8LpWCibMnwysBagubIDBZrfh0
        NA+arQxIkFUlX+R8kw7BJpRBxd8+fFI=
X-Google-Smtp-Source: ABdhPJwskrQBaI4ZfYEZLmjPvyvh/yJuVRr2zo+98Ss7WRM2s+Brax0jcwEQtY5PxgS18KHBfJ1SRw==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr6687620wru.388.1617241812933;
        Wed, 31 Mar 2021 18:50:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 135sm6739970wma.44.2021.03.31.18.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:12 -0700 (PDT)
Message-Id: <49ca5ed05c8d0e9333494ebb08ed65cb167dc96e.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:52 +0000
Subject: [PATCH v2 15/25] stash: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
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
 builtin/stash.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index ba774cce674f..6fb7178ef2fa 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1350,6 +1350,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
+		/* TODO: audit for interaction with sparse-index. */
+		ensure_full_index(&the_index);
 		for (i = 0; i < active_nr; i++)
 			ce_path_match(&the_index, active_cache[i], ps,
 				      ps_matched);
-- 
gitgitgadget

