Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0AC43332
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD63E64F04
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCRLQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhCRLQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 07:16:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B3C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:16:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so5078263wra.2
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=1srwXkQOh84vmR42J4PbPNerwUSUSUHml8jilz8IJSE=;
        b=JNAcWztZrvjGPcTUtFkzqJ4zlI8DLP3Ny7dP0p4WtW07xBin3sCq/MbVP2EBnv8y7N
         PNhFW8vVWlQht4dHr6+IoByHO0Kb4bKiyVJmn5XAENMK+oiQpP8CDQgzbKznjGIv2Zvx
         5/5c4s/eHlEHXpJaTKCTP1uEKCaseGKY8WETjabloRUxKYDq1ivpOg+ElHlzUuNBQ5wh
         AnmFy+clf8mpqoi9lCgdVwG9Jk7syrh/9I2olHS5JYWY3E4aVDJW0fTWARdPkaJfB+To
         xp11Yt1vAPxbgtdV9ij/5Hm3BFPW228AAzFbkdXuo8/LeSE/g5ffqWMVOYp8FWKK56O1
         uR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=1srwXkQOh84vmR42J4PbPNerwUSUSUHml8jilz8IJSE=;
        b=khz5dcxbXxcvdZXgXw/P3lWGq2pmrk1H5HOZ9QcVbdN5BmJD+dNkwBzOLac6w1fqsQ
         0v/o7pJW7nA3BWBcoaMdM7h657O+K1SRFFTj+Ez13V2tVN39ktGS7XFnnBVQvtz0t+92
         DLCpMQNxb0fTcwSUsUvSxfTISTvvC4Ll4Arhx/16+7cZElEsZ0fnbSy5DLk7AVdIP2C+
         AbcYsCeEuhmVfLWiuCBag9fU4I/6dUxUXXiaVg8UlnShC8cgACqDaQIQ0Otb6L5D8VVF
         90zeKScTagPth9QCZyjUTxocX3AF/7CFzSheDSsdTuZEF/2LgTAaAVGKed3irhBIxgL1
         DdXg==
X-Gm-Message-State: AOAM532lcLtCgS5guiVbrTjGlbC7x/awR0U2GlDr/G6z3sTFLdqUjwwL
        OXndBvq9LIsnxiDlb9J7s7D3D73IuU0=
X-Google-Smtp-Source: ABdhPJwXmYqByMNSzSez8dnaxvmgCpUX6xpIspwnNShbAX3Rq9iU1sOE2B1TkeZ87lPy6KnUE0R8mw==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr9235700wrt.31.1616066160072;
        Thu, 18 Mar 2021 04:16:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm2519987wrv.47.2021.03.18.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:15:59 -0700 (PDT)
Message-Id: <2dfcc20f0e9faa1aa08aa524127ffef44bd98182.1616066157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
        <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 11:15:56 +0000
Subject: [PATCH v10 3/3] commit: add own-identity option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Use the newly added option `--own-identity` in `interpret-trailers`,
implement new commit option `--own-identity` to allow those trailers
with no value add the user’s own identity. Using the `--own-identity`
option, users can directly use `--trailer="Signed-off-by"` to generate
a signoff trailer with their own identities in commit messages,

The effect is basically the same as the `--signoff` option. However, users
can add more useful options at the same time. e.g. `--trailer="Helped-by"
--own-identity` can general `Helped-by: C O Mitter <committer@example.com>`;
Or through appropriate configuration:
`git -c trailer.signoff.key="Signed-off-by" commit --trailer="signoff" \
--own-identity` can also general their needs trailers with their
favorite keys and their own identities.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-commit.txt          | 15 +++++
 builtin/commit.c                      |  8 +++
 t/t7501-commit-basic-functionality.sh | 91 +++++++++++++++++++++++++++
 t/t7502-commit-porcelain.sh           | 20 ++++++
 4 files changed, 134 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c5de981cd40d..393c424e8184 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -174,6 +174,21 @@ include::signoff-option.txt[]
 	and the "Helped-by" trailer in the commit message.)
 	Use `git -c trailer.* commit --trailer` to make the appropriate
 	configuration. See linkgit:git-interpret-trailers[1] for details.
+
+--own-identity::
+	Used with `--trailer`. Those trailers without value with the
+	`--own-identity` option all will add the user's own identity.
+	For example, `git commit --trailer \
+	"A:B" --trailer	"Signed-off-by" --trailer "Helped-by" --own-identity`,
+	will output:
+	"
+	A:B
+	Signed-off-by: C O Mitter <committer@example.com>
+	Helped-by: C O Mitter <committer@example.com>
+	"
+	in commit messages.
+	See linkgit:git-interpret-trailers[1]for details.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 7a79aae48f43..0310c187ec07 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -114,6 +114,7 @@ static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit, *pathspec_from_file;
 static struct strvec trailer_args = STRVEC_INIT;
+static int own_identity;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -972,6 +973,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		strvec_pushl(&run_trailer.args, "interpret-trailers",
 			     "--in-place", git_path_commit_editmsg(), NULL);
+		if (own_identity)
+			strvec_push(&run_trailer.args, "--own-identity");
 		strvec_pushv(&run_trailer.args, trailer_args.v);
 		run_trailer.git_cmd = 1;
 		if (run_command(&run_trailer)) {
@@ -1530,6 +1533,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
+		OPT_BOOL(0, "own-identity", &own_identity,
+			     N_("specify the user's own identity for omitted trailers value")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
@@ -1606,6 +1611,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
+	if (own_identity && !trailer_args.nr)
+		die(_("--own_identity requires --trailer"));
+
 	if (dry_run)
 		return dry_run_commit(argv, prefix, current_head, &s);
 	index_file = prepare_index(argv, prefix, current_head, 0);
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 512ae2781fe2..7ff74cf81e75 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -423,6 +423,25 @@ test_expect_success 'sign off (1)' '
 
 '
 
+test_expect_success '--trailer="signoff" (1)' '
+
+	echo 1 >>positive &&
+	git add positive &&
+	git -c trailer.signoff.key="Signed-off-by" \
+		commit --trailer="signoff" --own-identity \
+		-m "thank you" &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
+	(
+		echo thank you &&
+		echo &&
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
+	) >expected &&
+	test_cmp expected actual
+
+'
+
 test_expect_success 'sign off (2)' '
 
 	echo 2 >positive &&
@@ -444,6 +463,30 @@ $existing" &&
 
 '
 
+test_expect_success '--trailer="signoff" (2)' '
+
+	echo 2 >>positive &&
+	git add positive &&
+	existing="Signed-off-by: Watch This <watchthis@example.com>" &&
+	git -c trailer.signoff.key="Signed-off-by" \
+		commit --trailer="signoff" --own-identity \
+		-m "thank you
+
+$existing" &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
+	(
+		echo thank you &&
+		echo &&
+		echo $existing &&
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
+	) >expected &&
+	test_cmp expected actual
+
+'
+
+
 test_expect_success 'signoff gap' '
 
 	echo 3 >positive &&
@@ -464,6 +507,29 @@ $alt" &&
 	test_cmp expected actual
 '
 
+test_expect_success '--trailer="signoff" gap' '
+
+	echo 3 >>positive &&
+	git add positive &&
+	alt="Alt-RFC-822-Header: Value" &&
+	git -c trailer.signoff.key="Signed-off-by" \
+		commit --trailer="signoff" --own-identity \
+		-m "welcome
+
+$alt" &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
+	(
+		echo welcome &&
+		echo &&
+		echo $alt &&
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
+	) >expected &&
+	test_cmp expected actual
+'
+
+
 test_expect_success 'signoff gap 2' '
 
 	echo 4 >positive &&
@@ -487,6 +553,31 @@ $alt" &&
 	test_cmp expected actual
 '
 
+test_expect_success '--trailer="signoff" gap 2' '
+
+	echo 4 >>positive &&
+	git add positive &&
+	alt="fixed: 34" &&
+	git -c trailer.signoff.key="Signed-off-by" \
+		commit --trailer="signoff" --own-identity \
+		-m "welcome
+
+We have now
+$alt" &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
+	(
+		echo welcome &&
+		echo &&
+		echo We have now &&
+		echo $alt &&
+		echo &&
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
+	) >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'signoff respects trailer config' '
 
 	echo 5 >positive &&
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 6df71fa00bcb..1628a1c1e7d6 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -490,6 +490,26 @@ test_expect_success 'commit --trailer with -c and ":=#" as separators' '
 	test_cmp expected actual
 '
 
+test_expect_success 'commit --trailer with -c and --own-identity' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	git -c trailer.signoff.key="Signed-off-by: " \
+		commit --trailer "signoff" --own-identity -m "abc" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --own-identity without --trailer' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	test_must_fail git -c commit --own-identity -m "abc"
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
gitgitgadget
