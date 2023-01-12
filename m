Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C45AC61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbjALJU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjALJTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:19:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864954736
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k19so13313958pfg.11
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4cnAn6aFg6X/ukxRgPg5Mqy5tU0lOzmc4SyhpP9DMY=;
        b=OQIS8CorJC54w+yGRM1dG7DUkAHvN8zLuynoBxVn8pQYUqvCsBUb7pcXnsWrY0UsaS
         BQwiDflLMddDSSuoTBSWAJ0cxWXxdMt1M37q8gRkxLz0zYM45H6V14h2evl+BY7zRwSK
         FUF1yKJiaazDV4P35MZvn+FoG9vM5rL+2FaLVetjx0XUzT+D1hDjmnAcwS1T2AIBXW2N
         9el0mH1ECQ+qZx41fNo+ARINb3DG0TsOgPqAzVv1RZ8x9FcUCnxzThxbOmmEWC7j483E
         PSW2gF63ZwEuaAcb8U4ToM+SShitdEeJC9pwvBa6fE7JVG2rmT9LTi68smX3x8o+gDYq
         A+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4cnAn6aFg6X/ukxRgPg5Mqy5tU0lOzmc4SyhpP9DMY=;
        b=YXsVRYv+3xavdf0mRyEqF6aBKRXbqcRxdX1iS7dT9p2c4BAPxKR/SqtbewHK65h9Ht
         +c0AkU0bts+/rjabLW4VKMBm58SXg3tWrP/q9OytZpVFFpU46WufU4iK3i/8zXrr6VC6
         aKZ25tHTTsF1ltRHZzXJjdiL/hNuSFxGLowBa/tlNyTYdnLXVu2PGR6+TxMuckvTFOSq
         qfZQCMjS1T4s0CpiKB8K8Z0qVK3Rwcx6PLc7BP+hIy+XqK91k8qd301mNQ7KzSc5NnGN
         EMK4erwHwoUxQLzadvtjdwPG0qs5uaQGJ1sm9Ru2LzuZZFDL1Fx7cPGBLgEoRwvutBde
         ZcbA==
X-Gm-Message-State: AFqh2krekRWN9I9Wu/G3vWjIJxmKIhztzWbH67SgCI07wKJSR+Y3DMQL
        49wqx3ZJwc6VXKnX/IwEzsjQoS+hXbkyMjds
X-Google-Smtp-Source: AMrXdXt/1W2B10Dvg1MYyPaxDxaXpnvATpdLbv/NoRjbAXcUN2CdEAVw48TfZ7i3bhqPRl6B3Bq8Xw==
X-Received: by 2002:a62:1d97:0:b0:578:ac9f:79a9 with SMTP id d145-20020a621d97000000b00578ac9f79a9mr70761656pfd.15.1673514716953;
        Thu, 12 Jan 2023 01:11:56 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id d126-20020a623684000000b0058426d9db66sm11257069pfa.218.2023.01.12.01.11.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:11:56 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dyroneteng@gmail.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 5/6] ls-tree: cleanup the redundant SPACE
Date:   Thu, 12 Jan 2023 17:11:34 +0800
Message-Id: <20230112091135.20050-6-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.98.g174eaa53973.dirty
In-Reply-To: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

An redundant space was found in ls-tree.c, which is no doubt
a small change, but it might be OK to make a commit on its own.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index a743959f2b3..72eb70823d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -14,7 +14,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 
-static const  char * const ls_tree_usage[] = {
+static const char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
-- 
2.39.0.98.g174eaa53973.dirty

