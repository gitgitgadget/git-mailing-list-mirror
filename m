Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBBC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345372AbiEYVFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244613AbiEYVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:05:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEB3BA998
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:05:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D080196765;
        Wed, 25 May 2022 17:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=hrDdXUaQ4DK4AVGtUmDlJGfQy
        iKV6DFczissA9nIKPs=; b=vtPFhMESThNYQzNvdBLf7GJdyMoQ4v2H515Xh9kFv
        9ZXJAyx8eEGHABbDA5DXOClbQRNGUjY19yPqRdvB+E0OZjFtSmKNS4lbj53USibb
        IJYVys/1Qz9hzQXLXokDMT4g/lKhXFZgBXvnHwEWIVBlGAx9jolucPvYqvkkP51h
        Uo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24E39196764;
        Wed, 25 May 2022 17:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAEC4196760;
        Wed, 25 May 2022 17:05:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 3/5] parse-options.c: use optbug() instead of BUG()
 "opts" check
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <patch-3.5-5a3e7609854-20220521T170939Z-avarab@gmail.com>
Date:   Wed, 25 May 2022 14:05:05 -0700
Message-ID: <xmqqk0a95nni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5ABCB9AA-DC6E-11EC-982E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the assertions added in bf3ff338a25 (parse-options: stop
> abusing 'callback' for lowlevel callbacks, 2019-01-27) to use optbug()
> instead of BUG(). At this point we're looping over individual options,
> so if we encounter any issues we'd like to report the offending option.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  parse-options.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 7fff588a45f..5875936898f 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -474,20 +474,20 @@ static void parse_options_check(const struct opti=
on *opts)
>  			break;
>  		case OPTION_CALLBACK:
>  			if (!opts->callback && !opts->ll_callback)
> -				BUG("OPTION_CALLBACK needs one callback");
> +				optbug(opts, "OPTION_CALLBACK needs one callback");
>  			if (opts->callback && opts->ll_callback)
> -				BUG("OPTION_CALLBACK can't have two callbacks");
> +				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
>  			break;
>  		case OPTION_LOWLEVEL_CALLBACK:
>  			if (!opts->ll_callback)
> -				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
> +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
>  			if (opts->callback)
> -				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
> +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callbac=
k");
>  			break;

I wonder if we want to somehow warn developers against careless
conversion in the documentation.

For example, when rewriting BUG()s in the original

	if (!ptr)
		BUG("unexpected NULL in ptr");
	if (!strcmp(ptr, "(null)"))
		BUG("unexpected (null) in ptr");

into bug() followed by BUG_if_bug(), a mechanical rewrite

	if (!ptr)
		bug("unexpected NULL in ptr");
	if (!strcmp(ptr, "(null)"))
		bug("unexpected (null) in ptr");
	BUG_if_bug();

may not be correctly work, if evaluation of the latter condition is
not possible when an earlier condition holds true.  The code
structure (e.g. "if/if" -> "if/else if") might have to change in
some cases.  The conditions may have to be changed in other cases.


I think the changes made this in patch are good transformations to
use the bug()/BUG_if_bug(), of course.

>  		case OPTION_ALIAS:
> -			BUG("OPT_ALIAS() should not remain at this point. "
> -			    "Are you using parse_options_step() directly?\n"
> -			    "That case is not supported yet.");
> +			optbug(opts, "OPT_ALIAS() should not remain at this point. "
> +			       "Are you using parse_options_step() directly?\n"
> +			       "That case is not supported yet.");
>  		default:
>  			; /* ok. (usually accepts an argument) */
>  		}
