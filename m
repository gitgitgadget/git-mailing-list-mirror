Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49098208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756360AbdHYU1a (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 16:27:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52107 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756119AbdHYU12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 16:27:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23CD8A4FA7;
        Fri, 25 Aug 2017 16:27:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1k126g7FU1aT
        3h4kWkmY4yj8RQo=; b=racTyOBkxUVYTXDf84bJnPEl4krLjzJCJCuqnM5yMf1a
        iRS4c+klItuKlnTHkQ1P376dQMEvKC0iR/IUtsUiYTeu5fe+l/jTdhf8yAPSSooh
        8fwhXZeBzqCjnR4JVahGb251522CyI+sZwGIH9TlGKjCmOHmmdf0sB9SA/tsxsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Mwelkq
        vpWRVNUUNfbpLlVR045LAWfheJuTuc16Kb0BbEp3S/zyRB84PuNW8Trs1zKtJJW4
        yv5+9xOCrhpAYplHNE2FXbKUzfNOFZ9+ABL7HGFJzm4Bnkx431YiTfiDviIR4KgT
        9d06fUyaM748bGdFQZwbJEln9s+cvllf5X+Xo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14A74A4FA5;
        Fri, 25 Aug 2017 16:27:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69B29A4FA3;
        Fri, 25 Aug 2017 16:27:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage_with_options: omit double new line on empty option list
References: <xmqqy3q7sge2.fsf@gitster.mtv.corp.google.com/>
        <20170825192813.15697-1-sbeller@google.com>
Date:   Fri, 25 Aug 2017 13:27:25 -0700
In-Reply-To: <20170825192813.15697-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 25 Aug 2017 12:28:13 -0700")
Message-ID: <xmqqh8wvs89e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CFBD3696-89D3-11E7-BDFA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently the worktree command gives its usage, when no subcommand is
> given. However there are no general options, all options are related to
> the subcommands itself, such that:
>
>  #    $ git worktree
>  #    usage: git worktree add [<options>] <path> [<branch>]
>  #       or: git worktree list [<options>]
>  #       or: git worktree lock [<options>] <path>
>  #       or: git worktree prune [<options>]
>  #       or: git worktree unlock <path>
>  #
>  #
>  #    $
>
> Note the two empty lines at the end of the usage string. This is becaus=
e
> the toplevel usage is printed with an empty options list.
>
> Only print a new line after the option list if it is not empty.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>> I have this feeling that this patch may not be sufficient.
>>
>> The reason for the first blank line is because we unconditionally
>> emit one, expecting that we would have a list of options to show and
>> want to separate the usage from that list, and the fix in this patch
>> is correct---it is the right way to suppress it.
>>
>> But why do we need the second blank line in this case? =C2=A0There is =
a
>> similar unconditional LF near the end of this function. =C2=A0Is someb=
ody
>> else (other than usage_with_options() which will exit immeidately)
>> calls this function and expects to say something more after what
>> this function said, and is this extra blank line at the end is to
>> prepare for that caller?
>
> Good point, parse_options[_step] also makes use of the=20
> usage_with_options_internal, such that the regular options
> need=C2=A0to work, with a potentially interesting arrangement of OPTION=
_GROUPs.
>
> I think this one is cleaner, as it omits the correct LF.

Sorry, but now I am utterly confused, as I do not think I've made a
"good point", and I do not see how your "this one is cleaner than
the previous" can follow from what I said.

The first fputc('\n', outfile) touched in the previous version but
not this one is shown after the usage string.  I think the intention
of that is "We have finished giving the usage; now we are going to
list options, and we need a separator blank line in between", and
the reason why it is not conditional on "do we even have any option
in the list?" is probably those who helped parse-options evolve
never saw a user of parse-options API that actually does not have
any option.  So from that point of view, it is understandable why we
didn't check with OPTION_END and checking OPTION_END there and
omitting the blank makes sense---I understand what the previous
patch did, in other words, and agree with what it did.

By the way, it checked OPTION_GROUP and that is also
understandable.  In the loop, there will be a blank berfore each
option group to visually separate things across groups; if we know
the first entry in the options list is such an entry, then we do not
want a blank, as the blank (meant as a separator between usage and
option list) will be followed by another blank (meant as a separator
between groups) and we waste one blank line.

The other fputc('\n', outfile) that this version of the patch
touches is what I had trouble with, and I still do.  There must be a
similar rationale like the previous one, i.e. "We have finished
giving the usage, and we have finished showing all the options.  Now
we are about to further show X, so let's have a blank line here so
that what we have wrote will be separated from it", but I cannot
tell what that X is.

In other words, what I suspect the _right_ solution is, is to have
the previous patch that omits the first LF when the type of the
first element in the options array is either END or GROUP, plus
unconditional removal of the second LF.  If some caller of this
helper function has "now we are going to also show X and we want a
separator", I think that code should be showing the LF as needed.
usage_with_options(), the caller you showed its behaviour in your
proposed log message, does *not* want either of these two LFs, I
would think.



> Thanks,
> Stefan
>
>  parse-options.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 0dd9fc6a0d..2829c16b01 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -580,6 +580,7 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
>  				       const char * const *usagestr,
>  				       const struct option *opts, int full, int err)
>  {
> +	int new_line_after_opts;
>  	FILE *outfile =3D err ? stderr : stdout;
> =20
>  	if (!usagestr)
> @@ -606,6 +607,8 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
>  	if (opts->type !=3D OPTION_GROUP)
>  		fputc('\n', outfile);
> =20
> +	new_line_after_opts =3D (opts->type !=3D OPTION_END);
> +
>  	for (; opts->type !=3D OPTION_END; opts++) {
>  		size_t pos;
>  		int pad;
> @@ -645,7 +648,9 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
>  		}
>  		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
>  	}
> -	fputc('\n', outfile);
> +
> +	if (new_line_after_opts)
> +		fputc('\n', outfile);
> =20
>  	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
>  		fputs("EOF\n", outfile);
