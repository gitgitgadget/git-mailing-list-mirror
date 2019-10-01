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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2302D1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfJASaM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:30:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43296 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJASaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:30:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id v27so10238877pgk.10
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iz5w1hcY6KmUS9gRJEM/CsHU+54g5wSHLJQP1TfWYEc=;
        b=PyRrgxcZwNYcknYypO4FXG6nsR3akplNF72v8PcoE58Ygdc7K67AfhopIU/yjWhXDT
         g5eaT4zsEvEGFbYmwQ9cNkA29v2LR+BGYFnJcNQ1jstNv7bUdUInhnIybr/1WgQ08+i0
         5jFa7Ol2Q33O1Cr3vT6xVoaBFwlyuhAql3gRPC3TMzWFXgOHec+VY9q+9bCikIuM+iRv
         fB1WAirzC+sS7hPqwlMxDbwQf+2+ILx9uswfMSSjuanA304bWv4GAvGoWppo2lLqWYdo
         kaAwFX4rJuFRmYVBlrAKMOiMc7eca0yOVudDnT/qW78HqnEUf3noeyWooyd1ynDDEz0r
         6UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iz5w1hcY6KmUS9gRJEM/CsHU+54g5wSHLJQP1TfWYEc=;
        b=gxSCk27cMqcZmXZ+ja8dS8GBF9uVAth4PdgklH8RDfW1rndnJms+JlkKZoFkz8KHN5
         JMRCZqz3BRNoPtZ6sV2S6MbECE607nSOVhFhtFXevqSE25T+kp3sq2jZAbbJGIaJ2/dx
         kuECpNjCOzvs/HYOUERuqqpwQCx0Z5o+E3Ix31hE9KTi8bMphRM6xA+jNYCaaXcTksa2
         1jo+AzjpULJ36W3IydReFpqnWEsFV+2SkAfddZUOmmQ5iLIXtAJbrK5O6kQV6R+UH7HV
         hxeYR0dXQjAM1Sul498NgL5AKd0IKVh5QS1Bo7e1/XW+/BfHBiwjJtw1q53PTp0FfVhN
         m9pw==
X-Gm-Message-State: APjAAAUEjOEawP/p16ncPQqazVSHFE8VzVcdGagzBpDSs/vvJ0G2q9G6
        q5gL7ZNsMJW3Tk1QtFgdoylaQjzQSTM=
X-Google-Smtp-Source: APXvYqzerKJnoUXsxOIfUnBvVigl5uFNewfn/GMFWfXHvyI151Prv2o5iw0Lcr/grjbHj1x4VvWO4w==
X-Received: by 2002:a17:90a:e50b:: with SMTP id t11mr7068385pjy.50.1569954610433;
        Tue, 01 Oct 2019 11:30:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c8sm16229304pgw.37.2019.10.01.11.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Oct 2019 11:30:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] dir: special case check for the possibility that pathspec is NULL
Date:   Tue,  1 Oct 2019 11:30:05 -0700
Message-Id: <20191001183005.16977-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.25.g3f4444bfd7.dirty
In-Reply-To: <20190930191106.16128-1-newren@gmail.com>
References: <20190930191106.16128-1-newren@gmail.com>
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

Changes since v1:
  - Removed comments that made sense in context of the original thread
    but wouldn't be helpful to future readers.
  - s/Helped-by/Co-authored-by/

Range-diff:
1:  885c22d24b ! 1:  c495b9303c dir: special case check for the possibility that pathspec is NULL
    @@ t/t0050-filesystem.sh: $test_unicode 'merge (silent unicode normalization)' '
     +
     +		git checkout --orphan todo &&
     +		git reset --hard &&
    -+		# the subdir is crucial, without it there is no segfault
     +		mkdir -p gitweb/subdir &&
     +		>gitweb/subdir/file &&
     +		# it is not strictly necessary to add and commit the
    -+		# gitweb directory, its presence is sufficient
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
+		# it is not strictly necessary to add and commit the
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

