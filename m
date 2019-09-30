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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB721F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfI3VBx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:01:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46207 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3VBx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:01:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id z14so7771478vsz.13
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRb7C7xdmLvESoPj8pJJVsPrCIi1rTAYEWP2h8pp1Fo=;
        b=eVhTkRU9JPDcAsKp9jzo9ZyY3tHNo5Vk8IYpO8A3jIemJCIxJKX8F0YTADlk91x0bs
         gT6HPHP4W2hxbc0FhrFeuWKPSL4k9fWE75qvBAjTneFWZzi6mN55R3cdJCSszwy8n+rN
         TSuL+/j4FeTgiFt9vksizwckNV1A7uDNxJpbcESnuF7IrAm3rShbB7qHXZbT+9TNlQkd
         304Wq3fLyX16y8UwqlmuLouaElD0BV3BFQis0g6tNAsk9Bgy3NqD8FNOZEZBUkt9wnxV
         WiPLhra0CW3PczB/YzJfgzT1bGhTnuNjuLi9VwcPs6mCpzFi2EU061RcSG9eUvlfQd/Y
         E71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRb7C7xdmLvESoPj8pJJVsPrCIi1rTAYEWP2h8pp1Fo=;
        b=Q1kQNeOSqrp/tB2Uq9oUGxYXDZyDJk73O3kI8r2cfTQrwB+Bv8ySI6IN24pUS4JDy5
         s/R3dW+eH1fb00OKtqSHpXjMro/0MxUCpgj3D1neKxwgqT8bAcqhYJ+glmcLQ73GNCzz
         ZppuJ7L1Su4PmlGK46x+Tjz8UUkJimQb7srZpQYFauSjHASo6rXCxkSq5TjbxPG/tEQk
         wT3TJ6SWJuL+20C4t7FavIxNNX6novcwNIBu6eGiLFhxVNgmHauqz1aI3wWaU/Pg5mnD
         LkMubY5tECBrRGHsi8253p0Ceh4drDDkFstrUfzn9CZHL0xs0y6JPlmabBRFIrYm/H8b
         Bbqw==
X-Gm-Message-State: APjAAAVjzpZQYHmr3NxZnDMvUQPOlH5iWh74XCH87NtKMIO4Tfi7q69v
        bll8bMHptcunnQr279vQERT5qbFcLMU=
X-Google-Smtp-Source: APXvYqwr1z6cUuFgUHPB89aC57P5Ostl7K/OWLjhEpXZDcXf9EoHb8Y2dkJPB2Hi9J4ZIYdqFy0qQA==
X-Received: by 2002:a17:902:5a89:: with SMTP id r9mr20916555pli.206.1569870671471;
        Mon, 30 Sep 2019 12:11:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id k15sm11796875pfa.65.2019.09.30.12.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 12:11:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] dir: special case check for the possibility that pathspec is NULL
Date:   Mon, 30 Sep 2019 12:11:06 -0700
Message-Id: <20190930191106.16128-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.14.g885c22d24b
In-Reply-To: <20190927171034.GA6542@generichostname>
References: <20190927171034.GA6542@generichostname>
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

Helped-by: Denton Liu <liu.denton@gmail.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
This patch applies on top of en/clean-nested-with-ignored, which is now
in next.

Denton found and analyzed one issue and provided the patch for the
match_pathspec() call, SZEDER figured out why the issue only reproduced
for some folks and not others and provided the testcase, and I looked
through the remainder of the series and noted the do_match_pathspec()
call that should have the same check.

So, I'm not sure who should be author and who should be helped-by; I
feel like their contributions are possibly bigger than mine.  While I
tried to reproduce and debug, they ended up doing the work, and I just
looked through the rest of the series for similar issues and wrote up
a commit message.  *shrug*

 dir.c                 |  8 +++++---
 t/t0050-filesystem.sh | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

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
index 192c94eccd..edb30f9eb2 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -131,4 +131,27 @@ $test_unicode 'merge (silent unicode normalization)' '
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
+		# the subdir is crucial, without it there is no segfault
+		mkdir -p gitweb/subdir &&
+		>gitweb/subdir/file &&
+		# it is not strictly necessary to add and commit the
+		# gitweb directory, its presence is sufficient
+		git add gitweb &&
+		git commit -m "add gitweb/subdir/file" &&
+
+		git checkout master
+	)
+'
+
 test_done
-- 
2.22.1.14.g885c22d24b

