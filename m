Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF74E936EB
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 21:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbjJDVqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbjJDVq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 17:46:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A9CC0
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 14:46:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c186ea81c7so3725221fa.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696455980; x=1697060780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yidQtS8ycgDxQKMwK+ni6mVEs8WMhrDgA9a//bEZ7EM=;
        b=UZf5AfU6JW2KWi2tLP8aOHgNxiKAUCpcZDMgHjlMkPWVu8R6c0a2SU3lWgVCP5JMlU
         0lIXBNSxL9hZdHQ7YvF+kroyFeQb/ucUjq4F+H4sph3wVpjYvrptfUztLL6A9012uSlU
         WRQyT5wQfjhGlL/XvY0xtAcUy0OspYJK+mCv++8dosVCtdPUWFcKHtwjkUgZ3BI1+nPv
         pYyhmBRwXY7y5LLynuZKA8X7POfFFivXlXoW3RGrNhnD7JWVuIyt5LbVEF1FE3WDOwFf
         nazQcHxLuyfzHvEKtYPbf8Qf7g9rAtSo3v1162ZqWu1SlvOb6DWwOyiWDiWzhCPgFD62
         4QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696455980; x=1697060780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yidQtS8ycgDxQKMwK+ni6mVEs8WMhrDgA9a//bEZ7EM=;
        b=f/So+ig4uu65LtbbWWjpzqtIcGFtE+cnK5j75sxCJHPr65A+PxJeGJZST8ndRi+Lev
         zn64fZdyOaW7OcIFZh96ESg+zctdwNCUcrG/GTxPJcHz4TQBr/tpPyco3TJpMVgO9D6V
         DA7xqAIRYbYW9fiEpuFu84ihzEhlrUUVDV2zcYaHmfgjZp0MPCN9vxQ2RGcNtHrLLJXe
         xYjJEqhMFBFsUGGX7K01XTPvhbPKt4l2guxaLUtD3r7s5SNQ9dnOiwkNFUGmdgFBuRky
         QK4XSrq8/OQgc4EoScJCWxFYyO5J84bO+aV07503A1i9EAnXaHAElMl26v975heW8DUk
         EchA==
X-Gm-Message-State: AOJu0YzpiDroogm8JEEmvEretK9/sS0ywmNL2nqDlgbaMF7/om7ksnbi
        Zw5E8WUqyBw7hJzc8HWA7L1oD47zgk8=
X-Google-Smtp-Source: AGHT+IGB6KevYIwKYOgZ8d+tsdde+kaGpPqYDh2IDmk1CwcRk+n+/vo/NEIdc512a94i/R/0nKw9XQ==
X-Received: by 2002:a2e:3c10:0:b0:2b6:9da9:2884 with SMTP id j16-20020a2e3c10000000b002b69da92884mr3030417lja.40.1696455979641;
        Wed, 04 Oct 2023 14:46:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r25-20020a2e9959000000b002bfba0d26bcsm7818ljj.8.2023.10.04.14.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:46:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 0/3] diff-merges: introduce '--dd' option
Date:   Thu,  5 Oct 2023 00:45:55 +0300
Message-Id: <20231004214558.210339-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230909125446.142715-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new convenience option requests full diff with respect to first
parent, so that

  git log --dd

will output diff with respect to first parent for every commit,
universally, no matter how many parents the commit turns out to have.

'--dd' is implemented as pure synonym for "--diff-merges=first-parent
--patch".

The first commit in the series tweaks diff-merges documentation a bit,
and is valuable by itself. It's put here as '--dd' implementation
commit depends on it in its documentation part.

Note: the need for this new convenience option mostly emerged from
denial by the community of patches that modify '-m' behavior to imply
'-p' as the rest of similar options (such as --cc) do. So, basically,
'--dd' is what '-m' should have been to be more useful.

Updates in v3:

  * Option renamed from '-d' to '--dd' due to Junio overpowering
    request to keep short-and-sweet '-d' reserved for another (yet
    unspecified) use.

  * Added completion of '--dd' to git-completion.bash.

Updates in v2:

  * Reordered documentation for diff-merges formats in accordance with
    Junio recommendation.

  * Removed clarification of surprising -m behavior due to controversy
    with Junio on how exactly it should look like.

Sergey Organov (3):
  diff-merges: improve --diff-merges documentation
  diff-merges: introduce '--dd' option
  completion: complete '--dd'

 Documentation/diff-options.txt         | 103 ++++++++++++++-----------
 Documentation/git-log.txt              |   4 +-
 contrib/completion/git-completion.bash |   2 +-
 diff-merges.c                          |   3 +
 t/t4013-diff-various.sh                |   8 ++
 5 files changed, 72 insertions(+), 48 deletions(-)

Interdiff against v2:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 19bb78ff6652..f80d493dd4c8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -48,10 +48,6 @@ ifdef::git-log[]
 	similar to '--diff-merges=on' (which see) except `-m` will
 	produce no output unless `-p` is given as well.
 
--d::
-	Produce diff with respect to first parent.
-	Shortcut for '--diff-merges=first-parent -p'.
-
 -c::
 	Produce combined diff output for merge commits.
 	Shortcut for '--diff-merges=combined -p'.
@@ -60,6 +56,11 @@ ifdef::git-log[]
 	Produce dense combined diff output for merge commits.
 	Shortcut for '--diff-merges=dense-combined -p'.
 
+--dd::
+	Produce diff with respect to first parent for both merge and
+	regular commits.
+	Shortcut for '--diff-merges=first-parent -p'.
+
 --remerge-diff::
 	Produce diff against re-merge.
 	Shortcut for '--diff-merges=remerge -p'.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 59bd74a1a596..579682172fe4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,7 +120,7 @@ By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
 Note that unless one of `--diff-merges` variants (including short
-`-d`, `-m`, `-c`, and `--cc` options) is explicitly given, merge commits
+`-m`, `-c`, `--cc`, and `--dd` options) is explicitly given, merge commits
 will not show a diff, even if a diff format like `--patch` is
 selected, nor will they match search options like `-S`. The exception
 is when `--first-parent` is in use, in which case `first-parent` is
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 133ec92bfae7..ca4fa39f3ff8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2042,7 +2042,7 @@ __git_log_shortlog_options="
 "
 # Options accepted by log and show
 __git_log_show_options="
-	--diff-merges --diff-merges= --no-diff-merges --remerge-diff
+	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
 "
 
 __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
diff --git a/diff-merges.c b/diff-merges.c
index 6eb72e6fc28a..45507588a279 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -125,15 +125,15 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
 		revs->merges_need_diff = 0;
-	} else if (!strcmp(arg, "-d")) {
-		set_first_parent(revs);
-		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
 		revs->merges_imply_patch = 1;
+	} else if (!strcmp(arg, "--dd")) {
+		set_first_parent(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--remerge-diff")) {
 		set_remerge_diff(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index a07d6eb6dd97..4b474808311e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -473,10 +473,10 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
-test_expect_success 'log -d matches --diff-merges=1 -p' '
+test_expect_success 'log --dd matches --diff-merges=1 -p' '
 	git log --diff-merges=1 -p master >result &&
 	process_diffs result >expected &&
-	git log -d master >result &&
+	git log --dd master >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
-- 
2.25.1

