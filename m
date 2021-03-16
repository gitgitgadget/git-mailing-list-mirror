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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB2C4360C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B5365109
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbhCPQSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhCPQSH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980FC061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4102012wma.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrJ7XLTyJL5GQz5dbFbvH4a6OfCD2eBY/5CfuFOZ5J8=;
        b=J5Vn9yDUSZqAUt3g0ZmS1v4TAaRtkNH9EcQrVcrvrHhW7IxLNx7hsWc3Y6hD7nCCMh
         fh4v2W4JjWjr9FsLw9Rt8hbxedvJiI+szEI3NiKi0XjprHpyY5dfd/9RF2fBMZyde8lU
         RlRPDwGM5KMnDwOYhhwOiocD1uwq3CnDWb2ciOKZ4I6RJWwjLEaR3ztNkKRayMfqXcFz
         rInYiuOQvU3ncuvnCTjqUzh3htLltYxaIgOwbJiApcu6OLNicSiUakznDAiUOPEVtxMP
         shH5TctSdPBUjtIgPgbBP/j9yPABiec0RMT1+yhW6TdEwUptppnFup9d1U96oj69fgdv
         sP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrJ7XLTyJL5GQz5dbFbvH4a6OfCD2eBY/5CfuFOZ5J8=;
        b=VCqU/pnpuS1NOIkyHlBIc5VKsnqZxdya92J4QsUE2gQ/9LsaUrP6t1bGQx26XkW4wp
         juNy0XYmV6fhziw11wAaDw0kCjM5YhC2Ep+17vYMbkDbFPFreaolLCOAJ6aO4VHHEsLS
         nMW81WeUBnXSqzNVTs0yqiagrgZcYBccboXupuVuAIlnSVe4jKkOdiqfub6OPq29/PJg
         7uEqNguHPrAVnsnWUm+oyuXCsAwQqhpkIoJ/R1VZEj68o45FFPgygBGpuonTgo5thk6F
         51GT8xm1eQeqaYymkEdBv10mPLygXdFOINGGU6tdyxsfX8PSQnBK9Vql0GvnNrixmnM7
         D1Aw==
X-Gm-Message-State: AOAM531zIXlJwJmXAe1TPqnQ8JI7Q3mEKL5i9i+/XXs+9ppTgPYwIYEK
        uBn3SuoZhp2kE8hHJOgOeqRlkL092Zuq/w==
X-Google-Smtp-Source: ABdhPJxm+EY9r44LIUHvSSXiBrVdU/o4O/JjUUqzl2ObmjYO9TP3tjQ1UVAhQv+17W5GVseUwTiTLQ==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr411520wmc.114.1615911484973;
        Tue, 16 Mar 2021 09:18:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/22] fsck.c: call parse_msg_type() early in fsck_set_msg_type()
Date:   Tue, 16 Mar 2021 17:17:29 +0100
Message-Id: <20210316161738.30254-14-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason to defer the calling of parse_msg_type() until after
we've checked if the "id < 0". This is not a hot codepath, and
parse_msg_type() itself may die on invalid input.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index fb7d071bbf..2ccf1a2f0f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -201,11 +201,10 @@ void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
-	enum fsck_msg_type msg_type;
+	enum fsck_msg_type msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
-	msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
-- 
2.31.0.260.g719c683c1d

