Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F38C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1F46113C
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhDHUlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhDHUlt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:41:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9EC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:41:37 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g20so3723333qkk.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3/4d82Nmc29eCBwLIFmrBOCZ1ej8BoiRPFMZNFH6U8=;
        b=JvJ0jZILvEPdt+/NjT5FEm45AaJmG83M4REa7y+RF45iuE0PETjiBafI+44wUqQBLO
         YoIq6w6guQiUwH7PcVoZTSW6vZEUtc7JJpSkGrbhRz6UNBjFFRiAArbr7KqVpQzjqhS2
         9V0MzlebQ/QVy3BVq6aiMtlJkhjbXVepWIByq3MVkzAmhDUP0b94u2AojP0IpYEVc+xv
         okqMkm5wBPCtrlz6AUZwtd2Mvnz8SP2CRDjPIpUVF7CfEHvmJEVVJnC3VxEwMHvVWbIP
         X+foA1uY6iZmtv9983OATwK8/iklJYzAYO7UxqUfye01sxTqmhCmFfzQNInxpCMbySeG
         2pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3/4d82Nmc29eCBwLIFmrBOCZ1ej8BoiRPFMZNFH6U8=;
        b=cYBq7MqTSa4Uw4CTbtt4cpY8BlP1I2jiordCjoFirYJ2dFu5taj64V3boqp2cp1nSd
         ZG/kbMdnbC38kyNfu6hNXea1wMavi+NvHFeq9Zpt+Dwj0cbzCIRJn5mMWJ+PYSfWYDlk
         cD02B1jDu79AFPmimQh3IQZp5qNeSsgBEsroQGKmmum0l2oUwMu4UtpYdFPjzNa7s2Zo
         by+r2PGwfZcCNiXuThuXOmuyVnSwysnH3NgsJC7CnmbjoyWocD+mWyyIViM+LJ3Ad95i
         YQx4CRO3ltRGZGCkaFOmyxSOFPQNGPIMdg88HyENo0WS+jpnBJ0vWTV0apLrDl574oA9
         +0gg==
X-Gm-Message-State: AOAM530QmdVUKVrAUJNXDfC5Nfq/D6lKBuxD0CG6NOyRTRwxTaTSnIys
        I6J4ztwT8MS3s4tz0Sylsk9KrqNnF7rjag==
X-Google-Smtp-Source: ABdhPJyiTE1Q1n4D+GCQHAreKNv4D1/nhfFUtLelyDDXYMns0n9TGqx/4SKGiTuc1FMTC2QsodfK9A==
X-Received: by 2002:a05:620a:3c1:: with SMTP id r1mr10412094qkm.339.1617914496713;
        Thu, 08 Apr 2021 13:41:36 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm384733qkg.6.2021.04.08.13.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:41:36 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v4 1/7] add: include magic part of pathspec on --refresh error
Date:   Thu,  8 Apr 2021 17:41:22 -0300
Message-Id: <65f241b5c71a000a515b39c2159becb970d2cfdb.1617914011.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br>
References: <cover.1617914011.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git add --refresh <pathspec>` doesn't find any matches for the
given pathspec, it prints an error message using the `match` field of
the `struct pathspec_item`. However, this field doesn't contain the
magic part of the pathspec. Instead, let's use the `original` field.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c  | 2 +-
 t/t3700-add.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ea762a41e3..24ed7e25f3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -187,7 +187,7 @@ static void refresh(int verbose, const struct pathspec *pathspec)
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"),
-			    pathspec->items[i].match);
+			    pathspec->items[i].original);
 	}
 	free(seen);
 }
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b3b122ff97..dd3011430d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -196,6 +196,12 @@ test_expect_success 'git add --refresh with pathspec' '
 	grep baz actual
 '
 
+test_expect_success 'git add --refresh correctly reports no match error' "
+	echo \"fatal: pathspec ':(icase)nonexistent' did not match any files\" >expect &&
+	test_must_fail git add --refresh ':(icase)nonexistent' 2>actual &&
+	test_cmp expect actual
+"
+
 test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
-- 
2.30.1

