Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC1C3F68F
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616BB206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+fakB1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLZRmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:42:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39697 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfLZRmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:42:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id t17so23232035eds.6
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vesHcNww9E6q3lUswY+M2ZK8te4uXYbU9y8yM5Ierik=;
        b=Y+fakB1StwOsQ1Nugr2DJJtFJgnPEEN3uMK1YB0FAt4Hv1Wx0JO7eGf4oSF/U3ZpPj
         MYcD5WkL2kgZexsAS16FurplFQwPhYN6zFmTa/oQDxhDfDJiBSmA3I2KTDYSuJ6lRyIx
         RKOA51iP5cR3zzx7+wCbH9LL6+SFrNDtrXTsfu9sjI2btuRSgvFQnHGpotEseE7Jp4dA
         5PiZHHX6DgV+K+2LGJz9jdx2YC0i4wTKkwzVxqcjc3urhl22pCDIjunBUhYkZn3jdgjS
         qdDATc1qCGVQEO9r/mIcG6ZruM9GFShch8MsQFlr0bkU83tBaFC/MUvYi7ToISGHk8uz
         rd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vesHcNww9E6q3lUswY+M2ZK8te4uXYbU9y8yM5Ierik=;
        b=IWfTo6naTrwww9ls27h2BTrVgLw5tDbuQ+3sBxtEwud8iN0akSqyxclNOq95CCe2Rg
         dv25mg8C5ObYQdl1K0JjwXaPsee1AFVrhPxDmWsIHyV7dFMuShYqNJKe805l6FqWY4VW
         SAf4j5gICVERji9Xx509j9ksU3FGlGexnHRPKcXrTfk6NNcydDUi3YZSLpw13XJuBMJj
         +te2slqJ5EbiaMvBGmVghCwaN2LjkY20lKF5UOGtRMdyjvrA96gXv2x/yU2l+AU+EQF3
         EfRbP7vCr4O26U06wlIOOg7YLCE8Vt6K6ePaQNQYSnVirc82TZ84+QlHvFt4QvFK3p5L
         qCOg==
X-Gm-Message-State: APjAAAWAvq8XkLDrfS2SQuvI64WUOVc2hN4KFTsKHL1j1s7liBwJ3jqt
        uKIsFICQ4eZXRDnHwHyLt4s/vUO7
X-Google-Smtp-Source: APXvYqy2R7B9S1n7SLKTAP5D/6/tqLR8vNIVmLxJEuTGtugykWZOoY2iDTmMddk7RgnpmM3sNpRD6w==
X-Received: by 2002:a17:906:9248:: with SMTP id c8mr49999081ejx.37.1577382153632;
        Thu, 26 Dec 2019 09:42:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm1665487eje.34.2019.12.26.09.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:42:33 -0800 (PST)
Message-Id: <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 17:42:31 +0000
Subject: [PATCH 1/1] mingw: only test index entries for backslashes, not tree
 entries
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

While the clone still succeeds, a similar error prevents the equivalent
`git fetch` operation, which is inconsistent.

Arguably, this is the wrong layer for that error, anyway: As long as the
user never checks out the files whose names contain backslashes, there
should not be any problem in the first place.

So let's instead prevent such files to be added to the index.

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
