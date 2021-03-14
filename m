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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5AAC433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 15:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E01D64EB3
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 15:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhCNP7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNP6d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 11:58:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF89AC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 08:58:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so1232722wmq.1
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qCxTZq6z+GFuLgyKWVJrm0VBpnYgDurqkww2nyyRyX4=;
        b=BcsKfixnPxK7hVjyTZ8PhJQgD9L/CN9+T/SNT7jOFImOiD2hrUJDZe2qtAU//sjjHI
         4nKxfDfrSOdu167SDqtJ39q6NqLF3+qh3kI3pdYkf7u8HbOhpzrJQoYs/nig4wNFXgyq
         TXoHVlbqiO8GukiL2v+H9eymLsWeb7GIemMjLFvBFaKYE+uqBW/3aJtsWl9bJ+aw63Bf
         StlH3RSarOhmqhqoen1Wxwh2w+OTfDLp+cxQ/oJ7B7iWLrKAZUK/1Ke9gMmmLsI1VKuC
         fgMguFCTZPiM8eN0HaoWK6LKydKy98XmSVOakghwBSqCJEDhk49ugiI55u+zEBRLdW3k
         uTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qCxTZq6z+GFuLgyKWVJrm0VBpnYgDurqkww2nyyRyX4=;
        b=HV9pHBeZx5Xp7zAdsNfv/9gbrgPa0alk0c3hTFz8ODN2OYvi3k6YX/1Djb9wy8+/Vr
         l28tlUNTurSc79Cn5xxKa/kFIRSF1ozYmQWkhth24MY+9TTDhIOoIm36WtKDj83F1BhC
         eDnQyCPlyUtD+Ez/XZRyFxGkVu9ihzEOTrK/BjHKN537MG00d4L9ome5A9bwW8f7VurX
         +SfwGLK9tRyTylv8q6J4SQxrDJTBD553o9dr5WCa/ylGcl+T4L0G50PjaeSHdmWA5/jR
         3S4SQrP10Y/kSdvUMYYvIfuiwSFklK0leIhEI2qQAYZQIXaHKHqZnirx1AiplGdCVS9+
         iHbg==
X-Gm-Message-State: AOAM531VmbZmlRC4fxnTrloK+d7X6UbYRzHRzcSHerdDCMoArnq8Cw7Y
        2phWiKasu7CTHf8pRzRZ5qB9L/hkOpQ=
X-Google-Smtp-Source: ABdhPJzHUPX33IWcqBU7kGqQTtRf/Dvfz+99MiS9WEzM48hXpO3iHX3uWlQEXeTSZW2qdBl9DrfuJQ==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr22254747wme.107.1615737507094;
        Sun, 14 Mar 2021 08:58:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18sm17908358wrr.27.2021.03.14.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 08:58:26 -0700 (PDT)
Message-Id: <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
References: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 15:58:25 +0000
Subject: [PATCH v4] [GSOC] commit: add --trailer option
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v3:

 1:  b4e161a98f8b ! 1:  dc507553ef4f [GSOC] commit: add --trailer option
     @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `
       
      +--trailer <token>[(=|:)<value>]::
      +	Specify a (<token>, <value>) pair that should be applied as a
     -+	trailer. (e.g.  `git commit --trailer "Signed-off-by:C O Mitter <committer@example.com>" \
     -+	--trailer "Helped-by:C O Mitter <committer@example.com>"`will add the "Signed-off" trailer
     ++	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
     ++	<committer@example.com>" --trailer "Helped-by:C O Mitter \
     ++	<committer@example.com>"` will add the "Signed-off" trailer
      +	and the "Helped-by" trailer in the commit message.)
      +
       -n::
     @@ builtin/commit.c: static struct strbuf message = STRBUF_INIT;
      +		strvec_clear(&run_trailer.args);
      +		return -1;
      +	}
     -+	run_trailer.git_cmd = 1;
      +	strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
      +	return 0;
      +}
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       
       	fclose(s->fp);
       
     -+	run_command(&run_trailer);
     ++	if (run_trailer.args.nr != 4) {
     ++		run_trailer.git_cmd = 1;
     ++		run_command(&run_trailer);
     ++	} else
     ++		strvec_clear(&run_trailer.args);
      +
       	/*
       	 * Reject an attempt to record a non-merge empty commit without
     @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix
       	}
       	verbose = -1; /* unspecified */
      +	strvec_pushl(&run_trailer.args, "interpret-trailers",
     -+		"--in-place", "--where=end", git_path_commit_editmsg(), NULL);
     ++		    "--in-place", "--where=end", git_path_commit_editmsg(), NULL);
       	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
       					  builtin_commit_usage,
       					  prefix, current_head, &s);
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +	>file1 &&
      +	git add file1 &&
      +	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
     -+	--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
     -+	--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
     -+	--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
     -+	-m "hello" &&
     ++		--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
     ++		--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
     ++		--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
     ++		-m "hello" &&
      +	git cat-file commit HEAD >commit.msg &&
      +	sed -e "1,7d" commit.msg >actual &&
      +	cat >expected <<-\EOF &&


 Documentation/git-commit.txt |  9 ++++++++-
 builtin/commit.c             | 21 +++++++++++++++++++++
 t/t7502-commit-porcelain.sh  | 20 ++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

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
index 739110c5a7f6..b35ae5c9790d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,6 +113,8 @@ static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit, *pathspec_from_file;
+struct child_process run_trailer = CHILD_PROCESS_INIT;
+static const char *trailer;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -131,6 +133,16 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
+static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
+{
+	if (unset) {
+		strvec_clear(&run_trailer.args);
+		return -1;
+	}
+	strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
+	return 0;
+}
+
 static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
 {
 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
@@ -958,6 +970,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	fclose(s->fp);
 
+	if (run_trailer.args.nr != 4) {
+		run_trailer.git_cmd = 1;
+		run_command(&run_trailer);
+	} else
+		strvec_clear(&run_trailer.args);
+
 	/*
 	 * Reject an attempt to record a non-merge empty commit without
 	 * explicit --allow-empty. In the cherry-pick case, it may be
@@ -1507,6 +1525,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
+		OPT_CALLBACK(0, "trailer", &trailer, N_("trailer"), N_("trailer(s) to add"), opt_pass_trailer),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
@@ -1577,6 +1596,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			die(_("could not parse HEAD commit"));
 	}
 	verbose = -1; /* unspecified */
+	strvec_pushl(&run_trailer.args, "interpret-trailers",
+		    "--in-place", "--where=end", git_path_commit_editmsg(), NULL);
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
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
