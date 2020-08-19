Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D96C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5299C2067C
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r7SBl0Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHSRzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:55:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57934 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHSRzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:55:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD827EFC17;
        Wed, 19 Aug 2020 13:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/H2sbHDMTpQn2pFrJa78wi2p2n4=; b=r7SBl0
        AeRoRvWFeh21VPXaeYRaTtDbM+kGo0pxVyAIrutLkTvHQzAgahGwr+NAzQCjWhTX
        UpPuk8NISRib9c6ct/PP/cKlNg0x60NjUxuu6D4LFnxx4J7KzRC3Ouik/yJznQ5w
        VcbPuExwEJQuxpj5B0akdU22M1xSuvPbb/WFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u5QkmLnnsPBF5IktfGMOmkyMbk9Z24GX
        cihNOs8ukVFjVHOkHBXyuKsbBGnUc7jIy3+GULJabmPTqCzmhP+O4hhQIRuoJWtL
        3jOCoY52pA45ymsmvCD9vc76TQrYRht2Dpb/a+m0cN0a8zFYWwjR7td7i0cbc+TI
        6lVy/3x9/jg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C650BEFC16;
        Wed, 19 Aug 2020 13:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E650DEFC15;
        Wed, 19 Aug 2020 13:55:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: 'contents:trailers' show error if `:` is missing
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
        <7daf9335a501b99c29e299f72823fcb7e549e748.1597841551.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 10:55:03 -0700
In-Reply-To: <7daf9335a501b99c29e299f72823fcb7e549e748.1597841551.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Wed, 19 Aug 2020 12:52:31
        +0000")
Message-ID: <xmqqv9hettag.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CA75384-E245-11EA-8851-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hariom Verma <hariom18599@gmail.com>
>
> The 'contents' atom does not show any error if used with 'trailers'
> atom and semicolon is missing before trailers arguments.
>
> e.g %(contents:trailersonly) works, while it shouldn't.
>
> It is definitely not an expected behavior.
>
> Let's fix this bug.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Heba Waly <heba.waly@gmail.com>
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---

Nice spotting.  7a5edbdb (ref-filter.c: parse trailers arguments
with %(contents) atom, 2017-10-01) talks about being deliberate
about the case where skip_prefix(":") does not find a colon after
the "trailers" token, but from the message it is clear that it
expected that the case happens only when "trailers" is at the end of
the string.

The new helper that is overly verbose and may be overkill.

Shouldn't this be clear enough, equivalent and sufficient?

	else if (skip_prefix(arg, "trailers", &arg) &&
		 (!*arg || *arg == ':'))) {
		if (trailers_atom_parser(...);

That is, we not just make sure the string begins with "trailers",
but also make sure it either (1) ends the string (i.e. the token is
just "trailers"), or (2) is followed by a colon ':', before entering
the block to handle "trailers[:anything]".  If we later add a new
atom "trailersonly", that will not be handled here, but elsewhere in
the "else if" cascade.

>  ref-filter.c            | 21 ++++++++++++++++++---
>  t/t6300-for-each-ref.sh |  9 +++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index ba85869755..dc31fbbe51 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -332,6 +332,22 @@ static int trailers_atom_parser(const struct ref_format *format, struct used_ato
>  	return 0;
>  }
>  
> +static int check_format_field(const char *arg, const char *field, const char **option)
> +{
> +	const char *opt;
> +	if (skip_prefix(arg, field, &opt)) {
> +		if (*opt == '\0') {
> +			*option = NULL;
> +			return 1;
> +		}
> +		else if (*opt == ':') {
> +			*option = ++opt;
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int contents_atom_parser(const struct ref_format *format, struct used_atom *atom,
>  				const char *arg, struct strbuf *err)
>  {
> @@ -345,9 +361,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
>  		atom->u.contents.option = C_SUB;
> -	else if (skip_prefix(arg, "trailers", &arg)) {
> -		skip_prefix(arg, ":", &arg);
> -		if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
> +	else if (check_format_field(arg, "trailers", &arg)) {
> +		if (trailers_atom_parser(format, atom, arg, err))
>  			return -1;
>  	} else if (skip_prefix(arg, "lines=", &arg)) {
>  		atom->u.contents.option = C_LINES;
