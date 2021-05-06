Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0769C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989CD61176
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhEFPDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhEFPDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684DC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa21-20020a17090af0d5b0290157eb6b590fso3623886pjb.5
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02HX2RHT0/A9nDNttMjYUKL1zS2m8nzVpQr1kN+YZ0w=;
        b=qsOVqBVwL/ex3KdZWRU5tAOl0gAO1EcRZjfZ5ra4R0jtvvzygPHltgD7btzbjTlk2e
         tvuccKXNwl24clZcLSyEdbeSC7ABVwHF7MdBUtU6BJyUR3Y9W6dEwgPcj3jUoWUe1s3/
         wCLHc1h7gyszaLH5DkZitwt5+IfIWOY0PKG15l5VuARWlqd17VIxb2MhJZpLPgBysTcH
         3H3YrwrK3Ncz8dZOyfXG+62wrlJDmIGyZFo/4gJfq3s4v2Pmc8q3ZNekRcSgukM7ww2h
         UQwsVdPFoFzVSkEKnxNebwnlJjZ0BzhdNqtGSPusZCSuoTvN0BkGOfciKSuTSXOAjRYZ
         y/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02HX2RHT0/A9nDNttMjYUKL1zS2m8nzVpQr1kN+YZ0w=;
        b=e0A6xJ67nOnuX6vXTU/I+odWjR0d9z+cRNDfMDf9cGqCVRJCwv1rYsKfitlZM4Jp7F
         TV+9InXf/Jur17La/QdHd5ur5tk5eYmRwXqZNZf38U6HFzGglhVag8lkqXDcL2GY75Pf
         WqRCsDuIOmts6TnoCnu0HwAUlyyKJ4OWJCB3r52IbQANGbiVuMnqxqeFdQ9HNV/Dadwn
         dENFndgQ8b07da8Ig+Pii8v1LJx1Xsb7jiOhXWHWXahNTthMKpN6oSHclPAYuyToroIP
         CPKHShrzJhCkefEEx0f0w1xTMUR00neOYN7ufXUePiK3wZqhoR3GQa+xPh1DGKbasnOh
         zSCw==
X-Gm-Message-State: AOAM533dM4CojIZCKMyt76BcC4/SnNSINKZTgqRYjzTLNDWltECjP7lo
        lSvd9htSzYLC7uJm+ttS1VHIkFLK9srRzg==
X-Google-Smtp-Source: ABdhPJzgnVuggMI2gg4W82egsgqzw6hApLltBcmSsyO2VgcdvlgizEOmLFibpyCe5RE6nGaZTnJWWg==
X-Received: by 2002:a17:90a:c782:: with SMTP id gn2mr5027106pjb.94.1620313353968;
        Thu, 06 May 2021 08:02:33 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:33 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/6] Teach am/mailinfo to process quoted CR
Date:   Thu,  6 May 2021 22:02:17 +0700
Message-Id: <cover.1620311544.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <20210421013404.17383-1-congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When SMTP servers receive 8-bit email messages, possibly with only
LF as line ending, some of those servers decide to change said LF to
CRLF.

Some mailing list software, when receives an 8-bit email message,
decide to encode such message in base64 or quoted-printable.

This series try to help users of such softwares deal with such patches.

Change from v2:
* Change preparatory step (in mailinfo) to use parse_options
* move "have_quoted_cr" to "struct mailinfo", thus the patch to warn about
  quoted CR is less weird.
* Change "mailinfo_parse_quoted_cr" to Git's do-some-work function, return
  0 on success and negative on failure, eliminate the usage of _invalid_action
* Better error messages if invalid action was given.
* completion support for git am --quoted-cr
* Some style changes


Đoàn Trần Công Danh (6):
  mailinfo: load default metainfo_charset lazily
  mailinfo: stop parsing options manually
  mailinfo: warn if CR found in decoded base64/QP email
  mailinfo: allow squelching quoted CR warning
  mailinfo: allow stripping quoted CR without warning
  am: learn to process quoted lines that ends with CRLF

 Documentation/git-am.txt               |   4 +
 Documentation/git-mailinfo.txt         |  21 ++++-
 builtin/am.c                           |  51 +++++++++++
 builtin/mailinfo.c                     | 115 ++++++++++++++++++-------
 contrib/completion/git-completion.bash |   5 ++
 mailinfo.c                             |  39 +++++++++
 mailinfo.h                             |  10 +++
 t/t4258-am-quoted-cr.sh                |  37 ++++++++
 t/t4258/mbox                           |  12 +++
 t/t5100-mailinfo.sh                    |  21 +++++
 t/t5100/quoted-cr-info                 |   5 ++
 t/t5100/quoted-cr-msg                  |   2 +
 t/t5100/quoted-cr-patch                |  22 +++++
 t/t5100/quoted-cr.mbox                 |  22 +++++
 14 files changed, 332 insertions(+), 34 deletions(-)
 create mode 100755 t/t4258-am-quoted-cr.sh
 create mode 100644 t/t4258/mbox
 create mode 100644 t/t5100/quoted-cr-info
 create mode 100644 t/t5100/quoted-cr-msg
 create mode 100644 t/t5100/quoted-cr-patch
 create mode 100644 t/t5100/quoted-cr.mbox

Range-diff against v2:
1:  5b1cab5f95 < -:  ---------- mailinfo: avoid magic number in option parsing
-:  ---------- > 1:  fac95392df mailinfo: load default metainfo_charset lazily
-:  ---------- > 2:  1fb08bb37d mailinfo: stop parsing options manually
2:  534183c458 ! 3:  5aac2ba38e mailinfo: warn if CR found in base64/quoted-printable email
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    mailinfo: warn if CR found in base64/quoted-printable email
    +    mailinfo: warn if CR found in decoded base64/QP email
     
    -    When an SMTP server receives an 8-bit email message, possibly with only
    -    LF as line ending, some of those servers decide to change said LF to
    -    CRLF.
    +    When SMTP servers receive 8-bit email messages, possibly with only
    +    LF as line ending, some of them decide to change said LF to CRLF.
     
    -    Some mailing list softwares, when receives an 8-bit email message,
    -    decide to encoding such message in base64 or quoted-printable.
    +    Some mailing list softwares, when receive 8-bit email messages,
    +    decide to encode those messages in base64 or quoted-printable.
     
         If an email is transfered through above mail servers, then distributed
         by such mailing list softwares, the recipients will receive an email
         contains a patch mungled with CRLF encoded inside another encoding.
    -    Thus, such CR couldn't be dropped by mailsplit. Hence, the mailed patch
    -    couldn't be applied cleanly. Such accidents have been observed in the wild [1].
     
    -    Let's give our users some warnings if such CR is found.
    +    Thus, such CR couldn't be dropped by "mailsplit".
    +    Hence, the mailed patch couldn't be applied cleanly.
    +    Such accidents have been observed in the wild [1].
    +
    +    Instead of silently rejecting those messages, let's give our users
    +    some warnings if such CR is found.
     
         [1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## mailinfo.c ##
    -@@ mailinfo.c: static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
    - }
    - 
    - static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
    --				 struct strbuf *prev)
    -+				 struct strbuf *prev, int *have_quoted_cr)
    - {
    - 	size_t len = line->len;
    +@@ mailinfo.c: static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
      	const char *rest;
      
      	if (!mi->format_flowed) {
     +		if (len >= 2 &&
     +		    line->buf[len - 2] == '\r' &&
     +		    line->buf[len - 1] == '\n') {
    -+			*have_quoted_cr = 1;
    ++			mi->have_quoted_cr = 1;
     +		}
      		handle_filter(mi, line);
      		return;
    @@ mailinfo.c: static void handle_filter_flowed(struct mailinfo *mi, struct strbuf
      	handle_filter(mi, line);
      }
      
    -+static void summarize_quoted_cr(struct mailinfo *mi, int have_quoted_cr)
    ++static void summarize_quoted_cr(struct mailinfo *mi)
     +{
    -+	if (have_quoted_cr)
    ++	if (mi->have_quoted_cr)
     +		warning("quoted CR detected");
     +}
     +
      static void handle_body(struct mailinfo *mi, struct strbuf *line)
      {
      	struct strbuf prev = STRBUF_INIT;
    -+	int have_quoted_cr = 0;
    - 
    - 	/* Skip up to the first boundary */
    - 	if (*(mi->content_top)) {
     @@ mailinfo.c: static void handle_body(struct mailinfo *mi, struct strbuf *line)
      				handle_filter(mi, &prev);
      				strbuf_reset(&prev);
      			}
    -+			summarize_quoted_cr(mi, have_quoted_cr);
    -+			have_quoted_cr = 0;
    ++			summarize_quoted_cr(mi);
    ++			mi->have_quoted_cr = 0;
      			if (!handle_boundary(mi, line))
      				goto handle_body_out;
      		}
     @@ mailinfo.c: static void handle_body(struct mailinfo *mi, struct strbuf *line)
    - 						strbuf_addbuf(&prev, sb);
    - 						break;
    - 					}
    --				handle_filter_flowed(mi, sb, &prev);
    -+				handle_filter_flowed(mi, sb, &prev, &have_quoted_cr);
    - 			}
    - 			/*
    - 			 * The partial chunk is saved in "prev" and will be
    -@@ mailinfo.c: static void handle_body(struct mailinfo *mi, struct strbuf *line)
    - 			break;
    - 		}
    - 		default:
    --			handle_filter_flowed(mi, line, &prev);
    -+			handle_filter_flowed(mi, line, &prev, &have_quoted_cr);
    - 		}
    - 
    - 		if (mi->input_error)
    -@@ mailinfo.c: static void handle_body(struct mailinfo *mi, struct strbuf *line)
      
      	if (prev.len)
      		handle_filter(mi, &prev);
    -+	summarize_quoted_cr(mi, have_quoted_cr);
    ++	summarize_quoted_cr(mi);
      
      	flush_inbody_header_accum(mi);
      
     
    + ## mailinfo.h ##
    +@@ mailinfo.h: struct mailinfo {
    + 	struct strbuf charset;
    + 	unsigned int format_flowed:1;
    + 	unsigned int delsp:1;
    ++	unsigned int have_quoted_cr:1;
    + 	char *message_id;
    + 	enum  {
    + 		TE_DONTCARE, TE_QP, TE_BASE64
    +
      ## t/t5100-mailinfo.sh ##
     @@ t/t5100-mailinfo.sh: test_expect_success 'mailinfo handles unusual header whitespace' '
      	test_cmp expect actual
      '
      
    -+check_quoted_cr_mail() {
    ++check_quoted_cr_mail () {
     +	git mailinfo -u "$@" quoted-cr-msg quoted-cr-patch \
     +		<"$DATA/quoted-cr.mbox" >quoted-cr-info 2>quoted-cr-err &&
     +	test_cmp "expect-cr-msg" quoted-cr-msg &&
3:  0d115821c3 ! 4:  d5b2da370d mailinfo: skip quoted CR on user's wish
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    mailinfo: skip quoted CR on user's wish
    +    mailinfo: allow squelching quoted CR warning
     
    -    In previous change, we've turned on warning for quoted CR in base64
    -    encoded email. Despite those warnings are usually helpful for our users,
    -    they may expect quoted CR in their emails.
    +    In previous change, Git starts to warn for quoted CR in decoded
    +    base64/QP email. Despite those warnings are usually helpful,
    +    quoted CR could be part of some users' workflow.
     
         Let's give them an option to turn off the warning completely.
     
    @@ Documentation/git-mailinfo.txt: git-mailinfo - Extracts patch and authorship fro
      --------
      [verse]
     -'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
    -+'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] [--quoted-cr=<action>] <msg> <patch>
    ++'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n]
    ++	       [--[no-]scissors] [--quoted-cr=<action>]
    ++	       <msg> <patch>
      
      
      DESCRIPTION
    @@ Documentation/git-mailinfo.txt: This can be enabled by default with the configur
      
     +--quoted-cr=<action>::
     +	Action when processes email messages sent with base64 or
    -+	quoted-printable encoding, and the decoded lines end with CR-LF
    ++	quoted-printable encoding, and the decoded lines end with a CRLF
     +	instead of a simple LF.
     ++
     +The valid actions are:
     ++
     +--
    -+*	`nowarn`: Git will do nothing with this action.
    -+*	`warn`: Git will issue a warning for each message if such CR-LF is
    ++*	`nowarn`: Git will do nothing when such a CRLF is found.
    ++*	`warn`: Git will issue a warning for each message if such a CRLF is
     +	found.
     +--
     ++
    @@ Documentation/git-mailinfo.txt: This can be enabled by default with the configur
      	except the title line which comes from e-mail Subject.
     
      ## builtin/mailinfo.c ##
    -@@
    - #include "mailinfo.h"
    - 
    - static const char mailinfo_usage[] =
    --	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
    -+	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] [--quoted-cr=<action>] <msg> <patch> < mail >info";
    +@@ builtin/mailinfo.c: static int parse_opt_explicit_encoding(const struct option *opt,
    + 	return 0;
    + }
      
    ++static int parse_opt_quoted_cr(const struct option *opt, const char *arg, int unset)
    ++{
    ++	BUG_ON_OPT_NEG(unset);
    ++
    ++	if (mailinfo_parse_quoted_cr_action(arg, opt->value) != 0)
    ++		return error(_("bad action '%s' for '%s'"), arg, "--quoted-cr");
    ++	return 0;
    ++}
    ++
      int cmd_mailinfo(int argc, const char **argv, const char *prefix)
      {
    + 	struct metainfo_charset meta_charset;
     @@ builtin/mailinfo.c: int cmd_mailinfo(int argc, const char **argv, const char *prefix)
    - 			mi.use_scissors = 0;
    - 		else if (!strcmp(argv[1], "--no-inbody-headers"))
    - 			mi.use_inbody_headers = 0;
    --		else
    -+		else if (skip_prefix(argv[1], "--quoted-cr=", &str)) {
    -+			mi.quoted_cr = mailinfo_parse_quoted_cr_action(str);
    -+			if (mi.quoted_cr == quoted_cr_invalid_action)
    -+				usage(mailinfo_usage);
    -+		} else
    - 			usage(mailinfo_usage);
    - 		argc--; argv++;
    - 	}
    + 			       N_("re-code metadata to this encoding"),
    + 			       PARSE_OPT_NONEG, parse_opt_explicit_encoding),
    + 		OPT_BOOL(0, "scissors", &mi.use_scissors, N_("use scissors")),
    ++		OPT_CALLBACK_F(0, "quoted-cr", &mi.quoted_cr, N_("<action>"),
    ++			       N_("action when quoted CR is found"),
    ++			       PARSE_OPT_NONEG, parse_opt_quoted_cr),
    + 		OPT_HIDDEN_BOOL(0, "inbody-headers", &mi.use_inbody_headers,
    + 			 N_("use headers in message's body")),
    + 		OPT_END()
     
      ## mailinfo.c ##
     @@ mailinfo.c: static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
      
    - static void summarize_quoted_cr(struct mailinfo *mi, int have_quoted_cr)
    + static void summarize_quoted_cr(struct mailinfo *mi)
      {
    --	if (have_quoted_cr)
    -+	if (have_quoted_cr
    -+	    && mi->quoted_cr == quoted_cr_warn)
    +-	if (mi->have_quoted_cr)
    ++	if (mi->have_quoted_cr &&
    ++	    mi->quoted_cr == quoted_cr_warn)
      		warning("quoted CR detected");
      }
      
    @@ mailinfo.c: int mailinfo(struct mailinfo *mi, const char *msg, const char *patch
      	return mi->input_error;
      }
      
    -+enum quoted_cr_action mailinfo_parse_quoted_cr_action(const char *action)
    ++int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action)
     +{
    -+	if (!strcmp(action, "nowarn"))
    -+		return quoted_cr_nowarn;
    -+	else if (!strcmp(action, "warn"))
    -+		return quoted_cr_warn;
    -+	return quoted_cr_invalid_action;
    ++	if (!strcmp(actionstr, "nowarn"))
    ++		*action = quoted_cr_nowarn;
    ++	else if (!strcmp(actionstr, "warn"))
    ++		*action = quoted_cr_warn;
    ++	else
    ++		return -1;
    ++	return 0;
     +}
     +
      static int git_mailinfo_config(const char *var, const char *value, void *mi_)
      {
      	struct mailinfo *mi = mi_;
    -+	const char *str;
    - 
    - 	if (!starts_with(var, "mailinfo."))
    - 		return git_default_config(var, value, NULL);
     @@ mailinfo.c: static int git_mailinfo_config(const char *var, const char *value, void *mi_)
      		mi->use_scissors = git_config_bool(var, value);
      		return 0;
      	}
     +	if (!strcmp(var, "mailinfo.quotedcr")) {
    -+		git_config_string(&str, var, value);
    -+		mi->quoted_cr = mailinfo_parse_quoted_cr_action(str);
    -+		if (mi->quoted_cr == quoted_cr_invalid_action)
    -+			die(_("bad action '%s' for '%s'"), str, var);
    -+		free((void *)str);
    ++		if (mailinfo_parse_quoted_cr_action(value, &mi->quoted_cr) != 0)
    ++			return error(_("bad action '%s' for '%s'"), value, var);
    ++		return 0;
     +	}
      	/* perhaps others here */
      	return 0;
    @@ mailinfo.h
     +enum quoted_cr_action {
     +	quoted_cr_nowarn,
     +	quoted_cr_warn,
    -+	quoted_cr_invalid_action
     +};
     +
      struct mailinfo {
    @@ mailinfo.h: struct mailinfo {
      	struct strbuf email;
      	int keep_subject;
      	int keep_non_patch_brackets_in_subject;
    -+	enum quoted_cr_action quoted_cr;
    ++	int quoted_cr; /* enum quoted_cr_action */
      	int add_message_id;
      	int use_scissors;
      	int use_inbody_headers;
    @@ mailinfo.h: struct mailinfo {
      	int input_error;
      };
      
    -+enum quoted_cr_action mailinfo_parse_quoted_cr_action(const char *action);
    ++int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action);
      void setup_mailinfo(struct mailinfo *);
      int mailinfo(struct mailinfo *, const char *msg, const char *patch);
      void clear_mailinfo(struct mailinfo *);
     
      ## t/t5100-mailinfo.sh ##
    -@@ t/t5100-mailinfo.sh: check_quoted_cr_mail() {
    +@@ t/t5100-mailinfo.sh: check_quoted_cr_mail () {
      	test_cmp "$DATA/quoted-cr-info" quoted-cr-info
      }
      
4:  d48733805f ! 5:  9e96d4bf5e mailinfo: strip quoted CR on users' wish
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    mailinfo: strip quoted CR on users' wish
    +    mailinfo: allow stripping quoted CR without warning
     
         In previous changes, we've turned on warning for quoted CR in base64 or
    -    quoted-printable email messages. Some projects sees those quoted CR a lot
    -    and they know that it happens most of the time.
    +    quoted-printable email messages. Some projects see those quoted CR a lot,
    +    they know that it happens most of the time, and they find it's desirable
    +    to always strip those CR.
     
         Those projects in question usually fall back to use other tools to handle
    -    patches when receiving such patches.
    +    patches when receive such patches.
     
         Let's help those projects handle those patches by stripping those
    -    excessive CR-s.
    +    excessive CR.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Documentation/git-mailinfo.txt ##
     @@ Documentation/git-mailinfo.txt: The valid actions are:
    - *	`nowarn`: Git will do nothing with this action.
    - *	`warn`: Git will issue a warning for each message if such CR-LF is
    + *	`nowarn`: Git will do nothing when such a CRLF is found.
    + *	`warn`: Git will issue a warning for each message if such a CRLF is
      	found.
    -+*	`strip`: Git will convert those CR-LF to LF.
    ++*	`strip`: Git will convert those CRLF to LF.
      --
      +
      The default action could be set by configuration option `mailinfo.quotedCR`.
    @@ mailinfo.c
     @@ mailinfo.c: static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
      		    line->buf[len - 2] == '\r' &&
      		    line->buf[len - 1] == '\n') {
    - 			*have_quoted_cr = 1;
    + 			mi->have_quoted_cr = 1;
     +			if (mi->quoted_cr == quoted_cr_strip) {
     +				strbuf_setlen(line, len - 2);
     +				strbuf_addch(line, '\n');
    @@ mailinfo.c: static void handle_filter_flowed(struct mailinfo *mi, struct strbuf
      		}
      		handle_filter(mi, line);
      		return;
    -@@ mailinfo.c: enum quoted_cr_action mailinfo_parse_quoted_cr_action(const char *action)
    - 		return quoted_cr_nowarn;
    - 	else if (!strcmp(action, "warn"))
    - 		return quoted_cr_warn;
    -+	else if (!strcmp(action, "strip"))
    -+		return quoted_cr_strip;
    - 	return quoted_cr_invalid_action;
    - }
    - 
    +@@ mailinfo.c: int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action)
    + 		*action = quoted_cr_nowarn;
    + 	else if (!strcmp(actionstr, "warn"))
    + 		*action = quoted_cr_warn;
    ++	else if (!strcmp(actionstr, "strip"))
    ++		*action = quoted_cr_strip;
    + 	else
    + 		return -1;
    + 	return 0;
     
      ## mailinfo.h ##
     @@
    @@ mailinfo.h
      	quoted_cr_nowarn,
      	quoted_cr_warn,
     +	quoted_cr_strip,
    - 	quoted_cr_invalid_action
      };
      
    + struct mailinfo {
     
      ## t/t5100-mailinfo.sh ##
     @@ t/t5100-mailinfo.sh: test_expect_success 'mailinfo handle CR in base64 encoded email' '
5:  95e309cc8b ! 6:  d6aa12acc0 am: learn to process quoted lines that ends with CRLF
    @@ Commit message
         am: learn to process quoted lines that ends with CRLF
     
         In previous changes, mailinfo has learnt to process lines that decoded
    -    from base64 or quoted-printable and ends with CRLF.
    +    from base64 or quoted-printable, and ends with CRLF.
     
    -    Let's teach "am" that new option, too.
    +    Let's teach "am" that new trick, too.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ builtin/am.c: static void am_state_release(struct am_state *state)
     +static int am_option_parse_quoted_cr(const struct option *opt,
     +				     const char *arg, int unset)
     +{
    -+	int *quoted_cr = opt->value;
    -+
     +	BUG_ON_OPT_NEG(unset);
     +
    -+	*quoted_cr = mailinfo_parse_quoted_cr_action(arg);
    -+	if (*quoted_cr == quoted_cr_invalid_action)
    -+		return -1;
    ++	if (mailinfo_parse_quoted_cr_action(arg, opt->value) != 0)
    ++		return error(_("bad action '%s' for '%s'"), arg, "--quoted-cr");
     +	return 0;
     +}
     +
    @@ builtin/am.c: static void am_load(struct am_state *state)
     +	read_state_file(&sb, state, "quoted-cr", 1);
     +	if (!*sb.buf)
     +		state->quoted_cr = quoted_cr_unset;
    -+	else
    -+		state->quoted_cr = mailinfo_parse_quoted_cr_action(sb.buf);
    -+	if (state->quoted_cr == quoted_cr_invalid_action)
    ++	else if (mailinfo_parse_quoted_cr_action(sb.buf, &state->quoted_cr) != 0)
     +		die(_("could not parse %s"), am_path(state, "quoted-cr"));
     +
      	read_state_file(&sb, state, "apply-opt", 1);
    @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
      			N_("pass it through git-apply"),
      			0),
     
    + ## contrib/completion/git-completion.bash ##
    +@@ contrib/completion/git-completion.bash: __git_whitespacelist="nowarn warn error error-all fix"
    + __git_patchformat="mbox stgit stgit-series hg mboxrd"
    + __git_showcurrentpatch="diff raw"
    + __git_am_inprogress_options="--skip --continue --resolved --abort --quit --show-current-patch"
    ++__git_quoted_cr="nowarn warn strip"
    + 
    + _git_am ()
    + {
    +@@ contrib/completion/git-completion.bash: _git_am ()
    + 		__gitcomp "$__git_showcurrentpatch" "" "${cur##--show-current-patch=}"
    + 		return
    + 		;;
    ++	--quoted-cr=*)
    ++		__gitcomp "$__git_quoted_cr" "" "${cur##--quoted-cr=}"
    ++		return
    ++		;;
    + 	--*)
    + 		__gitcomp_builtin am "" \
    + 			"$__git_am_inprogress_options"
    +
      ## mailinfo.h ##
     @@
      #define MAX_BOUNDARIES 5
-- 
2.31.1.448.g9c2f8508d1

