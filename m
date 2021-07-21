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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A955C6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606C6613CF
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhGUU0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhGUU02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 16:26:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA0FC0613C1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f17so3590962wrt.6
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZbZn9ZoRmasPgRxw/gERFUjtdCVlPbEWarvAwxum0j0=;
        b=sgMlKoWPhNy76K8s4tO+Zi4ZRX37PO9Spy9TJw+hldeMBdoKdHzvUbvavLK/hYPxy3
         5N1T6PmuIlsJnYklf+uEu2qT3VQxBo7xScE/e/XdA5tPAytQi4wK8hKkxdaj2z/6SaNT
         jzzHR8nn3Y42Rm9hJ5rheR6jMifmqA8KSaHinKApiLnanwBu0yoskcQT/K8H4t1g+w3p
         PDyenIjEynjUBK91ul/0ms5N71IcaRnbaa/2ZB7paUyCjpCFh76mOhPYQCQ+gO9GKkvf
         B7S0PKIQOrys1KbdXcC8gRBc51LbMaUNqHKgyyIHnu8q3AwTD//v7FbfI36qmNFg8/oa
         K0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZbZn9ZoRmasPgRxw/gERFUjtdCVlPbEWarvAwxum0j0=;
        b=RkQa4y3edQBMDKyInw2C6UiF1+q3xAXgGIELxILgrgorQXLWXTZ/uzoYdRcQbDbJKA
         Bu4DQJACVUwZyE4lyxm/IxL4P7K6wQTtOkpHTJ5umvElK5mrPeDtIhLlLrOZOowbYJms
         73sf8WssfjsO5bvWbirh3k9PewHTkP7UKriudHZTes+bV5FEdhwfulLpsHD5ZCcSqPNq
         +b4yEpZuE9+RI9plEvSphiN5hWLgllG1SixdT6PxJ4zmzJW4lrKADasPXSMA1JD4bU/k
         XLX2MKR1pr3BDDc8FqkZLT9zpO5vNnPztgqLmilFX9aneyUneZMb5WtPkMujeoJHKjI5
         6r3w==
X-Gm-Message-State: AOAM532ICwwei/fgsAbqQVNfrRp5uE3bKt968GsIPjdgr+rH665Gli6s
        H+wEdeGDoC6w858JwVpqHiYLngGJ8kQ=
X-Google-Smtp-Source: ABdhPJzzzCoR/iD2DYoASW31Ur/d/hxANeHjPYcja10+yr7a5FvFxLeYX7p2KyHdZzP6nD/7pDvfOg==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr46016866wrn.304.1626901622514;
        Wed, 21 Jul 2021 14:07:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm32601181wrv.72.2021.07.21.14.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:07:02 -0700 (PDT)
Message-Id: <89ec6a7ce677815cdd9889fb90c8c19f8f6dd28f.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.git.1626901619.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 21:06:58 +0000
Subject: [PATCH 4/5] t1092: 'git add --refresh' difference with sparse-index
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

When running 'git add --refresh <path>', Git does not actually stage the
change, but instead updates the index based on the stat() information in
the working directory.

This typically does not make sense in a sparse-checkout scenario, where
Git wants this file to not exist. However, sometimes the file can exist
on-disk for other reasons, such as a user manually adding the file or a
merge conflict outside of the sparse cone.

Since b243012 (refresh_index(): add flag to ignore SKIP_WORKTREE
entries, 2021-04-08), 'git add --refresh <path>' will output an advice
message to indicate that this is not allowed when <path> is outside the
sparse cone. The check goes around the sparse index protections at the
moment, so it does not find a match when contained in a sparse directory
entry. We will update this behavior with a later change, but want to
demonstrate the failure now.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f9e2f5f4aa1..73c48a71d89 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -347,6 +347,25 @@ test_expect_success 'status/add: outside sparse cone' '
 	test_all_match git commit -m folder1/newer
 '
 
+test_expect_failure 'add: pathspec within sparse directory' '
+	init_repos &&
+
+	run_on_sparse mkdir folder1 &&
+	run_on_sparse ../edit-contents folder1/a &&
+	run_on_all ../edit-contents folder1/new &&
+
+	# This "git add folder1/a" fails with a warning
+	# in the sparse repos, differing from the full
+	# repo. This is intentional.
+	#
+	# However, in the sparse-index, folder1/a does not
+	# match any cache entry and fails with a different
+	# error message. This needs work.
+	test_sparse_match test_must_fail git add folder1/a &&
+	test_sparse_match test_must_fail git add --refresh folder1/a &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'checkout and reset --hard' '
 	init_repos &&
 
-- 
gitgitgadget

