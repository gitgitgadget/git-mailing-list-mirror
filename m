Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD6FC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B9D60FE6
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhHQRua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhHQRu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:50:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73978C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:49:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qk33so40168180ejc.12
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snZ9BOeJJSP/w1y+PhWW1VLwoU6IgAoQW18/y1R/l08=;
        b=XohkmUyQ4/6s1fwilXKNWQSYO3yB0q032JwaNA0grs0sJY3Lc71C8yRc5M+QqIlOCr
         +RUnJs7FXx+zq9iDYmk3Z3Kqc6Q5PHQKOXaumoO6qSLI4riF9EA4zH3Wbwzpe8dpQ9AU
         3//HDJxBSvWF/X95AgPxYMqd9MAJ1ZXWeckgQPfyykBdT1AGe4BzJFI1PbcDO0VA170V
         WzNddULgAbmvL/YRiASdOf5zi101CZ0p2J8uZ+8nG8WI8g/USLxaHVkzprHtIMGYmkeF
         MopZboS/82/2h2TsJvdTWtQzLoRQZy7KG9j2LiHAmgjmQDtXYPQ/ArJg85JcxABPxg0P
         JJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snZ9BOeJJSP/w1y+PhWW1VLwoU6IgAoQW18/y1R/l08=;
        b=KFZdMHQqAcXO0QaCrw4B/C8xbEUAdn7UOwgal7DtYvA4PH2lU5Vamodhqf0DdqJxSb
         34ZxnGnI/OvBT1tl9vm9WRhsm9i1Ov/uaS2LdZqyGFhaIFCccTWGm8Y0cj2545G1I4MR
         c6tsRiLPgs5KvLMQCfstoJ73OI2Ek1zA49tZM+wtyFjgOB0Z0xDBoZ2bcyz7ptwlcrxy
         W1lypkASk01CEI1uQzbH6XqX7dh0LsoFH4We30lHSjZQHPGZxGYUzk4ryFWjDD/q4332
         rQRyOgU/O4WClfnnedCoAAoAwU8rlppP5EwHtLqtRIcYGacEC5RSYwyn/tsroLPV26V6
         A4eQ==
X-Gm-Message-State: AOAM531QzxiMZLqdiiBzhV1vi9o8I7R0XBUmgb19RcsPnyC7DuryEZ7+
        6DC8GkqnoB2t1yplBymSVSNtfUqX7AI=
X-Google-Smtp-Source: ABdhPJwo2ERxOt64Hoq0cqGNl+4Sh2erx8Ego0vp/L1HUrLZfaqIa5fdQpse0IN++bO7ZBBFu13QyQ==
X-Received: by 2002:a17:906:49ce:: with SMTP id w14mr5329454ejv.273.1629222594101;
        Tue, 17 Aug 2021 10:49:54 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id p23sm1375240edt.71.2021.08.17.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:49:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/6] t1600-index: remove unnecessary redirection
Date:   Tue, 17 Aug 2021 19:49:33 +0200
Message-Id: <20210817174938.3009923-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
In-Reply-To: <20210817174938.3009923-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a helper function in the 't1600-index.sh' test script the stderr
of a 'git add' command is redirected to its stdout, but its stdout is
not redirected anywhere.  So apparently this redirection is
unnecessary, remove it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1600-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index c9b9e718b8..5d10cec67a 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -79,7 +79,7 @@ test_index_version () {
 		else
 			unset GIT_INDEX_VERSION
 		fi &&
-		git add a 2>&1 &&
+		git add a &&
 		echo $EXPECTED_OUTPUT_VERSION >expect &&
 		test-tool index-version <.git/index >actual &&
 		test_cmp expect actual
-- 
2.33.0.453.gc5e41af357

