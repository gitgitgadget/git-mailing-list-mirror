Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF520C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9058661108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhEaRl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhEaRk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC4C008751
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c3so11517090wrp.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=EZ8+RtFLom/n2zNyA7TP0YFGdpmTkg6DfxkQvHRyY+4=;
        b=bdpSbdu2pCiBfk/QYKbqb7bfO5njR0nNxODtqCBAxObpinyYeVIL+JeUrGWAw9vacE
         u11faxStUGDtAa5/+vd+b3jqUaS90qpyqcbGwXviG+pLxUnKXnbp2yn4XYNH9gzNID4D
         cf9mRXgVISJ+pNLdn8HHNbGnMXGoxphW8YyJZ8wyB3oUWie5NY5mE3nLnfb+MjXHfQXI
         1s2YYf+ctPxy/6qz5DWqJBM9NKkGCXTeWhI+L/TM9oWkkMrYi8SznkBaEXP0XJ4Pgunm
         +rAGdBSGbGhezo/KO/d8zA2oQ6Zc4C1h34WPDCN+P1ix2tFtzjrhmolp06c7hV/xoTWU
         JqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=EZ8+RtFLom/n2zNyA7TP0YFGdpmTkg6DfxkQvHRyY+4=;
        b=Gz37/UqGOTUpJYqW0z9gTx26LKgM+n76EG3ffn+8XhehrasnaL+uEujzwHSvHzzDA3
         NIS2qvLiUW3P40+2UWErVgIbi5r6Hm7fI+XxNJXj3itA9kKaXkM1UazLLobq7JGM7FTJ
         ypKPqI3DRbvXtPTwXP7vihkZUkTuFzLLcl9EYOwZPvVIT+OApVB+y+r2PD4DQM/vFvTo
         XtGqr/ODB52VKnVaSEI4bqNCr+oUnuyyx5WT88bQ6N//MA9HOpykzlCqgIEUutQpOrMb
         LU+57VcRe9zfcICJm8BA35jt6oDu9Y7jPwN73rZF3TJdFWFEYhs9kKSFhFiI4GmpAwfa
         Kj/A==
X-Gm-Message-State: AOAM532j5YoKO5qCJrEPkm3rsYek/VUaKtDQz0Wk2ce+vG5veKDMXR+s
        ap1rGRQkIGL1TwoTZ768uXGMyloyN4s=
X-Google-Smtp-Source: ABdhPJyoMbRGFe3wnnOecfy9dVJAbv7LsCf//iItS1hFGE7oUElMS8vv+fL38B+D/6CsIiDPOd0kkA==
X-Received: by 2002:adf:d209:: with SMTP id j9mr12156014wrh.328.1622480207081;
        Mon, 31 May 2021 09:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm266414wry.55.2021.05.31.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:46 -0700 (PDT)
Message-Id: <57fcd175fa723cec194ddf776d6e209ae0f27d74.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:30 +0000
Subject: [PATCH v3 15/22] t1407: require REFFILES for for_each_reflog test
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Add extensive comment why this test needs a REFFILES annotation.

I tried forcing universal reflog creation with core.logAllRefUpdates=true, but
that apparently also doesn't cause reflogs to be created for pseudorefs

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1407-worktree-ref-store.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index d3fe77751122..ad8006c81397 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -52,7 +52,14 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
 	test_cmp expected actual
 '
 
-test_expect_success 'for_each_reflog()' '
+# Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
+# only appear in the for-each-reflog output if it is called from the correct
+# worktree, which is exercised in this test. This test is poorly written (and
+# therefore marked REFFILES) for mulitple reasons: 1) it creates invalidly
+# formatted log entres. 2) it uses direct FS access for creating the reflogs. 3)
+# PSEUDO-WT and refs/bisect/random do not create reflogs by default, so it is
+# not testing a realistic scenario.
+test_expect_success REFFILES 'for_each_reflog()' '
 	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
 	mkdir -p     .git/logs/refs/bisect &&
 	echo $ZERO_OID > .git/logs/refs/bisect/random &&
-- 
gitgitgadget

