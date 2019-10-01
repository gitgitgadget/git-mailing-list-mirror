Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E641F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJAS4A (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:56:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45890 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJAS4A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:56:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so5940198pls.12
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqBrSSpM+snfvC/th8lXj9DKZ9LnmoG6TRdO+vBbaNI=;
        b=HvadydhP1Z09ZVYTBIcwbyodm9FriMoCfQOLDEyClyduGGEmAp81XxsRUW/5g6Ts29
         hJWBiaGKdJLCNucswGBe0CmWXQ2O1KdcBliDi6UjxNbSX/GswdFq/MIPfmQFrJPCkqDe
         /a6GHOxn0bNo/MKAB2ztd7kAHgzOWM4hqPBYOEjui7UEiHBvDdhuNZYkDAV1vTJAjgZj
         zcRVe0jbzpnoTprP5k2b1DgiDZ8ZAWL2AJ4zDlbj2gWgqJ3GR9UYGwtHiBAfkJcaLZXd
         CmLus2WB8/Z7/Y1O6/QhAOPImLlC8mTm7jjRg1gp3X+vyhc7GLTrHFgUuRGpXUsmCu+c
         uphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqBrSSpM+snfvC/th8lXj9DKZ9LnmoG6TRdO+vBbaNI=;
        b=bShqt5r1/2A5JmcZu2Bauiqoc4XJOG/DvuCh0WtInGct8thEELubeNQXXXWsNOkdlt
         0sNcnoD7Wv641XKqHy+3ObReZsrIQn84gqX4f4+AtnU+hukpwvMyl24qVrRDiPszRpEa
         HhKLD9XVBOMFOmZiOX9VwEFxrKe3o03RFCBLEmlTJNYZgzmnNIQnf6j52vKQ/T0/+dAd
         JOGr8Cr2Ek9JKpwgkUazrFyjZPRVB0cZT6Su1/WJvrBwBPoe92UlVdgWa5rsNFbqaBUe
         g0iUYErrEz+1GwyzhNJ719AZUwXRWx8d7R35XckiiGzp4W8OOFYeTnbPoeqOvL+BeWzm
         iW7A==
X-Gm-Message-State: APjAAAXBDVlBZzKHm0ik/mTTNH2XHbHfblpzts7Jzi8cbDWZDEWQdI89
        dWOEKlrr2amp/KN96uczuFWrBTp7o/Y=
X-Google-Smtp-Source: APXvYqxcGN+BB9IjI0RORYg+zcSJwW9r2gGEwSu6jfUn5EmrYgD3b6yuh9IeBHCoA+DqT3OfEDgtQg==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr19771099pll.321.1569956157539;
        Tue, 01 Oct 2019 11:55:57 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j10sm16834203pfn.128.2019.10.01.11.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Oct 2019 11:55:57 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3] dir: special case check for the possibility that pathspec is NULL
Date:   Tue,  1 Oct 2019 11:55:24 -0700
Message-Id: <20191001185524.18772-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.25.g3f4444bfd7.dirty
In-Reply-To: <20191001184049.GA30113@generichostname>
References: <20191001184049.GA30113@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commits 404ebceda01c ("dir: also check directories for matching
pathspecs", 2019-09-17) and 89a1f4aaf765 ("dir: if our pathspec might
match files under a dir, recurse into it", 2019-09-17) added calls to
match_pathspec() and do_match_pathspec() passing along their pathspec
parameter.  Both match_pathspec() and do_match_pathspec() assume the
pathspec argument they are given is non-NULL.  It turns out that
unpack-tree.c's verify_clean_subdirectory() calls read_directory() with
pathspec == NULL, and it is possible on case insensitive filesystems for
that NULL to make it to these new calls to match_pathspec() and
do_match_pathspec().  Add appropriate checks on the NULLness of pathspec
to avoid a segfault.

In case the negation throws anyone off (one of the calls was to
do_match_pathspec() while the other was to !match_pathspec(), yet no
negation of the NULLness of pathspec is used), there are two ways to
understand the differences:
  * The code already handled the pathspec == NULL cases before this
    series, and this series only tried to change behavior when there was
    a pathspec, thus we only want to go into the if-block if pathspec is
    non-NULL.
  * One of the calls is for whether to recurse into a subdirectory, the
    other is for after we've recursed into it for whether we want to
    remove the subdirectory itself (i.e. the subdirectory didn't match
    but something under it could have).  That difference in situation
    leads to the slight differences in logic used (well, that and the
    slightly unusual fact that we don't want empty pathspecs to remove
    untracked directories by default).

Denton found and analyzed one issue and provided the patch for the
match_pathspec() call, SZEDER figured out why the issue only reproduced
for some folks and not others and provided the testcase, and I looked
through the remainder of the series and noted the do_match_pathspec()
call that should have the same check.

Co-authored-by: Denton Liu <liu.denton@gmail.com>
Co-authored-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Note: Applies on top of en/clean-nested-with-ignored, in next.

As with v1, the authorship is really mixed, so I don't know if I
should use Co-authored-by (highlighted as a possibility by Denton), or
the far more common Helped-by (as suggested by Junio but based on a
more limited summary of the different contributions), or if perhaps
Denton or SZEDER should be marked as the author and I be marked as
Helped-by or Co-authored-by.  Since Denton commented on round 1, I
used his suggestion for attribution in this round, but I'm open to
changing it to whatever works best.

Changes since v2:
  - This time actually removed the entire unnecessary comment

Range-diff:
1:  c495b9303c ! 1:  40392c6bba dir: special case check for the possibility that pathspec is NULL
    @@ t/t0050-filesystem.sh: $test_unicode 'merge (silent unicode normalization)' '
     +		git reset --hard &&
     +		mkdir -p gitweb/subdir &&
     +		>gitweb/subdir/file &&
    -+		# it is not strictly necessary to add and commit the
     +		git add gitweb &&
     +		git commit -m "add gitweb/subdir/file" &&
     +

 dir.c                 |  8 +++++---
 t/t0050-filesystem.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 7ff79170fc..bd39b86be4 100644
--- a/dir.c
+++ b/dir.c
@@ -1962,8 +1962,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			((state == path_untracked) &&
 			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
 			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
-			  do_match_pathspec(istate, pathspec, path.buf, path.len,
-					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
+			  (pathspec &&
+			   do_match_pathspec(istate, pathspec, path.buf, path.len,
+					     baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
@@ -1975,7 +1976,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
 
-			if (!match_pathspec(istate, pathspec, path.buf, path.len,
+			if (pathspec &&
+			    !match_pathspec(istate, pathspec, path.buf, path.len,
 					    0 /* prefix */, NULL,
 					    0 /* do NOT special case dirs */))
 				state = path_none;
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 192c94eccd..a840919967 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -131,4 +131,25 @@ $test_unicode 'merge (silent unicode normalization)' '
 	git merge topic
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
+	git init repo &&
+	(
+		cd repo &&
+
+		>Gitweb &&
+		git add Gitweb &&
+		git commit -m "add Gitweb" &&
+
+		git checkout --orphan todo &&
+		git reset --hard &&
+		mkdir -p gitweb/subdir &&
+		>gitweb/subdir/file &&
+		git add gitweb &&
+		git commit -m "add gitweb/subdir/file" &&
+
+		git checkout master
+	)
+'
+
 test_done
-- 
2.23.0.25.g3f4444bfd7.dirty

