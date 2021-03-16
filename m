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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED44FC2BA4C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64E664F9F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhCPVSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhCPVRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3514BC061765
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y16so11250459wrw.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hu0/iar66qUjlCaAn1Eiz2QQN3SmGd2tkTGGsb/YzAM=;
        b=itdFatmk6nsuxyyeXZZC0d31qMBK7w/frmTjQwF4dIjz/Juis75ocGewAKhXkYAdEg
         aBGyw/0ha2Coq5Vos23QL0/my+ecNtH1iwRs83sIxlv0ddXXVa2JFhVSAxY+JBqJ231f
         aEQ3wMJnkztjK/EtVVg1iQBfYcJ/AJuDo3ra/9nNyu5dnNEBuz/PoYRf0s00K+906ATJ
         RAUulHvKenN+v0gv/kvcY3pBq+n2lASSShw6zFirLVvioMnCGk/R5crEUFMmYhLmOJMi
         pmRzXS78FuLh7bvxsMCbDGCfXmfKG1h8cTapJ6JRvmVxAQKW3LKmQo8GzuvcXXtjHt+7
         EmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hu0/iar66qUjlCaAn1Eiz2QQN3SmGd2tkTGGsb/YzAM=;
        b=TO231VtNrJ0OLJZNjezQoAaryH1ZmmysR05GanDvzUXEJf19j+3d682BSVe5aTzXmo
         z2yFLOavoLI1dCFoWYKn3MGaLZKPpO2xHVk16W+AqEDme6IHiJyBfVHKfcHQX1RookaL
         d8Jia/3xdx/egtVF+IujPqsbi9s/7F5l8K1eRqm55TU0eHJRS8Iw4dQYohsFP1fhP6jn
         7HJJwZHsD9qk3+LkwO/FG5oxRynDn001IbKUi9Ctv32kkDu7G+bwID4jKr6qSubfIPv6
         YM7Jm+Y8JYHhR7hwpffkTndaiS0O08yi+DboQ5gOYcrnLLmUWl/IUHqh+LTKQcsd5YOg
         4zSA==
X-Gm-Message-State: AOAM531dbgfRqaP7M/mtnKcpXZKf2RIIdhwe0+4T1/8p9+yyBkHm4NMK
        qRN5vO+6haCAgaKDqRCj+NAbxkFM9jQ=
X-Google-Smtp-Source: ABdhPJxg4MKaUqOvxwURivuLq8m6OWiSOZGOoTu4O4uM2eljKSD1Cc4gINu+cSpB2Fg7AEd4KgkUrQ==
X-Received: by 2002:a5d:4884:: with SMTP id g4mr915589wrq.191.1615929451065;
        Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm18191181wrv.25.2021.03.16.14.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:30 -0700 (PDT)
Message-Id: <57d59825627f10c4383c2c4ee8ee449e2c50f865.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:09 +0000
Subject: [PATCH 21/27] merge-recursive: ensure full index
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
 merge-recursive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index b8de7a704eae..7954c7829d27 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -522,6 +522,7 @@ static struct string_list *get_unmerged(struct index_state *istate)
 
 	unmerged->strdup_strings = 1;
 
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-- 
gitgitgadget

