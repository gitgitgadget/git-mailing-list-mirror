Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FABCC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 14:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjHKOWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjHKOWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 10:22:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2812D79
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26813478800so1232392a91.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691763767; x=1692368567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kezyjatartg2AoBS6oOh9SIu/F10hxZGEFeT/6v7r8=;
        b=RNrTcLTRXM9qC4wkYWo2Pyyx07NgKpciGen4pzpPtuXvYTNI64UDIhD2s01qdWX5BA
         8BySYsqTuxBjzeYm8IdBG/Cu2H2ZohV/Re2fgMCQUq4UqAPb7w+8giJfOWw9eH5qQ8VV
         2e0mm7SmsgslD1PtdYyUN+YdKgMaIOBf7YJ1lslbueghz/KuBD4L9eZ9oukE/zCzIjXa
         S9hksyd5iVXrKXis6oxs0+eiksroxOpVrOWhP5vYlsRbNSAyVpmqjXPJbupaNDrZ086e
         hFuYcHGAg9aUT5JMUnwfAWYcw1I+qjyxzjdRtxMy20dn6XxJVj0+YOksQUQQI46mi1Kw
         W/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763767; x=1692368567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kezyjatartg2AoBS6oOh9SIu/F10hxZGEFeT/6v7r8=;
        b=QvTNoAIOhDP2FkNbO+QpCFG7oSWC5a8R5/oTeBD6V83BYbPcJU1+6xe5Yack1/RuXb
         3ESdwyStXHnHsjRCZmYfyL42DYjmj4R7/zb0px1EhJfG/IdR4r+0CkT5eNK5nWhYaRfP
         6XxONMaV128p7kyS7/c5eZ1ewNq181UEZpzAwcF9Xyj/Gf1dqFTPArUWHaIo5V8Vc2TV
         5yM37FHckRLzVMuNnaRxxpa5GTIK6IRswfJx4ztK1jPsL0L7rIhBWgsV6I9Lqw13pAkY
         tOlioWulBJwj8iJi30uSPCYF5CDWZ4ya4mTEcRYuUk3xWF8h+WM2YycBly1qJ2hTLXA5
         gJBQ==
X-Gm-Message-State: AOJu0Yx0IunmpfV/dGmKscDb4MThheK1TUO4CFawpI+QbP2joP6zlKAy
        oBv3inJfduBY37TwZ3brp62RD2ar0AtytHLo
X-Google-Smtp-Source: AGHT+IE8Xy4+4Q0KDgyagXxa4EFyafFKvlT2ZlhA21dlM9MBP5faKkbuMJfS5oZPMPflGuHa5+nRZQ==
X-Received: by 2002:a17:90b:4b42:b0:269:228b:ef6 with SMTP id mi2-20020a17090b4b4200b00269228b0ef6mr1264690pjb.32.1691763767587;
        Fri, 11 Aug 2023 07:22:47 -0700 (PDT)
Received: from cheska.. ([120.231.214.68])
        by smtp.googlemail.com with ESMTPSA id p2-20020a17090a284200b00264044cca0fsm10000329pjf.1.2023.08.11.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:22:47 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v5 1/3] t1092: add tests for 'git check-attr'
Date:   Fri, 11 Aug 2023 10:22:09 -0400
Message-Id: <20230811142211.4547-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230811142211.4547-1-cheskaqiqi@gmail.com>
References: <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230811142211.4547-1-cheskaqiqi@gmail.com>
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
checks using the core. whitespace configuration option. Then, it
specifically re-enables the trailing whitespace check for a file located
in a sparse directory by adding a whitespace=trailing-space rule to the
.gitattributes file within that directory. Next, create and populate the
folder1 directory, and then add the .gitattributes file to the index.
Edit the contents of folder1/a, add it to the index, and proceed to
"re-sparsify" 'folder1/' with 'git sparse-checkout reapply'. Finally,
use 'git diff --check --cached' to compare the 'index vs. HEAD',
ensuring the correct application of the attribute rules even when the
file's path is outside the sparse-checkout definition.

Mark the two tests 'check-attr with pathspec outside sparse definition'
and 'diff --check with pathspec outside sparse definition' as
'test_expect_failure' to reflect an existing issue where the attributes
inside a sparse directory are ignored. Ensure that the 'check-attr'
command fails to read the required attributes to demonstrate this
expected failure.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8a95adf4b5..2d7fa65d81 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2259,4 +2259,53 @@ test_expect_success 'worktree is not expanded' '
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
+	test_sparse_match git add --sparse folder1/.gitattributes &&
+	test_all_match git commit -m "add .gitattributes" &&
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git check-attr -a --cached -- folder1/a
+'
+
+test_expect_failure 'diff --check with pathspec outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo "a " >"$1"
+	EOF
+
+	test_all_match git config core.whitespace -trailing-space,-space-before-tab &&
+
+	echo "a whitespace=trailing-space,space-before-tab" >>.gitattributes &&
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp ../.gitattributes ./folder1 &&
+	test_all_match git add --sparse folder1/.gitattributes &&
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git add --sparse folder1/a &&
+
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match test_must_fail git diff --check --cached -- folder1/a
+'
+
 test_done
-- 
2.39.0

