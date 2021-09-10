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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECEC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D02D610C8
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhIJKce (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhIJKca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:32:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF483C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso1071935wme.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L/SozFkYYgVAlkAdQp7NV7qNUhQ+hs+8Y/xGQudpUIw=;
        b=ExnRuu/yV3uT7mZN0FGxgBsZrE9Hp3LuuArmcCtL01tZKIKIHz6O3OObGmMoi4Jmly
         /19j9hx2Oy1JQgD14LMro6co10a49U1a/kG1m648X0Nji10o7zc+1kYLcptgO+wANWqu
         WVAaAZ3ImdmftyR+a+2qYtRbn08PhA7yEnIAhS/FbJLKUWRvWsq5XORwPy8zbpBM0bE9
         SWuO1zc+xUy7IXgQZigHNGIMvBi9/kpFbrcuF7xjKqf/pHEGm+T8eHYqx1tuKeV1FQlH
         dd1wiBbR9r8vgpUUmmkrRlmrQ0q6rqYPJkx5Zs57Uo0rulHu3P9vmkEiyKVKg/XQ1yZY
         ljQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L/SozFkYYgVAlkAdQp7NV7qNUhQ+hs+8Y/xGQudpUIw=;
        b=Io35Y+GPaK2ziOr650z3VJW8OVyjLl5EnS40ecIOYiMV5kEx3atIfQQmTBKrveGbRM
         3arV0n5daHgL3LsoWHJL2NySMwyQRn+tSqTonzR4XJiKV/S7PijHWvAi5B/tn1IT7AbP
         umeziauUiEsni36cwEB1MUeDu5HP9su+t9ry76q9K0BXnmPd1ywTAdxbYLq9Q2BPj5iI
         upejSTF723blyVs+GKCwvU1YE1HVwCNyFjGEb5SB5n1oe9s6D15UCJLAuwfzO7LigRHh
         3SPL4KKnybOIVSNEVpC2M+E/mFbkzwntVftqCEORq2cgYC7Gh0I9s+2cUfAv6tY7x+IL
         xeCQ==
X-Gm-Message-State: AOAM533BhB57py07F9yitzL7CWD4LPZ73ebY8gizdiIr2oEGgpfUD2up
        Qq7G/i74hY/exPdm6ixA3UsxhRFWX5k=
X-Google-Smtp-Source: ABdhPJztJ2SkHFFHkE7oA5LvC9WsKsjgLH8Yux1nt95PCcsueDQMx2gEeRN+/xejRAUdpPKMtP9DWw==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr7591762wmh.137.1631269878517;
        Fri, 10 Sep 2021 03:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm4327060wrs.60.2021.09.10.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:31:18 -0700 (PDT)
Message-Id: <38a7063b959f6a404b292586b52b9c3b4bbec308.1631269876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
        <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:31:15 +0000
Subject: [PATCH v2 2/3] t4151: add a few am --abort tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4151-am-abort.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 9d8d3c72e7e..15f2f92cd76 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -23,7 +23,13 @@ test_expect_success setup '
 		test_tick &&
 		git commit -a -m $i || return 1
 	done &&
+	git branch changes &&
 	git format-patch --no-numbered initial &&
+	git checkout -b conflicting initial &&
+	echo different >>file-1 &&
+	echo whatever >new-file &&
+	git add file-1 new-file &&
+	git commit -m different &&
 	git checkout -b side initial &&
 	echo local change >file-2-expect
 '
@@ -191,4 +197,37 @@ test_expect_success 'am --abort leaves index stat info alone' '
 	git diff-files --exit-code --quiet
 '
 
+test_expect_failure 'git am --abort return failed exit status when it fails' '
+	test_when_finished "rm -rf file-2/ && git reset --hard && git am --abort" &&
+	git checkout changes &&
+	git format-patch -1 --stdout conflicting >changes.mbox &&
+	test_must_fail git am --3way changes.mbox &&
+
+	git rm file-2 &&
+	mkdir file-2 &&
+	echo precious >file-2/somefile &&
+	test_must_fail git am --abort &&
+	test_path_is_dir file-2/
+'
+
+test_expect_success 'git am --abort cleans relevant files' '
+	git checkout changes &&
+	git format-patch -1 --stdout conflicting >changes.mbox &&
+	test_must_fail git am --3way changes.mbox &&
+
+	test_path_is_file new-file &&
+	echo further changes >>file-1 &&
+	echo change other file >>file-2 &&
+
+	# Abort, and expect the files touched by am to be reverted
+	git am --abort &&
+
+	test_path_is_missing new-file &&
+
+	# Files not involved in am operation are left modified
+	git diff --name-only changes >actual &&
+	test_write_lines file-2 >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

