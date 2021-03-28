Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5EC433E9
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF16B61971
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhC1NQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhC1NQF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F7C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x16so10152560wrn.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=to7bS0gtCj+Yby1/IsFaXtxzs/o3JXlOi0AR2DdoGIg=;
        b=P0ldGPvl8Oq2vyUfwrXiRsWNUzgKuBfPdBjkETZUkXVOD5b0l6cVu/wUFK5YJxK0U4
         8VGmraUPV/U5e5vXWjFwKE6FTqXZrJbVm0b70BxLpgRaYAR1o+PUmgV9Gl+EzzDcGszx
         7zd7GMh1gN19CENWB+kGj58/O5NV5fcQcblgwh67OdZEmsdFDBLK5PgSpBNDqPGlqEm+
         5gWtoOwvWQryYKEhJ3/CTVYTSfLgyY7zM+/4wSBjYmiYhMBxyWKZupcp65pR5bdPmXKy
         7XX6xskpheOrrx8e03TnuG5Hze71Z2LYHNFH1V5JqXC59ByEPN4c7b6PW213uKTAOyvO
         3Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=to7bS0gtCj+Yby1/IsFaXtxzs/o3JXlOi0AR2DdoGIg=;
        b=ICvmo/0oq6ov/0t9k48+7Lk3DcnWhH1CHOaTgMM+BXVg6ZjVYmc9XHF/btPayjAwgl
         WG+SyNeF5EEYbWKJvM8XBTP5uSzxhEzFJHork6542gwu0Lr50TwsSCrkCSfcS2Q7qWK2
         uRteoWJ9lRJbM2hd9FV7Fts84HKY0kX/263NQkCymgIG/8P0dJA2u6PDDhwQonMK6sp4
         DfZbUNIRwibSgmb1pawGUnzO0Pk3SfmXoczl7Zl92G2RVzGR0QTc50f4dbkizwWleyaO
         Al07eG0dYUbEEjAacPlxL6da7uNqAZAFV2dziDEuMQ8o/NrdI5K7DC2wOk8+tcFWzxlC
         sj0Q==
X-Gm-Message-State: AOAM532qm9J6TrHmtmedzqDXRjX4FdOFeT+i0U7YbyRIkGrKz81LSz4T
        rGvvykO1io4QTmfarw6qkQ/Wu+BVAWP2eg==
X-Google-Smtp-Source: ABdhPJy2BaCM9zp8Id1d1kr6LdXQuqn6MmF4FnFd5VoO5aiFAS8dN1snEcAKHZHLjp94MYX1dk3LCA==
X-Received: by 2002:a5d:404f:: with SMTP id w15mr24815214wrp.106.1616937363428;
        Sun, 28 Mar 2021 06:16:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 11/19] fsck.c: undefine temporary STR macro after use
Date:   Sun, 28 Mar 2021 15:15:43 +0200
Message-Id: <patch-11.20-ae5efd745cf-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f417eed8cde (fsck: provide a function to parse fsck message IDs,
2015-06-22) the "STR" macro was introduced, but that short macro name
was not undefined after use as was done earlier in the same series for
the MSG_ID macro in c99ba492f1c (fsck: introduce identifiers for fsck
messages, 2015-06-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck.c b/fsck.c
index 80365e62842..1b12e824ef6 100644
--- a/fsck.c
+++ b/fsck.c
@@ -100,6 +100,7 @@ static struct {
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
+#undef STR
 
 static void prepare_msg_ids(void)
 {
-- 
2.31.1.445.g087790d4945

