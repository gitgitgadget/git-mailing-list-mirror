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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD9C43462
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6EE6108D
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhDABud (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhDABuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E3C061764
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j9so166923wrx.12
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=63cgv+d6hF7bJxk9XJMcdXLWzyM+y2aIDW1QZ5VUN1A=;
        b=A7m9rt6w4Hg8Pe/0RAnlaW4T04G2vGCJtMz+qDFfycG8RmVzJz4n0PVn5HRI/TOqH0
         flHy9R6CxbimC7w+vitU9QAQzjajxlSKq13slmau+nyEDPTEYF5qxAlr0191cHU6Wny+
         WLEkIF5Mt7zC8LAXt7gI4FkI9f05PKtnribZkItQZ++yiTbaLNJKS2uaQWibKo6grF2g
         yc4VH5OkW467OSR+ymukNk7Q01Rb659hqHqOpjhGHZeWmi5WRxwfHscm3v65r8seuKFY
         rpUU5+h66liIdX08plYszx1pYLSUwau8QV/nvsYaD7UilVk0NgpVa59yqYBs49kg25I6
         454Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=63cgv+d6hF7bJxk9XJMcdXLWzyM+y2aIDW1QZ5VUN1A=;
        b=QFi90t1N777mdNflzlMWReXb9eyXY3wTiStbrcKcOwPRm+iYL2h4GBVIYVycXNWIJK
         Kk1JBBora3zw2qimgL2O7rvMXb4QNjIzIcs2pMNSwbfFibsaj102FH04Gx/yr+t76MUt
         kW5pO6JC0WuR5TM/Ho0XzLIZxGG4Js+7XMa1vHhwrDt0fOYE4VNH0DCl0xFkJwJ+dAHg
         MBsiE10M4O4ki+k3JMGl6xj+Yz1sjoWulC9wAQSLP+7SEhgte+uLF4oRwigjyKup+VeB
         X2h9JvphdBICiZ7AZYhpkZKaUf7cMbPFd+uYzBExVFjzeh69e8xGRaLIpBBQ16Yrymom
         doxQ==
X-Gm-Message-State: AOAM530aRYtnZxFM34jpCVet1B95OOJFg5i8O3anNx8JKGEaB+x7axHW
        eHsADoufxmhuV9sqmiBajoX/KKgwrTY=
X-Google-Smtp-Source: ABdhPJzVCgnJ1cuMPfvzkMmeOZyFWDiacepj6qPOd2kFsQRX7OtmBpHvUDFAx42M6fG8HCxPltq/fw==
X-Received: by 2002:adf:e4c7:: with SMTP id v7mr6701076wrm.245.1617241810254;
        Wed, 31 Mar 2021 18:50:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm7783968wmm.0.2021.03.31.18.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
Message-Id: <779a86ad1ec46f53ae38b17cb53df347b01576fe.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:47 +0000
Subject: [PATCH v2 10/25] fsck: ensure full index
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

When verifying all blobs reachable from the index, ensure that a sparse
index has been expanded to a full one to avoid missing some blobs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fsck.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 821e7798c706..4d7f5c63ce0d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -883,6 +883,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 		read_cache();
+		/* TODO: audit for interaction with sparse-index. */
+		ensure_full_index(&the_index);
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
-- 
gitgitgadget

