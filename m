Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2BC35E1D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 20:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFFB246A1
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 20:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hBBfBx7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgB0UtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:49:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61670 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbgB0UtY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 15:49:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 740D9416A9;
        Thu, 27 Feb 2020 15:49:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HqTKlS5nURCVPLqM6j7xBtVspp4=; b=hBBfBx
        7PNSyxj23DLNxmnSfPbzbvWdlTIlKaCpqBEm2WxhU1DBUcDUeCsNOlDE6maqvcDq
        8xF6CtUUJnQZk9O8lSxmJMF3zGMTl2l4OcGGuue81fQZdvGqwdgiSi82zsO9+JdA
        W5Hro4c+E+sygJYg6xHvkEZkt1iTaWPAlgOwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vmqiy8qKliu0L/IUR8+RrniKWQ8jbbOh
        4AZFdT78FbTnoRFYMkPXgXTk/j4u14OMLNtmWl30/cj92YlR6ulM2xbSX3yd+0Ew
        yCXXRV5qBqqN0584FeK/koEJLUQQ6dhcr1+w/KFYMAbslA3CRhNJG+WDqZBv7ot0
        lMFl1gSa/Z4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BD9C416A8;
        Thu, 27 Feb 2020 15:49:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D426D416A7;
        Thu, 27 Feb 2020 15:49:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v6 3/4] advice: revamp advise API
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <176e38a841d1bbb138ae31b6db34fb597f9188b2.1582778112.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 12:49:20 -0800
In-Reply-To: <176e38a841d1bbb138ae31b6db34fb597f9188b2.1582778112.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Thu, 27 Feb 2020 04:35:10
        +0000")
Message-ID: <xmqq7e07g3hr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A197369E-59A2-11EA-A485-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/advice.c b/advice.c
> index 258cc9ba7af..8d9f2910663 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -32,6 +32,40 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
>  int advice_nested_tag = 1;
>  int advice_submodule_alternate_error_strategy_die = 1;
>  
> +const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
> +const char ADVICE_AM_WORK_DIR[] = "advice.amWorkDir";
> ...
> +static const char *advice_config_keys[] = {
> +	ADVICE_ADD_EMBEDDED_REPO,
> +	ADVICE_AM_WORK_DIR,
> ...
> +/*
> + * To add a new advice, you need to:
> + * Define a new const char array.
> + * Add a new entry to advice_config_keys list.
> + * Add the new config variable to Documentation/config/advice.txt.
> + * Call advise_if_enabled to print your advice.
> + */
> +extern const char ADVICE_ADD_EMBEDDED_REPO[];
> +extern const char ADVICE_AM_WORK_DIR[];
> ...

Hmph.

Even though I said that I would prefer it over the current one,
in that it allows the compilers to catch typo, and over the one
in v5 which uses enum, in that we do not have to go through
enum->string->hash conversion all the time, I have to say that I
am not very happy that we'd need to make a consistent change to
three separate places.

What's the ideal long-term outcome?  The reason why I suggested
during the v5 review an array of structure, a field in which can
be the .disabled field, was because it would allow us to later
extend the struct to help users.  Wouldn't it be nice if we can
do something like:

    $ git advice --list "^fetch"
    fetchShowForcedUpdates	enabled
    $ git advice --list --verbose fetchShowForcedUpdates
    fetchShowForcedUpdates	enabled
	"git fetch" by default spends cycles to compute which
	branches were forcibly updated, but it can be turned off.
	To avoid mistaken sense of safety, however, a reminder
	message is issued instead when it is turned off.  The
	reminder can be turned off with this advice key.

Such a future enhancement will become possible by assiciating a
help text for each advice key, and the data structure introduced
in <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com> was meant to be
the beginning of it.

I dunno.
