Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624A7C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C3161C4F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKOLze (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhKOLzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 06:55:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C44C061746
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n8so14249709plf.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMie3k5+afbmSF1t7y73ZW2MTXj10SVKn+IT03w3vI4=;
        b=Pu0dv31h8BoYlBBYd1dIgkpyS2l179RzBg69iktNMoF98PX4+21b3V7AEq0Wf+aZ7d
         hp77VEAeV1LW/5UD0SoTA405U8RTJsCj5Z8odJe1G93sx3/MJ9wx7hbikXx5uUNiK4Uk
         qmku6AWXOXeJgqQdK22P/exW/4tgnOjjqMTxmmH5p3ac0Wco/Ww4/az8afJ49uYB7Q6l
         DcICqn/oZL8W6EBO9sJ20fhvDMEUV5UzgqqYWaZhePkhq45CrtgRxbymug8KNjvBvsdI
         xvnGM/p77Cltoz3LZTZxhNyqtVJHGWpiyguOWmX/QcsdmzpJiRRywSWNoKhOEcZyzoOj
         dONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMie3k5+afbmSF1t7y73ZW2MTXj10SVKn+IT03w3vI4=;
        b=x8vxFnvKN1uacj+DEM81FP9DR1AtTGfnm14ga3SEHF0/1P7HTl6nuzUY4Cdwau5wuE
         XAeI5Fn3uzGKuVjdgarWjCjIBugjkZEkRIGrdQ0jHoEzkefun+jW/jismPsHW0jsF0JH
         gmfwRlqUFgKUuUaevEUtlX8ql8miTZEIBV9iC7XtQ3CyGxBgTWyrRqvcK9tRd+gIWrsk
         hXac+mV5+vCD0xebTxkiuBR5NLXe31o7fzg/IS9ZwvT1tW0nR5WxaR57ksIULm3LSZCT
         LFPW+3FHIGA35tuyUZT5TqKRU2Iw6ZTR5r62FgLPvC9PM/DkSipdCP8ySV22eaxZ8ky/
         YhMw==
X-Gm-Message-State: AOAM531bvVb/gHabYgzXKxk3yaO5BgtKlb3CVHmo2u2gnyLTRMGLxoTu
        0oGhLnSTJioB7lq0dX0ONG4Lp+IH6XQGMQ==
X-Google-Smtp-Source: ABdhPJxY8/fL0V7Ai9hwC6Q+v1Ndbo+rERypeeJ0Bg2hRxGHVDGStBzgyY5/u0ARp+0k2xy1w2+AgQ==
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr63000845pjb.143.1636977146088;
        Mon, 15 Nov 2021 03:52:26 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id s2sm17543280pfg.124.2021.11.15.03.52.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 03:52:25 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 2/3] t3104: add related tests for `--oid-only` option
Date:   Mon, 15 Nov 2021 19:51:52 +0800
Message-Id: <20211115115153.48307-3-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
In-Reply-To: <20211115115153.48307-1-dyroneteng@gmail.com>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t3104-ls-tree-oid.sh | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 t/t3104-ls-tree-oid.sh

diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
new file mode 100755
index 0000000000..78ab9127c7
--- /dev/null
+++ b/t/t3104-ls-tree-oid.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git ls-tree oids handling.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo 111 >1.txt &&
+	echo 222 >2.txt &&
+	mkdir -p path0/a/b/c &&
+	echo 333 >path0/a/b/c/3.txt &&
+	find *.txt path* \( -type f -o -type l \) -print |
+	xargs git update-index --add &&
+	tree=$(git write-tree) &&
+	echo $tree
+'
+
+
+test_expect_success 'specify with --oid-only' '
+	git ls-tree --oid-only $tree >current &&
+	cat >expected <<\EOF &&
+58c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c
+c200906efd24ec5e783bee7f23b5d7c941b0c12c
+4e3849a078083863912298a25db30997cb8ca6d6
+EOF
+	test_cmp current expected
+'
+
+test_expect_success 'specify with --oid-only and -r' '
+	git ls-tree --oid-only -r $tree >current &&
+	cat >expected <<\EOF &&
+58c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c
+c200906efd24ec5e783bee7f23b5d7c941b0c12c
+55bd0ac4c42e46cd751eb7405e12a35e61425550
+EOF
+	test_cmp current expected
+'
+
+test_expect_success 'specify with --oid-only and --abbrev' '
+	git ls-tree --oid-only --abbrev=6 $tree >current &&
+	cat >expected <<\EOF &&
+58c9bd
+c20090
+4e3849
+EOF
+	test_cmp current expected
+'
+
+test_expect_success 'cannot specify --name-only and --oid-only as the same time' '
+	test_must_fail git ls-tree --oid-only --name-only $tree >current 2>&1 >/dev/null &&
+	echo "fatal: cannot specify --oid-only and --name-only at the same time" > expected &&
+	test_cmp current expected
+'
+
+test_done
-- 
2.33.1.9.g5fbd2fc599.dirty

