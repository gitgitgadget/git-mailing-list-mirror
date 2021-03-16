Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8920AC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 10:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3F164F7F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 10:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbhCPKkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 06:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbhCPKjq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 06:39:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEA0C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 03:39:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1119160wmi.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=97Z99WT+3sbXI6WEykDug3rQBY4V8uWzTV25E2jsRCI=;
        b=FnR4EX7cW08Y6gSEmqgf0XZ06QqDGi702f6uQg0ARrXhOKwPyIX3Sk9J/XccQyYlsQ
         OZkMqDCRGLavc78/KbOJXWNyU3O8d4QbiJPbEt5gNir0zKdD3FaETHw65qA+dWZ1Vfyh
         iWcrK1dgVcJIUybFMkvlquUTT95gJJ16Igll8Cpy+pDUM4fi1Hw/0RJ447D8QmcCLE/7
         pH2rWUHd+YDmWyY/mNODGWiR/hUrLnssS1u0jbljpg0qpMALm+XR7pyazLJ+yb0ccr3Y
         gbHJqLOLH3jDEvV3AWLg/wnYTEJe2PHg9bWAJZlX4tuCj+KlpgiiwdJnUC64ro1n3HGv
         pjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=97Z99WT+3sbXI6WEykDug3rQBY4V8uWzTV25E2jsRCI=;
        b=sdWfs4uwfWVoYgGmBAt34OvHLhH+YyaMourbK9J+g3gqIikO1sFaup4jhyT/lqrzdx
         zGoWqBKaJY1QhKi9zVsFg3vOgheujswZe3VAP+Imrt2zXBg4PV/XYvk5CWpscVo63DjO
         oV6/dK6UsWKdje+Y2QHX3kH/tm7mxiToyIy2D3OAFK+pLX6peWeVVzVEkfOotjpCXVZf
         MwW3W2v/PzIrMkyFA9t82Ot7+6ZC+79sVAR7KpIwQ7vfqusRj/zA65Okf8iX68uBInW8
         0NKKWlrzhW5hlZCgzll1+SrREg/v/7F22DdMhQUWS2KTFeIgMmGARIMByXDIHbXNNA0o
         pIQQ==
X-Gm-Message-State: AOAM533/tXVnPZLejZHE0guYu7vWh7yxro8s3kRR2PkN4ZBgCtnGb9ge
        plPKScPYxhRl3VFslUWQin/HZHbXT8M=
X-Google-Smtp-Source: ABdhPJyEUiFZbqCvAYsZ2mRWHfCAll+e2DOzRd2A51MoXrDXLPH4HB1VtYTCxkkC00ccg1wTb25S+g==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr3944555wmq.183.1615891184579;
        Tue, 16 Mar 2021 03:39:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm2706441wmm.19.2021.03.16.03.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 03:39:44 -0700 (PDT)
Message-Id: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
References: <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 10:39:42 +0000
Subject: [PATCH v9] [GSOC] commit: add --trailer option
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v8:

 1:  f81b6e66a6ba ! 1:  e524c4ba5dc1 [GSOC] commit: add --trailer option
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      +		struct child_process run_trailer = CHILD_PROCESS_INIT;
      +
      +		strvec_pushl(&run_trailer.args, "interpret-trailers",
     -+			     "--in-place", "--if-exists=add",
     -+			     git_path_commit_editmsg(), NULL);
     ++			     "--in-place", git_path_commit_editmsg(), NULL);
      +		strvec_pushv(&run_trailer.args, trailer_args.v);
      +		run_trailer.git_cmd = 1;
      +		if (run_command(&run_trailer))
 2:  68e0bd9e2d6f < -:  ------------ interpret_trailers: for three options parse add warning


 Documentation/git-commit.txt |  9 ++++++++-
 builtin/commit.c             | 22 ++++++++++++++++++++++
 t/t7502-commit-porcelain.sh  | 20 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..f74d320f0c96 100644
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
+	<committer@example.com>"` will add the "Signed-off-by" trailer
+	and the "Helped-by" trailer in the commit message.)
+	See linkgit:git-interpret-trailers[1] for details.
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..a002330d9d56 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,6 +113,7 @@ static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit, *pathspec_from_file;
+static struct strvec trailer_args = STRVEC_INIT;
 
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
+		struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+		strvec_pushl(&run_trailer.args, "interpret-trailers",
+			     "--in-place", git_path_commit_editmsg(), NULL);
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
