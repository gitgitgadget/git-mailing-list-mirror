Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE361C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiI3VBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiI3VBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:01:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AAFFC2A7
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:00:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE5DB1BE726;
        Fri, 30 Sep 2022 17:00:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0q4AppPSGPxa
        H/8iiTkU+h0cJ47PQp6eisKc5uvYO3I=; b=iaFSZkcYBryYJW2q65zZWKVYyHKG
        lviZkzoyjBzMlmcz8lI5I2Qmxc6aSAy37jdiq2Jn+rNuSrCPdHPep+nc4VsNQ5h4
        hgSIP5sDNx9QPmy1JoWHrIOU0hApCOVh0tOuuygZBrXsKojtU+OzsvPV+0B6sxHd
        fslH4lzRSfJlurs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E64311BE725;
        Fri, 30 Sep 2022 17:00:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A59321BE723;
        Fri, 30 Sep 2022 17:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/36] blame: use a more detailed usage_msg_optf()
 error on bad -L
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-04.36-a8312c50f01-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:00:50 -0700
In-Reply-To: <patch-v3-04.36-a8312c50f01-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:27
        +0200")
Message-ID: <xmqqv8p4a871.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F7873E60-4102-11ED-8BD1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Improve the error message emitted when there's a bad -L argument, and
> do so using the parse-options.c flavor of "usage()", instead of using
> the non-parse-options.c usage() function. This was the last user of
> usage() in this file.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/blame.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

This may not be incorrect (I didn't spend time to see if this "while
at it" is truly an improvement) but clearly outside the scome of
"output from the -h option should match synopsis" theme.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index a9fe8cf7a68..8ec59fa2096 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1108,12 +1108,13 @@ int cmd_blame(int argc, const char **argv, cons=
t char *prefix)
>  	anchor =3D 1;
>  	range_set_init(&ranges, range_list.nr);
>  	for (range_i =3D 0; range_i < range_list.nr; ++range_i) {
> +		const char *arg =3D range_list.items[range_i].string;
>  		long bottom, top;
> -		if (parse_range_arg(range_list.items[range_i].string,
> -				    nth_line_cb, &sb, lno, anchor,
> +		if (parse_range_arg(arg, nth_line_cb, &sb, lno, anchor,
>  				    &bottom, &top, sb.path,
>  				    the_repository->index))
> -			usage(blame_usage);
> +			usage_msg_optf(_("failed to parse -L argument '%s'"),
> +				       blame_opt_usage, options, arg);

So, it used to be that it emitted only blame_usage which is a rough
match to the synopsis,=20

    "git blame [<options>] [<rev-opts>] [<rev>] [--] <file>"

but now we use blame_opt_usage + options, which means that the same
blame_usage, a blank line, and "<rev-opts> are documented in
git-rev-list(1)" is given, followed by the list of full options.=20

I do think saying "failed to parse -L" is an improvement, but it is
dubious it is a good idea to follow it with a wall of text that
comes from options[].  After all, if the user chose to use "-L 2,8"
and a typo replaced the comma with a full stop, which caused
parse_range_arg() to fail, does it make sense to scroll away the
message that helpfully points out that "-L argument '2.8'" was the
problem with other option descriptions?

This is why we shouldn't distract a series with "while at it"
changes that are outside the scope of the theme.  Letting the patch
authors and reviewers concentrate on doing one thing well would
avoid mistakes, but mixing unrelated changes distracts them.  Having
to think about the differences between usage() and usage_msg_optf()
with this change already distracted me and stopped my review on this
series in this sitting.  The topic will need to wait for the next
time I decide to sit with it and start reading it from the next step.

And of course, a series like this, which is supposed to do the same
thing to many files for consistency, is better written and reviewed
in one sitting, because that will make it easier in reviewers' mind
to keep and apply the same review criteria consistently.

>  		if ((!lno && (top || bottom)) || lno < bottom)
>  			die(Q_("file %s has only %lu line",
>  			       "file %s has only %lu lines",
