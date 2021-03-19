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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D19C433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A2B64F6B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCSMHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCSMGn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 08:06:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542DC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:06:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t9so8846854wrn.11
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1dKb22szXjbLMQBLOaANBoXVCoH56kq1IWezYQwlCQU=;
        b=KOg/SqWabgy+oQ2UL82QkCUW19LWdLMjjsKttGHKnxzdRYssz8E8wi5CH562G1YzeZ
         LXRLT8Becl3NB9gO3OQZ3MdDF3XoIK54wjtg4i1VN9EGalnVJfxfGp88WEaWKx9tFi1/
         Wn1pTrVlVO98zVeNDYR+IQG2B4sCxT5UDrjroLpTKiaWZEbEZev8XJtVpDcYq8ZcnzOJ
         volSx9Zx5yAE65T9vfME4B/59JdZQgxRPJHotjrqaLpe7Di9Tml4nyZQ6y8EFqwoqFWe
         jQZJD/YcOWsvtDyWloSYB5jtSAD4otS1akCHMob8DeY76C+cMgRaFZN3fOtf2Zgbh0Z8
         Shuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1dKb22szXjbLMQBLOaANBoXVCoH56kq1IWezYQwlCQU=;
        b=QCSz8vnaSmHsFVIfxRMWBs5/oBU7zo+OkL7kSgeNtpusufO4WnQLWFBRI2tOxs2G/7
         3P7VALgWHAoursjRQ39l8JvJIHgWoiuacT77FXNtrw9K8ffdCMWob+9Z/I4xLUpx35md
         Jfx76c+LkJCV9X5zWDZtrNfT6CSFerg47NocxS/P34oQ/X1PQU1muPrTCxnGi2lJjWab
         Sm92rkcsG0yEbWOcx/TvN/BMyt/kbO5jrEANw/ASenHIGIHUQysJRRXq1Sv2GpKbxi8J
         Q2bO9o2OgkLAKajIIC+c2OFPAPUn0V0Er3tp5etSRpBkqfEKUIooRDSkbGPyRGBoBbi6
         FLCw==
X-Gm-Message-State: AOAM530Sk7Qvos2Yl/VTh5EWGV00Sf5pyKTx53NumDkTWyMdrMV60rAW
        qKmYb/yCh8cntfnD0HN03Usm8HPG/0A=
X-Google-Smtp-Source: ABdhPJxG93nZE64Z7ykDS9MfVIwNya0HxlHvxX3rvaYYhL9VBdpNdqJP0xLXzNNIPipJHYP1jg2F4g==
X-Received: by 2002:a5d:5744:: with SMTP id q4mr4343935wrw.390.1616155602146;
        Fri, 19 Mar 2021 05:06:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm5746479wmo.10.2021.03.19.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:06:41 -0700 (PDT)
Message-Id: <a89f6d0717eed9ffadb58cbed15d8c2005c3d898.1616155599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.909.git.1616155599.gitgitgadget@gmail.com>
References: <pull.909.git.1616155599.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 12:06:39 +0000
Subject: [PATCH 3/3] [GSOC] commit: add own-identity option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Use the newly added option `--own-identity` in
`interpret-trailers`, implement new commit option
`--own-identity` to allow user optionalise <value>
in `--trailer`, by substitute user's identity if
missing. Using the `--own-identity` option, users
can directly use `--trailer="Signed-off-by"` to
generate a signoff trailer with their own identities
in commit messages,

The effect is basically the same as the `--signoff`
option. However, users can add more useful options at
the same time. e.g. `--trailer="Helped-by" --own-identity`
can general `Helped-by: C O Mitter <committer@example.com>`,
or through appropriate configuration:
`git -c trailer.signoff.key="Signed-off-by" commit \
--trailer="signoff" --own-identity`
can also general their needs trailers with their favorite
keys and their own identities.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-commit.txt          | 19 +++++-
 builtin/commit.c                      |  8 +++
 t/t7501-commit-basic-functionality.sh | 91 +++++++++++++++++++++++++++
 t/t7502-commit-porcelain.sh           | 20 ++++++
 4 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 2ba2fe0dd10e..69b3e694eb20 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,8 +14,8 @@ SYNOPSIS
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
-	   [--] [<pathspec>...]
+	   [(--trailer <token>[(=|:)<value>])... [--own-identity]]
+	   [-S[<keyid>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -175,6 +175,21 @@ include::signoff-option.txt[]
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
index 4b06672bd07d..dc2fc0dc46ff 100644
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
 		if (run_command(&run_trailer))
@@ -1529,6 +1532,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
+		OPT_BOOL(0, "own-identity", &own_identity,
+			     N_("specify the user's own identity for omitted trailers value")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
@@ -1605,6 +1610,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index 024cf3c81b18..6c1387c943ff 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -489,6 +489,26 @@ test_expect_success 'commit --trailer with -c and ":=#" as separators' '
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
