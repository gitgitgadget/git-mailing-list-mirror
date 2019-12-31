Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D4C3F68F
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 22:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF86206E6
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 22:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECBCjdWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLaWxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 17:53:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39458 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfLaWxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 17:53:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id t17so36128069eds.6
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v99fha7JXYvAX0cXnhwtAY2d8420ZaZEfnNDep14yw8=;
        b=ECBCjdWHRnCTQvXAQC9cY9bW3UV0abJLqyc8FACcjQgt8OTkTNIHrgCOJUsFD3F08w
         /X5+dsk06cCrbF6CLgKxLfhv9ChveZMd8bctsDFj+iC+GDMRe8f4o2K9EsxZq1IvgEEo
         ILhgFvpzMy7W3/whPVgcE4gtPaSlhDi7PsbHtuqLGrj5uIi8gOActU4sLlPcNDZihFUf
         5Lc3UdbdX08P/yoxLdlYJTOio4KT0vRWFleiRlASE3BT2+7eOvfkUnmoHq9FZ7TFW1y+
         Btnxg//xa9FMIbXqAOR2KN3nyWhEg5yTUT6qWnYmnNn1tPH18ACj28sqL+Fg6yCgucQF
         JEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v99fha7JXYvAX0cXnhwtAY2d8420ZaZEfnNDep14yw8=;
        b=GWxiJlC+Mkj9JdYOQomXwRA/pWtWJNowcN2b2CUbwXg5XuwjD3GJLnv2vS5h31NZ2Y
         qIU5oULvNZ/p5xkdispEJoAkr9NJoz1tB2dt6g/ISzBRNOtKpqNZssMzisubOHE1MRJU
         mo3us8SsqxO/c8AgxlBAysu7EESZ5Aq6u2hVkOZIFleibpR8X58M0vkQGkStdrw518xl
         WwKG7cUS5Xz7V0Hu2KcYSk1MZzUTryXqNmui069F9coEMW6p+gYVYvwqej8jz1FmX0B/
         Y8Tba+ZS46gM//wOZ+x/EtzD4ZMaFE/xDNvGAwA84m+s6DZnNmZSpGIAnflw/5o76I12
         Aeyg==
X-Gm-Message-State: APjAAAXNYYMYI7p6bknkQU2Xaj9w77csNguhYOy1OWVnZmIeXANBLyaU
        iSi4PCiQDzfFLxizf9HlE9y3waK+
X-Google-Smtp-Source: APXvYqy+awnJ384DlNBsbZmoGPt4KGrc27CzYJh9QuhToF8j36TekMIOPcQH7ZVuiamZmyYNPe+1Uw==
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr78042488ejb.308.1577832832612;
        Tue, 31 Dec 2019 14:53:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm6009505edl.11.2019.12.31.14.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 14:53:52 -0800 (PST)
Message-Id: <d6da8315d37c6264dfd777f487b19ba200dd31fd.1577832830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.682.v2.git.git.1577832830.gitgitgadget@gmail.com>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
        <pull.682.v2.git.git.1577832830.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 22:53:50 +0000
Subject: [PATCH v2 1/1] mingw: only test index entries for backslashes, not
 tree entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

During a clone of a repository that contained a file with a backslash in
its name in the past, as of v2.24.1(2), Git for Windows prints errors
like this:

	error: filename in tree entry contains backslash: '\'

The idea is to prevent Git from even trying to write files with
backslashes in their file names: while these characters are valid in
file names on other platforms, on Windows it is interpreted as directory
separator (which would obviously lead to ambiguities, e.g. when there is
a file `a\b` and there is also a file `a/b`).

Arguably, this is the wrong layer for that error: As long as the user
never checks out the files whose names contain backslashes, there should
not be any problem in the first place.

So let's loosen the requirements: we now leave tree entries with
backslashes in their file names alone, but we do require any entries
that are added to the Git index to contain no backslashes on Windows.

Note: just as before, the check is guarded by `core.protectNTFS` (to
allow overriding the check by toggling that config setting), and it
is _only_ performed on Windows, as the backslash is not a directory
separator elsewhere, even when writing to NTFS-formatted volumes.

An alternative approach would be to try to prevent creating files with
backslashes in their file names. However, that comes with its own set of
problems. For example, `git config -f C:\ProgramData\Git\config ...` is
a very valid way to specify a custom config location, and we obviously
do _not_ want to prevent that. Therefore, the approach chosen in this
patch would appear to be better.

This addresses https://github.com/git-for-windows/git/issues/2435

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c               | 5 +++++
 t/t7415-submodule-names.sh | 7 ++++---
 tree-walk.c                | 6 ------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ad0b48c84d..737916ebd9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1278,6 +1278,11 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
+#ifdef GIT_WINDOWS_NATIVE
+	if (protect_ntfs && strchr(ce->name, '\\'))
+		return error(_("filename in tree entry contains backslash: '%s'"), ce->name);
+#endif
+
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
 		cache_tree_invalidate_path(istate, ce->name);
 
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index 905a557585..7ae0dc8ff4 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -207,6 +207,9 @@ test_expect_success MINGW 'prevent git~1 squatting on Windows' '
 			git hash-object -w --stdin)" &&
 		rev="$(git rev-parse --verify HEAD)" &&
 		hash="$(echo x | git hash-object -w --stdin)" &&
+		test_must_fail git update-index --add \
+			--cacheinfo 160000,$rev,d\\a 2>err &&
+		test_i18ngrep backslash err &&
 		git -c core.protectNTFS=false update-index --add \
 			--cacheinfo 100644,$modules,.gitmodules \
 			--cacheinfo 160000,$rev,c \
@@ -214,9 +217,7 @@ test_expect_success MINGW 'prevent git~1 squatting on Windows' '
 			--cacheinfo 100644,$hash,d./a/x \
 			--cacheinfo 100644,$hash,d./a/..git &&
 		test_tick &&
-		git -c core.protectNTFS=false commit -m "module" &&
-		test_must_fail git show HEAD: 2>err &&
-		test_i18ngrep backslash err
+		git -c core.protectNTFS=false commit -m "module"
 	) &&
 	test_must_fail git -c core.protectNTFS=false \
 		clone --recurse-submodules squatting squatting-clone 2>err &&
diff --git a/tree-walk.c b/tree-walk.c
index b3d162051f..d5a8e096a6 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -43,12 +43,6 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 		strbuf_addstr(err, _("empty filename in tree entry"));
 		return -1;
 	}
-#ifdef GIT_WINDOWS_NATIVE
-	if (protect_ntfs && strchr(path, '\\')) {
-		strbuf_addf(err, _("filename in tree entry contains backslash: '%s'"), path);
-		return -1;
-	}
-#endif
 	len = strlen(path) + 1;
 
 	/* Initialize the descriptor entry */
-- 
gitgitgadget
