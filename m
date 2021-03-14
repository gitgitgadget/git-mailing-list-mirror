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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC05C4332B
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006B764EE9
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 13:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhCNNDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbhCNNDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 09:03:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2929C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:03:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g25so6494417wmh.0
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lj+ayGj6ENkklY9yFDEV60zSN8Q4al0qVArwU0BVsq4=;
        b=EEZVMXuaV9/BC6/7/J4FFppl75wgo29QvRKkeHwp+rCfB3YDq0wN2hX+YQZg19/u8Q
         3TYTvtZhc9LssRB2SY01NEUXIYTwnmqNyw6dWvnPgOdOUW4314oVPFLVZGLimlj7AxOm
         tb19PcWuDm04GdjMFnL/ZlC8T2/8Eh34I2bNQC6w688t4oZ67SRpptdIcJGSxKHNeSpd
         lPsTyprr3HOZQShWlO0UpWtYJZpcfaQfaRu6FXOfTOQOcwEm80fZEWCpdi+RBxPDMYQk
         bZuDchAptufbiRDprj4HyGPc6SJKaa7w/yek6O+786si7XwYjjgx7CyrMfchLnN/lHra
         Z3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lj+ayGj6ENkklY9yFDEV60zSN8Q4al0qVArwU0BVsq4=;
        b=XtZfFDB7aUPD6lx1AKqo/ZMoZLZDAOTSQlQN20O1iVMsGoSGL3yxSpIA8CppTGmWmA
         KQYM1kI8CvmphfHiNc7Y3cSUsMgyM3XzI7u0jdoKJ9SP6y91DB9o4fbxC262a3vszcQH
         6pCU02Ctd3XkPlD2HtFqATVInr9PQDBXeTdP1pOvWuxDhOqIHQ1r+ASfSDH7BYpSqIAQ
         l6tMNR7w9e/wcoWhFfvuIltEZh6TPoD5KKPD59IHiOSkBWUInraVFgtvvVDnpN/R/Vg5
         Dvtpud9uULsighUTjM8MGH/TCI5EXRWaSkhkk5UqUZd5FYg8gpvYCkAY1IZ3jlfKsYe5
         vxDg==
X-Gm-Message-State: AOAM531id7s/c2SncpS+JfTElyBOjAb5EsfaACv2KdZj3cfc0zcn/TbQ
        XfRuvN0HEsNoWGggO2HFYmgBTHn7Gyc=
X-Google-Smtp-Source: ABdhPJyOgR9wwId2Mk64JzdFmcZMJwN31Rur36SmFWPARwFcZ8PdfjCvHuB38aniN9W9IqJoK+dpCg==
X-Received: by 2002:a1c:1fc6:: with SMTP id f189mr21894227wmf.68.1615726979754;
        Sun, 14 Mar 2021 06:02:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm14913266wrt.68.2021.03.14.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 06:02:59 -0700 (PDT)
Message-Id: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
References: <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 13:02:57 +0000
Subject: [PATCH v3] [GSOC] commit: add --trailer option
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v2:

 1:  4c507d17db4f ! 1:  b4e161a98f8b [GSOC] commit: add trailer command
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] commit: add trailer command
     +    [GSOC] commit: add --trailer option
      
          Historically, Git has supported the 'Signed-off-by' commit trailer
          using the '--signoff' and the '-s' option from the command line.
     -    But users may need to provide richer trailer information from the
     +    But users may need to provide other trailer information from the
          command line such as "Helped-by", "Reported-by", "Mentored-by",
      
     -    Now use `--trailer <token>[(=|:)<value>]` pass the trailers to
     -    `interpret-trailers` and generate trailers in commit messages.
     +    Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
     +    other trailers to `interpret-trailers` and insert them into commit
     +    messages.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      


 Documentation/git-commit.txt |  8 +++++++-
 builtin/commit.c             | 18 ++++++++++++++++++
 t/t7502-commit-porcelain.sh  | 20 ++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..764513a3f287 100644
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
@@ -166,6 +166,12 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer. (e.g.  `git commit --trailer "Signed-off-by:C O Mitter <committer@example.com>" \
+	--trailer "Helped-by:C O Mitter <committer@example.com>"`will add the "Signed-off" trailer
+	and the "Helped-by" trailer in the commit message.)
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..abbd136b27f0 100644
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
@@ -131,6 +133,17 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
+static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
+{
+	if (unset) {
+		strvec_clear(&run_trailer.args);
+		return -1;
+	}
+	run_trailer.git_cmd = 1;
+	strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
+	return 0;
+}
+
 static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
 {
 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
@@ -958,6 +971,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	fclose(s->fp);
 
+	run_command(&run_trailer);
+
 	/*
 	 * Reject an attempt to record a non-merge empty commit without
 	 * explicit --allow-empty. In the cherry-pick case, it may be
@@ -1507,6 +1522,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
+		OPT_CALLBACK(0, "trailer", &trailer, N_("trailer"), N_("trailer(s) to add"), opt_pass_trailer),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
@@ -1577,6 +1593,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			die(_("could not parse HEAD commit"));
 	}
 	verbose = -1; /* unspecified */
+	strvec_pushl(&run_trailer.args, "interpret-trailers",
+		"--in-place", "--where=end", git_path_commit_editmsg(), NULL);
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 6396897cc818..4b9ac4587d17 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -154,6 +154,26 @@ test_expect_success 'sign off' '
 
 '
 
+test_expect_success 'trailer' '
+	>file1 &&
+	git add file1 &&
+	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
+	--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
+	--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
+	--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
+	-m "hello" &&
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
