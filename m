Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184A9C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346900AbiCOKDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbiCOKD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:03:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE074B1F7
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:02:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a5so18822549pfv.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QULUaao4RG0DzByci0AcHObXNcNiFhnm8fz74xUsXxM=;
        b=WopF6cJq/d+L13puWU7qSBGmz8Wgqr3wVe4wYmQKAaGCZLsiN0gg+snaF2FfFH6dNn
         H8OkPLlAXVJKtz+zoy4K+tL/2yHfb7DMGVyFa4FqTv9hQlfRwWTE2kfJZt2KRS02o2LU
         6PYmrjuzzI8ChCZzsFTP35TaR/iJMQI7DfopQzFiW6gWcwlm1QcTIcPo3tKvCLMGZ/gD
         KHjLWY2lMUeyWl2ytXfw5JHipmyFutx1+GQxr0Obm62sIr2tjcm2heXUWs3NYEX7Uw7E
         SENmqYu3HsVdgI5duy000W7uqjPbR+fww63WaAgcBupLlai/4fCX/Es0eu4LSkxeJAbA
         WZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QULUaao4RG0DzByci0AcHObXNcNiFhnm8fz74xUsXxM=;
        b=a6qtmV/ZYTSpeqTGkhfchK+8YmAEBfXm00uNjZ122zdzowAw4QBYIaPFL9iJvd7Qlw
         fshYyNPPsWGD5i2stUjhCWRoHeLIc6ZBlKHPaA9/gx20gKzQVnE3D9qfAkqo+3Tagj50
         SxQzzIBqnVr3HJmAUn4O9BmQoxeNuf78qtCQNM2UF4zQfEHmwVgK4oHCbL+9twwpot8K
         fshVOjg3pZodeGZ4LAMletm5nOXITP/1VEkA8O8eUBtgEBhjtKxTMv2OOT6o0Hkt//EY
         3goFfGBz7aSeNJeCCzrkmngvVlkcZiq2p8Jnh9lLHMzQj8kEXZldsa+hjE+heSbk//k4
         TqoQ==
X-Gm-Message-State: AOAM532D4BDHMQm2OheHTPx/qxnRDRCuAGAzN3di1DyQFHsY9Z0wnwjK
        XiMhZidLziE4XQA7onhx/XXG5kgg89g=
X-Google-Smtp-Source: ABdhPJw2zmNt3LY7r4jO1OZkIIZVZDeB0z3/ma4y/AXwfRtGUMTL7mJOeFcwCqIn+4ZEffrbnPOkig==
X-Received: by 2002:a63:2a4f:0:b0:37c:4e54:c399 with SMTP id q76-20020a632a4f000000b0037c4e54c399mr23415887pgq.324.1647338537053;
        Tue, 15 Mar 2022 03:02:17 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.90])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm24316041pfh.177.2022.03.15.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:02:16 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [RFC PATCH 1/1] mv: integrate with sparse-index
Date:   Tue, 15 Mar 2022 18:01:45 +0800
Message-Id: <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                             |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba83..111360ebf5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -138,6 +138,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
 			     builtin_mv_usage, 0);
 	if (--argc < 1)
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2a04b532f9..0a8164c5f6 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1521,4 +1521,38 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
 	test_cmp full-checkout-err sparse-index-err
 '
 
+test_expect_success 'mv' '
+	init_repos &&
+
+	# test first form <source> <destination>
+	test_all_match git mv deep/a deep/a_mod &&
+	test_all_match git mv deep/deeper1 deep/deeper1_mod &&
+	test_all_match git mv deep/deeper2/deeper1/deepest2/a \
+	deep/deeper2/deeper1/deepest2/a_mod &&
+
+	run_on_all git reset --hard &&
+
+	test_all_match git mv -f deep/a deep/before/a &&
+	test_all_match git mv -f deep/before/a deep/a &&
+
+	run_on_all git reset --hard &&
+
+	test_all_match git mv -k deep/a deep/before/a &&
+	test_all_match git mv -k deep/before/a deep/a &&
+
+	run_on_all git reset --hard &&
+
+	test_all_match git mv -v deep/a deep/a_mod &&
+	test_all_match git mv -v deep/deeper1 deep/deeper1_mod &&
+	test_all_match git mv -v deep/deeper2/deeper1/deepest2/a \
+	deep/deeper2/deeper1/deepest2/a_mod &&
+
+	# test second form <source> ... <destination directory>
+	run_on_all git reset --hard &&
+	run_on_all mkdir deep/folder &&
+	test_all_match git mv deep/a deep/folder &&
+	test_all_match git mv -v deep/deeper1 deep/folder &&
+	test_all_match git mv -f deep/deeper2/deeper1/deepest2/a deep/folder
+'
+
 test_done
-- 
2.35.1

