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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7BCC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6B3613CF
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhGUU00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhGUU0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 16:26:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FACC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t5so3575671wrw.12
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H841QFdSJazHTsJiCphF34tuE+VZ8kvrCGBiwT2/RrU=;
        b=oVDJ3toq1TJXWwIFTEKH/aZBRjcnuD9I8ts5Br253jGTwsUhqOQBfzT9zcXMP/Pq2n
         7X49IXC73EgVuUH7FzhVemFn/oUGSb0haQFG9HkxKRNHHMBQAGENm4LzGSKCkYsgq79t
         0ir1CqS1LhVJqz8crQNOLw/irbXwievP+/UuabbFxj4imveSoqt6VB58WWrceCvIU63m
         kWYJI2dRxd7fqQYskneBYtFWTcb41HnZlNEgQUTQdgqXyg7nPfxvzkbuehOBr3K2z6C1
         WuPQsE/S9d7oIcCFodC3HftZorRe0PWI+lYzrm8Hwrzp9IExqEc+70Y33N+yU2ThPBdq
         4w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H841QFdSJazHTsJiCphF34tuE+VZ8kvrCGBiwT2/RrU=;
        b=E/H5kUu7/yn0MoJkX3MLciiXBDtasG3vJ1yywUaPHYrA1cpyu+hjoX7D9AzJsPmlvB
         I1tNopqsypPmB4nDCjaXD+29QzVfCDhV4xubsU1zM1k3VAHcPWKq652oW118nt5HyMqn
         6xPEJ5wY/3/bUVL7VKVi+z4ZsXr8N8cyIqpSG15Ek50FZg6d99x2gkf10Gj/nbo/wptf
         xB2uLw68DiEX38TjoJjiX8TGXuFIeN5xTQnKyexhqPL2ECxKXBNntuWX4Tt6pHO2S5PA
         asjx9oQgXR8+IrYTuX+aRuKXzMj4TSaXSC69EPQ/ppa9INoW+1WmaUcbxPmt2aBkfvsL
         e+oQ==
X-Gm-Message-State: AOAM5303dwjO2ucNe1O7JBkPUtJhFYwGp4m28mvInsuos3HlMpQk/iQa
        MZALyUXGmUq7H2Cntm/Qw9EVwCqbWvg=
X-Google-Smtp-Source: ABdhPJyCfp5RBCorxr68yVWwEBJp72Oc12pPHxJbfFMLyGh8pmDVFL8OdadubsRO8X5lKkf5QKUTAw==
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr44643763wrs.394.1626901620670;
        Wed, 21 Jul 2021 14:07:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm32696130wrg.18.2021.07.21.14.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:07:00 -0700 (PDT)
Message-Id: <a763a7d15b8e92dec61c1fa328ecb647b6f61682.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.git.1626901619.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 21:06:55 +0000
Subject: [PATCH 1/5] t1092: test merge conflicts outside cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 91e30d6ec22..a3c01d588d8 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -114,6 +114,16 @@ test_expect_success 'setup' '
 		git add . &&
 		git commit -m "file to dir" &&
 
+		for side in left right
+		do
+			git checkout -b merge-$side base &&
+			echo $side >>deep/deeper2/a &&
+			echo $side >>folder1/a &&
+			echo $side >>folder2/a &&
+			git add . &&
+			git commit -m "$side" || return 1
+		done &&
+
 		git checkout -b deepest base &&
 		echo "updated deepest" >deep/deeper1/deepest/a &&
 		git commit -a -m "update deepest" &&
@@ -482,6 +492,33 @@ test_expect_success 'merge' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
+test_expect_success 'merge with conflict outside cone' '
+	init_repos &&
+
+	test_all_match git checkout -b merge-tip merge-left &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match test_must_fail git merge -m merge merge-right &&
+	test_all_match git status --porcelain=v2 &&
+
+	# resolve the conflict in different ways:
+	# 1. revert to the base
+	test_all_match git checkout base -- deep/deeper2/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# 2. add the file with conflict markers
+	test_all_match git add folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# 3. rename the file to another sparse filename
+	run_on_all mv folder2/a folder2/z &&
+	test_all_match git add folder2 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git merge --continue &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD^{tree}
+'
+
 test_expect_success 'merge with outside renames' '
 	init_repos &&
 
-- 
gitgitgadget

