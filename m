Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13752C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA9B2395A
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgLGU4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 15:56:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54280 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLGU4T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 15:56:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1523311D825;
        Mon,  7 Dec 2020 15:55:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nGF0cci6MhMNJYWDcHAJDOPUMk8=; b=cJ8yqT
        GAEBxcdOCceX8k61mQlGP1EAWEr3yHyzlpLfN2D9Nc99ILE9vvyVQxcvFI+YgJBM
        /X3EvRqDbpZB4JgJ2Q5eRpbXBUv/zP4SGFgPd+vjYH/yJUjZfLjs1ly8Keh5c8XV
        zAecy2y9j292z2hnTbDWsw1A0fBVRYXD+Mrh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ew/OcBY4IKrl119qCIW4txCIADHNzqzs
        CMH7QkIPxBmiJ/JPrjPxtr1x7F8hxQqu7amwO2/VWEIov4nHdsKJ4KAhMfjtn8pN
        ZS3uEXAUL7yVaVUgeJA5ILsi1vAIzPFKRRQzcdtRAwZeH1PT+0z2AQ0Z9KryVvWr
        qZC+mKVM8fw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EDC411D824;
        Mon,  7 Dec 2020 15:55:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2719411D822;
        Mon,  7 Dec 2020 15:55:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 02/16] pull: improve default warning
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
        <20201205195313.1557473-3-felipe.contreras@gmail.com>
Date:   Mon, 07 Dec 2020 12:55:30 -0800
In-Reply-To: <20201205195313.1557473-3-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Sat, 5 Dec 2020 13:52:59 -0600")
Message-ID: <xmqq4kkx9vzx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C3732B6-38CE-11EB-9868-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We want to:
>
> 1. Be clear about what "specifying" means; merge, rebase, or
>    fast-forward.
> 2. Mention a direct shortcut for people that just want to get on with
>    their lives: git pull --no-rebase.
> 3. Have a quick reference for users to understand what this
>    "fast-forward" business means.
>
> This patch does all three.
>
> Thanks to the previous patch now "git pull --help" explains what a
> fast-forward is, and a further patch changes --no-rebase to --merge so
> it's actually user friendly.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1034372f8b..d71344fe28 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -345,18 +345,19 @@ static enum rebase_type config_get_rebase(void)
>  		return parse_config_rebase("pull.rebase", value, 1);
>  
>  	if (opt_verbosity >= 0 && !opt_ff) {
> -		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -			 "discouraged. You can squelch this message by running one of the following\n"
> -			 "commands sometime before your next pull:\n"
> -			 "\n"
> -			 "  git config pull.rebase false  # merge (the default strategy)\n"
> -			 "  git config pull.rebase true   # rebase\n"
> -			 "  git config pull.ff only       # fast-forward only\n"
> -			 "\n"
> -			 "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -			 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -			 "or --ff-only on the command line to override the configured default per\n"
> -			 "invocation.\n"));


> +		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
> +			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
> +			"You can squelch this message by running one of the following commands:\n"
> +			"\n"
> +			"  git config pull.rebase false  # merge (the default strategy)\n"
> +			"  git config pull.rebase true   # rebase\n"
> +			"  git config pull.ff only       # fast-forward only\n"
> +			"\n"
> +			"You can replace \"git config\" with \"git config --global\" to set a default\n"
> +			"preference for all repositories.\n"
> +			"If unsure, run \"git pull --no-rebase\".\n"
> +			"Read \"git pull --help\" for more information."
> +			));
>  	}

It is an improvement to say what they can do from the command line
in order to get out of the current situation, before giving them a
configuration advice.

But the exact instruction for the command line in the original seems
to have been lost during the rewrite, which I think makes the "what
to do now" advice less valuable than it could be.

I personally think it is backwards to update this message before
fixing the condition under which it triggers (I think by now
everybody involved in the thread understands that we do not want to
give this advise that does not stop to behave as-is---it should be
made not to trigger if we know the history would fast-forward, and
when it triggers it should stop the operation).  It may appear OK as
long as we get the right end-state, but because this message must be
rewritten when the triggering condition changes (i.e. when we stop
giving this message when the history fast-forwards, there is no
point in offering the fast-forward-only as a viable option), it
seems to me a needless detour.

