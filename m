Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8EAC25B06
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 04:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiHGEON (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 00:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiHGEOA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 00:14:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C310FCB
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 21:13:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id iw1so5893243plb.6
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 21:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w14YtX5hbdcv5nO+DH51KgoD08YYAKivWfr4n0Nepjk=;
        b=gKButyYxX07QfbvAADKmsSh8wjmd/sgNWtmgo2HB3vYfYb6T0srScKc/dMWTIFY/5e
         Tk3MMDRSKNX0P64IkBU533RXjKcUNWZXOqjQCecBGKzc4jy9CYfrwA7dBd95jd1db14e
         Fn+XpFBvrLKpuCssdH2JVDds+FAA1fRouIeQJ4mIiO8YlEVnCbxRuUFPB8bREsegWe6N
         3/VV6lkPb0h9qoqEKDuVWFn7nr/YxUGCpzqn9MCMq4YRTzfJGHau6GFngMsMTFqmOA9C
         9pFtITKdmSUTJU4gI7kzuGfbtEnsdqiyCpciPsW/yOEqBJKgC5eR7lkyvNU/kg0DLwpC
         k3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w14YtX5hbdcv5nO+DH51KgoD08YYAKivWfr4n0Nepjk=;
        b=QhZYypwpDIhB12DE24KbDGbdtXmV0/+wAfABZNj6yDJV+M8XjQprSTGuGGq0WShNhb
         97MRqn8AhQfR0Xds96C9m5LLn6MpOGhw5KbbJYtgIKaSpjwwGmGPyaYLwEcTXkV/pB3k
         OfdrEshlZ0faSZgCzbRMMSIAPgP9CeKCzaAodEo/6ZfscCZN1aX1+zql69sFmbeXDQxK
         5NvVEvCxxLmC0OF3/LaSYzrGbv8jn78/aFMr2jzYX4KFT8CbTwIN//EP9xc9UFvKzXhq
         zsdDXXAlPkId2c2UMw29CYvJJwtItomswL7qDmGPFRazD7Ub5ueOOP/OKUB+knyaSsHT
         Otgg==
X-Gm-Message-State: ACgBeo01fmzlc5A6t6MTVQtZ9zsfD2bXRo6P1WSEaEWWbei1jgE8jwvK
        K6mBbOBWBbc43uYtNVT+Z9O6PnlzEUtPvA==
X-Google-Smtp-Source: AA6agR61Bkhl0jpO/aCgWe4tGmTZoAB6YFkQHoCcDgAeQpVFu8l7nEtNOaxjPtr+Be+NDIVNQf9L6A==
X-Received: by 2002:a17:90b:1c0d:b0:1f5:4ddf:1607 with SMTP id oc13-20020a17090b1c0d00b001f54ddf1607mr20879735pjb.90.1659845639120;
        Sat, 06 Aug 2022 21:13:59 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.209.111])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090a0e1600b001f333fab3d6sm8057027pje.18.2022.08.06.21.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:13:58 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 3/4] rm: expand the index only when necessary
Date:   Sun,  7 Aug 2022 12:13:34 +0800
Message-Id: <20220807041335.1790658-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the `ensure_full_index()` method so `git-rm` does not always
expand the index when the expansion is unnecessary, i.e. when
<pathspec> does not have any possibilities to match anything outside
of sparse-checkout definition.

Expand the index when the <pathspec> needs an expanded index, i.e. the
<pathspec> contains wildcard that may need a full-index or the
<pathspec> is simply outside of sparse-checkout definition.

Notice that the test 'rm pathspec expands index when necessary' in
t1092 *is* testing this code change behavior, though it will be marked
as 'test_expect_success' only in the next patch, where we officially
mark `command_requires_full_index = 0`, so the index does not expand
unless we tell it to do so.

Notice that because we also want `ensure_full_index` to record the
stdout and stderr from Git command, a corresponding modification
is also included in this patch. The reason we want the "sparse-index-out"
and "sparse-index-err", is that we need to make sure there is no error
from Git command itself, so we can rely on the `test_region` result
and determine if the index is expanded or not.

Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/rm.c                             |  5 +++--
 t/t1092-sparse-checkout-compatibility.sh | 27 ++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 84a935a16e..58ed924f0d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -296,8 +296,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+	if (pathspec_needs_expanded_index(&the_index, &pathspec))
+		ensure_full_index(&the_index);
+
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c9300b77dd..94464cf911 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1340,10 +1340,14 @@ ensure_not_expanded () {
 		shift &&
 		test_must_fail env \
 			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
-			git -C sparse-index "$@" || return 1
+			git -C sparse-index "$@" \
+			>sparse-index-out \
+			2>sparse-index-error || return 1
 	else
 		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
-			git -C sparse-index "$@" || return 1
+			git -C sparse-index "$@" \
+			>sparse-index-out \
+			2>sparse-index-error || return 1
 	fi &&
 	test_region ! index ensure_full_index trace2.txt
 }
@@ -1910,4 +1914,23 @@ test_expect_failure 'rm pathspec outside sparse definition' '
 	test_sparse_match git status --porcelain=v2
 '
 
+test_expect_failure 'rm pathspec expands index when necessary' '
+	init_repos &&
+
+	# in-cone pathspec (do not expand)
+	ensure_not_expanded rm "deep/deep*" &&
+	test_must_be_empty sparse-index-err &&
+
+	# out-of-cone pathspec (expand)
+	! ensure_not_expanded rm --sparse "folder1/a*" &&
+	test_must_be_empty sparse-index-err &&
+
+	# pathspec that should expand index
+	! ensure_not_expanded rm "*/a" &&
+	test_must_be_empty sparse-index-err &&
+
+	! ensure_not_expanded rm "**a" &&
+	test_must_be_empty sparse-index-err
+'
+
 test_done
-- 
2.37.0

