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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E33C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F0264FF5
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhCLPyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhCLPyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 10:54:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1722C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 07:54:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o16so2047553wrn.0
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 07:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YBwWwCGWIjAvxFMibz47DGr0JzvhnWGETqvHQNUa8uw=;
        b=mCkMLNWXmBIFTyZb8Ov+xcXLFCz5VZsfmW4Gg1dP5Dt+xTmi1lupfoYM772qWhArwV
         lfnlUC5GE0Ze/r/zu/jLl5XdPp4f7IC2sN8P2xrBDKkvT5JOjBFeEbPetnA8frHMvcT+
         +Lut1Q/5FxNP7JpJfAb2svotrSaONGwro38kbKBoM6vL5l1MrJczRenB4UoBb9SBND7N
         b8PDFXjYortAowldg25a3KR2RoGwLfiA47ARCjiEIKkQbEnsqFOSV12a4wIzDcOdsMRL
         W2Fh3TDAJgApzIQSwx+hPvkx4QImY9NFDFASbuzQhZ6LpCMGFEMR6A9hrF3tgwTyff9t
         HN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YBwWwCGWIjAvxFMibz47DGr0JzvhnWGETqvHQNUa8uw=;
        b=h2+iaM8kscV88qTnA44u4WTTvTGTrtulDsUz/Oi7T72x7XRw5zzJFfp1NBUNUn4yKo
         Xr2UAVVXpCd7mMxjAOy92HLVoT5q0BIdKBusN6cq9iqYumyo2bN+a+LOMQC3DxW1OBwH
         VQSiwmI0GFxkhZKDo18H7ztZLEAslC19CZSXwGmh74JfjD6nIZgiUDjoS6Q35Zh6eviw
         PCEv1tr33StGSusVsu7dnNueR1h4Ax/4Ke+DgFbt2P+E9ScGKkoNmo7J6r6dCrZ3T1rt
         ewsD3qylA004Qpl27xbQQ1SAqdQSAIjkhXLFXyGuCRpGLCShO3nipc6ebw/TMj5jonEf
         S9Jw==
X-Gm-Message-State: AOAM532ADTSryTuS+HEG97KrB2n9F2qNtKN84P1+NcUexi1NYarwiwTk
        QSWUYTeRyOS3aoj2PP3pFvOA9phZ5pk=
X-Google-Smtp-Source: ABdhPJw2EN4lRHNRs00TAj2YT036RH9e/8zqRvkfDOVZ6Ax3KhOs+oMlwdI/2bgY6mOGY43V3KHmGg==
X-Received: by 2002:adf:ebc9:: with SMTP id v9mr14970507wrn.387.1615564479232;
        Fri, 12 Mar 2021 07:54:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d29sm8087964wra.51.2021.03.12.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:54:38 -0800 (PST)
Message-Id: <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 15:54:37 +0000
Subject: [PATCH v2] [GSOC] commit: add trailer command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Historically, Git has supported the 'Signed-off-by' commit trailer
using the '--signoff' and the '-s' option from the command line.
But users may need to provide richer trailer information from the
command line such as "Helped-by", "Reported-by", "Mentored-by",

Now use `--trailer <token>[(=|:)<value>]` pass the trailers to
`interpret-trailers` and generate trailers in commit messages.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] commit: provides multiple signatures from command line
    
    Now maintainers or developers can also use commit
    --trailer="Signed-off-by:commiter<email>" from the command line to
    provide trailers to commit messages. This solution may be more
    generalized than v1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v1:

 1:  e9389e72ac65 ! 1:  4c507d17db4f [GSOC] commit: provides multiple common signatures
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] commit: provides multiple common signatures
     +    [GSOC] commit: add trailer command
      
     -    Similar to "Helped-by", "Reported-by", "Reviewed-by", "Mentored-by"
     -    these signatures are often seen in git commit messages. After
     -    referring to the simple implementation of `commit --signoff`
     -    and `send-email -cc=" commiter <email>"`, I am considering
     -    whether to provide multiple signature parameters from the
     -    command line. I think this might help maintainers and
     -    developers directly uses the shell to provide these signatures
     -    instead of multiple times repetitive writing those trailers
     -    each time.
     +    Historically, Git has supported the 'Signed-off-by' commit trailer
     +    using the '--signoff' and the '-s' option from the command line.
     +    But users may need to provide richer trailer information from the
     +    command line such as "Helped-by", "Reported-by", "Mentored-by",
      
     -    To achieve this goal, i refactored the `append_signoff` design and
     -    provided `append_message` and `append_message_string_list` interfaces,
     -    providing new ways to generate those various signatures.
     -
     -    Users now can use `commit -H "helper <eamil>"` to generate "Helped-by" trailer,
     -    `commit -R "reviewer <eamil>"` to generate "Reviewed-by" trailer,
     -    `commit -r "reporter <eamil> "`to generate "Reported-by" trailer,
     -    `commit -M "mentor <eamil>"` to generate "Mentored-by" trailer.
     +    Now use `--trailer <token>[(=|:)<value>]` pass the trailers to
     +    `interpret-trailers` and generate trailers in commit messages.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-commit.txt: SYNOPSIS
       	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
       	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
      -	   [-S[<keyid>]] [--] [<pathspec>...]
     -+	   [-S[<keyid>]] [--] [<pathspec>...] [(-H|--helped-by)=<address>...]
     -+	   [(-R|--reviewed-by)=<address>...] [(-r|--reported-by)=<address>...]
     -+	   [(-M|--mentored)=<address>...]
     ++	   [-S[<keyid>]] [--] [<pathspec>...] [(--trailer <token>[(=|:)<value>])...]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `
       
       include::signoff-option.txt[]
       
     -+-H=<address>...::
     -+--helped-by=<address>...::
     -+	Add one or more `Helped-by` trailer by the committer at the end of the commit
     -+	log message.
     -+
     -+-R=<address>...::
     -+--reviewed-by=<address>...::
     -+	Add one or more `Reviewed-by` trailer by the committer at the end of the commit
     -+	log message.
     -+
     -+-r=<address>...::
     -+--reported-by=<address>...::
     -+	Add one or more `Reported-by` trailer by the committer at the end of the commit
     -+	log message.
     -+
     -+-M=<address>...::
     -+--mentored-by=<address>...::
     -+	Add one or more `Mentored-by` trailer by the committer at the end of the commit
     -+	log message.
     ++--trailer <token>[(=|:)<value>]::
     ++	Specify a (<token>, <value>) pair that should be applied as a
     ++	trailer. (e.g.  `git commit --trailer "Signed-off-by:C O Mitter <committer@example.com>" \
     ++	--trailer "Helped-by:C O Mitter <committer@example.com>"`will add the "Signed-off" trailer
     ++	and the "Helped-by" trailer in the commit message.)
      +
       -n::
       --no-verify::
     @@ builtin/commit.c: static int config_commit_verbose = -1; /* unspecified */
       static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
       static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
       static char *sign_commit, *pathspec_from_file;
     -+static struct string_list helped_by = STRING_LIST_INIT_NODUP;
     -+static struct string_list mentored_by = STRING_LIST_INIT_NODUP;
     -+static struct string_list reviewed_by = STRING_LIST_INIT_NODUP;
     -+static struct string_list reported_by = STRING_LIST_INIT_NODUP;
     ++struct child_process run_trailer = CHILD_PROCESS_INIT;
     ++static const char *trailer;
       
       /*
        * The default commit message cleanup mode will remove the lines
     -@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     - 	if (signoff)
     - 		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
     - 
     -+	if(helped_by.items)
     -+		append_message_string_list(&sb, "Helped-by: ", &helped_by, ignore_non_trailer(sb.buf, sb.len), 0);
     -+	if(reviewed_by.items)
     -+		append_message_string_list(&sb, "Reviewed-by: ", &reviewed_by, ignore_non_trailer(sb.buf, sb.len), 0);
     -+	if(reported_by.items)
     -+		append_message_string_list(&sb, "Reported-by: ", &reported_by, ignore_non_trailer(sb.buf, sb.len), 0);
     -+	if(mentored_by.items)
     -+		append_message_string_list(&sb, "Mentored-by: ", &mentored_by, ignore_non_trailer(sb.buf, sb.len), 0);
     -+
     -+	string_list_clear(&helped_by, 0);
     -+	string_list_clear(&reviewed_by, 0);
     -+	string_list_clear(&reported_by, 0);
     -+	string_list_clear(&mentored_by, 0);
     -+
     - 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
     - 		die_errno(_("could not write commit template"));
     +@@ builtin/commit.c: static struct strbuf message = STRBUF_INIT;
       
     -@@ builtin/commit.c: static int git_commit_config(const char *k, const char *v, void *cb)
     - 	return git_status_config(k, v, s);
     - }
     + static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
       
     -+static int help_callback(const struct option *opt, const char *arg, int unset)
     -+{
     -+	if (unset)
     -+		string_list_clear(&helped_by, 0);
     -+	else
     -+		string_list_append(&helped_by, arg);
     -+	return 0;
     -+}
     -+
     -+static int review_callback(const struct option *opt, const char *arg, int unset)
     ++static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
      +{
     -+	if (unset)
     -+		string_list_clear(&reviewed_by, 0);
     -+	else
     -+		string_list_append(&reviewed_by, arg);
     -+	return 0;
     -+}
     -+
     -+static int report_callback(const struct option *opt, const char *arg, int unset)
     -+{
     -+	if (unset)
     -+		string_list_clear(&reported_by, 0);
     -+	else
     -+		string_list_append(&reported_by, arg);
     -+	return 0;
     -+}
     -+
     -+static int mentor_callback(const struct option *opt, const char *arg, int unset)
     -+{
     -+	if (unset)
     -+		string_list_clear(&mentored_by, 0);
     -+	else
     -+		string_list_append(&mentored_by, arg);
     ++	if (unset) {
     ++		strvec_clear(&run_trailer.args);
     ++		return -1;
     ++	}
     ++	run_trailer.git_cmd = 1;
     ++	strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
      +	return 0;
      +}
      +
     - int cmd_commit(int argc, const char **argv, const char *prefix)
     + static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
       {
     - 	static struct wt_status s;
     + 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
     +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     + 
     + 	fclose(s->fp);
     + 
     ++	run_command(&run_trailer);
     ++
     + 	/*
     + 	 * Reject an attempt to record a non-merge empty commit without
     + 	 * explicit --allow-empty. In the cherry-pick case, it may be
      @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix)
       		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
       		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
       		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
     -+		OPT_CALLBACK('H', "helped-by", NULL, N_("email"), N_("add a Helped-by trailer"), help_callback),
     -+		OPT_CALLBACK('r', "reported-by", NULL, N_("email"), N_("add a Reported-by trailer"), report_callback),
     -+		OPT_CALLBACK('R', "reviewed-by", NULL, N_("email"), N_("add a Reviewed-by trailer"), review_callback),
     -+		OPT_CALLBACK('M', "mentored-by", NULL, N_("email"), N_("add a Mentored-by trailer"), mentor_callback),
     ++		OPT_CALLBACK(0, "trailer", &trailer, N_("trailer"), N_("trailer(s) to add"), opt_pass_trailer),
       		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
       		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
       		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
      @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix)
     - 	struct commit_extra_header *extra = NULL;
     - 	struct strbuf err = STRBUF_INIT;
     - 
     -+	helped_by.strdup_strings = 1;
     -+	reviewed_by.strdup_strings = 1;
     -+	reported_by.strdup_strings = 1;
     -+	mentored_by.strdup_strings = 1;
     -+
     - 	if (argc == 2 && !strcmp(argv[1], "-h"))
     - 		usage_with_options(builtin_commit_usage, builtin_commit_options);
     - 
     -
     - ## sequencer.c ##
     -@@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
     - 	return res;
     - }
     - 
     --void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
     -+void append_message(struct strbuf *msgbuf, struct strbuf *sob,
     -+			size_t ignore_footer, unsigned flag)
     - {
     - 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
     --	struct strbuf sob = STRBUF_INIT;
     - 	int has_footer;
     - 
     --	strbuf_addstr(&sob, sign_off_header);
     --	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
     --	strbuf_addch(&sob, '\n');
     --
     - 	if (!ignore_footer)
     - 		strbuf_complete_line(msgbuf);
     - 
     -@@ sequencer.c: void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
     - 	 * If the whole message buffer is equal to the sob, pretend that we
     - 	 * found a conforming footer with a matching sob
     - 	 */
     --	if (msgbuf->len - ignore_footer == sob.len &&
     --	    !strncmp(msgbuf->buf, sob.buf, sob.len))
     -+	if (msgbuf->len - ignore_footer == sob->len &&
     -+	    !strncmp(msgbuf->buf, sob->buf, sob->len))
     - 		has_footer = 3;
     - 	else
     --		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
     -+		has_footer = has_conforming_footer(msgbuf, sob, ignore_footer);
     - 
     - 	if (!has_footer) {
     - 		const char *append_newlines = NULL;
     -@@ sequencer.c: void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
     - 
     - 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
     - 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
     --				sob.buf, sob.len);
     -+				sob->buf, sob->len);
     -+}
     -+
     -+void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
     -+{
     -+	struct strbuf sob = STRBUF_INIT;
     -+	strbuf_addstr(&sob, sign_off_header);
     -+	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
     -+	strbuf_addch(&sob, '\n');
     -+	append_message(msgbuf, &sob, ignore_footer, flag);
     -+	strbuf_release(&sob);
     -+}
     - 
     -+void append_message_string_list(struct strbuf *msgbuf, const char *header,
     -+		struct string_list *sobs, size_t ignore_footer, unsigned flag) {
     -+	int i;
     -+	struct strbuf sob = STRBUF_INIT;
     -+
     -+	for ( i = 0; i < sobs->nr; i++)
     -+	{
     -+		strbuf_addstr(&sob, header);
     -+		strbuf_addstr(&sob, sobs->items[i].string);
     -+		strbuf_addch(&sob, '\n');
     -+		append_message(msgbuf, &sob, ignore_footer, flag);
     -+		strbuf_reset(&sob);
     -+	}
     - 	strbuf_release(&sob);
     - }
     - 
     -
     - ## sequencer.h ##
     -@@ sequencer.h: int todo_list_rearrange_squash(struct todo_list *todo_list);
     -  * and the new signoff will be spliced into the buffer before those bytes.
     -  */
     - void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
     -+void append_message(struct strbuf *msgbuf, struct strbuf *sob,
     -+		size_t ignore_footer, unsigned flag);
     -+void append_message_string_list(struct strbuf *msgbuf, const char*header,
     -+		struct string_list *sobs, size_t ignore_footer, unsigned flag);
     - 
     - void append_conflicts_hint(struct index_state *istate,
     - 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
     + 			die(_("could not parse HEAD commit"));
     + 	}
     + 	verbose = -1; /* unspecified */
     ++	strvec_pushl(&run_trailer.args, "interpret-trailers",
     ++		"--in-place", "--where=end", git_path_commit_editmsg(), NULL);
     + 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
     + 					  builtin_commit_usage,
     + 					  prefix, current_head, &s);
      
       ## t/t7502-commit-porcelain.sh ##
      @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
       
       '
       
     -+test_expect_success 'helped-by' '
     -+
     ++test_expect_success 'trailer' '
      +	>file1 &&
      +	git add file1 &&
     -+	git commit --helped-by="foo <bar@frotz>" \
     -+	--helped-by="foo2 <bar2@frotz>" -m "thank you" &&
     -+	git cat-file commit HEAD >commit.msg &&
     -+	sed -ne "s/Helped-by: //p" commit.msg >actual &&
     -+	cat >expected <<-\EOF &&
     -+	foo <bar@frotz>
     -+	foo2 <bar2@frotz>
     -+	EOF
     -+	test_cmp expected actual
     -+
     -+'
     -+
     -+test_expect_success 'reported-by' '
     -+
     -+	>file2 &&
     -+	git add file2 &&
     -+	git commit --reported-by="foo <bar@frotz>" \
     -+	--reported-by="foo2 <bar2@frotz>" -m "thank you" &&
     -+	git cat-file commit HEAD >commit.msg &&
     -+	sed -ne "s/Reported-by: //p" commit.msg >actual &&
     -+	cat >expected <<-\EOF &&
     -+	foo <bar@frotz>
     -+	foo2 <bar2@frotz>
     -+	EOF
     -+	test_cmp expected actual
     -+
     -+'
     -+
     -+test_expect_success 'reviewed-by' '
     -+
     -+	>file3 &&
     -+	git add file3 &&
     -+	git commit --reviewed-by="foo <bar@frotz>" \
     -+	--reviewed-by="foo2 <bar2@frotz>" -m "thank you" &&
     -+	git cat-file commit HEAD >commit.msg &&
     -+	sed -ne "s/Reviewed-by: //p" commit.msg >actual &&
     -+	cat >expected <<-\EOF &&
     -+	foo <bar@frotz>
     -+	foo2 <bar2@frotz>
     -+	EOF
     -+	test_cmp expected actual
     -+
     -+'
     -+
     -+test_expect_success 'mentored-by' '
     -+
     -+	>file4 &&
     -+	git add file4 &&
     -+	git commit --mentored-by="foo <bar@frotz>" \
     -+	--mentored-by="foo2 <bar2@frotz>" -m "thank you" &&
     -+	git cat-file commit HEAD >commit.msg &&
     -+	sed -ne "s/Mentored-by: //p" commit.msg >actual &&
     -+	cat >expected <<-\EOF &&
     -+	foo <bar@frotz>
     -+	foo2 <bar2@frotz>
     -+	EOF
     -+	test_cmp expected actual
     -+
     -+'
     -+
     -+test_expect_success 'multiple signatures' '
     -+
     -+	>file5 &&
     -+	git add file5 &&
     -+	git commit --helped-by="foo <bar@frotz>" \
     -+	--reviewed-by="foo2 <bar2@frotz>" \
     -+	--mentored-by="foo3 <bar3@frotz>" \
     -+	--reported-by="foo4 <bar4@frotz>" -s -m "thank you" &&
     ++	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
     ++	--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
     ++	--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
     ++	--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
     ++	-m "hello" &&
      +	git cat-file commit HEAD >commit.msg &&
      +	sed -e "1,7d" commit.msg >actual &&
      +	cat >expected <<-\EOF &&
      +	Signed-off-by: C O Mitter <committer@example.com>
     -+	Helped-by: foo <bar@frotz>
     -+	Reviewed-by: foo2 <bar2@frotz>
     -+	Reported-by: foo4 <bar4@frotz>
     -+	Mentored-by: foo3 <bar3@frotz>
     ++	Signed-off-by: C O Mitter1 <committer1@example.com>
     ++	Helped-by: C O Mitter2 <committer2@example.com>
     ++	Reported-by: C O Mitter3 <committer3@example.com>
     ++	Mentored-by: C O Mitter4 <committer4@example.com>
      +	EOF
      +	test_cmp expected actual
     -+
     -+'
     -+
     -+test_expect_success 'multiple signatures (use abbreviations)' '
     -+
     -+	>file6 &&
     -+	git add file6 &&
     -+	git commit -H "foo <bar@frotz>" \
     -+	-R "foo2 <bar2@frotz>" \
     -+	-M "foo3 <bar3@frotz>" \
     -+	-r "foo4 <bar4@frotz>" -s -m "thank you" &&
     -+	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,7d" commit.msg >actual &&
     -+	cat >expected <<-\EOF &&
     -+	Signed-off-by: C O Mitter <committer@example.com>
     -+	Helped-by: foo <bar@frotz>
     -+	Reviewed-by: foo2 <bar2@frotz>
     -+	Reported-by: foo4 <bar4@frotz>
     -+	Mentored-by: foo3 <bar3@frotz>
     -+	EOF
     -+	test_cmp expected actual
     -+
      +'
      +
       test_expect_success 'multiple -m' '


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
