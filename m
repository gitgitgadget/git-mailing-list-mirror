Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F280E75451
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 16:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjJEQLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbjJEQKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 12:10:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FFD13B46
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 08:22:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3231df68584so1071251f8f.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696519351; x=1697124151; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mrl0qrHEv8JytGWH12V4E84t7wHoZ7QB8MqgauhQvVY=;
        b=nRfAw49BoEZEGaqc8bAmGfyPZ7CorCd+OzRas6rBdI7X9/opKO/mBNlXO6M10Y/xCE
         KdEAUn6HEgHj7o0NL4blB5m0CppAfJsH/Indf0hzibmhC2oZ+C2J4SFv7RYmxYqY7xgY
         cA1KpHv0IRw7uHBQw1ohbEfNOX3NK7N+PHSaQ5A9IxsRAC7g9xi8uZ9s22rQEF8NImUz
         WgJpger4Nkm8gfcH4mvzv3c0v8QlvVb/zISP5EIV0faVh1X0IvbNamhhw3McAsTGctiM
         MwtY7n3gBX5XkDTV4GUD3aUqew5//70SV01dxRdaQZKPI7jUHskUR60dJ6/8UxI8C62i
         uqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696519351; x=1697124151;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrl0qrHEv8JytGWH12V4E84t7wHoZ7QB8MqgauhQvVY=;
        b=jXzfXOPJ7XYTJ7tQ9w2I1cUsWHJTL7qYg0tysRLms6SVzm9fVyMP62LgRs0atGRzky
         WJbd6IsLOk8paoq+jfcwFAN9jUa918wvGqDWuvzkTxvFhOuCg2yEiFu4M6RsTfqH7Ekp
         9NYPTL5xkGVgxtdbgd/vNOx0gfhe8Ali/D5/5ZscJ2p7yWU6cpODzhAFNFNPoQvzXugE
         821Pu1ToftmTFlpTvY/iMzXL+tKJnU5NRrKp9EDKbHTakh3TrELHN0Tu4ozmQs1gut1P
         Xdv5HGTegQh2YZ7ws5MfVgcZLxm8iOj+2McPEIWxXgic4pI9RNoFJNGyVu4gpP5Z2rLt
         0cJg==
X-Gm-Message-State: AOJu0Yy2UTKQWa6HOHhB2Xt4XPFWKrf9xoVcqoGyMUMforYaKpTwbTzl
        02Ve6L0DqFMfB5lEckzaErsOfDxu0vQ=
X-Google-Smtp-Source: AGHT+IEs2mYQo8iFGVAlHYaq68bSDcbqpg0DiLqcfcjT6FLHiNqRuFA5UFGcey7JRxBXlZCqZjI4/A==
X-Received: by 2002:a5d:6548:0:b0:327:e070:15b8 with SMTP id z8-20020a5d6548000000b00327e07015b8mr5245861wrv.41.1696519350785;
        Thu, 05 Oct 2023 08:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020adfe751000000b00327de0173f6sm2014544wrn.115.2023.10.05.08.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:22:30 -0700 (PDT)
Message-ID: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Oct 2023 15:22:29 +0000
Subject: [PATCH] merge-ort: initialize repo in index state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

initialize_attr_index() does not initialize the repo member of
attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=<tree>"
global option to "git", 2023-05-06), this became a problem because
istate->repo gets passed down the call chain starting in
git_check_attr(). This gets passed all the way down to
replace_refs_enabled(), which segfaults when accessing r->gitdir.

Fix this by initializing the repository in the index state.

Signed-off-by: John Cai <johncai86@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
---
    merge-ort: initialize repo in index state
    
    initialize_attr_index() does not initialize the repo member of
    attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=" global
    option to "git", 2023-05-06), this became a problem because istate->repo
    gets passed down the call chain starting in git_check_attr(). This gets
    passed all the way down to replace_refs_enabled(), which segfaults when
    accessing r->gitdir.
    
    Fix this by initializing the repository in the index state.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1583%2Fjohn-cai%2Fjc%2Fpopulate-repo-when-init-attr-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1583/john-cai/jc/populate-repo-when-init-attr-index-v1
Pull-Request: https://github.com/git/git/pull/1583

 merge-ort.c           |  1 +
 t/t4300-merge-tree.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 7857ce9fbd1..172dc7d497d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1902,6 +1902,7 @@ static void initialize_attr_index(struct merge_options *opt)
 	struct index_state *attr_index = &opt->priv->attr_index;
 	struct cache_entry *ce;
 
+	attr_index->repo = the_repository;
 	attr_index->initialized = 1;
 
 	if (!opt->renormalize)
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 57c4f26e461..254453fff9c 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -86,6 +86,26 @@ EXPECTED
 	test_cmp expected actual
 '
 
+test_expect_success '3-way merge with --attr-source' '
+	test_when_finished rm -rf 3-way &&
+	git init 3-way &&
+	(
+		cd 3-way &&
+		test_commit initial file1 foo &&
+		base=$(git rev-parse HEAD) &&
+		git checkout -b brancha &&
+		echo bar>>file1 &&
+		git commit -am "adding bar" &&
+		source=$(git rev-parse HEAD) &&
+		echo baz>>file1 &&
+		git commit -am "adding baz" &&
+		merge=$(git rev-parse HEAD) &&
+		test_must_fail git --attr-source=HEAD merge-tree -z --write-tree \
+		--merge-base "$base" --end-of-options "$source" "$merge" >out &&
+		grep "Merge conflict in file1" out
+	)
+'
+
 test_expect_success 'file change A, B (same)' '
 	git reset --hard initial &&
 	test_commit "change-a-b-same-A" "initial-file" "AAA" &&

base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
-- 
gitgitgadget
