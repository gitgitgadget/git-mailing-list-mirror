Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F5C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2455F2080D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DTpDpELP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEFRMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:12:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64839 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgEFRMv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:12:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0C6EC5A19;
        Wed,  6 May 2020 13:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IQ+J59FkDdmgi1/qSgHuDbCPF/M=; b=DTpDpE
        LPLqZ5983bp85Gk+hW0GQRHvpPOUkJUDOyj4PIR9zIhxtZO9Gs9No+J47Q2cD3+c
        cpJtMyKs8+7R/7k0xp8Q7/THmmJDg8NdY+wjw9ye6mW0VOyMJOV9LcI3t0b16l/E
        pBbxo96oHI0p9GkjYfgkcLx7oLAVVmN3p0kXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TIUtMqIUjIjdHuQoHQcDcVP9GkMDIF6+
        U361dTfHlWSOIjRq8dmp291WQbtpI2KffAft+ccKs3PfBMnmdtzLblr8Hwz0+n/Z
        9bhFdySzwI5MXUobdJb5JmsPNzTHB+R9IKmAX+Niq8DpfdvVCj1UNpqVIQv7HWr7
        AQGsLd6HkXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E79ACC5A17;
        Wed,  6 May 2020 13:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26205C5A14;
        Wed,  6 May 2020 13:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
Date:   Wed, 06 May 2020 10:12:43 -0700
In-Reply-To: <20200506073717.9789-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 6 May 2020 13:07:17 +0530")
Message-ID: <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD731E54-8FBC-11EA-83D2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Convert submodule subcommand 'set-url' to a builtin. Port 'set-url'to
> 'submodule--helper.c' and call the latter via 'git-submodule.sh'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> Thank you Junio for the review! :)
> BTW, how detailed should the commit message be about the
> patch?
>
>  builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 22 +--------------------
>  2 files changed, 40 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1a4b391c88..f50745a03f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2246,6 +2246,44 @@ static int module_config(int argc, const char **argv, const char *prefix)
>  	usage_with_options(git_submodule_helper_usage, module_config_options);
>  }
>  
> +static int module_set_url(int argc, const char **argv, const char *prefix)
> +{
> +	int quiet = 0;
> +	const char *newurl;
> +	const char *path;
> +	struct strbuf config_name = STRBUF_INIT;
> +
> +	struct option set_url_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
> +		OPT_END()
> +	};
> +
> +	const char *const usage[] = {
> +		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
> +		NULL
> +	};

Hmph, do we really want all the blank lines in the above?

There is only one "struct option" the code in this function needs to
be aware of and worried about.  Isn't naming it set_url_options[]
overly redundant?  Calling it just options[] would save lines here ;-)

> +	argc = parse_options(argc, argv, prefix, set_url_options,
> +			     usage, 0);

	argc = parse_options(argc, argv, prefix, options, usage, 0);

> +	if (argc!=2) {

Style.  SP around all binary operators like !=, i.e.

	if (argc != 2) {

By the way, looking at print_default_remote() that takes no
arguments wants argc to be 1, and resolve_relative_url() that takes
only one or two arguments checks for 2 or 3, shouldn't this be
checking if argc is 3, not 2?

I thought I pointed it out in my very first review of this series.

	... tries to go back and check, notices that this v4 is not
        ... a reply to v3 or earlier and feels somewhat irritated.
	... then finally finds the following in the v2 review.

> Taking all these together,
> 
>         if (argc != 3) {
>                 usage_with_options(usage, options);
>                 return 1;
>         }
>         path = argv[0];
>         newurl = argv[1];
> 
> If you feel paranoid, you can check these two are not NULL, too,
> i.e.
> 
>         if (argc != 3 || !(path = argv[0]) || !(newurl = argv[1])) {
>                 usage_with_options(usage, options);
>                 return 1;
>         }
> 
> I have no strong preference either way.  Perhaps the latter is more
> concise and more careful at the same time, so some people may prefer
> it.

Thanks.
