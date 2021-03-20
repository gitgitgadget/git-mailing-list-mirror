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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86329C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C4E61973
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCTOmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCTOlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 10:41:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CCC061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 07:41:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso6763089wmi.0
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pvIZVxVoxgZLRQGOMV+gC6jnzSY3yK6WsNbKqr3zImY=;
        b=WQWq8I6COLMA1bJF4tWo1RHhf/AMnDbHDWWP0eu+bzxXPrZRJKphPNinxtdtGJNTsG
         xHDRbuuclhxxRQgc/b2zRu1lVHlSwbXlf5PoYtO4cAuvsYMqSEvgc5Em6m2duYPKYNHu
         CrTATROBCAEt1fFBSN6VJF9g1Rt9VwXL6WmsqRSvD5KWWtF3erM5p5Yp0CCpUj43neAr
         d8YnJTpLKEnrgGvVO4StiF2MUARCaW60Xpw3lpZkIUJeQzieIm+7pICuAiIEEUUmUmMl
         Ktluhd6wxmk0BV6D/ujshkAH3XP09F9nwpUwRycy27K2iNt6sss88zNsJNPPEXJ00Cho
         I/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pvIZVxVoxgZLRQGOMV+gC6jnzSY3yK6WsNbKqr3zImY=;
        b=On7yy/lgyJUxxT7U2gceZppr+GQA3zqQgUU9MwvtVN5oj8mS7KucTWdjMkewPBwsuP
         6cwF5EXKjW5KXZltpxJSU7OZVUk8lzmmnjSW+oUnIPm4Cz0DaYs9+jqpwrK12TmI/9Gm
         euAlK0kMEPnc0w1fcHf1AWPH4DXQvwk1Kv+rDEmvXW7b/Xn0IzaVKDK7rFRvVFX0t9Ag
         qYEesQ4mj/ZAE2UBgmCD5N89jndT+WdKnT2DL0RYBDhl+7JL+EiOF/TekuF4GXxRcl04
         eOKhSehR5tZ2OKrENe2yFxCXeORWCJcEu3NPjQCAoVysULBsk+aCfArFixOW6RWm+tgp
         T/Lg==
X-Gm-Message-State: AOAM533ljb1x4u/co0KNuOsVDanG2aqdb4xCv/yu/0o8SnQNS46p8O7t
        GkHLiuIX5QRy21zVzbF1sMxx8jCOWsA=
X-Google-Smtp-Source: ABdhPJx9FhhA02IW6ohLSNbqK1vac3rCClr3Gcezt3NZxvWrmthhmCXWGoLop69R9dT1LFIThhg6uA==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr7929966wmi.127.1616251300886;
        Sat, 20 Mar 2021 07:41:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm13122625wrp.79.2021.03.20.07.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 07:41:40 -0700 (PDT)
Message-Id: <2378e3b4c1ae2a38b6cf7d11eea16c5d3c55da74.1616251299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.911.git.1616251299.gitgitgadget@gmail.com>
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 14:41:37 +0000
Subject: [PATCH 1/2] [GSOC] commit: add --trailer option
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
---
 Documentation/git-commit.txt |  14 +-
 builtin/commit.c             |  22 +++
 t/t7502-commit-porcelain.sh  | 291 +++++++++++++++++++++++++++++++++++
 3 files changed, 326 insertions(+), 1 deletion(-)

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
index 6396897cc818..74b1602c0ce6 100755
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
@@ -154,6 +164,287 @@ test_expect_success 'sign off' '
 
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
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
gitgitgadget

