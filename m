Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E18C0015E
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 13:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGKNbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGKNbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 09:31:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF2134
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7672073e7b9so417118285a.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082300; x=1691674300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA5bHkUBVq0H/s2qn/18DqjwN31FuX+wGgYKZJPMS0E=;
        b=mTN5f0loDXJNew5OWrzoj/+UXwaXm8My778uFV5NXw6NSVoPI7j9YAaClcXiL9GShA
         Sf6u2MEaRNMeTOcRy0S5PHkurkwvS55M0QC203sgL6u9wn43y+Cwo0eUmFqwLCNM44ic
         zatHb7ipIoP0obWEH6mukW5SDL2gMdTqq4EnR+PaD5iSKBiKibuBXY3ktsZ/D7ABYGvX
         YI13wjIESq3CZABsLR5iA5+kA3jxPJ9StaYJJj9n/VNnO3ZktY85WK/jCfj08RT3EDIB
         2EPQy8h2pHcKO4KdS+6puJw/y08/0Jy8j+dTL/tLuGMZFA8KeSqfU3dZj80D/yW8w1vC
         Q0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082300; x=1691674300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA5bHkUBVq0H/s2qn/18DqjwN31FuX+wGgYKZJPMS0E=;
        b=VepVsP4F9F7/IXSqWL7VUxFdsroX8vt4wHkKDmdiEf+FpcsSVwsNaU0i/FM14we09G
         LuZNc5apajQ+mreOOM/cgbjjvVj3kZkr5fPqBjEyhSZPJaVa5eS+zUQLU1yPu+sshKCR
         r0O4usW2ffgKkvZYUoEwAnUO59mgVD7r1ViCHSpKv+WUYZp+TX0pBzAQE3Q622Kb+Ojd
         YE34lsuP6/V8Iq22v8o00FR+5zRspH23llRGzh3wuf9P6zKPxI5WYMH1n0QRVcGsIxId
         SrbTkRUlhjwJ7HgUSchC9Nm3RMI1aKljzoAJHMpbuhe8S8HqeXmBkJMVbUBaGOR96GRn
         vK/Q==
X-Gm-Message-State: ABy/qLZfZ38N3idcHE1WoV1jh/6KxWkalQ1AYXEBPedYxuS06UZ1I3NB
        U1ID/XGgDMe5BA3mvk3e+YOWA8X1xPycPA==
X-Google-Smtp-Source: APBJJlGG3O6P4IXp3Cod4TA3Ex2DmA+MHnlbtGNX3UStRuM8nWzsAMdTB1ev+kfOI1BT6lak+ELySA==
X-Received: by 2002:a05:620a:371c:b0:767:3d52:f8f with SMTP id de28-20020a05620a371c00b007673d520f8fmr15916519qkb.36.1689082299719;
        Tue, 11 Jul 2023 06:31:39 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id oq5-20020a05620a610500b00766fbeb3e7csm966010qkn.132.2023.07.11.06.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:31:39 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v3 2/3] t1092: add tests for `git check-attr`
Date:   Tue, 11 Jul 2023 09:30:34 -0400
Message-Id: <20230711133035.16916-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711133035.16916-1-cheskaqiqi@gmail.com>
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add smudge/clean filters in .gitattributes files inside the affected
sparse directories in test 'merge with conflict outside cone', make sure
it behaves as expected when path is outside of sparse-checkout.

Add tests for `git check-attr`, make sure it behaves as expected when
path is both inside or outside of sparse-checkout definition.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8a95adf4b5..839e08d8dd 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1006,6 +1006,17 @@ test_expect_success 'merge with conflict outside cone' '
 
 	test_all_match git checkout -b merge-tip merge-left &&
 	test_all_match git status --porcelain=v2 &&
+
+	echo "a filter=rot13" >>.gitattributes &&
+	run_on_sparse mkdir folder1 &&
+	run_on_all cp ../.gitattributes ./folder1 &&
+	git -C full-checkout add folder1/.gitattributes &&
+	run_on_sparse git add --sparse folder1/.gitattributes &&
+	run_on_all git commit -m "add .gitattributes" &&
+	test_sparse_match git sparse-checkout reapply &&
+	git config filter.rot13.clean "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
+	git config filter.rot13.smudge "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
+
 	test_all_match test_must_fail git merge -m merge merge-right &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -2259,4 +2270,33 @@ test_expect_success 'worktree is not expanded' '
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
+test_expect_success 'check-attr with pathspec outside sparse definition' '
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
 test_done
-- 
2.39.0

