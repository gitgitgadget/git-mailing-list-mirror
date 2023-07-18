Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3089C001DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGRX3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGRX3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:29:49 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B1ED
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-635e6f8bf77so37348916d6.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689722983; x=1692314983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJn+Qz+JPknMw4ob2dUkPQGBYrvHehUfhF/WjObxw64=;
        b=CDWWrjAHd7hLMGMiG79vtY6VEi8xXF6/AG4CCLjzEcZc4B/lzmAaNZIcfSCzVbKjjX
         Zi7ZxzTir02Lp74qKnGUt5iiVBwY3mQRjexyL4Id69YqBDBI++lqAGEgig0RkyE6sszL
         EowqFPS125QSq4T2qrlqhlzcD3JsyTFpuvFzMt2F84XF7qH9QLDP4mid+LHt3az3o6L3
         2dsWJnO13tBrmy630WaXo9NIAzl/e7YRKlJ7SZs5uvU9MM77trkJTgw7ObWFl/Qb2gg2
         HbkaNLaawLCwXjI+/vRaRyF/q/oB+kiYEyUgKP2uoau+WZQOrO8OWpPIKes0Tk5tzHZ4
         +scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722983; x=1692314983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJn+Qz+JPknMw4ob2dUkPQGBYrvHehUfhF/WjObxw64=;
        b=elAZzf13vNEHnck0VwBG/t6WDSxsOD/FwKXijS15sMQbd/c+2uDy1ZxLHp020jGxY/
         ubJawTTeX6paGrTuwAjTP1HqLPQnD7KB74RXxjbkc3FA5+WxSLbNt7IO1EzyrwmY3/mE
         mNJ9xw70i/NizjHrXbFlpdEg0zj6XGG9jNH5k3RCEQd0H0pAyPctoHF2BvzaZbNpy6pA
         XZyEE8lRDHRmLDoVgfyZrgUAMc5t+PiwpdoeKg+ZIJO5sEfzZPeUruZ0w4JtfWC6p+Fb
         Clp+QPdcZpb3YId8098vYZDG+VONeQH5rQdjXfqcoSN06gFd1cLeiyP0kMAEiIRqs1ue
         ezSw==
X-Gm-Message-State: ABy/qLbN9ecwHVzvRI4FOdpFrRXkgoGBGYUnGI3k7wZguawMTo1OWK86
        RQqahVXmf5s/bJmM2Iy4iI6NDYfBRYCMzA==
X-Google-Smtp-Source: APBJJlFj6FN4HLkvyat25+It2At5W7IoDY8h84YEWzFHv/nfldIsyvRq5Xc4gCd9uTFmJwKMt2RjkA==
X-Received: by 2002:a0c:e48e:0:b0:634:d868:f0dd with SMTP id n14-20020a0ce48e000000b00634d868f0ddmr15641229qvl.50.1689722983631;
        Tue, 18 Jul 2023 16:29:43 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id h18-20020a0cf212000000b0063640486254sm1057695qvk.116.2023.07.18.16.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:29:43 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v4 1/3] t1092: add tests for 'git check-attr'
Date:   Tue, 18 Jul 2023 19:29:14 -0400
Message-Id: <20230718232916.31660-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230718232916.31660-1-cheskaqiqi@gmail.com>
References: <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for `git check-attr`, make sure attribute file does get read
from index when path is either inside or outside of sparse-checkout
definition.

Add a test named 'diff --check with pathspec outside sparse definition'.
It starts by disabling the trailing whitespace and space-before-tab
checks using the core.whitespace configuration option. Then, it
specifically re-enables the trailing whitespace check for a file located
in a sparse directory. This is accomplished by adding a
whitespace=trailing-space rule to the .gitattributes file within that
directory. To ensure that only the .gitattributes file in the index is
being read, and not any .gitattributes files in the working tree, the
test removes the .gitattributes file from the working tree after adding
it to the index. The final part of the test uses 'git diff --check' to
verify the correct application of the attribute rules. This ensures that
the .gitattributes file is correctly read from index and applied, even
when the file's path falls outside of the sparse-checkout definition.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8a95adf4b5..90633f383a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2259,4 +2259,52 @@ test_expect_success 'worktree is not expanded' '
 	ensure_not_expanded worktree remove .worktrees/hotfix
 '
 
+test_expect_success 'check-attr with pathspec inside sparse definition' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	run_on_all cp ../.gitattributes ./deep &&
+
+	test_all_match git check-attr -a -- deep/a &&
+
+	test_all_match git add deep/.gitattributes &&
+	test_all_match git check-attr -a --cached -- deep/a
+'
+
+test_expect_failure 'check-attr with pathspec outside sparse definition' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	run_on_sparse mkdir folder1 &&
+	run_on_all cp ../.gitattributes ./folder1 &&
+	run_on_all cp a folder1/a &&
+
+	test_all_match git check-attr -a -- folder1/a &&
+
+	git -C full-checkout add folder1/.gitattributes &&
+	run_on_sparse git add --sparse folder1/.gitattributes &&
+	run_on_all git commit -m "add .gitattributes" &&
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git check-attr  -a --cached -- folder1/a
+'
+
+test_expect_failure 'diff --check with pathspec outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo "a " >"$1"
+	EOF
+
+	git config core.whitespace -trailing-space,-space-before-tab &&
+
+	echo "a whitespace=trailing-space,space-before-tab" >>.gitattributes &&
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp ../.gitattributes ./folder1 &&
+	git -C full-checkout add folder1/.gitattributes &&
+	run_on_sparse git add --sparse folder1/.gitattributes &&
+	run_on_all rm folder1/.gitattributes &&
+	run_on_all  ../edit-contents folder1/a &&
+	test_all_match test_must_fail git diff --check -- folder1/a
+'
+
 test_done
-- 
2.39.0

