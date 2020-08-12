Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE72BC433E1
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6008205CB
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltqbs3Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHLHMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgHLHMl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 03:12:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFEAC061787
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 00:12:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so858329wmd.4
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lgz2EB3gb3PdAPlp0LwhVrWsFb2apcv7Q9XTO5oDBLA=;
        b=Ltqbs3HkjPH5Ek0NZFkuHJkMAOudf//Z6/Wzl1bTsah5ivcA+tr/jsKPrqainzZC71
         CYS1PmgIl3om6Fk361j0Gc8lHgYON1JMEuP+MJbuyob/dsxkoQMd4+SHtxbddRdR/ZsJ
         V64iHDAi8VCOl56ZEvqOcHTHbDfwMmq/sUltYt/0NcZl3F0/qrZKEwTGQC5jkvUvvAV5
         EmDhYbo6nmaPWt+UIPvAXyZr2vXfigbIB7bgClnZtcF5F+05MY7rpSWNQkActEXU5qsg
         SIbWk5nJq1GPc98+ZfOSRAhbVpvh+50pCBJRqydmZ0noRU4xXeanUFpbZ60Q5M4+doIc
         YVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lgz2EB3gb3PdAPlp0LwhVrWsFb2apcv7Q9XTO5oDBLA=;
        b=IM9voIta5l6j4bx44Tn1mSHZi6IC5xcjq/aT59OaXqf+uC5Gafz+9MswMwxddzvshv
         zP+/nOSdA6a8R7Nsz1WfVybwYRj+oOPWU+Pe2KcqiA5NQSb1s6vYA5f/1DC7L7yXYrkz
         bUQX6CuPsHO2iAjT8hkPjgGDWvrGt4jJUumuux9U6VYHXcSpUha/VfhwJSqY5LgceWcJ
         b+XEC1lZb1SCP0/MzFnm0RbzcNu9gXKFpwXBJ9WKto+voQP4njZj3ZjzBQpY+x8rh+HI
         HK/lX3dK5SoFve7QAAhbjvlvEdRvs5xWGaGSXM/v2uMW0cke5t/iN+iRHmnrZNLfxCSo
         XMcQ==
X-Gm-Message-State: AOAM532HyFjJoWk+mM3p+FcSdjIQgcIcnnyI6VGDHSsMaZAlxFPimQ4X
        eqM2Uc9CL7Npr0JcejMY+t4W9S6f
X-Google-Smtp-Source: ABdhPJz8NteYjTdDVyjeISSNT2aEtoV3H8pwrva2mhHoMK27lRSUxXo94CV2HChXzzxIJwo+M91MEg==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr7530218wmf.26.1597216359458;
        Wed, 12 Aug 2020 00:12:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm2630510wrg.96.2020.08.12.00.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:12:38 -0700 (PDT)
Message-Id: <11a286b071ca8a6b96f4fba6658e9bafb9314be4.1597216356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.git.1597216356.gitgitgadget@gmail.com>
References: <pull.829.git.git.1597216356.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 07:12:36 +0000
Subject: [PATCH 2/2] dir: avoid prematurely marking nonbare repositories as
 matches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Nonbare repositories are special directories.  Unlike normal directories
that we might recurse into to list the files they contain, nonbare
repositories must themselves match and then we always report only on the
nonbare repository directory itself and not on any of its contents.

Separately, when traversing directories to try to find untracked or
excluded files, we often think in terms of paths either matching the
specified pathspec, or not matching them.  However, there is a special
value that do_match_pathspec() uses named
MATCHED_RECURSIVELY_LEADING_PATHSPEC which means "this directory does
not match any pathspec BUT it is possible a file or directory underneath
it does."  That special value prevents us from prematurely thinking that
some directory and everything under it is irrelevant, but also allows us
to differentiate from "this is a match".

The combination of these two special cases was previously uncovered.
Add a test to the testsuite to cover it, and make sure that we return a
nonbare repository as a non-match if the best match it got was
MATCHED_RECURSIVELY_LEADING_PATHSPEC.

Reported-by: christian w <usebees@gmail.com>
Simplified-testcase-and-bisection-by: Kyle Meyer <kyle@kyleam.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                      |  9 ++++++---
 t/t3000-ls-files-others.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 1045cc9c6f..b5082ca05f 100644
--- a/dir.c
+++ b/dir.c
@@ -1792,9 +1792,12 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		nested_repo = is_nonbare_repository_dir(&sb);
 		strbuf_release(&sb);
 	}
-	if (nested_repo)
-		return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
-			(excluded ? path_excluded : path_untracked));
+	if (nested_repo) {
+		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+		    (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
+			return path_none;
+		return excluded ? path_excluded : path_untracked;
+	}
 
 	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
 		if (excluded &&
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 1b9327b780..740ce56eab 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -212,4 +212,20 @@ test_expect_success 'ls-files -o --directory to get immediate paths under one di
 	)
 '
 
+test_expect_success 'ls-files -o avoids listing untracked non-matching gitdir' '
+	test_when_finished "rm -rf nested/untracked/deep/empty" &&
+	(
+		cd nested &&
+
+		git init untracked/deep/empty &&
+		git ls-files --others "untracked/*.c" >actual &&
+
+		cat <<-EOF >expect &&
+		untracked/deep/foo.c
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget
