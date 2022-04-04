Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA34C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 05:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377360AbiDDFwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 01:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiDDFwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 01:52:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8664326E3
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 22:50:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso4916816wml.5
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 22:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mdl/cY5KwGX1bTHeKZm40ji8gokQIdZPHyiZAjG5MXc=;
        b=aF57NXTi3IZkw0aa1Yavff0OctJ8Xuv7597/ux7jfI4Y/KZz6I5WWJ8d/ltEWnetDL
         Oys9seelfLngCU8ieoWCL62QLVapqofyRm5qKJ9duKw3kjH5PcFaSs7RAwCMJNO7a1f0
         UhUwAN8aSfq+nawHvTPaq/Xtnige4fDjlt6tf6XHg3+01wx8MMSpPww8F93/MPknSWk0
         n/EaLNvEqEfniBCnhjsYEt6CBZnA3+qSWWVH8knrgB6Q5khh58zM/R3M+iaEl2rfnFdb
         wlvLsWeKBGBgBHY86e294lv9Y5Bih/BjuWjmdHSt3/0v1imISOLqZEOGTyoygio6O+mP
         CH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mdl/cY5KwGX1bTHeKZm40ji8gokQIdZPHyiZAjG5MXc=;
        b=g8/hw5SSOEbYP1vgh/xp44/G+zq03Wo5LZoRGkMav7xcH6EP26hwckuSUl71d6B9oX
         e4tTGG0X6szBwgqp8w4rU7/zhppWaPcni28vmhtdaU+dfXkQ1dx1gbDOznYm3/OZIpU4
         FjVmeZSCYdo/4EbVXFXkXpqZTwNQKIyGRjHMYhBMM17Tt2aBppLIfaX++ekCi9l7WCLV
         CHTjyMWxT5Kh37CJg4cIA3DN8KgCPw0kCXfU5N+O+Uf47RAt9AjmHcFJoQA31le+B1pR
         FMO0rx98AFYut0RXImDO4ayzyNozGd0ObPKdYkz0SyQ1wiCcxVlbJLzRT/ykv2unqFr4
         LiJQ==
X-Gm-Message-State: AOAM532NZp03Nj7i1/BZPHNbBvvzxI0T6SCxqCkGdq669LYUwwtLfBQL
        OYgAazxLzeQK6Nq+2B8prOwochlrI4Q=
X-Google-Smtp-Source: ABdhPJy6cFdjOjXdTEVseNmsFuaXPT5RIes7AyrvGNnWjOxvzXCOnTpff4V+yBs+VbEcnrp0wwiZdg==
X-Received: by 2002:a05:600c:3589:b0:38c:d35f:7d18 with SMTP id p9-20020a05600c358900b0038cd35f7d18mr18355071wmq.30.1649051438070;
        Sun, 03 Apr 2022 22:50:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b0038cc046cb2esm12311156wmq.32.2022.04.03.22.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 22:50:37 -0700 (PDT)
Message-Id: <pull.1203.git.1649051436934.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Apr 2022 05:50:36 +0000
Subject: [PATCH] git-p4: preserve utf8 BOM when importing from p4 to git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Perforce has a file type "utf8" which represents a text file with
explicit BOM. utf8-encoded files *without* BOM are stored as
regular file type "text". The "utf8" file type behaves like text
in all but one important way: it is stored, internally, without
the leading 3 BOM bytes.

git-p4 has historically imported utf8-with-BOM files (files stored,
in Perforce, as type "utf8") the same way as regular text files -
losing the BOM in the process.

Under most circumstances this issue has little functional impact,
as most systems consider the BOM to be optional and redundant, but
this *is* a correctness failure, and can have lead to practical
issues for example when BOMs are explicitly included in test files,
for example in a file encoding test suite.

Fix the handling of utf8-with-BOM files when importing changes from
p4 to git, and introduce a test that checks it is working correctly.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    git-p4: preserve utf8 BOM when importing from p4 to git
    
    I manually tested these changes with python2 and python3 - I don't know
    whether there is a more rigorous approach possible than changing the
    system default python and rerunning the "t98xx" tests, but that did work
    (and initially highlighted an issue, now fixed).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1203%2FTaoK%2Fgit-p4-utf8-bom-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1203/TaoK/git-p4-utf8-bom-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1203

 git-p4.py                  | 10 ++++++++++
 t/t9802-git-p4-filetype.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index a9b1f904410..6d932e7ed76 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2885,6 +2885,16 @@ class P4Sync(Command, P4UserMap):
             print("\nIgnoring apple filetype file %s" % file['depotFile'])
             return
 
+        if type_base == "utf8":
+            # The type utf8 explicitly means utf8 *with BOM*. These are
+            # streamed just like regular text files, however, without
+            # the BOM in the stream.
+            # Therefore, to accurately import these files into git, we
+            # need to explicitly re-add the BOM before writing.
+            # 'contents' is a set of bytes in this case, so create the
+            # BOM prefix as a b'' literal.
+            contents = [b'\xef\xbb\xbf' + contents[0]] + contents[1:]
+
         # Note that we do not try to de-mangle keywords on utf16 files,
         # even though in theory somebody may want that.
         regexp = p4_keywords_regexp_for_type(type_base, type_mods)
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 19073c6e9f8..2a6ee2a4678 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -333,4 +333,38 @@ test_expect_success SYMLINKS 'empty symlink target' '
 	)
 '
 
+test_expect_success SYMLINKS 'utf-8 with and without BOM in text file' '
+	(
+		cd "$cli" &&
+
+		# some utf8 content
+		echo some tǣxt >utf8-nobom-test &&
+
+		# same utf8 content as before but with bom
+		echo some tǣxt | sed '\''s/^/\xef\xbb\xbf/'\'' >utf8-bom-test &&
+
+		# bom only
+		dd bs=1 count=3 if=utf8-bom-test of=utf8-bom-empty-test &&
+
+		p4 add utf8-nobom-test utf8-bom-test utf8-bom-empty-test &&
+		p4 submit -d "add utf8 test files"
+	) &&
+	test_when_finished cleanup_git &&
+
+	git p4 clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git checkout refs/remotes/p4/master &&
+
+		echo some tǣxt >utf8-nobom-check &&
+		test_cmp utf8-nobom-check utf8-nobom-test &&
+
+		echo some tǣxt | sed '\''s/^/\xef\xbb\xbf/'\'' >utf8-bom-check &&
+		test_cmp utf8-bom-check utf8-bom-test &&
+
+		dd bs=1 count=3 if=utf8-bom-check of=utf8-bom-empty-check &&
+		test_cmp utf8-bom-empty-check utf8-bom-empty-test
+	)
+'
+
 test_done

base-commit: 4b6846d9dcd391164b72bd70e8a0c0e09776afe3
-- 
gitgitgadget
