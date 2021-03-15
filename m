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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E15C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 09:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE2461481
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 09:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCOJI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCOJI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 05:08:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C03CC061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 02:08:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o14so4455039wrm.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QKmeV7LxIukhqE9KmCPzabXxsEjsiM1mP7wIJGygdVY=;
        b=eu6JoTAqPC0EzsmMHmW7E/uHjzjLbueudEQNFDh2/bB1kXq9HqZ+JGF931Syns/aql
         WTKbR9w2sMSM2+acu6K1RX/cmf81Pb2lmmwWAh+Vf4FHDPS1Negcz49gHvi+wpT/TBPS
         YgDQ1zZThSkOqOKM72D6uDQ7LJ1nrz1ulLjSj2oAEtNV1dJdx3L7JLuLBsK1TrIlOyiU
         Hfykx3IQylB2kBXzYjq7PRw0hK9qgHnwUOWWOgOAc5XhC25jLYdOipFgDvIR8bqibWOe
         MrsYIVOv/+nT1po+4caiqbrQ7ws7DQmhKelWVvN1LezXvmvvYcBcB450ttGh9CRmKA0n
         04Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QKmeV7LxIukhqE9KmCPzabXxsEjsiM1mP7wIJGygdVY=;
        b=OAyDBFbAcaAofWBnW0/EBcrmr9XIPawURPbzorxYsJWER/Q6LzuvumtX3wVVpYwX71
         F520fA70st6zmcvlwC3MTTXuiTvhtFHNJKu4Vwxm/8A07ikcvjBrwPnCJRrWtubNQCqm
         qdFCNKCL8NeRRCfmHY/G9Z3PYsBIu6dbzDmiIR8AWyP2PAZVwvSwkPb1Q2nbi2+rjnGB
         HaOeMMFfjM18Kvsoq4Jw0iz1oY/EJPzEr0Y6f4W7Jk1TtSCpghGc09oQfxhIXbOaiho0
         n76B1U2D5DVYuR9bWgVOnRObYMJoCgh6TdQK4O6r2HaUEbC+NuwA21XG7jntpVTT+C4B
         tyOw==
X-Gm-Message-State: AOAM533hb42o62JQsugyBEYd0k/ITFkDyew3rcJlM3e2rma0lgCghbjv
        re5xLdgtv3Hf3q+GwjzNFBDPsT7IJII=
X-Google-Smtp-Source: ABdhPJykqOssQNs9Qcg+Pz+LypUuBbNn7fYzLdXf4XT5KHaYC9mnNP1VARQgMIc+uL9a4Y+JRsfrzQ==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr26719629wrt.294.1615799306138;
        Mon, 15 Mar 2021 02:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm11727075wmh.13.2021.03.15.02.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 02:08:25 -0700 (PDT)
Message-Id: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
References: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 09:08:24 +0000
Subject: [PATCH v7] [GSOC] commit: add --trailer option
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v6:

 1:  c99ce75da792 ! 1:  3ce8e8cac24a [GSOC] commit: add --trailer option
     @@ builtin/commit.c: static int config_commit_verbose = -1; /* unspecified */
       static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
       static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
       static char *sign_commit, *pathspec_from_file;
     -+struct strvec trailer_args = STRVEC_INIT;
     ++static struct strvec trailer_args = STRVEC_INIT;
       
       /*
        * The default commit message cleanup mode will remove the lines
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       	fclose(s->fp);
       
      +	if (trailer_args.nr) {
     -+		static struct child_process run_trailer = CHILD_PROCESS_INIT;
     ++		struct child_process run_trailer = CHILD_PROCESS_INIT;
      +
      +		strvec_pushl(&run_trailer.args, "interpret-trailers",
      +			     "--in-place", "--where=end", git_path_commit_editmsg(), NULL);


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
index 739110c5a7f6..0ddd1891f71c 100644
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
