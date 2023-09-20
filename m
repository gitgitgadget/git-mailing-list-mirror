Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CF9CE79D1
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 14:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjITOAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjITOAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 10:00:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D83AC
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 07:00:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f71b25a99so6818803f8f.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695218434; x=1695823234; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz4T+i/qaxTxnt/SJ9QMBCX5QphXFL2znb0uOumkXlw=;
        b=Cz74Jp/AOkj2rY/5dsaS1X7kHwoj52rrxRbuDSvpFQOiUyYmqUNzEVL2AaN8y8nSGa
         /mGy4cgO6sKiKFeGNvOAQsOqsFABehleTE28S2IzUUdp3W0zxjmnMIrHquHem8IFO3Dw
         tWG9RPbfZQNTvrQ+lYEt3qThIQ6jZYHB6zaEj3x2Qyxi58p6LFwFVN2uHR+Gu/iI5HXz
         Zoqqjy7jl7kedkS4sAbEYMFQ4lztG7ahq21B22C8JxiffvK2sXwMOS0QKCPPAL35EqSu
         WF/t+0N6L7a1IF6o5OfOCPzEvoFMrBlAbtyE/lZzdFd/Nc8BMciYdnhZU+hAHqvwXPYM
         ER8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218434; x=1695823234;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uz4T+i/qaxTxnt/SJ9QMBCX5QphXFL2znb0uOumkXlw=;
        b=UiTQL0He3rXIK7UJKRVm8zApKxWuokPWwS56/patK3PqMO9bK1yZaacJEEshRBDHMs
         PaTaw5lBXVmsL7aIuAqs0uhBkmzeO0xl7DuO+0gCpb3jE+b0dp/lDffS94bI8K3c40T/
         uBjcrN/6pxbn/KGzAo/+p5XKJhgfqL3t4QvBUhbqfppooAOtLzkj955I3Bhm4yO6Qt6W
         x658wVOCswOn49Txc2lJPd6hzqpm6oFvbuCfUyDCsWmrQf8ERRXPa9Qg4J7fIf2TVgdW
         s4nkbesj9eK3/Av4SaaaYotLuLYUi35InCuqWEOZK/RY6PWH2DHeo70bJbcz4MnVwZuG
         TBqA==
X-Gm-Message-State: AOJu0Yw/lapZPTksRL5Cz+VFbSTmHMd7y8y30A8LBtyUIJjAJY2CGfEO
        f6ihGjpjfZmcik5Hz8u4rLAUHYHcJSQ=
X-Google-Smtp-Source: AGHT+IFrBD4NxiBCNPpiZ7mrExci/Czk9cXRd75hJn3sOkRGBwljJ3G9SrqvB/ahCM+d1LeuSpVVJA==
X-Received: by 2002:a5d:574d:0:b0:321:6a61:e45a with SMTP id q13-20020a5d574d000000b003216a61e45amr2266979wrw.15.1695218432381;
        Wed, 20 Sep 2023 07:00:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0031f5f0d0be0sm18789743wru.31.2023.09.20.07.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:00:32 -0700 (PDT)
Message-ID: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 14:00:30 +0000
Subject: [PATCH] attr: attr.allowInvalidSource config to allow invalid
 revision
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

44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
2023-05-06) provided the ability to pass in a treeish as the attr
source. When a revision does not resolve to a valid tree is passed, Git
will die. GitLab keeps bare repositories and always reads attributes
from the default branch, so we pass in HEAD to --attr-source.

With empty repositories however, HEAD does not point to a valid treeish,
causing Git to die. This means we would need to check for a valid
treeish each time. To avoid this, let's add a configuration that allows
Git to simply ignore --attr-source if it does not resolve to a valid
tree.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    attr: attr.allowInvalidSource config to allow empty revision
    
    44451a2e5e (attr: teach "--attr-source=" global option to "git",
    2023-05-06) provided the ability to pass in a treeish as the attr
    source. When a revision does not resolve to a valid tree is passed, Git
    will die. GitLab keeps bare repositories and always reads attributes
    from the default branch, so we pass in HEAD to --attr-source.
    
    With empty repositories however, HEAD does not point to a valid treeish,
    causing Git to die. This means we would need to check for a valid
    treeish each time. To avoid this, let's add a configuration that allows
    Git to simply ignore --attr-source if it does not resolve to a valid
    tree.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1577%2Fjohn-cai%2Fjc%2Fconfig-attr-invalid-source-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1577/john-cai/jc/config-attr-invalid-source-v1
Pull-Request: https://github.com/git/git/pull/1577

 Documentation/config.txt      |  2 ++
 Documentation/config/attr.txt |  6 ++++++
 attr.c                        | 11 +++++++++--
 t/t0003-attributes.sh         | 36 +++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/attr.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 229b63a454c..b1891c2b5af 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -371,6 +371,8 @@ other popular tools, and describe them in your documentation.
 
 include::config/advice.txt[]
 
+include::config/attr.txt[]
+
 include::config/core.txt[]
 
 include::config/add.txt[]
diff --git a/Documentation/config/attr.txt b/Documentation/config/attr.txt
new file mode 100644
index 00000000000..2218f0c982a
--- /dev/null
+++ b/Documentation/config/attr.txt
@@ -0,0 +1,6 @@
+attr.allowInvalidSource::
+	If `--attr-source` cannot resolve to a valid tree object, ignore
+	`--attr-source` instead of erroring out, and fall back to looking for
+	attributes in the default locations. Useful when passing `HEAD` into
+	`attr-source` since it allows `HEAD` to point to an unborn branch in
+	cases like an empty repository.
diff --git a/attr.c b/attr.c
index 71c84fbcf86..854a3720e3f 100644
--- a/attr.c
+++ b/attr.c
@@ -1208,8 +1208,15 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;
 
-	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
-		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+
+	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source)) {
+		int allow_invalid_attr_source = 0;
+
+		git_config_get_bool("attr.allowinvalidsource", &allow_invalid_attr_source);
+
+		if (!allow_invalid_attr_source)
+			die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+	}
 }
 
 static struct object_id *default_attr_source(void)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 26e082f05b4..3272237ee2b 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -342,6 +342,42 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
+
+test_expect_success 'attr.allowInvalidSource when HEAD is unborn' '
+	test_when_finished rm -rf empty &&
+	echo $bad_attr_source_err >expect_err &&
+	echo "f/path: test: unspecified" >expect &&
+	git init empty &&
+	test_must_fail git -C empty --attr-source=HEAD check-attr test -- f/path 2>err &&
+	test_cmp expect_err err &&
+	git -C empty -c attr.allowInvalidSource=true --attr-source=HEAD check-attr test -- f/path >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'attr.allowInvalidSource when --attr-source points to non-existing ref' '
+	test_when_finished rm -rf empty &&
+	echo $bad_attr_source_err >expect_err &&
+	echo "f/path: test: unspecified" >expect &&
+	git init empty &&
+	test_must_fail git -C empty --attr-source=refs/does/not/exist check-attr test -- f/path 2>err &&
+	test_cmp expect_err err &&
+	git -C empty -c attr.allowInvalidSource=true --attr-source=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bad attr source defaults to reading .gitattributes file' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	echo "f/path test=val" >empty/.gitattributes &&
+	echo "f/path: test: val" >expect &&
+	git -C empty -c attr.allowInvalidSource=true --attr-source=HEAD check-attr test -- f/path >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&

base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
-- 
gitgitgadget
