Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59CAE1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 07:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKBHck (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 03:32:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55506 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKBHcj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 03:32:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BA809E260;
        Sat,  2 Nov 2019 03:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZJIyOgvay8SAt1Oqm/kINYT6rzQ=; b=CSpBeX
        FItK5vXTv9uNBZvQlT65HW11DxdlRXVoHBUyZCUA/uWHvDE+8Jus8p38OpfK9mRG
        FuT3IWZtgESBC3bOUOkhoiLz7DVEfxUJMAs/9QN09T7lyNbcaJO5l/mTbMK6frjV
        Ru7E9q5aQ0LyKl4CgC9+YlTJVf96SY7oKTjcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hq3hh7Obxyubz1b3i3be2tdYvxls5DbY
        SOSX20zWvg3zUL3uGoNa2aw/lUTX1Wwh1uYERU0XTs6oaJz9nsD93thELA1i9KuV
        w2OVhv+LzBIdEAdB/0CpkSx1MVIcC+agOgZ14p+22piM0Vv+KnGpKKy5jCarXmLO
        wJ4xu1zzmrs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83C829E25E;
        Sat,  2 Nov 2019 03:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE73F9E25B;
        Sat,  2 Nov 2019 03:32:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v5 5/6] rebase -i: support --ignore-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-6-rohit.ashiwal265@gmail.com>
Date:   Sat, 02 Nov 2019 16:32:32 +0900
In-Reply-To: <20191101140003.13960-6-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 1 Nov 2019 19:30:02 +0530")
Message-ID: <xmqqa79e3f8v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFF9DAB0-FD42-11E9-AA08-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

>  --ignore-date::
> +	Instead of using the given author date, reset it to the
> +	current time. This implies --force-rebase.

The first sentence is unclear and puzzles me with "for what?".  IOW,
you are saying that by default the command uses the given (I presume
that you meant what is recorded in the original commits being
rebased---but we should find a way to explain it more clearly)
author date, but with this option what is used is reset to the
current time.  It is left unspecified what the command is using that
time for.

Perhaps (I am writing this paragraph after writing the rest of the
message, i.e. after reading the patch through):

	By default, the author date recorded in the commit being
	rebased as the author date is used as the author date of the
	rebased commits.  The option tells Git to use the current
	timestamp as the author date of the rebased commits instead.
	This implies `--force-rebase`.

The committer-date-is-author-date is indirectly also affected by
this option, because it (re)uses the "author date", but by making it
clear where the "author date" comes from in the description of this
option, it would make the interaction between these two options
obvious, hopefully ;-)

>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>  static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
> +static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")

It probably is a good idea to use dash not underscore for
cdate-is-adata and ignore-date, the two files you are adding.

It would be good to eventually fix the existing gpg-sign-opt to
follow suit, but not as a part of this series.

> +static void push_dates(struct child_process *child, int change_committer_date)
> +{
> +	time_t now = time(NULL);
> +	struct strbuf date = STRBUF_INIT;

I am tempted to suggest adding a /* NEEDSWORK */ comment to remind
us that we'd want to eventually use date.c::get_time() here, but not
as part of this series.  But grepping for "\<time(" is easy enough
so I can live without it.

> +	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
> +	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);

OK, so we get author-date of "now" (which we do not do normally)
when the caller decides to call us (which is, under
"--ignore-date").

> +	if (change_committer_date)
> +		argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);

And when we are using --committer-date-is-author-date, we muck with
the committer-date as well.

Makes sense.

> @@ -958,7 +989,8 @@ static int run_git_commit(struct repository *r,
>  	                return -1;
>  
>  	        strbuf_addf(&datebuf, "@%s", date);
> -	        res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
> +		res = setenv("GIT_COMMITTER_DATE",
> +			     opts->ignore_date ? "" : datebuf.buf, 1);

This is the codepath that handles committer-date-is-author-date
option.  We read the author date into "date", and used to
unconditionally use it as the committer date.  With --ignore-date,
we behave differently.

It may happen that an empty string in GIT_COMMITTER_DATE is treated
the same way as missing GIT_COMMITTER_DATE, i.e. unspecified.

	if (opts->ignore_date)
		res = unsetenv("GIT_COMMITTER_DATE");
	else
        	res = setenv(...);

would be conceptually clearer.

But then we would notice that there is no reason to even read the
author-date into date if ignore-date is set, no?  So the whole thing
now becomes

	-	if (opts->committer_date_is_author_date) {
	+	if (!opts->ignore_date && opts->committer_date_is_author_date) {

which feels even cleaner.  Am I missing some subtleties (e.g. are we
worried about the case where the user has GIT_COMMITTER_DATE set and
exported to the environment of the shell that starts "git rebase", or
something like that?)???

> @@ -982,6 +1014,8 @@ static int run_git_commit(struct repository *r,
>  		argv_array_push(&cmd.args, "--amend");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +	if (opts->ignore_date)
> +		push_dates(&cmd, opts->committer_date_is_author_date);
>  	if (defmsg)
>  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>  	else if (!(flags & EDIT_MSG))
> @@ -1404,7 +1438,8 @@ static int try_to_commit(struct repository *r,
>  		strbuf_addf(&date, "@%.*s %.*s",
>  			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
>  			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
> -		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
> +		res = setenv("GIT_COMMITTER_DATE",
> +			     opts->ignore_date ? "" : date.buf, 1);

The same comment as the early half of the above, on relying on the
empty date string instead of an explicit unsetenv().

> @@ -1454,6 +1489,15 @@ static int try_to_commit(struct repository *r,
>  
>  	reset_ident_date();
>  
> +	if (opts->ignore_date) {
> +		author = ignore_author_date(author);

The helper function called here begins with this comment:

"Construct a free()able author string with current time as the author date"

but without reading (and memorizing) it, ignore_author_date()
function sounds like a boolean that tells us "are we told to
ignore the author date?"

It sorely wants a better name to tell the reader that it is the
author ident with current timestamp.

> +		if (!author) {
> +			res = -1;
> +			goto out;
> +		}
> +		free(author_to_free);
> +		author_to_free = (char *)author;
> +	}

> @@ -2538,6 +2582,11 @@ static int read_populate_opts(struct replay_opts *opts)
>  			opts->committer_date_is_author_date = 1;
>  		}
>  
> +		if (file_exists(rebase_path_ignore_date())) {
> +			opts->allow_ff = 0;
> +			opts->ignore_date = 1;
> +		}

OK.

> @@ -3557,6 +3608,8 @@ static int do_merge(struct repository *r,
>  		argv_array_push(&cmd.args, git_path_merge_msg(r));
>  		if (opts->gpg_sign)
>  			argv_array_push(&cmd.args, opts->gpg_sign);
> +		if (opts->ignore_date)
> +			push_dates(&cmd, opts->committer_date_is_author_date);

OK, we've seen the callee above already and we know what this does.

> @@ -3830,7 +3883,8 @@ static int pick_commits(struct repository *r,
>  	if (opts->allow_ff)
>  		assert(!(opts->signoff || opts->no_commit ||
>  				opts->record_origin || opts->edit ||
> -				opts->committer_date_is_author_date));
> +				opts->committer_date_is_author_date ||
> +				opts->ignore_date));

We may want to switch this assert(...) and others to "if (!(...))
BUG()" someday, but not as part of this patch.

