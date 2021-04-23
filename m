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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058FBC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86A661467
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbhDWVfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbhDWVfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E55C06138B
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so1913579wma.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PWgdKnHxpR77nD6z+mgPXsfVi8En6vUQNKR8GlQu2hQ=;
        b=jcUXh5flR1FNglLcz5RMf+NXnJtDA0/8wQxhxyHWAyjNppkfMVbflQyWYtWcTJDduL
         Yb9qkm+a6z+KNGLcLGqCgmm+ML4VKDgJKbKvwKVrGJGED6cjmDJ4ppwO56oYfRH9guOa
         5QmFkatzz3ji5ephGMxgkZy2BMsyF9d86PCbTkKEauaW6CQJREDmBWbZ4x2pyWV8OHue
         FCOicJNYSAPFCrV3OEAmobJqxML/MK7gHCGOZFGdaXeny+dxr55r3yvSCGh8TbaA65pc
         I9QjTktJBrRYEXXXFgXVlnVaxQhjco7oWsJ85uQNG2RCmGBcDz6zb2eRr9iQVx/4BGM/
         Gtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PWgdKnHxpR77nD6z+mgPXsfVi8En6vUQNKR8GlQu2hQ=;
        b=BMB2WsQ/ndVBQOBbvGxljhWO6U36dSmGFZzXLV/r8DzOeFIFUpdF+hAH1JDxVS+But
         o6FMnFbocAQFdUAcVVl14kUByzhaJ8k1pA4bZCVj/k8ECwij6tN8v3qcPzLYEKxABpYI
         JP2shmGoYEyglQhioH3B/jCIgtK+X+cqnm1IWlWtOt+IDMoX1bUJgazacXGbcrdcrNR1
         3K4riJ893tIZMx5yBV1tg0kBG1zgDpv1P37QjJ54wnkp9q2KRtaS0oIoLs2dtHFJs1yF
         4bwgNRnEI2dkhpjVQDhQFfRp9JAk6paGB8AEuY/HlEImyyGlzheqGOWNOzvxOPOGQPYz
         N4bw==
X-Gm-Message-State: AOAM5338f7VqlKXEpXkvIddHyjRczmXWcAem/VxmgLzibd75q/pgeEsZ
        bJ7Mx51uPlecOKI6u0YDEg8v1Wyh7ec=
X-Google-Smtp-Source: ABdhPJzQm01Xtt0+d9x5mcy3wZr6Bnvf1ZXulXRa/je0AbTV+XS4iO+1Aa5pEJ9/2zyusVEDUp5dww==
X-Received: by 2002:a1c:bd46:: with SMTP id n67mr7647441wmf.171.1619213669289;
        Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm10603186wrx.22.2021.04.23.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
Message-Id: <d3c8948d0a33d81e0d426130c89783df25b06703.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
        <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:21 +0000
Subject: [PATCH v2 4/8] unpack-trees: stop recursing into sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When walking trees using traverse_trees_recursive() and
unpack_callback(), we must not attempt to walk into a sparse directory
entry. There are no index entries within that directory to compare to
the tree object at that position, so skip over the entries of that tree.

This code is used in many places, so the only way to test it is to start
removing the command_requres_full_index option from one builtin at a
time and carefully test that its use of unpack_trees() behaves correctly
with a sparse-index. Such tests will be added by later changes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3af797093095..67777570f829 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1256,6 +1256,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
+	unsigned unpack_tree = 1;
 
 	/* Find first entry with a real name (we could use "mask" too) */
 	while (!p->mode)
@@ -1297,12 +1298,16 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 					}
 				}
 				src[0] = ce;
+
+				if (S_ISSPARSEDIR(ce->ce_mode))
+					unpack_tree = 0;
 			}
 			break;
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_tree &&
+	    unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1332,7 +1337,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
+		if (unpack_tree &&
+		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 					     names, info) < 0)
 			return -1;
 		return mask;
-- 
gitgitgadget

