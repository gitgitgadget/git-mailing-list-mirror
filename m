Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ABAC7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 23:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjFLXFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFLXFS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 19:05:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173EE4
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 16:05:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc4c832c501so3456526276.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686611116; x=1689203116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VpNv6BO0bMems+x9vlwX9KeplCC7eGxg/VriPxmCbA=;
        b=KkuYmARZaEM5ByQOGsT+QwHZ7to0/+DL3DyHfmLt4zH4Ju9mrQf8As9qIWMmkIgtBn
         hI+/5RstR62ezR7i/u5fSHilnU14xCOZLs7W8yxtMKwZqoOYNazpy2CHUDPzfBEw1Fz+
         3+JNodAqjugfsOTK/sTw4INp/lcgpfL9wAsh9CmtlN4zRksFQFEABo3qxtvPjBHSE6LR
         003jeZxXnALr1NjdzumtjGFCLoOs93dEQZNw8TLXo28XAyiBjxRsf2GtEtyo3oPntR7W
         o/ji1R2wI6Qcpy/vWhi36skHEl8cMhFcRrVQ6QRTWJuYOsFoW9ioxo2Dx7ZsJcLAdgBc
         iy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686611116; x=1689203116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VpNv6BO0bMems+x9vlwX9KeplCC7eGxg/VriPxmCbA=;
        b=OpXlc2v8+0mcbLtWiZjcbcW0nyInruF/wAXlL6sa7zjJf8w16vrRmW4WbK19pH+kU2
         m5DkeFRLQShDHAts4n+wphtDiIV/tL2kqZ9KMDYy5TXQHP4DL85Rq/YR8wGijjnBRJzo
         zANNOE1Ynk9XqHpT1eXxakgSmMqMuy3oiLl+0gNmnZzbb53ALRx4rm20iSrgwjdrYM9a
         mNm8auaIwPj/X0NOw/cQeBVrackJnStumL9qfq7PN90kuv4+neCfejOx1+VGPGmMnVRE
         bSDHuYcZZvlVfRt0zrMml0EcV49uLRhkk+q2KdhQ4Lj4wHisJVBnlVy3WaJOpTiD6RUK
         VZyA==
X-Gm-Message-State: AC+VfDyOLXfYlEIh3MMZqi9z7F+LJm+cDx9L8b8E1rGp6Pt0MdFeGZFS
        lUxxPlndwzRiMMzqqc90MhEPTr4bwzEZn+SUNn/cYeR9IdoTUHa8mKV6JIAT3lfR6V9jdTach0F
        9KEKIKcXliDio9E4uqF1UB3NhYN22tRm4r5MTvFiJ8apUYhKTcjPKH0j8FYqTlHw=
X-Google-Smtp-Source: ACHHUZ5r6lH99o7cYaCVJ4/TUnPrkgq7RsgufB+G7y4qYRvTPVU0AHvNqYTynQnBt10SYbHwXT7rZNmdKDTzeQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1184:b0:bcf:c51:181c with SMTP
 id m4-20020a056902118400b00bcf0c51181cmr23718ybu.6.1686611115640; Mon, 12 Jun
 2023 16:05:15 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:04:48 -0700
In-Reply-To: <kl6lr0qgfmzo.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lr0qgfmzo.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230612230453.70864-1-chooglen@google.com>
Subject: [PATCH] setup: copy repository_format using helper
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several parts of the setup machinery, we set up a repository_format
and then use it to set up the_repository in nearly the exact same way,
suggesting that we might be able to use a helper function to standardize
the behavior and make future modifications easier. Create this helper
function, setup_repository_from_format(), thus standardizing this
behavior.

To determine what the 'standardized behavior' should be, we can compare
the candidate call sites in repo_init(), setup_git_directory_gently(),
check_repository_format() and discover_git_directory(),

- All of them copy .worktree_config.

- All of them 'copy' .partial_clone. Most perform a shallow copy of the
  pointer, then set the .partial_clone = NULL so that it doesn't get
  cleared by clear_repository_format(). However,
  check_repository_format() copies the string deeply because the
  repository_format is sometimes read back (it is an "out" parameter).
  To accomodate both shallow copying and deep copying, toggle this
  behavior using the "modify_fmt_ok" parameter.

- Most of them set up repository.hash_algo, except
  discover_git_directory(). Our helper function unconditionally sets up
  .hash_algo because it turns out that discover_git_directory() probably
  doesn't need to set up "struct repository" at all!
  discover_git_directory() isn't actually used in the setup process - its
  only caller in the Git binary is read_early_config(). As explained by
  16ac8b8db6 (setup: introduce the discover_git_directory() function,
  2017-03-13), it is supposed to be an entrypoint into setup.c machinery
  that allows the Git directory to be discovered without side effects,
  in other words, we shouldn't have introduced side effects in
  ebaf3bcf1ae (repository: move global r_f_p_c to repo struct,
  2021-06-17). Fortunately, we didn't start to rely on this unintended
  behavior between then and now, so we can just drop it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
Here's the helper function I had in mind. I was initially mistaken and
it turns out that we need to support deep copying, but fortunately,
t0001 is extremely thorough and will catch virtually any mistake in the
setup process. CI seems to pass, though it appears to be a little flaky
today and sometimes cancels jobs
(https://github.com/chooglen/git/actions/runs/5249029150).

If you're comfortable with it, I would prefer for you to squash this
into your patches so that we don't just end up changing the same few
lines. If not, I'll Reviewed-by your patches (if I don't find any other
concerns on a re-read) and send this as a 1-patch on top.

 repository.c |  7 +------
 setup.c      | 31 +++++++++++++++++++------------
 setup.h      | 10 ++++++++++
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/repository.c b/repository.c
index 104960f8f5..50f0b26a6c 100644
--- a/repository.c
+++ b/repository.c
@@ -181,12 +181,7 @@ int repo_init(struct repository *repo,
 	if (read_and_verify_repository_format(&format, repo->commondir))
 		goto error;
 
-	repo_set_hash_algo(repo, format.hash_algo);
-	repo->repository_format_worktree_config = format.worktree_config;
-
-	/* take ownership of format.partial_clone */
-	repo->repository_format_partial_clone = format.partial_clone;
-	format.partial_clone = NULL;
+	setup_repository_from_format(repo, &format, 1);
 
 	if (worktree)
 		repo_set_worktree(repo, worktree);
diff --git a/setup.c b/setup.c
index d866395435..33ce58676f 100644
--- a/setup.c
+++ b/setup.c
@@ -1561,13 +1561,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			setup_git_env(gitdir);
 		}
 		if (startup_info->have_repository) {
-			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
-			the_repository->repository_format_worktree_config =
-				repo_fmt.worktree_config;
-			/* take ownership of repo_fmt.partial_clone */
-			the_repository->repository_format_partial_clone =
-				repo_fmt.partial_clone;
-			repo_fmt.partial_clone = NULL;
+			setup_repository_from_format(the_repository,
+						     &repo_fmt, 1);
 		}
 	}
 	/*
@@ -1654,14 +1649,26 @@ void check_repository_format(struct repository_format *fmt)
 		fmt = &repo_fmt;
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
-	repo_set_hash_algo(the_repository, fmt->hash_algo);
-	the_repository->repository_format_worktree_config =
-		fmt->worktree_config;
-	the_repository->repository_format_partial_clone =
-		xstrdup_or_null(fmt->partial_clone);
+	setup_repository_from_format(the_repository, fmt, 0);
 	clear_repository_format(&repo_fmt);
 }
 
+void setup_repository_from_format(struct repository *repo,
+				  struct repository_format *fmt,
+				  int modify_fmt_ok)
+{
+	repo_set_hash_algo(repo, fmt->hash_algo);
+	repo->repository_format_worktree_config = fmt->worktree_config;
+	if (modify_fmt_ok) {
+		repo->repository_format_partial_clone =
+			fmt->partial_clone;
+		fmt->partial_clone = NULL;
+	} else {
+		repo->repository_format_partial_clone =
+			xstrdup_or_null(fmt->partial_clone);
+	}
+}
+
 /*
  * Returns the "prefix", a path to the current working directory
  * relative to the work tree root, or NULL, if the current working
diff --git a/setup.h b/setup.h
index 4c1ca9d0c9..ed39aa38e0 100644
--- a/setup.h
+++ b/setup.h
@@ -140,6 +140,16 @@ int verify_repository_format(const struct repository_format *format,
  */
 void check_repository_format(struct repository_format *fmt);
 
+/*
+ * Setup a "struct repository" from the fields from the repository format.
+ * If "modify_fmt_ok" is nonzero, pointer members in "fmt" will be shallowly
+ * copied to repo and set to NULL (so that it's safe to clear "fmt").
+ */
+struct repository;
+void setup_repository_from_format(struct repository *repo,
+				  struct repository_format *fmt,
+				  int modify_fmt_ok);
+
 /*
  * NOTE NOTE NOTE!!
  *
-- 
2.41.0.162.gfafddb0af9-goog

