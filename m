Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACA3C43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8746135D
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbhDLVIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbhDLVIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23462C06138C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso7640668wmq.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=icvbxp/b5Ftybmb6oGJlzeU1p7Pw4+4yErHEotpNNtc=;
        b=qw3zWiFse6MZ9xeDr19C1W3pMVLkrIPLhDiyvCDngIA+2uZ85scGYYWL5NQ2TR0nt/
         Rl1Jjnopjds9/Hj+qwylk7sLw8BMCUC7rb3IHudLj/xL8lZJZXsyLm5BszXnaRqxpNbd
         1qTqaFdtwiZiEPeDsjMcFhEnBKYZIPO+81njqLdoJ196pVQMP6d09onPjU2JTxhCJ40Q
         Z5NOWzny6F5jG6/gyOPFB0LpAUMDCraxQquRF3Gh2uhIFlPTOJ9bAG/nIDW2UhTUhklg
         B97E1Xru5vAfogMYwl/uGQA2q2S/w8DXx+b8Q2NzKGGJIz3hzt92BOPIvAbwhrAfpYTm
         dQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=icvbxp/b5Ftybmb6oGJlzeU1p7Pw4+4yErHEotpNNtc=;
        b=FdLf8K3GHuv/bYMccDUuyd+7A8xO5sK9i/KgARYcu5PJtyIQYp+Xl92JAZEAt6FJgF
         nvIkLydKmR/A0xAbo2yfWHnQfDtT549hnnGwObwRTmTBDjxsx02XyUqiyL098oVajcs5
         3wlXLATdIpHrYQ6QvkkDAE8eCbW9HEJqoscy/rXNVKxaCJT9bDgemFdlVROIkW2+UstI
         iwNSwZRUvwNPmyNW+5wrGm6Dyn1AiUA071K+EqJi4/Uz/lhJzMIkFHE5xCMgNXgtNAFO
         SmEmZ2GPZ6aCW4gpovl12vc7OUYaRX7BBY3tlCKHDflKdzK156t6jXB2mWJYqVnuZvdx
         Gfhg==
X-Gm-Message-State: AOAM533wZcpNnBOXjUL09PZ+BTKIeav+bIsuvRded911BZP3C7us07Jj
        oduKnU5QSezPPal9NfKf6vpzc3vAGck=
X-Google-Smtp-Source: ABdhPJyBM/gyA66GV4gzU47gsLGuPtbiw5nJC70hbBd/WM+7ayyQyj0J+2/Vw76bz0Nse0t52ZxELw==
X-Received: by 2002:a7b:c20c:: with SMTP id x12mr870811wmi.51.1618261701970;
        Mon, 12 Apr 2021 14:08:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm18803987wrr.42.2021.04.12.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:21 -0700 (PDT)
Message-Id: <da17774a53c547374aaf23e6f016d9e54d096f53.1618261697.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:55 +0000
Subject: [PATCH v3 04/26] cache: move ensure_full_index() to cache.h
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

Soon we will insert ensure_full_index() calls across the codebase.
Instead of also adding include statements for sparse-index.h, let's just
use the fact that anything that cares about the index already has
cache.h in its includes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h        | 1 +
 sparse-index.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 5006278c13ca..b7e20e9778db 100644
--- a/cache.h
+++ b/cache.h
@@ -350,6 +350,7 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 void free_name_hash(struct index_state *istate);
 
+void ensure_full_index(struct index_state *istate);
 
 /* Cache entry creation and cleanup */
 
diff --git a/sparse-index.h b/sparse-index.h
index 39dcc859735e..0268f38753c0 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -2,7 +2,6 @@
 #define SPARSE_INDEX_H__
 
 struct index_state;
-void ensure_full_index(struct index_state *istate);
 int convert_to_sparse(struct index_state *istate);
 
 struct repository;
-- 
gitgitgadget

