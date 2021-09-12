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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE6C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5161056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhILNYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhILNYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F0C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r128-20020a1c4486000000b003065f0bc631so280668wma.0
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jKmLVazVK7gtvwbhr3jVySvGWDJtYIfWGhrkZamSAi8=;
        b=YqYAQBnYWx1BcMauqLe513CEaTTQSUf+QIAqmgywU9B4mBLMrQ4r83zwBmTSjw3L0Q
         3UzlAw96KpqElNK8Xb88jLTV/2o6YpoXM4p5LVpme/sskDknnRSgPVA4Cd0rWXtsb/Yc
         ZKxsWgdOBts2ZSwd+50MGdwNFBw/wM+C9OYukpIO7TrQ6U2MoRhShi0x60z/ZTEKxMhu
         vW4D8BOYI2PvvXOzOLfWpquXCb4537G319CWXnDycS3MhVGVGA2TFi80Sotd6YYel8KJ
         a6uajWl34Iptyz2l3vderYro4r5/wycpYJcXF2og9YCFPo9bEXD7BA0uiwR0l4UiThny
         V2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jKmLVazVK7gtvwbhr3jVySvGWDJtYIfWGhrkZamSAi8=;
        b=HNK/1cQSHJ/M/guTbk/4p55nx2/9/Yojmcnsj8NPAEnrybYrgyBuXRFC5HmcbRfXCa
         Z9XAltjJLJYduFGzwl7SDabRb4YlVYYa0yYRL+acrOzBaXrUCnLSwi8gykCKYFcdJTfd
         dQZZd2Kn4zRPYSfvTYakMvXVj8vIoDp9Ym6Hi1+ZmZV28YpxspS+tAQaBN4YcoEHy0zg
         9TyVC1JRgErYpYb10I5APzDYfbCltIeP+kmd/6++VTEwq5Gb2Gmtng9+q1cEZGv2Ryu0
         xXNSINqORq/pUO/VeIXu8J0b9wzgwEa6ZbcXZHcTFNXlql9xC6V3lNzYl58aPl6MEMY5
         A7RA==
X-Gm-Message-State: AOAM532R+7NzIWaVNOamkwuySlcQ0aqdAcDz/52H0eakdLyS3UDCKYtM
        PX6Y1m49H6HTx82iy7E2QCy0Ue8+jLc=
X-Google-Smtp-Source: ABdhPJzYLfJVRShd4I2BWVqETG1+VgBPTVONqkTNGFpSmfNlI9I1KqZusR9WP27JE5ZKfN8U+BmAew==
X-Received: by 2002:a1c:2943:: with SMTP id p64mr6676627wmp.107.1631453013429;
        Sun, 12 Sep 2021 06:23:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm4340880wmi.0.2021.09.12.06.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:33 -0700 (PDT)
Message-Id: <61c23dc59a6e062e073ba3bea135c370a78415aa.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:18 +0000
Subject: [PATCH v2 02/14] t1092: behavior for adding sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
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
index 886e78715fe..5b3f55e355e 100755
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
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
+	test_sparse_match git add folder1/newfile
+'
+
 test_expect_success 'commit including unstaged changes' '
 	init_repos &&
 
@@ -339,7 +363,11 @@ test_expect_success 'status/add: outside sparse cone' '
 
 	# Adding the path outside of the sparse-checkout cone should fail.
 	test_sparse_match test_must_fail git add folder1/a &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 
 	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
 	test_sparse_match git add folder1/new &&
-- 
gitgitgadget

