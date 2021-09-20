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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D74C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966D360F48
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbhITXil (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbhITXgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7817C0EDAF4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so32044188wrb.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UtU2DmWqyc3//8gFeL1a4W4npwLEnpHhsy3ImlR7lY0=;
        b=o5cWIHWPZjlNTW3jFAsRX+Jl0HBL+h4InE5iMOWNwvadCSlCprCH78FvRyj6kT4dbf
         OOEE4OaInT3uzw1l9jvjMvBdXYnY8a2vkVgodL123QbA3WpKll0sSaGbPk8QL68EqISO
         DukLj3WJydt59eInpLaxUWrx3xjQYGv6e6iWtWSoKjFeRxViGNEW91ma0QKILB00P9Hu
         6uKTBaFvKO4svpf4vgu45UozigZeN2VxiWLMq3qaKV3xf8XLlW/XIZfmsnejPdvxPnVS
         ww7i5zWpM+73nqnTWXdC6hVko8nMMDZU9AgEaY+0v8atedSxCFHNqUPeghj2d47DlcSL
         iApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UtU2DmWqyc3//8gFeL1a4W4npwLEnpHhsy3ImlR7lY0=;
        b=5eCafby08RwagiJQ6oyWibj2XgLo493UCoBpfp1bLkWBDWsKioyAAB0fS4tNAs9Kk0
         cBa1gyRCHx8Ibe0s56NUjUkpC3invGvG5m1znEkKpqrp103p3oVItnEsW9rl1dYixONa
         xWF8gRH/YjAngx0LwO0XPIofamxocfuKguJXtKPBRZlWtHwJZknA3MzKmJRtas5a6Fwn
         Vhjdum7QO3Xl9vZ1VDVR7mMN3U2kx1lj+ydgbvbPNfshRPorjXqTki/LTmxR8kYIhww7
         ITlBfo778rhZC3lF2OKj/HuWaliNomDV4yKfnRx1NWdnY839/afGxwkRwZ0HHiNTo/Pd
         3loQ==
X-Gm-Message-State: AOAM5331Tacu1vXjqDTYQm9QTjj1EHBZa2rUZ9m8iciZx2Cc8arT8KQO
        I1XfF5oPfIl1DuZWiCEO8/wqhQDW5xo=
X-Google-Smtp-Source: ABdhPJxK7FwQYYkMxd1QXIj/SRKyWB685rBUn3gtU30pvaTzkec+QsauqTiYBIhmKYiyUpbf4hP9Qg==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr288069wme.42.1632159940402;
        Mon, 20 Sep 2021 10:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm171932wmh.20.2021.09.20.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:40 -0700 (PDT)
Message-Id: <c7dedb41291ed6ff48dd9b9b9814e3040f4fa92c.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:25 +0000
Subject: [PATCH v3 02/14] t1092: behavior for adding sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add some tests to demonstrate the current behavior around adding files
outside of the sparse-checkout cone. Currently, untracked files are
handled differently from tracked files. A future change will make these
cases be handled the same way.

Further expand checking that a failed 'git add' does not stage changes
to the index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..3fb764f5eb9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -187,6 +187,16 @@ test_sparse_match () {
 	test_cmp sparse-checkout-err sparse-index-err
 }
 
+test_sparse_unstaged () {
+	file=$1 &&
+	for repo in sparse-checkout sparse-index
+	do
+		git -C $repo status --porcelain >$repo-out &&
+		! grep "^A  $file\$" $repo-out &&
+		! grep "^M  $file\$" $repo-out || return 1
+	done
+}
+
 test_expect_success 'sparse-index contents' '
 	init_repos &&
 
@@ -291,6 +301,20 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+# NEEDSWORK: This documents current behavior, but is not a desirable
+# behavior (untracked files are handled differently than tracked).
+test_expect_success 'add outside sparse cone' '
+	init_repos &&
+
+	run_on_sparse mkdir folder1 &&
+	run_on_sparse ../edit-contents folder1/a &&
+	run_on_sparse ../edit-contents folder1/newfile &&
+	test_sparse_match test_must_fail git add folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
+	test_sparse_match git add folder1/newfile
+'
+
 test_expect_success 'commit including unstaged changes' '
 	init_repos &&
 
@@ -339,7 +363,11 @@ test_expect_success 'status/add: outside sparse cone' '
 
 	# Adding the path outside of the sparse-checkout cone should fail.
 	test_sparse_match test_must_fail git add folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 
 	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
 	test_sparse_match git add folder1/new &&
-- 
gitgitgadget

