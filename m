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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD8C433E9
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919C164F57
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCRLQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhCRLQA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 07:16:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53397C06175F
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:16:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z2so5067227wrl.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sZO3k8wNG8s4G08B8fMn63C6102xmKzA5YjUcdXqeIM=;
        b=JP3gZ+A/62ttct124OT3Lg1jnVsqNRVKUrgs/cNnc0OJ3+01xU2pQtZ/aYih/bTgLJ
         hqEcpNRbpkj7Xsj3rNttSIAX5TK5vgtg2h6IN+ERfua8O31+kgo/LRTWC+I2KZ1O9f79
         Uz1GlxhW5G1UhJZpV3Tu+wvSVb+ADwmf/wSnEkwJTyf4ZEorUiIIcFpf1rbCWp3sGcYq
         y1ePEqAgIxqEltDKVLJ4fK9ST8DXGR8VsIkEHM/oGltqptPkSglM/B4dQXN7v+tRu25z
         5f3gpTG1bxfU5ZNnldrWbHdDQtnCrhWTHqAmLsuDfeioHNVs7fX9OPcz8h4qD7+9k4E8
         lwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sZO3k8wNG8s4G08B8fMn63C6102xmKzA5YjUcdXqeIM=;
        b=HbOfAR7m4BXRf8zV2VIilqwLAAvO7+PcNVx2reqdFMVH0K6yXcN561N3wnDdv1RDCn
         aNjCwfX+BooJNLDB29NzqOBXOqUXxVFLd/bhoBnkziLQd1i06KfD5h3BWiM+m6a3bJUc
         n0ZVczuJN1wKKKkKSQbf4zHgCbp8EaHi+bPhynmXXIXq003bd8a9l7dLYGATmiKZ+21a
         C90uvYkwV8HBEosqzbUg3d7E4NqDtmCB6wptdn6N3udxmiq5c9yG6jiqNMdA8u26zKyd
         /5si6sFBoHk7dIk9dsge3ykIanY12cZufVr9mbgZpXxz0MPTL4DvGX7PYwFQIHZwJavi
         4P0g==
X-Gm-Message-State: AOAM533KFskfSrjYawjOOS7wiq/BSxOuh+V/ud/7EYWzNlk1zkermFt4
        q2epf1O+r5ghyTQiJtLzPjbrIjAotqw=
X-Google-Smtp-Source: ABdhPJxUhT/Uavc35G1bqJrztG7h4gwBM1pJVDwvzR/QU+CM3Sjyp5bJHuMayCwxMALT2z3J/EFFXg==
X-Received: by 2002:a05:6000:10c5:: with SMTP id b5mr9004743wrx.347.1616066159047;
        Thu, 18 Mar 2021 04:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm2427274wrt.82.2021.03.18.04.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:15:58 -0700 (PDT)
Message-Id: <949faf9ee56a3146a643ba634771779efa89bbc5.1616066156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
        <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 11:15:54 +0000
Subject: [PATCH v10 1/3] [GSOC] commit: add --trailer option
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
 Documentation/git-commit.txt |  10 +-
 builtin/commit.c             |  23 +++
 t/t7502-commit-porcelain.sh  | 336 +++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..c5de981cd40d 100644
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
@@ -166,6 +166,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
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
index 739110c5a7f6..7a79aae48f43 100644
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
@@ -958,6 +967,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	fclose(s->fp);
 
+	if (trailer_args.nr) {
+		struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+		strvec_pushl(&run_trailer.args, "interpret-trailers",
+			     "--in-place", git_path_commit_editmsg(), NULL);
+		strvec_pushv(&run_trailer.args, trailer_args.v);
+		run_trailer.git_cmd = 1;
+		if (run_command(&run_trailer)) {
+			die(_("unable to pass tailers to --trailers"));
+		}
+		strvec_clear(&trailer_args);
+	}
+
 	/*
 	 * Reject an attempt to record a non-merge empty commit without
 	 * explicit --allow-empty. In the cherry-pick case, it may be
@@ -1507,6 +1529,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
+		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 6396897cc818..6df71fa00bcb 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -154,6 +154,342 @@ test_expect_success 'sign off' '
 
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
+test_expect_success 'commit --trailer with -c and "=" as separators' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+
+		Acked-by= Peff
+	EOF
+	git -c trailer.separators="=" \
+		-c trailer.ack.key="Acked-by= " \
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

