Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BEC2B9F6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC64561166
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhELRox (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347766AbhELR3m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB39C06138B
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso134642wmj.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2ZiYssB16i7F8qxNfOEy3ZNesqACrrwJ1aBmmG9MeA=;
        b=Yd6qwZu9H/hIB7qTk0xek3T0BKSYN9ZAFSJ7hYkNZKsb+yXKbJph8yQ0rT6Sgi33w1
         IitkdJPsqJtamclc7SU0ANsr/kmNkvxiy7hwOWNBVumoL7QJPwE3mn1qp6HzAoZRsddL
         PnWms5REyPsHZDyeRdKavKeE6pzSGIXJk5ZjAstpx3RfDG3igrpptQYZWNv+HIlOQtrx
         Y2DfJxnsKT35XO4aVvAl7uKyj3T2ya5+dVs5bPROHvAZcQeoH4mb9DCjU8Fsxk6bwbmt
         GPSj9ZLnMCmbAxY+peixw+wVHsoPFpj822+lRSP/tgy5NADGlLdkDcTTCQO8uP04rWtX
         cXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2ZiYssB16i7F8qxNfOEy3ZNesqACrrwJ1aBmmG9MeA=;
        b=NT/HBR4/+sRVhCiIbaLbIawvuvxFcnLX96kuQrXL4mTgywa2ibAQZROn0RVtspo5Gs
         frJgrYKI/6QfDfwUnZz4ySaTEbivQy5+3mlAp5Emmky+/Cw5AOLCHvPMUSWuTF22qO/X
         jWVvxeArPfSRiG5th8WHtVgy7nR+9318sh4d+u2C/PpbUNahq5EVpIE1omg2FpeGAgUH
         1U3f5M2pe7VsdGFs99hjZEi97lUtDwCbh17flCkoqZv/Rz0BjRQJaeZkCQ+dw4DR2agY
         xO/m0PtwGycIAn7/LasZDnDFgNN/aF4sby7W2E8C2294bi0N1PN0zOCWe+GNNk4meakJ
         C2Aw==
X-Gm-Message-State: AOAM533zRqyeGJfoLyfHgNf8/1tiQomEz+989MN2iB2kIaAwDAeSGmkZ
        uJM8LKu97IXhts3fNfnQeYMfErcYySU=
X-Google-Smtp-Source: ABdhPJw4HKBSU0yPvMI4MKFrwFgMJK0TlnvYDKVNERvSXT75X37wiLqdHZOerrXyyyzIbbsACKQE6g==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr5186026wma.74.1620840511863;
        Wed, 12 May 2021 10:28:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm354275wrr.2.2021.05.12.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:31 -0700 (PDT)
Message-Id: <179f992edc9254803252ae10e5d692f3755a40f3.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:21 +0000
Subject: [PATCH v5 8/9] dir: update stale description of treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

The documentation comment for treat_directory() was originally written
in 095952 (Teach directory traversal about subprojects, 2007-04-11)
which was before the 'struct dir_struct' split its bitfield of named
options into a 'flags' enum in 7c4c97c0 (Turn the flags in struct
dir_struct into a single variable, 2009-02-16). When those flags
changed, the comment became stale, since members like
'show_other_directories' transitioned into flags like
DIR_SHOW_OTHER_DIRECTORIES.

Update the comments for treat_directory() to use these flag names rather
than the old member names.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index c0233bbba36c..4794c822b47f 100644
--- a/dir.c
+++ b/dir.c
@@ -1749,13 +1749,13 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
  * Case 3: if we didn't have it in the index previously, we
  * have a few sub-cases:
  *
- *  (a) if "show_other_directories" is true, we show it as
- *      just a directory, unless "hide_empty_directories" is
+ *  (a) if DIR_SHOW_OTHER_DIRECTORIES flag is set, we show it as
+ *      just a directory, unless DIR_HIDE_EMPTY_DIRECTORIES is
  *      also true, in which case we need to check if it contains any
  *      untracked and / or ignored files.
- *  (b) if it looks like a git directory, and we don't have
- *      'no_gitlinks' set we treat it as a gitlink, and show it
- *      as a directory.
+ *  (b) if it looks like a git directory and we don't have the
+ *      DIR_NO_GITLINKS flag, then we treat it as a gitlink, and
+ *      show it as a directory.
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
@@ -1843,7 +1843,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_recurse;
 	}
 
-	/* This is the "show_other_directories" case */
 	assert(dir->flags & DIR_SHOW_OTHER_DIRECTORIES);
 
 	/*
@@ -1858,7 +1857,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	/* Special cases for where this directory is excluded/ignored */
 	if (excluded) {
 		/*
-		 * In the show_other_directories case, if we're not
+		 * If DIR_SHOW_OTHER_DIRECTORIES is set and we're not
 		 * hiding empty directories, there is no need to
 		 * recurse into an ignored directory.
 		 */
-- 
gitgitgadget

