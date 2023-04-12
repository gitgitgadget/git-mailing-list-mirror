Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D5C77B72
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 20:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDLUGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 16:06:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F921B7
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:05:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id gw11-20020a05600c850b00b003f07d305b32so7945451wmb.4
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681329958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruIfd2sE5WAotyfxRHF7t+2tv53VezoD3wXPQHLqorQ=;
        b=s0c9i2YiwB/s0tno5GsCt6adLvv9uAIm4F6v/Gcl/fvI8lvz5Kkspn595/LZoeeM+/
         HaV8NJXTBXOKN9e4/cbMoETlWAJ/6++ssotl+oBTktSHouRhzloqJc3fb64osR7pi2oT
         HWy67O6l7XAl96Oait1DXBBXiVjgf7Pn2XxNzDN9+qkrhSJEiUqnDwM38abkwfvTJS/t
         5Gkr6yfiQ1eCDcg1rbB4UxjLN+7vXDNX26m7D35zVikgLvBLYymheRGPxNv3hF5GZIqk
         D3+pCVzCnCdW3jN3H3jD71ctdAv/bdrvI7H4ADQfv7O3kAyEzuhCSaDfv7UG6qrbmU+p
         f+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruIfd2sE5WAotyfxRHF7t+2tv53VezoD3wXPQHLqorQ=;
        b=eEqZxVyoc+Wo7E3zw3nK7kdQPhDk9ny9SiU0rceoYJ7B9W3zSaBNWqnAq33pls7jB4
         /pHi6rJx9Z8dEprBj3+ubVXCXzMXCruzBFX3nsBMvsUFqLn5c5S4F6tHBMnAYis6Awcs
         xKFPJ++dj5ifJzyVC/wFBmTE3+clCAdTy40p6N7Y2FStT2YS1o+J5ylFxcWaYuiBXQRV
         3+Q0TgB+EsmsLL4BpwpbYGF97FOknQ27f6pwijlzlgvFw2E2Fiu23BqoaB6ejEUwjR6f
         6u/ykmaefVONMHsT3NKPrk7o7kyqeJ9I54QkBiyrwYkaxXKfNEgh1QDUPwawJIPx6/PU
         v7dg==
X-Gm-Message-State: AAQBX9efCMm+rkQzp4F9bCtrW0bOagmNjGoxp6OMui6Vjt6pu4742dah
        8CujTdlkWvVB6CJjh2Clq7b9335N5MQ=
X-Google-Smtp-Source: AKy350blCfx50Lh9h8p9Bug962KrPfSXUP2JI77cSRTOsErQly/2utOQ0PuT+s5OOeH63w3WcF8oeA==
X-Received: by 2002:a1c:750c:0:b0:3ee:1acd:b039 with SMTP id o12-20020a1c750c000000b003ee1acdb039mr36187wmc.34.1681329958089;
        Wed, 12 Apr 2023 13:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8-20020adfee08000000b002c5a1bd5280sm17836436wrn.95.2023.04.12.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:05:57 -0700 (PDT)
Message-Id: <75feb18dfd8af03f5e7ba02403a16a0ed4c2edaa.1681329955.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Apr 2023 20:05:55 +0000
Subject: [PATCH 2/2] cocci: codify authoring and reviewing practices
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

This isn't set in stone; we expect this to be updated as the project
evolves.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 contrib/coccinelle/README | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index 9b28ba1c57a..055e3622e5c 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -92,3 +92,26 @@ that might be useful to developers.
 
    The absolute times will differ for you, but the relative speedup
    from caching should be on that order.
+
+== Authoring and reviewing coccinelle changes
+
+* When introducing and applying a new .cocci file, both the Git changes and
+  .cocci file should be reviewed.
+
+* Reviewers do not need to be coccinelle experts. To give a Reviewed-By, it is
+  enough for the reviewer to get a rough understanding of the proposed rules by
+  comparing the .cocci and Git changes, then checking that understanding
+  with the author.
+
+* Conversely, authors should consider that reviewers may not be coccinelle
+  experts. The primary aim should be to make .cocci files easy to understand,
+  e.g. by adding comments or by using rules that are easier to understand even
+  if they are less elegant.
+
+* .cocci rules should target only the problem it is trying to solve; "collateral
+  damage" is not allowed.
+
+* .cocci files used for refactoring should be temporarily kept in-tree to aid
+  the refactoring of out-of-tree code (e.g. in-flight topics). They should be
+  removed when enough time has been given for others to refactor their code,
+  i.e. ~1 release cycle.
-- 
gitgitgadget
