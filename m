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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF449C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14FB64EE7
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCONH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCONHl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 09:07:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D64DC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:07:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v11so5659214wro.7
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=caLVwHBpgWu1zvPFyEdGbv/V0a45YmDYIOfz36LdHW0=;
        b=YRwcYluiYCMObFupj3v9LQ2Bf6H4nUaIhL0VRCYY6R4lDFPBPhLMt1Jl9Trb0RPbCb
         NyDibJpqbXsOjMJ+zGV+vYF+OgOq6w4UF4gSo11lENjWKp/E7TrRFPuqWrhFPM0NeCtw
         TdPzyBiliGcm06jT6nGW61xvXIDMRiz0vw+2lJpZr8pEq198FvXpAezanQevP9It+KMR
         rfl59DnVyeKDZGRMuz27G0aDhxdLFmS9qeABaTGnrQHfP0mCW0X4qVNGah72gJl3w6qp
         zrjuc5+O7KhGQgQmDF+NuAORJBBjlzkwOBzNQEzzsEMcxfgNMKVJ1+uKk+F0Fl4ttqOU
         e+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=caLVwHBpgWu1zvPFyEdGbv/V0a45YmDYIOfz36LdHW0=;
        b=fIPuI3FEhbm3FhnADUn7/xIJIClxs7Jnldx6tGg4NtHMhWSHKOPbl5nhIcxHfG4U06
         qXPRzycUNHbxQj2WU9JJonxhfW8nqSztigLt0t2abUUOzBhmaX33E+WPC5gD3JZwml1S
         LG0v/oKm9E3pH6oe3idvqUWBamY3bK1HKTYkfKuebGdoqA3eQdkWfbYxenhP7RWw3X3K
         KEzAwOqMEkr7/WKOa+TZszvGIo0uzpw+2I5HDGVSvFH24lFpBghnqcsEVPmZtuFWG/Jb
         WfbHI7AkoFFk246H+CD7Vvz8Vs+n03nqkyOL4LFFpdPlvKF0AKL3ArPo61UO31I2ZVvZ
         CFCA==
X-Gm-Message-State: AOAM533OwK1UWNCCG6oVZiIzyKgtt2HOpUb/894oIUH+QZUZZLqIfho0
        3cwV0gM5HLjlcxoqqaQfvMEK3YUg/70=
X-Google-Smtp-Source: ABdhPJxoH8xKTWN35fcqsLxZc3eCgpbCBq6Y7craWW8SY2xRslbLB6fY+x8cxfcFAmYcmf9oUOUtzg==
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr26526380wrs.34.1615813659929;
        Mon, 15 Mar 2021 06:07:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm19153363wrx.43.2021.03.15.06.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:07:39 -0700 (PDT)
Message-Id: <f81b6e66a6ba6b2fc8e6307dbc5fba9cddcff181.1615813658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
        <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 13:07:36 +0000
Subject: [PATCH v8 1/2] [GSOC] commit: add --trailer option
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
 Documentation/git-commit.txt |  9 ++++++++-
 builtin/commit.c             | 23 +++++++++++++++++++++++
 t/t7502-commit-porcelain.sh  | 20 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

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
index 739110c5a7f6..250e93d977df 100644
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
+			     "--in-place", "--if-exists=add",
+			     git_path_commit_editmsg(), NULL);
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
@@ -1507,6 +1529,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
-- 
gitgitgadget

