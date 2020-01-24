Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908CBC35243
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBCE2072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOu2iXTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgAXVT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:58 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55452 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAXVTx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:53 -0500
Received: by mail-wm1-f50.google.com with SMTP id q9so807374wmj.5
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IGh+4pUYPBaIAjObkrwXXG7x2R0PcRUvoF6yo5N4Njc=;
        b=sOu2iXTjcvv0enEjOXP85IIBfsOIF8HToS2QHfxDLDNgqgVXLiiVHeoJmqUZIkGNw0
         i9C4Ppm9wDOPE7MwQj48bHCwZVOiGcU+HumyWnJNE6664JIMbterztsl/JnG50KSFSea
         ZQr3xVEAHujyMOzmmHBjL8vF6Aa+O0Na3c0wTyDVfHOYaexTDRjzE/60Ujpz6RQLEczB
         kRo/MjySmVrzCwMZ8VncYirA2xXZKHwwD/gvjBWALT2IqvwvKK7RlZ7kXB3Z2FU7Hhd5
         CyTu6bzctzmUM2wdgvz+8kyP8HX9PLi2WFPll0hH2prR0yYDQSv9Mir2K4/4Q4b6CZsL
         xQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IGh+4pUYPBaIAjObkrwXXG7x2R0PcRUvoF6yo5N4Njc=;
        b=UEe7kFCdMS4Lrn8JknQlOxmNuxXOmNK0q+mA2b1H7tfDz7pBjPwQ2QbIHIvY23VFnr
         xnc7bFqt4oBLhm0eWUqU6SfGPuBTrQqTlFS3ZhZkUgBHJe8O0l6/9K41IzM1oHnPSGUP
         XPe8cv6z/7jMa6yP1EFJ9JPVGvuls3UHWghVcYu2zQa6uSPGfNuPt21bzY/SG403V766
         oBbH+6swK52d4tb8USm6Sh2+wn28wuVwk0rXpQybKEI2rt1njmIh64ioBgkriVqqXSm4
         4uVZvWU3OiBOsWJMGPpxA5HnhynSj1GP5yWOQbfCiAbyAmUctniwO6VQ7V6ECwCCek4y
         IWKw==
X-Gm-Message-State: APjAAAUiJ4myBX5+XTRzJh8H7L0iqZMoLY1AL0KSuxbuiCMj59r6zeku
        I3cRdT8yxOTVoBpjXpxGe2dm2tkI
X-Google-Smtp-Source: APXvYqzXvmGVucyppDf8+wbfYw2kDBFHXiCqUIdeT6uo3Ljz/PAXV/OrjnwZVOem8MPH/NvhmcAQeg==
X-Received: by 2002:a05:600c:149:: with SMTP id w9mr940491wmm.132.1579900791539;
        Fri, 24 Jan 2020 13:19:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm9223553wro.47.2020.01.24.13.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:51 -0800 (PST)
Message-Id: <526d5becbc87591d7ad37a589a2e44e933bb3e87.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:41 +0000
Subject: [PATCH v2 11/12] sparse-checkout: use C-style quotes in 'list'
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When in cone mode, the 'git sparse-checkout list' subcommand lists
the directories included in the sparse cone. When these directories
contain odd characters, such as a backslash, then we need to use
C-style quotes similar to 'git ls-tree'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 7 +++++--
 t/t1091-sparse-checkout-builtin.sh | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 61d2c30036..83c8e9bb0c 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -13,6 +13,7 @@
 #include "resolve-undo.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
+#include "quote.h"
 
 static const char *empty_base = "";
 
@@ -77,8 +78,10 @@ static int sparse_checkout_list(int argc, const char **argv)
 
 		string_list_sort(&sl);
 
-		for (i = 0; i < sl.nr; i++)
-			printf("%s\n", sl.items[i].string);
+		for (i = 0; i < sl.nr; i++) {
+			quote_c_style(sl.items[i].string, NULL, stdout, 0);
+			printf("\n");
+		}
 
 		return 0;
 	}
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 2bb30cbe29..16dd924291 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -392,7 +392,8 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
 	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
-	git -C escaped ls-tree -d --name-only HEAD | git -C escaped sparse-checkout set --stdin &&
+	git -C escaped ls-tree -d --name-only HEAD >list-expect &&
+	git -C escaped sparse-checkout set --stdin <list-expect &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -403,7 +404,9 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	/zdoes\*exist/
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
-	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist"
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	git -C escaped sparse-checkout list >list-actual &&
+	test_cmp list-expect list-actual
 '
 
 test_done
-- 
gitgitgadget

