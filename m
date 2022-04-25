Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23EDC433FE
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 20:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbiDYUcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbiDYUcG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 16:32:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C133EA6
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 13:28:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b19so22474875wrh.11
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uh1Vd5NyRR/Y0IOOzpk+hgKbohhXmBySr0Q4S3IvSo=;
        b=kify3dgcE0E6zvJhTr0CKXHcC9uxd0Fj/MLDzhRfq8vPobG8Csgo2fiqU8cYW8BO4G
         EnUnxGCydK4zWw80VIB0o0Zw3F3kn0tmA5GDMi/qoWJCIn6ye7GzlDNPVvYkkmZprWbj
         CN1Lix+JAgXrlGRvDwNpYddajGgagsMMBfIjl8qgMc8e1yEP0OxHvuAVfcQdSy9TfXc4
         l2sM9utAj/BZe6Nyyn5BKN89z+CYFqhTl+RJndLs9U5CKGIazKHU891sLbEYN4jw9Bw0
         aPIMqBrQf8KOvPaeZs/iYcYk6P0HrQvRzqBK06qRjKDLmTfWB6XfvLdJqcUHG+0i26SO
         1WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uh1Vd5NyRR/Y0IOOzpk+hgKbohhXmBySr0Q4S3IvSo=;
        b=maS+nmFrGHZLixX4JhMjEM1rAlAKH9r/xpcPPO4Lcjv5GFLQym4czx7pppo+XYE9MQ
         a5COVs/3BkMzjNFJMJ9VMTf4xa5eRl75U4/nM8x5CZHK/tkmXGcNaQGHXO8DeU2g3dTP
         DdqNBR7rm/uCavrXEfGPOKQm24Z9sEvvL/OGD5HDZDTrtmgXca/JYNaJNWcrKm67m+aq
         jb5iDQDt6Yzt045h3PHHei1T+PnZ1tLzoX2Ea605xVlpajYnkc8C3Ye5ERPPqEFlpTCY
         cayCDeEp9LnxfBFIEe96Ls9DpsCsJml3eGx+T2IoZoqMH73BCIu5uN553FhcO/ZG3AUh
         qDlQ==
X-Gm-Message-State: AOAM532i/liyhQS9Z5jP7PqDvu8+ArP8oUtR5mdBl6PTY6lgLsPoG1+r
        4GIRyxH0Cua5KoPdL5UBsGI=
X-Google-Smtp-Source: ABdhPJy0JUH6Bv89pu/xOzdA2KpweT7Km2UxpitUYj6wZlmThw0ohC69wWeCHHj9E1gPuzcfSwxPvg==
X-Received: by 2002:a05:6000:18c3:b0:206:1575:ec8f with SMTP id w3-20020a05600018c300b002061575ec8fmr15404334wrq.479.1650918538311;
        Mon, 25 Apr 2022 13:28:58 -0700 (PDT)
Received: from localhost.localdomain (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id h9-20020adfa4c9000000b0020ae2a771fdsm876256wrb.72.2022.04.25.13.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:28:57 -0700 (PDT)
From:   Jonathan <git.jonathan.bressat@gmail.com>
To:     gitster@pobox.com
Cc:     Jonathan.bressat@etu.univ-lyon1.fr, Matthieu.Moy@univ-lyon1.fr,
        cogoni.guillaume@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com
Subject: [PATCH v1 0/2] Be nicer to the user on tracked/untracked merge conflicts
Date:   Mon, 25 Apr 2022 22:27:19 +0200
Message-Id: <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.7.gc8609858e0.dirty
In-Reply-To: <xmqqfsmg97ac.fsf@gitster.g>
References: <xmqqfsmg97ac.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for being a bit slow to answer.

Junio C Hamano <gitster@pobox.com> wrote:
> 	if (result) {
> 		...
> -	}
> +	} else if (!ie_modified(...)) {
> +		return 0;
> +	}
> 	return add_rejected_path(...);
> 
> is what you want, perhaps?

Yes, but that made us ask if it can be a good idea to extend our patch
to overwrite all unstaged file. However if we want to overwrite all
unstaged file even tracked one just this may not be enough:

if (result) {
	...
}

+if (!ie_modified(...)) {
+	return 0;
+}

Because with this merge still fail for unstaged file that has the same
content, because unstaged file are not exactly treated the same way.

Our patch broke some test in t6436-merge-overwrite.sh so we think that
we need to modify those tests to make them follow the patch.

Thanks for your reviews

Jonathan (2):
  t7615: test how merge behave when there is untracked file
  merge with untracked file that are the same without failure

 t/t7615-merge-untracked.sh | 63 ++++++++++++++++++++++++++++++++++++++
 unpack-trees.c             |  5 ++-
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100755 t/t7615-merge-untracked.sh

Interdiff vs v0 :
diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
index 71a34041d2..99f8bae4c0 100755
--- a/t/t7615-merge-untracked.sh
+++ b/t/t7615-merge-untracked.sh
@@ -2,78 +2,62 @@
 
 test_description='test when merge with untracked file'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
+test_expect_success 'setup' '
+	test_commit "init" README.md "content" &&
+	git checkout -b A
+'
+
+test_expect_success 'fastforward overwrite untracked file that has the same content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	git merge B
+'
 
-test_expect_success 'overwrite the file when fastforward and the same content' '
-    echo content >README.md &&
-    test_commit "init" README.md &&
-    git branch A &&
-    git checkout -b B &&
-    echo content >file &&
-    git add file &&
-    git commit -m "tracked" &&
-    git switch A &&
-    echo content >file &&
-    git merge B
+test_expect_success 'fastforward fail when untracked file has different content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git switch A &&
+	echo other >file &&
+	test_must_fail git merge B
 '
 
-test_expect_success 'merge fail with fastforward and different content' '
-    rm * &&
-    rm -r .git &&
-    git init &&
-    echo content >README.md &&
-    test_commit "init" README.md &&
-    git branch A &&
-    git checkout -b B &&
-    echo content >file &&
-    git add file &&
-    git commit -m "tracked" &&
-    git switch A &&
-    echo dif >file &&
-    test_must_fail git merge B
+test_expect_success 'normal merge overwrite untracked file that has the same content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo content >file &&
+	git merge B
 '
 
-test_expect_success 'normal merge with untracked with the same content' '
-    rm * &&
-    rm -r .git &&
-    git init &&
-    echo content >README.md &&
-    test_commit "init" README.md &&
-    git branch A &&
-    git checkout -b B &&
-    echo content >fileB &&
-    echo content >file &&
-    git add fileB &&
-    git add file &&
-    git commit -m "tracked" &&
-    git switch A &&
-    echo content >fileA &&
-    git add fileA &&
-    git commit -m "exA" &&
-    echo content >file &&
-    git merge B -m "merge"
+test_expect_success 'normal merge fail when untracked file has different content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo dif >file &&
+	test_must_fail git merge B
 '
 
-test_expect_success 'normal merge fail when untracked with different content' '
-    rm * &&
-    rm -r .git &&
-    git init &&
-    echo content >README.md &&
-    test_commit "init" README.md &&
-    git branch A &&
-    git checkout -b B &&
-    echo content >fileB &&
-    echo content >file &&
-    git add fileB &&
-    git add file &&
-    git commit -m "tracked" &&
-    git switch A &&
-    echo content >fileA &&
-    git add fileA &&
-    git commit -m "exA" &&
-    echo dif >file &&
-    test_must_fail git merge B -m "merge"
+test_expect_success 'merge fail when tracked file modification is unstaged' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	test_commit --no-tag "unstaged" file "other" &&
+	git checkout -b B &&
+	test_commit --no-tag "staged" file "content" &&
+	git switch A &&
+	echo content >file &&
+	test_must_fail git merge B
 '
 
-test_done
\ No newline at end of file
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 834aca0da9..61e06c04be 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2257,18 +2257,17 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (result) {
 		if (result->ce_flags & CE_REMOVE)
 			return 0;
-	}
-
-	if (!ie_modified(&o->result, ce, st, 0))
+	} else if (!ie_modified(&o->result, ce, st, 0)) {
 		return 0;
-
+	}
 
 	return add_rejected_path(o, error_type, name);
 }
 
 /*
  * We do not want to remove or overwrite a working tree file that
- * is not tracked, unless it is ignored.
+ * is not tracked, unless it is ignored and unless it has the same
+ * content than the merged file.
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
-- 
2.35.1.7.gc8609858e0.dirty

