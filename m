Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CE4C433EF
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiBMAkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiBMAkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290686005E
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso8616459wme.1
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=87B8g00aRBUIF982wcafTYUkZmMVb2hLgP1kfIXtpRo=;
        b=jm8tU4drgVxHtrsOcP+GeJ/xUnOnUJJkpvsSoxbQ89Hz0+oBvLQZfVuIOw9oMIIlJE
         l5GtYtLOA1iUUY77soMMCA0PngW5+5wyUrAGbnHaPqsQ2Dlv/QXxg2lCx6S4hvy75+h7
         W8dWCKFlN7yoScGlPBCzDcXyGH3ZqA4/1wNSYdBE5bTW1idodES7ku7d2rsscv8ytHBs
         2QtOTIDMvk71B8/HL8I5jQO6rdhP4TyyaPUQlfOt64bzuookjeuyI5LIMQuFNkiPFPet
         y69fAtFB0bBv+KZE97WQFcOnJtCo2uvbLFDBMy98B/co6ZENC8AntVesftOo3fCCOuIL
         W17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=87B8g00aRBUIF982wcafTYUkZmMVb2hLgP1kfIXtpRo=;
        b=5PY88dJfJoFSQJbNlCBmdDxYLStqZ7F3GutNqCGK/vV+HkVLRJJ0bH8m3XRVVD21At
         ahCjk1jNH9jsoMLHoe/36JsZrfwQImoqLKFek0Hvs1hUglsudHpq85dfcBvTl/tjlDLZ
         4u39E67RQ8NLsaXGbX+8vGPNki3mNbhoKxbRGHw3ELtyBPZK6k1jC4P5SKuUbdl5WSXB
         zNVX7VKOBFQaHak9Q+Yl/DTDHpLmy64KfNxmcG/un3iybxNAP5XtQg8Ma+mpGD/byY7V
         UhLdTCK1hD9gzSmcVWOwELK6WFrM6t82V+A4qGRdJSqKMPlY+lekurolu0Q6dJoYZKyy
         oWZw==
X-Gm-Message-State: AOAM533DTPsGwVeiXWYrkhEI8oSbi2WXBB32mPBomAoMbXEV7LHL21WT
        kvYaKW+RhPT2qcRFvyrp/hjZr4/wH+E=
X-Google-Smtp-Source: ABdhPJw0hLdttstIcnrCwkRrlNqf0YoBZqXqMZ8+tbsaiTI/N+YdwznXgV2ii6qFiZypWsxoaMCA+g==
X-Received: by 2002:a05:600c:601a:: with SMTP id az26mr5663234wmb.2.1644712803587;
        Sat, 12 Feb 2022 16:40:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k34sm6869991wms.35.2022.02.12.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:40:03 -0800 (PST)
Message-Id: <265cbe36b2df5a9a076877fe3ddc3880a64a9217.1644712798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:55 +0000
Subject: [PATCH 5/7] sparse-checkout: reject non-cone-mode patterns starting
 with a '#'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In sparse-checkout add/set, in cone mode any specified directories will
be transformed into appropriate patterns.  In non-cone mode, the
non-option arguments are treated as patterns.

Since .git/info/sparse-checkout will ignore any patterns starting with a
'#' (they are just gitignore patterns), if the user passes an argument
starting with a '#' to sparse-checkout add/set in non-cone mode, it
would just be treated as a comment and ignored.  Error out in such
cases, informing the user that they need to backslash escape it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 5 +++++
 t/t1091-sparse-checkout-builtin.sh | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8f8d2bd6ba5..0f9e737ed97 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -704,6 +704,11 @@ static void sanitize_paths(int argc, const char **argv,
 	if (skip_checks)
 		return;
 
+	if (!core_sparse_checkout_cone)
+		for (i = 0; i < argc; i++)
+			if (argv[i][0] == '#')
+				die(_("paths beginning with a '#' must be preceeded by a backslash"));
+
 	for (i = 0; i < argc; i++) {
 		struct cache_entry *ce;
 		struct index_state *index = the_repository->index;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 1d95fa47258..32b77415679 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -857,4 +857,10 @@ test_expect_success 'by default, non-cone mode will warn on individual files' '
 	grep "passing directories or less specific patterns is recommended" warning
 '
 
+test_expect_success 'paths starting with hash must be escaped in non-cone mode' '
+	test_must_fail git -C repo sparse-checkout set --no-cone "#funny-path" 2>error &&
+
+	grep "paths beginning.*#.*must be preceeded by a backslash" error
+'
+
 test_done
-- 
gitgitgadget

