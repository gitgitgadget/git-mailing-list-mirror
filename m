Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E9C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0AD21D42
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 20:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vLduy2Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgISU1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 16:27:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50057 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgISU1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 16:27:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75D69E2D83;
        Sat, 19 Sep 2020 16:26:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CMFgfXnBgqXi1cQQB/7/OuLb80A=; b=vLduy2
        HcymOLrgBd0nm1DlOxz8uEznUHeWzp/EYMVRNU9HYyDKfKlqU25ZzmrLt39JiNX/
        h/tg7YP5Vcatzz0nnmOr5tDFMeobSQSwtl+zFQmc5ak598VP+yG6xQ/edGD+t2Ee
        e43yjAlBWk9Lh7n+/i8ZrT9KHTtEbOstyupxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ORd+TI73JdMuRgcYZ0pI0aFTI7LBurRW
        DGePwihgCE1OCc/U+EfAnIy7yBfbi5EcEhZktP54ZE9VGiHQFxVNJuzICO5iAqkv
        cnq5DhxXG4RmdtKKzz+OhfEKeDDH4vwO65xqM1hWBhF0Dg3myJFe2uzubVv01VGT
        yJiBoF6ALio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F77AE2D82;
        Sat, 19 Sep 2020 16:26:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE7DEE2D7F;
        Sat, 19 Sep 2020 16:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/3] push: parse and set flag for "--force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-3-shrinidhi.kaushik@gmail.com>
Date:   Sat, 19 Sep 2020 13:26:54 -0700
In-Reply-To: <20200919170316.5310-3-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 19 Sep 2020 22:33:15 +0530")
Message-ID: <xmqq7dspjywh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75E6E52A-FAB6-11EA-A130-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Adds a flag: "TRANSPORT_PUSH_FORCE_IF_INCLUDES" to indicate that the new
> option was passed from the command line of via configuration settings;
> update command line and configuration parsers to set the new flag
> accordingly.

s/Adds/Add/;

> Introduces a new configuration option "push.useForceIfIncludes", which
> is equivalent to setting "--force-if-includes" in the command line.

s/Introduces/Introduce/; (I won't repeat).

>
> Updates "remote-curl" to recognize and pass this option to "send-pack"
> when enabled.
>
> Updates "advise" to catch the reject reason "REJECT_REF_NEEDS_UPDATE",
> which is set when the ref status is "REF_STATUS_REJECT_REMOTE_UPDATED"
> and (optionally) print a help message when the push fails.

All of the above say what were done.  A summarizing sentence before
all of the above would make the proposed commit log message perfect,
perhaps:

    The previous step added the necessary machinery to implement the
    "--force-if-includes" protection, when "--force-with-lease" is
    used without giving exact object the remote still ought to have.
    Surface the feature by adding a command line option and a
    configuration variable to enable it.

    - Add a flag ... to indicate that ...

    - Introduce a configuration option ...

    - Update 'remote-curl' to ...

    ...


Also, in the proposed log message for [1/3], especially near its
end, how "--force-if-includes" interacts with "--force-with-lease"
was described.  The description should be added to the log message
of this change, as it is what introduces the end-user facing
feature.  The description can also be in the log for [1/3] as well,
but not having it here for [2/3] is unfriendly to the readers.

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 4d76727edb..9289c0eecb 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -159,6 +159,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	int progress = -1;
>  	int from_stdin = 0;
>  	struct push_cas_option cas = {0};
> +	unsigned int force_if_includes = 0;

I think OPT_BOOL takes a pointer to int, not unsigned, as it is
OPT_SET_INT in disguise, and you can see that a near-by 'progress'
that also is fed to OPT_BOOL() is 'int' so you can mimic it.

> @@ -184,6 +185,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
>  		  N_("require old value of ref to be at this value"),
>  		  PARSE_OPT_OPTARG, parseopt_push_cas_option),
> +		OPT_BOOL(0, TRANS_OPT_FORCE_IF_INCLUDES, &force_if_includes,
> +			 N_("require remote updates to be integrated locally")),
>  		OPT_END()
>  	};

> diff --git a/remote.h b/remote.h
> index 38ab8539e2..72c374d539 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -350,4 +350,10 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
>  int is_empty_cas(const struct push_cas_option *);
>  void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
>  
> +/*
> + * Sets "use_force_if_includes" for "compare-and-swap"
> + * when "--force-if-includes" is specified.
> + */
> +void push_set_force_if_includes(struct push_cas_option *);

Let's not add this helper function.  Instead just open-code a single
liner at its two callers.  It makes it easier to read and understand
the flow and the logic in cmd_push() and cmd_send_pack().

> diff --git a/transport-helper.c b/transport-helper.c
> index e547e21199..2a4436dd79 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -868,6 +868,12 @@ static void set_common_push_options(struct transport *transport,
>  		if (set_helper_option(transport, TRANS_OPT_ATOMIC, "true") != 0)
>  			die(_("helper %s does not support --atomic"), name);
>  
> +	/* If called with "--force-if-includes". */

The comment does not add any value as you are already using a
descriptive constant name.  Drop it to follow suit of existing if
statements nearby.

> +	if (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES)
> +		if (set_helper_option(transport, TRANS_OPT_FORCE_IF_INCLUDES, "true") != 0)
> +			die(_("helper %s does not support --%s"),
> +			    name, TRANS_OPT_FORCE_IF_INCLUDES);
> +
>  	if (flags & TRANSPORT_PUSH_OPTIONS) {
>  		struct string_list_item *item;
>  		for_each_string_list_item(item, transport->push_options)

Thanks.
