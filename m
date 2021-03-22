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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BBC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE11461968
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhCVEZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 00:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVEY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 00:24:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD63C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 21:24:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y124-20020a1c32820000b029010c93864955so10585839wmy.5
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cjnmanl4YdOJeRUekZeuX4aZsNfQxGGeoOSZUE0DS7k=;
        b=PiXy5sm1bWPGd2sb+/j573CHyYBuwiYUh0/+OI39tjkpVQK/i3yTuZfWLsdGu0EWwV
         kNu6XSi0VMUakQ9DWhcfbwhaddt8tG8x9X+hamVoRC2yeGYCpVRfZdB1+7++Hbun3ZBB
         zOOZ+iTnOYIQp/fTvyPALoTh7Duz/uu10P817Rns4SWA33FT5rwhFi1ur9fbC7zwJjSB
         MwMPf0geo1hrBSpZZTD1h3HIALgSTYFrNB8HtjH8VTEVdun2Z+RGeNgZ2Q/7HesRUCVt
         nZ8Ft/8HJw4Vy916eFWfea6eOjtcs7Ht6ETqCR59U3QJ0wP6B43i6vIUxu9bBMXf7VX0
         /BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cjnmanl4YdOJeRUekZeuX4aZsNfQxGGeoOSZUE0DS7k=;
        b=VaDj6yIJgLwIquGLUZWxYYri52vEAYBDF7sDpUZPjkgNsSazIYkHWefBinHb5vcA5F
         ZUKh8H+IiMughxyN6GoA1MoolJdxBTkFGBuRm8bnowPDF0jQELWEvj9eUMhJwOZSXPol
         gx8dcO2vyvJ0xWv/m3N64wjMNrkpFShcG8UhKVMknOAsUk6NyMAQo+xGd9I2L09VR2m7
         /ffKUrs7HtxD2VJkWzj+Wx9KQwxNb2jz4C2ao0GbWwhU1EXWxz9bY2Sznm3qlqqTyEBq
         1cZPuVa0mldflNs7y5yQNfrL8nLkHXca8iRENdJAYlGa1M0ZiZkX3hZpVOTkwiHMzIIz
         qgsA==
X-Gm-Message-State: AOAM533mOXhvpf9HlpKKjNwRaQYw9BDJS4crivlLhg9AQUYt58CokASa
        wUDmBiHvakqmybPwfuFkMjOOWoaWcDE=
X-Google-Smtp-Source: ABdhPJwHocxRBOVdy38zGD1ysJakVW4lpNhY3D38xlW16yARkOJ+d3FWk2Q+A6VH+CUiHIUHmSrZAA==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr14345171wmc.132.1616387094652;
        Sun, 21 Mar 2021 21:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm15252168wmh.13.2021.03.21.21.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 21:24:54 -0700 (PDT)
Message-Id: <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 04:24:53 +0000
Subject: [PATCH v13] [GSOC] commit: add --trailer option
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
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
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
Reported-by:
---
    [GSOC] commit: add --trailer option
    
    Now maintainers or developers can also use commit
    --trailer="Signed-off-by:commiter<email>" from the command line to
    provide trailers to commit messages. This solution may be more
    generalized than v1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v13
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v12:

 1:  2378e3b4c1ae ! 1:  98b0c470e141 [GSOC] commit: add --trailer option
     @@ Commit message
          messages.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     +    Reported-by:
      
       ## Documentation/git-commit.txt ##
      @@ Documentation/git-commit.txt: SYNOPSIS
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
     ++
     ++test_expect_success 'commit --trailer with -c and command' '
     ++	trailer_commit_base &&
     ++	cat >expected <<-\EOF &&
     ++	hello
     ++
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
     ++	Mentored-by: C4 E4
     ++	Reported-by: A U Thor <author@example.com>
     ++	EOF
     ++	git -c trailer.report.key="Reported-by: " \
     ++		-c trailer.report.ifexists="replace" \
     ++		-c trailer.report.command="git log --author=\"\$ARG\" -1 \
     ++		--format=\"format:%aN <%aE>\"" \
     ++		commit --trailer "report = author" --amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
      +
       test_expect_success 'multiple -m' '
       


 Documentation/git-commit.txt |  14 +-
 builtin/commit.c             |  22 +++
 t/t7502-commit-porcelain.sh  | 312 +++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..3fe7ef33cb07 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	   [-S[<keyid>]] [--] [<pathspec>...]
+	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
+	   [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -166,6 +167,17 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
+	<committer@example.com>" --trailer "Helped-by:C O Mitter \
+	<committer@example.com>"` will add the "Signed-off-by" trailer
+	and the "Helped-by" trailer to the commit message.)
+	The `trailer.*` configuration variables
+	(linkgit:git-interpret-trailers[1]) can be used to define if
+	a duplicated trailer is omitted, where in the run of trailers
+	each trailer would appear, and other details.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..4b06672bd07d 100644
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
+			die(_("unable to pass trailers to --trailers"));
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
+		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 6396897cc818..dd044fcea31c 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -38,6 +38,16 @@ check_summary_oneline() {
 	test_cmp exp act
 }
 
+trailer_commit_base () {
+	echo "fun" >>file &&
+	git add file &&
+	git commit -s --trailer "Signed-off-by=C1 E1 " \
+		--trailer "Helped-by:C2 E2 " \
+		--trailer "Reported-by=C3 E3" \
+		--trailer "Mentored-by:C4 E4" \
+		-m "hello"
+}
+
 test_expect_success 'output summary format' '
 
 	echo new >file1 &&
@@ -154,6 +164,308 @@ test_expect_success 'sign off' '
 
 '
 
+test_expect_success 'commit --trailer with "="' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "replace" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	EOF
+	git -c trailer.ifexists="replace" \
+		commit --trailer "Mentored-by: C4 E4" \
+		 --trailer "Helped-by: C3 E3" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "add" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.ifexists="add" \
+		commit --trailer "Reported-by: C3 E3" \
+		--trailer "Mentored-by: C4 E4" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "donothing" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reviewed-by: C6 E6
+	EOF
+	git -c trailer.ifexists="donothing" \
+		commit --trailer "Mentored-by: C5 E5" \
+		--trailer "Reviewed-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "addIfDifferent" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C5 E5
+	EOF
+	git -c trailer.ifexists="addIfDifferent" \
+		commit --trailer "Reported-by: C3 E3" \
+		--trailer "Mentored-by: C5 E5" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "addIfDifferentNeighbor" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reported-by: C3 E3
+	EOF
+	git -c trailer.ifexists="addIfDifferentNeighbor" \
+		commit --trailer "Mentored-by: C4 E4" \
+		--trailer "Reported-by: C3 E3" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "end" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.where="end" \
+		commit --trailer "Reported-by: C3 E3" \
+		--trailer "Mentored-by: C4 E4" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "start" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C1 E1
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.where="start" \
+		commit --trailer "Signed-off-by: C O Mitter <committer@example.com>" \
+		--trailer "Signed-off-by: C1 E1" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "after" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C5 E5
+	EOF
+	git -c trailer.where="after" \
+		commit --trailer "Mentored-by: C4 E4" \
+		--trailer "Mentored-by: C5 E5" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "before" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C2 E2
+	Mentored-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.where="before" \
+		commit --trailer "Mentored-by: C3 E3" \
+		--trailer "Mentored-by: C2 E2" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "donothing" as ifmissing' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C5 E5
+	EOF
+	git -c trailer.ifmissing="donothing" \
+		commit --trailer "Helped-by: C5 E5" \
+		--trailer "Based-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "add" as ifmissing' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C5 E5
+	Based-by: C6 E6
+	EOF
+	git -c trailer.ifmissing="add" \
+		commit --trailer "Helped-by: C5 E5" \
+		--trailer "Based-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c ack.key ' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+		hello
+
+		Acked-by: Peff
+	EOF
+	git -c trailer.ack.key="Acked-by" \
+		commit --trailer "ack = Peff" -m "hello" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and ":=#" as separators' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+		I hate bug
+
+		Bug #42
+	EOF
+	git -c trailer.separators=":=#" \
+		-c trailer.bug.key="Bug #" \
+		commit --trailer "bug = 42" -m "I hate bug" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and command' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Mentored-by: C4 E4
+	Reported-by: A U Thor <author@example.com>
+	EOF
+	git -c trailer.report.key="Reported-by: " \
+		-c trailer.report.ifexists="replace" \
+		-c trailer.report.command="git log --author=\"\$ARG\" -1 \
+		--format=\"format:%aN <%aE>\"" \
+		commit --trailer "report = author" --amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&

base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
-- 
gitgitgadget
