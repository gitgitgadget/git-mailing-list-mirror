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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3F4C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D2D64E5C
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 07:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhCKHQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 02:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhCKHQL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 02:16:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8FC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 23:16:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so9193339wmj.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qcELzYo8FrEA+ihOtzhNw6apUY6pHKK8guTTFfk2Ud8=;
        b=ndPavnJSbBb/1KuMkxAMkBhM8fQrpmDOsEwUv4ZHCsMDiYSMXmn8Qtc/Kg8V/Wdm70
         OWsqRTs62UVWxoRmtBdZgMgc+KpunOQOPpvAukZU38qM2Lx8dYJmCcKhOlI1kOv2j4U5
         MfCq0LWEMQUYlxvKFFjvmFWzH7kHdGwBSET6B1hqMi3aO0A2Jo4kMmbQt6/TvvOq1urx
         5BFuGd1/c3E2JT9TB7MtEjGj1f0a2jX6B1PTCrV/7t/idK/+btYhZm/ws4rWdRll3Vbt
         Z1Uglcz0Pmknh2Rl8xneWRWYdsiYCZgFE8ZJVwNcmAFqxMq4u5a7m3MWvU3OrOc2airb
         uMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qcELzYo8FrEA+ihOtzhNw6apUY6pHKK8guTTFfk2Ud8=;
        b=Zdh4jwP1zobluCIvbCs4Exmb0AsP0vqxaoZtWVwhN7j3Dv9JQsoPXylwpyLV7uDHhT
         cOSLcABtc9vq/yezKR5/235GDBZBSOKCQiTCcylxvfgMRqesR/dqj6rCKZgF05SreSJc
         c8wf8nQc6z+YCyjIC+kbzLlLP3ZqGsNTtSN77K8utQJxwMBEjkPoyuf+xIXmpkBmneZc
         KHwI5Zo7SqGFbvfakc84SeggJgIdqXVQQJ7GNPgv3vGmYR+vgP8YJ69T0W0rwrYPZsGY
         MPEPKah9RyL6m9Rj21cPCtWfOivAwS6nsuyGu9oByokqPLASwi99tBTGWM1fCJbi0ujn
         rhhg==
X-Gm-Message-State: AOAM531ODx8A2pVkYO9oZpOTRy3x3vny9bmGMk+LqRZwRIjTxGnORG6A
        DaUCfiBRKqsK3jLGsim4JpEf7sBAT1M=
X-Google-Smtp-Source: ABdhPJwgwKz0ibtMM157wdnyB/EeREOwlkoMKQPtjjduPmoqi3jXH5Tzede3o4LCBE9xzR5ivWotjw==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr6758423wmg.7.1615446970045;
        Wed, 10 Mar 2021 23:16:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm2362005wrq.74.2021.03.10.23.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 23:16:09 -0800 (PST)
Message-Id: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 07:16:08 +0000
Subject: [PATCH] [GSOC] commit: provides multiple common signatures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Similar to "Helped-by", "Reported-by", "Reviewed-by", "Mentored-by"
these signatures are often seen in git commit messages. After
referring to the simple implementation of `commit --signoff`
and `send-email -cc=" commiter <email>"`, I am considering
whether to provide multiple signature parameters from the
command line. I think this might help maintainers and
developers directly uses the shell to provide these signatures
instead of multiple times repetitive writing those trailers
each time.

To achieve this goal, i refactored the `append_signoff` design and
provided `append_message` and `append_message_string_list` interfaces,
providing new ways to generate those various signatures.

Users now can use `commit -H "helper <eamil>"` to generate "Helped-by" trailer,
`commit -R "reviewer <eamil>"` to generate "Reviewed-by" trailer,
`commit -r "reporter <eamil> "`to generate "Reported-by" trailer,
`commit -M "mentor <eamil>"` to generate "Mentored-by" trailer.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] commit: provides multiple signatures from command line
    
    I don’t know if my idea will satisfy everyone, I'm also thinking about
    whether we can provide a more generalized version (I think this idea can
    be extended: because users and developers have other signature methods
    that they want, such as "Based-on-patch-by") I hope someone can give me
    pointers (on the correctness of ideas or codes)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/901

 Documentation/git-commit.txt |  24 +++++++-
 builtin/commit.c             |  63 +++++++++++++++++++++
 sequencer.c                  |  40 +++++++++----
 sequencer.h                  |   4 ++
 t/t7502-commit-porcelain.sh  | 106 +++++++++++++++++++++++++++++++++++
 5 files changed, 226 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..e1b528d70c1a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,7 +14,9 @@ SYNOPSIS
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	   [-S[<keyid>]] [--] [<pathspec>...]
+	   [-S[<keyid>]] [--] [<pathspec>...] [(-H|--helped-by)=<address>...]
+	   [(-R|--reviewed-by)=<address>...] [(-r|--reported-by)=<address>...]
+	   [(-M|--mentored)=<address>...]
 
 DESCRIPTION
 -----------
@@ -166,6 +168,26 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
+-H=<address>...::
+--helped-by=<address>...::
+	Add one or more `Helped-by` trailer by the committer at the end of the commit
+	log message.
+
+-R=<address>...::
+--reviewed-by=<address>...::
+	Add one or more `Reviewed-by` trailer by the committer at the end of the commit
+	log message.
+
+-r=<address>...::
+--reported-by=<address>...::
+	Add one or more `Reported-by` trailer by the committer at the end of the commit
+	log message.
+
+-M=<address>...::
+--mentored-by=<address>...::
+	Add one or more `Mentored-by` trailer by the committer at the end of the commit
+	log message.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..4b312af03181 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,6 +113,10 @@ static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit, *pathspec_from_file;
+static struct string_list helped_by = STRING_LIST_INIT_NODUP;
+static struct string_list mentored_by = STRING_LIST_INIT_NODUP;
+static struct string_list reviewed_by = STRING_LIST_INIT_NODUP;
+static struct string_list reported_by = STRING_LIST_INIT_NODUP;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -829,6 +833,20 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (signoff)
 		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
 
+	if(helped_by.items)
+		append_message_string_list(&sb, "Helped-by: ", &helped_by, ignore_non_trailer(sb.buf, sb.len), 0);
+	if(reviewed_by.items)
+		append_message_string_list(&sb, "Reviewed-by: ", &reviewed_by, ignore_non_trailer(sb.buf, sb.len), 0);
+	if(reported_by.items)
+		append_message_string_list(&sb, "Reported-by: ", &reported_by, ignore_non_trailer(sb.buf, sb.len), 0);
+	if(mentored_by.items)
+		append_message_string_list(&sb, "Mentored-by: ", &mentored_by, ignore_non_trailer(sb.buf, sb.len), 0);
+
+	string_list_clear(&helped_by, 0);
+	string_list_clear(&reviewed_by, 0);
+	string_list_clear(&reported_by, 0);
+	string_list_clear(&mentored_by, 0);
+
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
 
@@ -1490,6 +1508,42 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
+static int help_callback(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		string_list_clear(&helped_by, 0);
+	else
+		string_list_append(&helped_by, arg);
+	return 0;
+}
+
+static int review_callback(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		string_list_clear(&reviewed_by, 0);
+	else
+		string_list_append(&reviewed_by, arg);
+	return 0;
+}
+
+static int report_callback(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		string_list_clear(&reported_by, 0);
+	else
+		string_list_append(&reported_by, arg);
+	return 0;
+}
+
+static int mentor_callback(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		string_list_clear(&mentored_by, 0);
+	else
+		string_list_append(&mentored_by, arg);
+	return 0;
+}
+
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
@@ -1507,6 +1561,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
+		OPT_CALLBACK('H', "helped-by", NULL, N_("email"), N_("add a Helped-by trailer"), help_callback),
+		OPT_CALLBACK('r', "reported-by", NULL, N_("email"), N_("add a Reported-by trailer"), report_callback),
+		OPT_CALLBACK('R', "reviewed-by", NULL, N_("email"), N_("add a Reviewed-by trailer"), review_callback),
+		OPT_CALLBACK('M', "mentored-by", NULL, N_("email"), N_("add a Mentored-by trailer"), mentor_callback),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
@@ -1561,6 +1619,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 
+	helped_by.strdup_strings = 1;
+	reviewed_by.strdup_strings = 1;
+	reported_by.strdup_strings = 1;
+	mentored_by.strdup_strings = 1;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
diff --git a/sequencer.c b/sequencer.c
index d2332d3e1787..528daf9df252 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4668,16 +4668,12 @@ int sequencer_pick_revisions(struct repository *r,
 	return res;
 }
 
-void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
+void append_message(struct strbuf *msgbuf, struct strbuf *sob,
+			size_t ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
-	struct strbuf sob = STRBUF_INIT;
 	int has_footer;
 
-	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
-	strbuf_addch(&sob, '\n');
-
 	if (!ignore_footer)
 		strbuf_complete_line(msgbuf);
 
@@ -4685,11 +4681,11 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 	 * If the whole message buffer is equal to the sob, pretend that we
 	 * found a conforming footer with a matching sob
 	 */
-	if (msgbuf->len - ignore_footer == sob.len &&
-	    !strncmp(msgbuf->buf, sob.buf, sob.len))
+	if (msgbuf->len - ignore_footer == sob->len &&
+	    !strncmp(msgbuf->buf, sob->buf, sob->len))
 		has_footer = 3;
 	else
-		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
+		has_footer = has_conforming_footer(msgbuf, sob, ignore_footer);
 
 	if (!has_footer) {
 		const char *append_newlines = NULL;
@@ -4723,8 +4719,32 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 
 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-				sob.buf, sob.len);
+				sob->buf, sob->len);
+}
+
+void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
+{
+	struct strbuf sob = STRBUF_INIT;
+	strbuf_addstr(&sob, sign_off_header);
+	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
+	strbuf_addch(&sob, '\n');
+	append_message(msgbuf, &sob, ignore_footer, flag);
+	strbuf_release(&sob);
+}
 
+void append_message_string_list(struct strbuf *msgbuf, const char *header,
+		struct string_list *sobs, size_t ignore_footer, unsigned flag) {
+	int i;
+	struct strbuf sob = STRBUF_INIT;
+
+	for ( i = 0; i < sobs->nr; i++)
+	{
+		strbuf_addstr(&sob, header);
+		strbuf_addstr(&sob, sobs->items[i].string);
+		strbuf_addch(&sob, '\n');
+		append_message(msgbuf, &sob, ignore_footer, flag);
+		strbuf_reset(&sob);
+	}
 	strbuf_release(&sob);
 }
 
diff --git a/sequencer.h b/sequencer.h
index f8b2e4ab8527..b24e274f4c62 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -174,6 +174,10 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
  * and the new signoff will be spliced into the buffer before those bytes.
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
+void append_message(struct strbuf *msgbuf, struct strbuf *sob,
+		size_t ignore_footer, unsigned flag);
+void append_message_string_list(struct strbuf *msgbuf, const char*header,
+		struct string_list *sobs, size_t ignore_footer, unsigned flag);
 
 void append_conflicts_hint(struct index_state *istate,
 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 6396897cc818..40823152a51c 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -154,6 +154,112 @@ test_expect_success 'sign off' '
 
 '
 
+test_expect_success 'helped-by' '
+
+	>file1 &&
+	git add file1 &&
+	git commit --helped-by="foo <bar@frotz>" \
+	--helped-by="foo2 <bar2@frotz>" -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Helped-by: //p" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	foo <bar@frotz>
+	foo2 <bar2@frotz>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'reported-by' '
+
+	>file2 &&
+	git add file2 &&
+	git commit --reported-by="foo <bar@frotz>" \
+	--reported-by="foo2 <bar2@frotz>" -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Reported-by: //p" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	foo <bar@frotz>
+	foo2 <bar2@frotz>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'reviewed-by' '
+
+	>file3 &&
+	git add file3 &&
+	git commit --reviewed-by="foo <bar@frotz>" \
+	--reviewed-by="foo2 <bar2@frotz>" -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Reviewed-by: //p" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	foo <bar@frotz>
+	foo2 <bar2@frotz>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'mentored-by' '
+
+	>file4 &&
+	git add file4 &&
+	git commit --mentored-by="foo <bar@frotz>" \
+	--mentored-by="foo2 <bar2@frotz>" -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Mentored-by: //p" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	foo <bar@frotz>
+	foo2 <bar2@frotz>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'multiple signatures' '
+
+	>file5 &&
+	git add file5 &&
+	git commit --helped-by="foo <bar@frotz>" \
+	--reviewed-by="foo2 <bar2@frotz>" \
+	--mentored-by="foo3 <bar3@frotz>" \
+	--reported-by="foo4 <bar4@frotz>" -s -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,7d" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	Signed-off-by: C O Mitter <committer@example.com>
+	Helped-by: foo <bar@frotz>
+	Reviewed-by: foo2 <bar2@frotz>
+	Reported-by: foo4 <bar4@frotz>
+	Mentored-by: foo3 <bar3@frotz>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'multiple signatures (use abbreviations)' '
+
+	>file6 &&
+	git add file6 &&
+	git commit -H "foo <bar@frotz>" \
+	-R "foo2 <bar2@frotz>" \
+	-M "foo3 <bar3@frotz>" \
+	-r "foo4 <bar4@frotz>" -s -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,7d" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	Signed-off-by: C O Mitter <committer@example.com>
+	Helped-by: foo <bar@frotz>
+	Reviewed-by: foo2 <bar2@frotz>
+	Reported-by: foo4 <bar4@frotz>
+	Mentored-by: foo3 <bar3@frotz>
+	EOF
+	test_cmp expected actual
+
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&

base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
-- 
gitgitgadget
