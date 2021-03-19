Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D019C433E9
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EE264F65
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCSMHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCSMGm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 08:06:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649EDC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:06:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x16so8853799wrn.4
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0uIlmPncanBqKu8OQTC0kaebv16ur9TjTYQOm0TMPCk=;
        b=L4Y2s27+dTKnb/XxsIcvjZQr34wyDR5oYmTeZj2H86K0p7SajRWzXpzQgrp6mLsKuK
         HsoOn3QX0TIXer/5H71Qx76c5wz2pM82sNv5U6huUSHt7iFelfcv0SvwcGAJRE/6J61f
         lbXYbMpxuDbowZaNWRcz3j+2aZGr9n9Crl0HhgEL5kHcaaWV06+lIE1PHA90m8S9x8Bh
         k6MT3ezQvDwcelwIFgwVD60sJY7QKaAsrvGTNAy4oZ23JG9NNDHQ3kur6PsWNPOQGJ01
         fvJigwDXtgVKyIbMQhWk5e4cgZ5T50NHPjohvjaseXpxvsOCanIRxgk7vSpN6fW2Gnqf
         gKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0uIlmPncanBqKu8OQTC0kaebv16ur9TjTYQOm0TMPCk=;
        b=oBqDIYroeQFZkmoIjKkI0SXAamiCQ5wSawzkOev+tdBaFM71Ay4yOZCs64594Gr1JP
         6pnwqahdCTDbaYU7vFT0SWYNXlK6m4yaMj1Zvn4ZBIxg6TytElTINId2CmMpha4zId0a
         Uy9k3/47I1szNrAkiqxjfdCgwJZIipXqfheoSnsn/cxlvtIffQ1HfGxNIGYLn0qX+AHG
         jVGcZjf/hGG1TEXrcsd5yU3+2fBkabF7/uGN6i+xBHv+7QoGaygkrFoLG+PWBJxwA992
         xJOVR4mWQpNbKi7Yfy6dwK4QcX2htn1xeZTuwsY/bhFcXuRC6dQz4Ei9MywGfHemg6ZW
         S81Q==
X-Gm-Message-State: AOAM532bljL3rBCVB2nQaprY3LmArPtbZ3LJaskKo2ZRebW0UkiRO8Pk
        isbo4PJJRV5Hw+WVgVX9qEBo850FR3g=
X-Google-Smtp-Source: ABdhPJxZdskDFGj6rsTNYJsL882VnBzj4ptQH4/EkTTHFZeYnXE6ifXzI9FQqgjXaHD0bEeIdOA8aQ==
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr4219301wrx.23.1616155601101;
        Fri, 19 Mar 2021 05:06:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm7353730wru.2.2021.03.19.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:06:40 -0700 (PDT)
Message-Id: <0db1210ffd6d1888760b0f74345b67337ed195be.1616155599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.909.git.1616155599.gitgitgadget@gmail.com>
References: <pull.909.git.1616155599.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 12:06:37 +0000
Subject: [PATCH 1/3] [GSOC] commit: add --trailer option
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
-- 
gitgitgadget

