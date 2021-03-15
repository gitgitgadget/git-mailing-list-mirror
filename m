Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BDEC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 06:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8BD64E38
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 06:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCOGgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 02:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCOGfy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 02:35:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FDCC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 23:35:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so18744471wmd.5
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fRT/sfFZOZS3FjQ+0uREWQIQ1Tkt826sdrjqQw68TXY=;
        b=slfUiHt+poklPQDuqYQgHEBb4gxYpFXMygg7dzVnu98K2v6U8GlnWHQ/8P0PG7pvYu
         zq24++cTyp4+Fi/fz79/8QXY2/iY+74nx1Pw2ogxad7FE6We/MBkDsYhFENguPwjv692
         kkZjwyO2GwwRmT65jJqF7GwS4q4kSVhmOkc6ITsD54lx8pipQPDagnoLs8oSbskItRvr
         V6Lp01nPzkmeM/hZlY/3CmhXXuF+SiHXXML5mJH2VNv4WlOwVd4zWf4d9VFalKwGRbCo
         cQ0lwz6H9KIV/FHzwMdf2uqlRAWCHGlaRoz8ua2njltgX+3cwN8OC9DR73BE82XCNpqk
         FhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fRT/sfFZOZS3FjQ+0uREWQIQ1Tkt826sdrjqQw68TXY=;
        b=LXDdSMdWdPGA9sk/n4BNxBeaQUfNVNHOxfPxoDY2a2JWWkevmY5aptfMqrEQ6K28Jx
         RnyGti8sarKqt0IzFUXYDYDIoTVDTogdYdrtRUiJaMiqYdKnerT4eWd0uHF0wFuk+aVu
         Ebiy1x4SDBI4pRgfGEQ6qtFxMrKo7jcdnQrvKHgsaH4surGp0qykxtzbPYkNzV6U9BlK
         HB7bZ3QtYTGDNCu/KdB4ZPQgk/oZzB0wrVHY1k0VlBCfgX2idpnr9Nl1x++CAqhDjZFi
         nKhg62rR2B5gWU0o2/nMNd8r6RF5folgjCVHZntn0DV4z0el+os/YxQbWiTC06T5qwM4
         WYzQ==
X-Gm-Message-State: AOAM5338rcUHd8Th2lP9B//6lnV5ow+ydE7R3b2IhG2e6zOezlQfHG0G
        6N7JRdRrORXbSu30OTQnJiv63ao+D2Q=
X-Google-Smtp-Source: ABdhPJznzmPPM6fvgKpCC8dW3MpAgOQLdkAK4O8ygbw2vdDX4K1eOgVztoM2fIpW4dGN0LYBAgC9VQ==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr24841115wmf.148.1615790152189;
        Sun, 14 Mar 2021 23:35:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g202sm11324769wme.20.2021.03.14.23.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 23:35:51 -0700 (PDT)
Message-Id: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com>
References: <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 06:35:50 +0000
Subject: [PATCH v6] [GSOC] commit: add --trailer option
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
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Historically, Git has supported the 'Signed-off-by' commit trailer
using the '--signoff' and the '-s' option from the command line.
But users may need to provide other trailer information from the
command line such as "Helped-by", "Reported-by", "Mentored-by",

Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
other trailers to `interpret-trailers` and insert them into commit
messages.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] commit: add --trailer option
    
    Now maintainers or developers can also use commit
    --trailer="Signed-off-by:commiter<email>" from the command line to
    provide trailers to commit messages. This solution may be more
    generalized than v1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v5:

 1:  ca91accb2852 ! 1:  c99ce75da792 [GSOC] commit: add --trailer option
     @@ builtin/commit.c: static int config_commit_verbose = -1; /* unspecified */
       static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
       static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
       static char *sign_commit, *pathspec_from_file;
     -+struct child_process run_trailer = CHILD_PROCESS_INIT;
      +struct strvec trailer_args = STRVEC_INIT;
     -+static const char *trailer;
       
       /*
        * The default commit message cleanup mode will remove the lines
     @@ builtin/commit.c: static struct strbuf message = STRBUF_INIT;
       
      +static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
      +{
     -+	if (unset) {
     -+		strvec_clear(&trailer_args);
     -+		return -1;
     -+	}
     ++	BUG_ON_OPT_NEG(unset);
     ++
      +	strvec_pushl(&trailer_args, "--trailer", arg, NULL);
      +	return 0;
      +}
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       	fclose(s->fp);
       
      +	if (trailer_args.nr) {
     ++		static struct child_process run_trailer = CHILD_PROCESS_INIT;
     ++
      +		strvec_pushl(&run_trailer.args, "interpret-trailers",
      +			     "--in-place", "--where=end", git_path_commit_editmsg(), NULL);
      +		strvec_pushv(&run_trailer.args, trailer_args.v);
     @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix
       		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
       		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
       		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
     -+		OPT_CALLBACK(0, "trailer", &trailer, N_("trailer"), N_("trailer(s) to add"), opt_pass_trailer),
     ++		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("trailer(s) to add"), PARSE_OPT_NONEG, opt_pass_trailer),
       		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
       		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
       		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),


 Documentation/git-commit.txt |  9 ++++++++-
 builtin/commit.c             | 22 ++++++++++++++++++++++
 t/t7502-commit-porcelain.sh  | 20 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..73a7507db47f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	   [-S[<keyid>]] [--] [<pathspec>...]
+	   [-S[<keyid>]] [--] [<pathspec>...] [(--trailer <token>[(=|:)<value>])...]
 
 DESCRIPTION
 -----------
@@ -166,6 +166,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
+	<committer@example.com>" --trailer "Helped-by:C O Mitter \
+	<committer@example.com>"` will add the "Signed-off" trailer
+	and the "Helped-by" trailer in the commit message.)
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..726d2f4eaf5d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,6 +113,7 @@ static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit, *pathspec_from_file;
+struct strvec trailer_args = STRVEC_INIT;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -131,6 +132,14 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
+static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+
+	strvec_pushl(&trailer_args, "--trailer", arg, NULL);
+	return 0;
+}
+
 static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
 {
 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
@@ -958,6 +967,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	fclose(s->fp);
 
+	if (trailer_args.nr) {
+		static struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+		strvec_pushl(&run_trailer.args, "interpret-trailers",
+			     "--in-place", "--where=end", git_path_commit_editmsg(), NULL);
+		strvec_pushv(&run_trailer.args, trailer_args.v);
+		run_trailer.git_cmd = 1;
+		if (run_command(&run_trailer))
+			strvec_clear(&run_trailer.args);
+		strvec_clear(&trailer_args);
+	}
+
 	/*
 	 * Reject an attempt to record a non-merge empty commit without
 	 * explicit --allow-empty. In the cherry-pick case, it may be
@@ -1507,6 +1528,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
+		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("trailer(s) to add"), PARSE_OPT_NONEG, opt_pass_trailer),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 6396897cc818..0acf23799931 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -154,6 +154,26 @@ test_expect_success 'sign off' '
 
 '
 
+test_expect_success 'trailer' '
+	>file1 &&
+	git add file1 &&
+	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
+		--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
+		--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
+		--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
+		-m "hello" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,7d" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C O Mitter1 <committer1@example.com>
+	Helped-by: C O Mitter2 <committer2@example.com>
+	Reported-by: C O Mitter3 <committer3@example.com>
+	Mentored-by: C O Mitter4 <committer4@example.com>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&

base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
-- 
gitgitgadget
