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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB267C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B761164F65
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCSMFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCSMFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 08:05:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4FC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:05:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e9so8855541wrw.10
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y5ecHSxh41fUfT4l6y2pDDQxbHofo6FBPAuzCddM0OA=;
        b=od9qfORVHj7oU/AOS0jWDkvZiBbg7SSFNA8j6dKeG/dg9zviYniO2t47PTqgly86pN
         aWTaikC3CybwXrg2ci4nhOkCoUOdy/AouV+Ca2ukxLHwuSfTMwGJF1UJELzMsCatVfg5
         nH0gjO+KdHlCoxCgZWYm9wpTItcSQMxTD20Vig0+EFbZAjRNoCdWRTMgJSvf/1QelcZj
         v8edO27m3qG0IaySHu9HL8gG0Nykfg1zXI2yUEoTQTKgYsbIoiz1EnHt3LBWXaNNiy/3
         l+k00rZOUt+Y/CXp2+kEUvJjWJfWVmYHKShs0dERLFiXbdv7nmUTC35he477AQvipsT3
         ACoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y5ecHSxh41fUfT4l6y2pDDQxbHofo6FBPAuzCddM0OA=;
        b=N7JR+s23+OyXYncN75d58ydERDlYCJdYivCcC6f59xAjeSc2XP5HT5Tzf9PZKk94qN
         ZJStZdYIDUHu9AUCOIkdrHjs95+hsD78xM4dTSlyeOPZOL8no+Rt6/sjsjA3Fxoj6v9A
         FXu0iA0mXqygS3SqKx9IH+g3a/HdoIq9VhwgB7QicG9I6R3/cic2bDaIv8ybVH48IRa+
         SE22aTaLkS/1tiHHyAmnZimYjNvutJZl+VaiaWvGaS9MIFGZ+WBGZ0G6EhNBb6nyr47J
         WFjeBVGFtmVhaC094NJLzoe3vLFPxz6biPapZi1Kjh+noek8UoKmNOkgn6l2QBcC63zf
         rDgQ==
X-Gm-Message-State: AOAM5328lKjv8IiBluumwxZFJ/229xqoP6mft+Wuk1riAikQsXaZ2Kz9
        A8Gv81DPubuL7ljb8cZm63DtI7GIfys=
X-Google-Smtp-Source: ABdhPJz1OTaF4J87To9tckIFJferqCFClvvFz8PY+DnYfSNbWG9BLr9Qwam691Ngqcmgt4rCWIKgZw==
X-Received: by 2002:a05:6000:250:: with SMTP id m16mr4239535wrz.325.1616155518889;
        Fri, 19 Mar 2021 05:05:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm6280128wme.47.2021.03.19.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:05:18 -0700 (PDT)
Message-Id: <pull.901.v11.git.1616155517590.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
References: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 12:05:17 +0000
Subject: [PATCH v11] [GSOC] commit: add --trailer option
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v11
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v10:

 1:  949faf9ee56a ! 1:  0db1210ffd6d [GSOC] commit: add --trailer option
     @@ Documentation/git-commit.txt: SYNOPSIS
       	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
       	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
      -	   [-S[<keyid>]] [--] [<pathspec>...]
     -+	   [-S[<keyid>]] [--] [<pathspec>...] [(--trailer <token>[(=|:)<value>])...]
     ++	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
     ++	   [--] [<pathspec>...]
       
       DESCRIPTION
       -----------
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      +			     "--in-place", git_path_commit_editmsg(), NULL);
      +		strvec_pushv(&run_trailer.args, trailer_args.v);
      +		run_trailer.git_cmd = 1;
     -+		if (run_command(&run_trailer)) {
     -+			die(_("unable to pass tailers to --trailers"));
     -+		}
     ++		if (run_command(&run_trailer))
     ++			die(_("unable to pass trailers to --trailers"));
      +		strvec_clear(&trailer_args);
      +	}
      +
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +	test_cmp expected actual
      +'
      +
     -+test_expect_success 'commit --trailer with -c and "=" as separators' '
     ++test_expect_success 'commit --trailer with "=" ' '
      +	echo "fun" >>file1 &&
      +	git add file1 &&
      +	cat >expected <<-\EOF &&
      +
     -+		Acked-by= Peff
     ++		Acked-by: Peff
      +	EOF
     -+	git -c trailer.separators="=" \
     -+		-c trailer.ack.key="Acked-by= " \
     ++	git -c trailer.ack.key="Acked-by" \
      +		commit --trailer "ack = Peff" -m "hello" &&
      +	git cat-file commit HEAD >commit.msg &&
      +	sed -e "1,6d" commit.msg >actual &&
 2:  42590e95deee < -:  ------------ interpret-trailers: add own-identity option
 3:  2dfcc20f0e9f < -:  ------------ commit: add own-identity option


 Documentation/git-commit.txt |  11 +-
 builtin/commit.c             |  22 +++
 t/t7502-commit-porcelain.sh  | 335 +++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..2ba2fe0dd10e 100644
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
@@ -166,6 +167,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
+	<committer@example.com>" --trailer "Helped-by:C O Mitter \
+	<committer@example.com>"` will add the "Signed-off-by" trailer
+	and the "Helped-by" trailer in the commit message.)
+	Use `git -c trailer.* commit --trailer` to make the appropriate
+	configuration. See linkgit:git-interpret-trailers[1] for details.
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
index 6396897cc818..024cf3c81b18 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -154,6 +154,341 @@ test_expect_success 'sign off' '
 
 '
 
+test_expect_success 'commit --trailer without -c' '
+	echo "fun" >>file &&
+	git add file &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git commit -s --trailer "Signed-off-by:C1 E1 " \
+		--trailer "Helped-by:C2 E2 " \
+		--trailer "Reported-by:C3 E3" \
+		--trailer "Mentored-by:C4 E4" \
+		-m "hello" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "replace" as ifexists' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
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
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "add" as ifexists' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	EOF
+	git -c trailer.ifexists="add" \
+		commit --trailer "Helped-by: C3 E3" \
+		--trailer "Helped-by: C3 E3" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "donothing" as ifexists' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	EOF
+	git -c trailer.ifexists="donothing" \
+		commit --trailer "Mentored-by: C5 E5" \
+		--trailer "Reviewed-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "addIfDifferent" as ifexists' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	EOF
+	git -c trailer.ifexists="addIfDifferent" \
+		commit --trailer "Reviewed-by: C6 E6" \
+		--trailer "Reported-by: C5 E5" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "addIfDifferentNeighbor" as ifexists' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	EOF
+	git -c trailer.ifexists="addIfDifferent" \
+		commit --trailer "Reported-by: C5 E5" \
+		--trailer "Reviewed-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "end" as where' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	Reported-by: C7 E7
+	EOF
+	git -c trailer.where="end" \
+		commit --trailer "Reported-by: C5 E5" \
+		--trailer "Reported-by: C7 E7" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "start" as where' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C8 E8
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	Reported-by: C7 E7
+	EOF
+	git -c trailer.where="start" \
+		commit --trailer "Signed-off-by: C8 E8" \
+		--trailer "Signed-off-by: C8 E8" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "after" as where' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C8 E8
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C9 E9
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	Reported-by: C7 E7
+	Reported-by: C10 E10
+	EOF
+	git -c trailer.where="after" \
+		commit --trailer "Mentored-by: C9 E9" \
+		--trailer "Reported-by: C10 E10" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "before" as where' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C8 E8
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C11 E11
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C9 E9
+	Helped-by: C12 E12
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	Reported-by: C7 E7
+	Reported-by: C10 E10
+	EOF
+	git -c trailer.where="before" \
+		commit --trailer "Helped-by: C12 E12" \
+		--trailer "Reported-by: C11 E11" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "donothing" as ifmissing' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C8 E8
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C11 E11
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C9 E9
+	Helped-by: C12 E12
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	Reported-by: C7 E7
+	Reported-by: C10 E10
+	Helped-by: C12 E12
+	EOF
+	git -c trailer.ifmissing="donothing" \
+		commit --trailer "Helped-by: C12 E12" \
+		--trailer "Based-by: C13 E13" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "add" as ifmissing' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+	Signed-off-by: C8 E8
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C11 E11
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C9 E9
+	Helped-by: C12 E12
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Helped-by: C3 E3
+	Reviewed-by: C6 E6
+	Reported-by: C5 E5
+	Reported-by: C7 E7
+	Reported-by: C10 E10
+	Helped-by: C12 E12
+	Based-by: C13 E13
+	EOF
+	git -c trailer.ifmissing="add" \
+		commit --trailer "Helped-by: C12 E12" \
+		--trailer "Based-by: C13 E13" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with "=" ' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+		Acked-by: Peff
+	EOF
+	git -c trailer.ack.key="Acked-by" \
+		commit --trailer "ack = Peff" -m "hello" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and ":=#" as separators' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+		Bug #42
+	EOF
+	git -c trailer.separators=":=#" \
+		-c trailer.bug.key="Bug #" \
+		commit --trailer "bug = 42" -m "I hate bug" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,6d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&

base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
-- 
gitgitgadget
