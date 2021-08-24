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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B80C4320E
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8761A611C8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhHXVwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbhHXVwe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91996C0613C1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i6so9602629wrv.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MbU88O7tq8/LF2BlKKzEtM7WyKkge6STN6O1kXeP2X4=;
        b=tJkm2aojw2RytfQ8/b5ODRnins96LjP8D7/cTcB4BM/pqhh0DvVJWylxI24WCn1IzG
         oJrvjAaKmBeFiu7rEaO8643F5cMyP/4rKKQIvLCGxlRf4nss4f5Rg4jFomzX6rOW8baz
         p1HwDtNgflOW1vRc8oVovP3Wybq0hNjAFRxWsyNLtkJI2fGFLhT+wCLy5sVQe/46ZJc+
         AycWG/1qv8bEghsDHiX0f3zSBhSYJDDw4OJHGPynydiF26q5/u7QiEDfuGUnA6XfNpl+
         g9oBFml1zH3SHnc5/iqYfR08GdCDZLxcvI6tTBHoJWDFfJs2dvE/u67IsAOzXQgYUtJP
         mJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MbU88O7tq8/LF2BlKKzEtM7WyKkge6STN6O1kXeP2X4=;
        b=hpjMhAmIq4FgdVveBZBHimIPSS+9i+WyprFH2hhOs0l5WV4dzQ62fb0qGFU6pkGUGR
         7lslpGDbFS2mL7saHFYQNIuN8Zfa3K34gJUxiGQgOwKrzhlTX+hmetdquqy/STVZxKZY
         IyACzZVfW/EFSIlTsm+KnN2952k+D5qWpdwrpnAQzAgd4ZuGeP7ZOuDGtVU1axJ59wD1
         ygrQzL4cI7v9pIRI6JwmU50TdmKadFjvqXNOx9sc5bHRVuIcaucFUPVkTHMldS077rHT
         G1Rp5LESSpVWh4mCazm6eApgNRCZ107VZVw0ITkm7wg75OvgM1EQQ8uqk9A6iSC8XFpJ
         eUCA==
X-Gm-Message-State: AOAM5307lkAVBR6Zo8lpHzanx7u9PJFTRTA+u3cm4q+MrNavR3uGEwTg
        TGv55dIAg5bSzMOhd3/htVJtEFHfg0Y=
X-Google-Smtp-Source: ABdhPJyQUi6mKX+4xDQlphXs/E3lx+FvJJOA4Lie/aIEBxmZJ1ZSFQS5Wv1SplamxspHrUz8QtYZUw==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr21635764wrs.152.1629841908247;
        Tue, 24 Aug 2021 14:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm3356362wmj.20.2021.08.24.14.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:47 -0700 (PDT)
Message-Id: <b379b8fc61af8a8c39ff8b73aae03ad4999a456c.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:38 +0000
Subject: [PATCH v4 04/10] sparse-index: use WRITE_TREE_MISSING_OK
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When updating the cache tree in convert_to_sparse(), the
WRITE_TREE_MISSING_OK flag indicates that trees might be computed that
do not already exist within the object database. This happens in cases
such as 'git add' creating new trees that it wants to store in
anticipation of a following 'git commit'. If this flag is not specified,
then it might trigger a promisor fetch or a failure due to the object
not existing locally.

Use WRITE_TREE_MISSING_OK during convert_to_sparse() to avoid these
possible reasons for the cache_tree_update() to fail.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index d9b07695953..880c5f72338 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -181,8 +181,11 @@ int convert_to_sparse(struct index_state *istate)
 	/*
 	 * Silently return if there is a problem with the cache tree update,
 	 * which might just be due to a conflict state in some entry.
+	 *
+	 * This might create new tree objects, so be sure to use
+	 * WRITE_TREE_MISSING_OK.
 	 */
-	if (cache_tree_update(istate, 0))
+	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
 		return 0;
 
 	remove_fsmonitor(istate);
-- 
gitgitgadget

