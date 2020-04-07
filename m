Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC80EC2BABC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 07:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724182072A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 07:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCvU1htG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgDGHkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:40:36 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52127 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGHkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 03:40:36 -0400
Received: by mail-pj1-f66.google.com with SMTP id n4so390057pjp.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=my6iYQpq5HSRYffGcwWVcBc9ANbDvSi3Sc23zZnwUM0=;
        b=qCvU1htGMq+FMQ8REQF6HyBhK7+nzXSqQ+WILLvU8p96OCteXiZUZ4XBkqUADbjXR6
         9kVLngU9Vh2oZYhH4FcCRpn/n4gU/QtPoPe80upkXF9skcLDU3dFZawEKZD7EfgG/U4J
         B6MX5ITXoYHUbzfYuusq9oqT3BA9HaVok6lSTcRnBB96QTSBFbN3BL7Lw5AEv3sQ9rbv
         oVA1W7Kap7gCSu5uI6yNJr0h9z8Hf97UeV/6mFLv1aTQd8DxQkP8VpYalXVoFip2ys2M
         5/w6DmWsGC2XHLtUDX7sSK/uFh/brou9LA5BtOBenZW2pYSunwfD0x09XqeIcoCVmQOW
         jBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=my6iYQpq5HSRYffGcwWVcBc9ANbDvSi3Sc23zZnwUM0=;
        b=Q9/7dAamn56nfmWEUhy0S1o+dMwTx/VY81e4BIaxOW1QhWv33HnizDZCLi1jPrLGKd
         8F4xV1aHTDL0psTwIp3lPjtx0jBufNkzj1TgoabXTr9jSgzojM/yt94T6VpCatMTSuge
         l4vjq1Op79JXWSrFJUZ3jjgRmh62bd0ZEoqUdUqRZuIiYVRHHB1+qok2OGre58tmV3vf
         LNXd7PWjX8mUgBQmLbih8N01w/A1VoVRbXiiz1o3EP86JM7hNm49Zpv9Kp2OPL5Oz9H5
         v3rCDt35mOCzzeXWzIO+EsKgI2IS8hZyKEmQx+hsbCZA7J3Bhaj1PwuvQrLpfL+J5cWF
         hUrQ==
X-Gm-Message-State: AGi0PuaqGJ//b9XO3E33o+VpoU/Y5e+B9Pobd56tIMhoC4xhNj3kU/bK
        RpitfPwgQF4yk+czBb2Qc9c=
X-Google-Smtp-Source: APiQypJrJEd5k7i8x4Csv2Ex8qJv/phUbEiwfFAekduqt7NszHIknhmBcsjL/yFRxNdq6o9vJTw5Ug==
X-Received: by 2002:a17:90b:4c0e:: with SMTP id na14mr1222869pjb.73.1586245233761;
        Tue, 07 Apr 2020 00:40:33 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id u16sm11388213pgf.52.2020.04.07.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 00:40:33 -0700 (PDT)
Date:   Tue, 7 Apr 2020 14:40:31 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] format-patch: teach --no-q-encode-headers
Message-ID: <20200407074031.GA20612@danh.dev>
References: <20200405231109.8249-1-me@pluvano.com>
 <20200407051745.44390-1-me@pluvano.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200407051745.44390-1-me@pluvano.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-07 05:17:45+0000, Emma Brooks <me@pluvano.com> wrote:
> When commit subjects or authors have non-ASCII characters, git
> format-patch Q-encodes them so they can be safely sent over email.
> However, if the patch transfer method is something other than email (web
> review tools, sneakernet), this only serves to make the patch metadata
> harder to read without first applying it (unless you can decode RFC 2047
> in your head). git am as well as some email software supports
> non-Q-encoded mail as described in RFC 6531.
> 
> Add --[no-]q-encode-headers and format.qEncodeHeaders to let the user
> control this behavior.
> 
> Signed-off-by: Emma Brooks <me@pluvano.com>
> ---
> 
> Changes since v1:
> 
> - Rename --encode-headers to --q-encode-headers
> - Rename format.encodeHeaders to format.qEncodeHeaders
> - Simplify language in docs
> - Reel in over-indented lines
> 
>  Documentation/config/format.txt    |  4 +++
>  Documentation/git-format-patch.txt |  8 +++++
>  builtin/log.c                      |  7 ++++
>  log-tree.c                         |  1 +
>  pretty.c                           |  6 ++--
>  pretty.h                           |  1 +
>  revision.c                         |  4 +++
>  revision.h                         |  3 +-
>  t/t4014-format-patch.sh            | 53 ++++++++++++++++++++++++++++++
>  9 files changed, 84 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> index 45c7bd5a8f..9b0d665d27 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -57,6 +57,10 @@ format.suffix::
>  	`.patch`. Use this variable to change that suffix (make sure to
>  	include the dot if you want it).
>  
> +format.qEncodeHeaders::
> +	Encode email headers that have non-ASCII characters with
> +	"Q-encoding" for email transmission. Defaults to true.

I think have (described in RFC 2047) as same as
--[no]-q-encode-headers belows would be better.

> +
>  format.pretty::
>  	The default pretty format for log/show/whatchanged command,
>  	See linkgit:git-log[1], linkgit:git-show[1],
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 0d4f8951bb..13de39a27c 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -24,6 +24,7 @@ SYNOPSIS
>  		   [(--reroll-count|-v) <n>]
>  		   [--to=<email>] [--cc=<email>]
>  		   [--[no-]cover-letter] [--quiet]
> +		   [--[no-]q-encode-headers]
>  		   [--no-notes | --notes[=<ref>]]
>  		   [--interdiff=<previous>]
>  		   [--range-diff=<previous> [--creation-factor=<percent>]]
> @@ -253,6 +254,13 @@ feeding the result to `git send-email`.
>  	containing the branch description, shortlog and the overall diffstat.  You can
>  	fill in a description in the file before sending it out.
>  
> +--q-encode-headers::
> +--no-q-encode-headers::
> +	Encode email headers that have non-ASCII characters with
> +	"Q-encoding" (described in RFC 2047), instead of outputting the
> +	headers verbatim. The default is set to the value of the
> +	`format.qEncodeHeaders` configuration variable.

I find this paragraph hard to understand.
I think:

	If this option is omited, set to value of of ...

is easier to understand (to me, at least).

> +
>  --interdiff=<previous>::
>  	As a reviewer aid, insert an interdiff into the cover letter,
>  	or as commentary of the lone patch of a 1-patch series, showing
> diff --git a/builtin/log.c b/builtin/log.c
> index 83a4a6188e..ea63902b82 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -46,6 +46,7 @@ static int default_abbrev_commit;
>  static int default_show_root = 1;
>  static int default_follow;
>  static int default_show_signature;
> +static int default_q_encode_headers = 1;
>  static int decoration_style;
>  static int decoration_given;
>  static int use_mailmap_config = 1;
> @@ -151,6 +152,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
>  	rev->show_root_diff = default_show_root;
>  	rev->subject_prefix = fmt_patch_subject_prefix;
>  	rev->show_signature = default_show_signature;
> +	rev->q_encode_headers = default_q_encode_headers;
>  	rev->diffopt.flags.allow_textconv = 1;
>  
>  	if (default_date_mode)
> @@ -438,6 +440,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		return git_config_string(&fmt_pretty, var, value);
>  	if (!strcmp(var, "format.subjectprefix"))
>  		return git_config_string(&fmt_patch_subject_prefix, var, value);
> +	if (!strcmp(var, "format.qencodeheaders")) {
> +		default_q_encode_headers = git_config_bool(var, value);
> +		return 0;
> +	}
>  	if (!strcmp(var, "log.abbrevcommit")) {
>  		default_abbrev_commit = git_config_bool(var, value);
>  		return 0;
> @@ -1719,6 +1725,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	rev.show_notes = show_notes;
>  	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
>  	rev.commit_format = CMIT_FMT_EMAIL;
> +	rev.q_encode_headers = default_q_encode_headers;
>  	rev.expand_tabs_in_log_default = 0;
>  	rev.verbose_header = 1;
>  	rev.diff = 1;
> diff --git a/log-tree.c b/log-tree.c
> index 897a90233e..fb37149854 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -693,6 +693,7 @@ void show_log(struct rev_info *opt)
>  	ctx.abbrev = opt->diffopt.abbrev;
>  	ctx.after_subject = extra_headers;
>  	ctx.preserve_subject = opt->preserve_subject;
> +	ctx.q_encode_headers = opt->q_encode_headers;
>  	ctx.reflog_info = opt->reflog_info;
>  	ctx.fmt = opt->commit_format;
>  	ctx.mailmap = opt->mailmap;
> diff --git a/pretty.c b/pretty.c
> index 28afc701b6..3ae52cc9db 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -474,7 +474,8 @@ void pp_user_info(struct pretty_print_context *pp,
>  		}
>  
>  		strbuf_addstr(sb, "From: ");
> -		if (needs_rfc2047_encoding(namebuf, namelen)) {
> +		if (pp->q_encode_headers &&
> +		    needs_rfc2047_encoding(namebuf, namelen)) {
>  			add_rfc2047(sb, namebuf, namelen,
>  				    encoding, RFC2047_ADDRESS);
>  			max_length = 76; /* per rfc2047 */
> @@ -1767,7 +1768,8 @@ void pp_title_line(struct pretty_print_context *pp,
>  	if (pp->print_email_subject) {
>  		if (pp->rev)
>  			fmt_output_email_subject(sb, pp->rev);
> -		if (needs_rfc2047_encoding(title.buf, title.len))
> +		if (pp->q_encode_headers &&
> +		    needs_rfc2047_encoding(title.buf, title.len))
>  			add_rfc2047(sb, title.buf, title.len,
>  						encoding, RFC2047_SUBJECT);
>  		else
> diff --git a/pretty.h b/pretty.h
> index 4ad1fc31ff..e40b6d3e83 100644
> --- a/pretty.h
> +++ b/pretty.h
> @@ -43,6 +43,7 @@ struct pretty_print_context {
>  	struct string_list *mailmap;
>  	int color;
>  	struct ident_split *from_ident;
> +	unsigned q_encode_headers:1;
>  
>  	/*
>  	 * Fields below here are manipulated internally by pp_* functions and
> diff --git a/revision.c b/revision.c
> index 8136929e23..51d3e8a558 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2241,6 +2241,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->topo_order = 1;
>  		revs->rewrite_parents = 1;
>  		revs->graph = graph_init(revs);
> +	} else if (!strcmp(arg, "--q-encode-headers")) {
> +		revs->q_encode_headers = 1;
> +	} else if (!strcmp(arg, "--no-q-encode-headers")) {
> +		revs->q_encode_headers = 0;
>  	} else if (!strcmp(arg, "--root")) {
>  		revs->show_root_diff = 1;
>  	} else if (!strcmp(arg, "--no-commit-id")) {
> diff --git a/revision.h b/revision.h
> index 475f048fb6..4794aa4742 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -203,7 +203,8 @@ struct rev_info {
>  			use_terminator:1,
>  			missing_newline:1,
>  			date_mode_explicit:1,
> -			preserve_subject:1;
> +			preserve_subject:1,
> +			q_encode_headers:1;
>  	unsigned int	disable_stdin:1;
>  	/* --show-linear-break */
>  	unsigned int	track_linear:1,
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b653dd7d44..9f780b8fe8 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1160,6 +1160,59 @@ test_expect_success 'format-patch wraps extremely long from-header (rfc2047)' '
>  	check_author "Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
>  '
>  
> +cat >expect <<'EOF'
> +From: Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar
> + Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo
> + Bar Foo Bar Foo Bar Foo Bar <author@example.com>
> +EOF
> +test_expect_success 'format-patch wraps extremely long from-header (non-ASCII without Q-encoding)' '
> +	echo content >>file &&
> +	git add file &&
> +	GIT_AUTHOR_NAME="Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar" \
> +	git commit -m author-check &&
> +	git format-patch --no-q-encode-headers --stdout -1 >patch &&
> +	sed -n "/^From: /p; /^ /p; /^$/q" patch >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<'EOF'
> +Subject: [PATCH] Foö
> +EOF

In most of tests, we use this here doc inside the test instead of
global scope.

Only in this file and a minority others, this style is used.

I'm not sure which one is prefered,
maybe Junio can decide.

> +test_expect_success 'subject lines are unencoded with --no-q-encode-headers' '
> +	echo content >>file &&
> +	git add file &&
> +	git commit -m "Foö" &&

IIUC, test_commit is prefered to those above 3 lines.

> +	git format-patch --no-q-encode-headers -1 --stdout >patch &&
> +	grep ^Subject: patch >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<'EOF'
> +Subject: [PATCH] Foö
> +EOF
> +test_expect_success 'subject lines are unencoded with format.qEncodeHeaders=false' '
> +	echo content >>file &&
> +	git add file &&
> +	git commit -m "Foö" &&
> +	git config format.qEncodeHeaders false &&
> +	git format-patch -1 --stdout >patch &&
> +	grep ^Subject: patch >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<'EOF'
> +Subject: [PATCH] =?UTF-8?q?Fo=C3=B6?=
> +EOF
> +test_expect_success '--q-encode-headers overrides format.qEncodeHeaders' '
> +	echo content >>file &&
> +	git add file &&
> +	git commit -m "Foö" &&
> +	git config format.qEncodeHeaders false &&
> +	git format-patch --q-encode-headers -1 --stdout >patch &&
> +	grep ^Subject: patch >actual &&
> +	test_cmp expect actual
> +'
> +
>  cat >expect <<'EOF'
>  Subject: header with . in it
>  EOF

-- 
Danh
