Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF5FC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58E761248
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEaEqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 00:46:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52418 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhEaEqc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 00:46:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DD95B2330;
        Mon, 31 May 2021 00:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=NXY9vYL16hpdElriQiTDN93kmL8O9YzHAoZC+IANrnE=; b=EY7t
        +f7peqciotd5eUjgk8vBcSIE1Rvlo28gEHh6lpcdzQQCcMwF35aoIpv+CicOS737
        MEPn/abiu5++/va6yvhWxrqIEluShxKvPMRng0AougYlUK9UxMrEvu3AfXFI1XEp
        8dBEZQKa8DBtzfTGojZTWA46NEF9a+NozdeHAOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 263FAB232F;
        Mon, 31 May 2021 00:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94537B232E;
        Mon, 31 May 2021 00:44:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 1/6] push: hedge code of default=simple
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529071115.1908310-2-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 13:44:51 +0900
Message-ID: <xmqqim2zy0jg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F06EF6E4-C1CA-11EB-8E69-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> `simple` is the most important mode so move the relevant code to its own
> function to make it easier to see what it's doing.

The change and the above description makes sense to me.

I didn't, and still don't, understand the use of verb "to hedge" in
the title, though.  Apparently it isn't "to evade the risk of
commitment", "to protect oneself finantially", and of course not "to
plant, form, or trim a hedge".

> Reviewed-by: Elijah Newren <newren@gmail.com>

I trust Elijah would complain and/or clarify if this footer is
inappropriate (I didn't see an explicit "You can have my
Reviewed-by", but only "this looks good to me", and didn't know
what he meant).

I do like the change of the phrasing from triangular to same-remote
at the end of the extended series, by the way.  It makes the code
simpler to read and much easier to reason about, and it would be
nice to have it even before this step ;-)


> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 194967ed79..7045e4ef0c 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -223,6 +223,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>  	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
>  }
>  
> +static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
> +{
> +	if (triangular)
> +		setup_push_current(remote, branch);
> +	else
> +		setup_push_upstream(remote, branch, triangular, 1);
> +}
> +
>  static int is_workflow_triangular(struct remote *remote)
>  {
>  	struct remote *fetch_remote = remote_get(NULL);
> @@ -242,10 +250,7 @@ static void setup_default_push_refspecs(struct remote *remote)
>  
>  	case PUSH_DEFAULT_UNSPECIFIED:
>  	case PUSH_DEFAULT_SIMPLE:
> -		if (triangular)
> -			setup_push_current(remote, branch);
> -		else
> -			setup_push_upstream(remote, branch, triangular, 1);
> +		setup_push_simple(remote, branch, triangular);
>  		break;
>  
>  	case PUSH_DEFAULT_UPSTREAM:
