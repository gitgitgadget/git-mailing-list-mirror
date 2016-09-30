Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3519C207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 00:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935052AbcI3AOO (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 20:14:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935005AbcI3AON (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 20:14:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59D1142132;
        Thu, 29 Sep 2016 20:14:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LX2j197EBWawkNE49D2nMN3KMiY=; b=LE0jCr
        jbCeY0C+jHqlCRqt0fTD78OqCpTw4ctNhW1BoAkcvPOgsmXLdNz7tcInA7y90Z1F
        zucA42+zXHKK+jlA2vMa4i4zd6lp8pyJ5VCOEJYWUg6TAshxw+vFGbO+KH0xOVpE
        KIsXiY45QUAb6f3P/ewawDMX9HqejAvdFJ/zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MfLoYsRiSzQlDu3ORRqV91Q1dGFjt5Ep
        VOHuBoyDj9Wb6hmz6RZW2LqNGDfuF0Ux6tJQeJmeeMz9kNG2qeK9Y0qj7JmxNjHo
        TNU5XdvVIkF2jFxFzAnRrL30Fp4A8xPIXRDssN1XqEA0Cg1IkWbJIaK2GnlTInhm
        UO7RrHIv2dU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FB6542131;
        Thu, 29 Sep 2016 20:14:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8EFF42130;
        Thu, 29 Sep 2016 20:14:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v6 3/4] ls-files: pass through safe options for --recurse-submodules
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
        <1475185723-36871-1-git-send-email-bmwill@google.com>
        <1475185723-36871-4-git-send-email-bmwill@google.com>
Date:   Thu, 29 Sep 2016 17:14:07 -0700
In-Reply-To: <1475185723-36871-4-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Thu, 29 Sep 2016 14:48:42 -0700")
Message-ID: <xmqqy42ab5ww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF0A07CC-86A2-11E6-B79D-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
> +{
> +	if (line_terminator == '\0')
> +		argv_array_push(&submodules_options, "-z");
> +	if (show_tag)
> +		argv_array_push(&submodules_options, "-t");
> +	if (show_valid_bit)
> +		argv_array_push(&submodules_options, "-v");
> +	if (show_cached)
> +		argv_array_push(&submodules_options, "--cached");
> +	if (show_deleted)
> +		argv_array_push(&submodules_options, "--deleted");
> +	if (show_modified)
> +		argv_array_push(&submodules_options, "--modified");
> +	if (show_others)
> +		argv_array_push(&submodules_options, "--others");
> +	if (dir->flags & DIR_SHOW_IGNORED)
> +		argv_array_push(&submodules_options, "--ignored");
> +	if (show_stage)
> +		argv_array_push(&submodules_options, "--stage");
> +	if (show_killed)
> +		argv_array_push(&submodules_options, "--killed");
> +	if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
> +		argv_array_push(&submodules_options, "--directory");
> +	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES))
> +		argv_array_push(&submodules_options, "--empty-directory");
> +	if (show_unmerged)
> +		argv_array_push(&submodules_options, "--unmerged");
> +	if (show_resolve_undo)
> +		argv_array_push(&submodules_options, "--resolve-undo");
> +	if (show_eol)
> +		argv_array_push(&submodules_options, "--eol");
> +	if (debug_mode)
> +		argv_array_push(&submodules_options, "--debug");
> +}

With this and 4/4 applied, the documentation still says "--cached"
is the only supported option.

Does it really make sense to pass all of these?  I understand "-z"
and I suspect things like "-t" and "-v" that affect "how" things are
shown may also happen to work, but I am not sure how much it makes
sense for options that affect "what" things are shown.

What does it even mean to ask for say "--unmerged" to be shown, for
example, from the superproject?  Recurse into submodules whose cache
entries in the index of the superproject are unmerged, or something
else?

I am inclined to say that it is probably better to keep the
"--cached only" as documented, at least on the "what are shown"
side.

Thanks.
