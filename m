Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B17C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiAYW33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiAYW3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:29:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20966C061744
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:29:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso2612729wma.1
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uNjSuJTJZo6RWZQfMsXwzz3SwzR2oZDSRUPMX9pyKvg=;
        b=n0tO4gWuWWQ9rlt4opHBfbh0wfDj3ieHm5yxuxgGIsZX08Jd1CmnHyfVNjbYfBxFtD
         191XgiwxBXlI+z0th8+gob4ywe0KB9s3GkivZugWATyvUtpVg1yaeXbgsBMz34v31vsH
         8XhIP4HY1AnYmtOMwEgXXeElriCtiKyMmPPyoPtCWRj5egtezhca+XTi0P81NFqJPIFJ
         ypMHpcGtz+CkeWsgNroAm2sL/LHpRfJfPgvoNa+Fa3PfMpiXXWE9drYZuxcVqmtUcu4Y
         akmVCxPq2hKrBE7qcOcr0O0EmHiU/ZT5XiURIMkXxM4Pm3wLKomJJQ2zrCUCQtj8D4xn
         pi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uNjSuJTJZo6RWZQfMsXwzz3SwzR2oZDSRUPMX9pyKvg=;
        b=wW8WtHzLPDUyTSLG2GEK6U6gbUT6kTQq/oA4XFLJmX5Je3wx1F73Jy/9acLB5EweWs
         Ik9ar9xCmt8apbv5op3PSKMOLLaf6y9NrvAvG+6pNfQBXsgQv4tIwKlkYhIt7VGcjs4t
         Myilk1mTKkEeKEa/AFu7FCJRF2vEOupQ40JvNrbQ/L6lzTa6lWcVh4YsbUxnZAA35urY
         JdDs7alpX6EbD5iVFV+S1SF0OS6SpddgFj1YlkbRXFSn+Qo9k+Yp/JD189cVBhCSRsxB
         8IjNFi23dq9LoptBLRq5pc+N7TnqzeVCUBwpftZd1IE4axh+zzO94Lo7aimVEdlN6lzM
         oY4w==
X-Gm-Message-State: AOAM531OzL9vKBrlYki24LFXP4Cpo9fpK+TnfpoaBDS2RZ5S+lROfbVy
        bOpzV4lMDAqoALpXvZnxDYKJhp4vn2U=
X-Google-Smtp-Source: ABdhPJz+Fg73MLQs8npCaPATGZJpM6DRy0luOOOHC2MPKNeuyAr+anlJEc+1hBCBHRnvXzq+cJnanw==
X-Received: by 2002:a05:600c:3516:: with SMTP id h22mr4688621wmq.143.1643149762183;
        Tue, 25 Jan 2022 14:29:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm18056415wru.38.2022.01.25.14.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:29:21 -0800 (PST)
Message-Id: <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 22:29:19 +0000
Subject: [PATCH 2/2] diff-filter: be more careful when looking for negative
 bits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `--diff-filter=<bits>` option allows to filter the diff by certain
criteria, for example `R` to only show renamed files. It also supports
negating a filter via a down-cased letter, i.e. `r` to show _everything
but_ renamed files.

However, the code is a bit overzealous when trying to figure out whether
`git diff` should start with all diff-filters turned on because the user
provided a lower-case letter: if the `--diff-filter` argument starts
with an upper-case letter, we must not start with all bits turned on.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c         | 8 +++-----
 t/t4202-log.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index c862771a589..fc1151b9c73 100644
--- a/diff.c
+++ b/diff.c
@@ -4821,17 +4821,15 @@ static int diff_opt_diff_filter(const struct option *option,
 	prepare_filter_bits();
 
 	/*
-	 * If there is a negation e.g. 'd' in the input, and we haven't
+	 * If the input starts with a negation e.g. 'd', and we haven't
 	 * initialized the filter field with another --diff-filter, start
 	 * from full set of bits, except for AON.
 	 */
 	if (!opt->filter) {
-		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
-			if (optch < 'a' || 'z' < optch)
-				continue;
+		optch = optarg[0];
+		if (optch >= 'a' && 'z' >= optch) {
 			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
 			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
-			break;
 		}
 	}
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 50495598619..28f727937dd 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -142,6 +142,14 @@ test_expect_success 'diff-filter=R' '
 
 '
 
+test_expect_success 'diff-filter=Ra' '
+
+	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
+	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'diff-filter=C' '
 
 	git log -C -C --pretty="format:%s" --diff-filter=C HEAD >actual &&
-- 
gitgitgadget
