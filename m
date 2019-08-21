Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674FE1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 19:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfHUTcY (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 15:32:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55068 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfHUTcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 15:32:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7989915B386;
        Wed, 21 Aug 2019 15:32:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+fhI6ktWB0VYDEbGVVlJ6jFZMqU=; b=SSk/6i
        Wh+PU0kK83c6GjW5rspf5OyvsAdE0k7Tb0kHEe8cSscfWd64S+ndY3l8m8bbxLW6
        CRDu9PF09juB7R4FI6nwLyI9YDQGh0AWSCjzql8AIdn3v7PA1OWLUc2lPrS/bfU6
        XjQIN0gXYKUiA/5oOj5iK6lLIvc+2LBYtmaEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J/XGdchirOqJl4EeA+oADPEGfSGsSXma
        44Rd48/9Twf37yFqmDdLHSKIK/DDx8LkZntUac1lWXEEYAunhj6SIVHni0Ndq0ll
        OphpErGpimTy5Ku+4GTCqYS5WTI/tjAbAqh9pGqMVnFUs4lJ4EXneZSK6TI8PimA
        hgzJIqOL7tE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70A2D15B385;
        Wed, 21 Aug 2019 15:32:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AEFF15B384;
        Wed, 21 Aug 2019 15:32:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
References: <cover.1566258525.git.liu.denton@gmail.com>
        <cover.1566285151.git.liu.denton@gmail.com>
        <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
Date:   Wed, 21 Aug 2019 12:32:19 -0700
In-Reply-To: <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 20 Aug 2019 03:19:16 -0400")
Message-ID: <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64A2DA56-C44A-11E9-AF6B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Teach format-patch to use the first line of the branch description as
> the Subject: of the generated cover letter, rather than "*** SUBJECT

I would not say "the first line", as I do not think that is what
happens by calling pretty.c::format_subject().  The function is
designed to take the first paragraph, and the behaviour is in line
with how the subject is formed from the log message in a commit
object.  I'd say "the first paragraph" instead.

> HERE ***" if `--infer-cover-subject` is specified or the corresponding
> `format.inferCoverSubject` option is enabled. This complements the
> existing inclusion of the branch description in the cover letter body.
>
> The reason why this behaviour is not made default is because this change
> is not backwards compatible and may break existing tooling that may rely
> on the default template subject.

I'd suggest writing it more assertively, rather than appearing to be
making lame excuses.  Perhaps like

	The new behaviour is not made default; doing so would
	surprise existing users, which is not a good idea.

Or just drop the excuse of not changing the default altogether.  It
is pretty much the standard practice for us to keep the existing
behaviour the same and to make the new behaviour opt-in.

Having said that, I suspect that in the longer term, people would
want to see this new behaviour with a bit of tweak become the new
default.

The "tweak" I suspect is needed is to behave sensibly when "the
first line" ends up to be too long a subject.  Whether we make this
the new default or keep this optional, the issue exists either way.

One way to make it behave sensibly with overly long first paragraph
is to fall back to the current behaviour.  We can think about the way
an ideally "tweaked" version of this patch uses the branch description
like this:

 1. Preprocess and prepare the branch description string for use in
    the next step.

    - If there is no branch description, then pretend as if "***
      Subject Here ***" followed by a blank line and "*** Blurb here
      ***" were given as the branch description in the step 2.

    - If the first paragraph of the description is overly long, then
      prepend "*** Subject Here ***" followed by a blank line before
      the branch description, and use that the branch description
      string in the step 2 (this is the "tweak to make it behave
      sensibly" change I suggested above).

    - Otherwise, use the given branch description in the step 2.
      Optionally, when a backward-compatibility knob is in effect,
      always prepend the "Subject Here" paragraph.  That way, step
      2. would end up keeping the traditional behaviour.

 2. Split the first pragraph out of the branch description.  Use it
    as the subject, and use the remainder in the body.

And if we view the behaviour that way, it becomes clear that the
"--infer-cover-subject" is a fairly meaningless name for the option.
We unconditionally use the branch description to fill in the subject
and the body, but the traditional way and the updated one when the
first paragraph is overly long use placeholder string for the
subject instead.  I.e. a better name for the option may be something
like --placeholder-subject-in-cover (as opposed to taking the
subject in cover from the branch description), and it can be negated
i.e. --no-placeholder-subject-in-cover, to force keeping the old
behaviour.

And I suspect that the approach would allow the implementation to
become simple and straight-forward.  The "branch description" needs
to be prepared in a few different ways (i.e. if there is no
branch.*.description, you'd fill a fixed string; after reading
branch.*.description and measuring the first paragraph, you may
prepend another fixed string), but after that is done, the actual
generation of the cover letter will need NO conditional logic. It
just needs to split that into the first paragraph to be used as the
subject, and the remainder used in the body.

Hmm?

> @@ -887,6 +888,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  		}
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.infercoversubject")) {
> +		infer_cover_subject = git_config_bool(var, value);
> +		return 0;
> +	}
>  
>  	return git_log_config(var, value, cb);
>  }
> @@ -993,20 +998,6 @@ static void print_signature(FILE *file)
>  	putc('\n', file);
>  }
>  
> -static void add_branch_description(struct strbuf *buf, const char *branch_name)
> -{
> -	struct strbuf desc = STRBUF_INIT;
> -	if (!branch_name || !*branch_name)
> -		return;
> -	read_branch_desc(&desc, branch_name);
> -	if (desc.len) {
> -		strbuf_addch(buf, '\n');
> -		strbuf_addbuf(buf, &desc);
> -		strbuf_addch(buf, '\n');
> -	}
> -	strbuf_release(&desc);
> -}
> -
>  static char *find_branch_name(struct rev_info *rev)
>  {
>  	int i, positive = -1;
> @@ -1057,13 +1048,17 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
>  			      const char *branch_name,
> +			      int infer_subject,
>  			      int quiet)
>  {
>  	const char *committer;
> -	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
> -	const char *msg;
> +	const char *subject = "*** SUBJECT HERE ***";
> +	const char *body = "*** BLURB HERE ***";
> +	const char *description = NULL;
>  	struct shortlog log;
>  	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf description_sb = STRBUF_INIT;
> +	struct strbuf subject_sb = STRBUF_INIT;
>  	int i;
>  	const char *encoding = "UTF-8";
>  	int need_8bit_cte = 0;
> @@ -1091,17 +1086,34 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	if (!branch_name)
>  		branch_name = find_branch_name(rev);
>  
> -	msg = body;
> +	if (branch_name && *branch_name)
> +		read_branch_desc(&description_sb, branch_name);
> +
> +	if (description_sb.len) {
> +		if (infer_subject) {
> +			description = format_subject(&subject_sb, description_sb.buf, " ");
> +			subject = subject_sb.buf;
> +		} else {
> +			description = description_sb.buf;
> +		}
> +	}
> +
>  	pp.fmt = CMIT_FMT_EMAIL;
>  	pp.date_mode.type = DATE_RFC2822;
>  	pp.rev = rev;
>  	pp.print_email_subject = 1;
>  	pp_user_info(&pp, NULL, &sb, committer, encoding);
> -	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
> -	pp_remainder(&pp, &msg, &sb, 0);
> -	add_branch_description(&sb, branch_name);
> +	pp_title_line(&pp, &subject, &sb, encoding, need_8bit_cte);
> +	pp_remainder(&pp, &body, &sb, 0);
> +	if (description) {
> +		strbuf_addch(&sb, '\n');
> +		strbuf_addstr(&sb, description);
> +		strbuf_addch(&sb, '\n');
> +	}
>  	fprintf(rev->diffopt.file, "%s\n", sb.buf);
>  
> +	strbuf_release(&description_sb);
> +	strbuf_release(&subject_sb);
>  	strbuf_release(&sb);
>  
>  	shortlog_init(&log);
> @@ -1577,6 +1589,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		{ OPTION_CALLBACK, 0, "rfc", &rev, NULL,
>  			    N_("Use [RFC PATCH] instead of [PATCH]"),
>  			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
> +		OPT_BOOL(0, "infer-cover-subject", &infer_cover_subject,
> +			    N_("infer a cover letter subject from branch description")),
>  		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
>  			    N_("Use [<prefix>] instead of [PATCH]"),
>  			    PARSE_OPT_NONEG, subject_prefix_callback },
> @@ -1916,7 +1930,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		if (thread)
>  			gen_message_id(&rev, "cover");
>  		make_cover_letter(&rev, use_stdout,
> -				  origin, nr, list, branch_name, quiet);
> +				  origin, nr, list, branch_name, infer_cover_subject, quiet);
>  		print_bases(&bases, rev.diffopt.file);
>  		print_signature(rev.diffopt.file);
>  		total++;
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 7b8c8fe136..94a3191aca 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -822,7 +822,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
>  '
>  
>  test_expect_success 'get git version' '
> -	git_version="$(git --version | sed "s/.* //")"
> +	git_version="$(git --version >version && sed "s/.* //" <version)"
>  '
>  
>  signature() {
> @@ -1516,6 +1516,39 @@ test_expect_success 'format patch ignores color.ui' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cover letter with config subject' '
> +	test_config branch.rebuild-1.description "config subject
> +
> +body" &&
> +	test_config format.inferCoverSubject true &&
> +	git checkout rebuild-1 &&
> +	git format-patch --stdout --cover-letter master >actual &&
> +	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
> +	grep "^body" actual
> +'
> +
> +test_expect_success 'cover letter with command-line subject' '
> +	test_config branch.rebuild-1.description "command-line subject
> +
> +body" &&
> +	git checkout rebuild-1 &&
> +	git format-patch --stdout --cover-letter --infer-cover-subject master >actual &&
> +	grep "^Subject: \[PATCH 0/2\] command-line subject$" actual &&
> +	grep "^body" actual
> +'
> +
> +test_expect_success 'cover letter with command-line --no-infer-cover-subject overrides config' '
> +	test_config branch.rebuild-1.description "config subject
> +
> +body" &&
> +	test_config format.inferCoverSubject true &&
> +	git checkout rebuild-1 &&
> +	git format-patch --stdout --cover-letter --no-infer-cover-subject master >actual &&
> +	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
> +	grep "^config subject" actual &&
> +	grep "^body" actual
> +'
> +
>  test_expect_success 'cover letter using branch description (1)' '
>  	git checkout rebuild-1 &&
>  	test_config branch.rebuild-1.description hello &&
