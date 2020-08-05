Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2120C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DBC20842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DsKCVVrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHETxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:53:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59236 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgHETx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 15:53:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF2BBE5E4A;
        Wed,  5 Aug 2020 15:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CwXRng5eksNjIrE9B5PHIa6bL48=; b=DsKCVV
        rYvxUROneZ7aWQ6xIWxI7eAFSoywnRRIsILEb6iwA3hN3Mm0ijRQRv+t+tXLixNQ
        cdCyZ7tRwC/pt3WgSPWQ6zOGweS3RfbQ1Y5yA3VZXtUlfYbcQiHCGUcZEYSySNUT
        31D4OSpqmWyFegLzF652dw1jABgnFPKOIOyHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tTfRk1IWLo8HBKF/ZtuPz6iMo5XQYLqx
        Xb+mdYTB3OfAvg1Rl07+V4OQ2ICNIl2HB6q3joIq8JRbpSCn+ZzC7HAFKZIUh19Y
        5iZCK95921VuicUz3+geudf/BDVWHuCNzYFoiOcq7ZOuvnslmbgsEOzw4blRwGPb
        nyzWXql42vY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4D61E5E49;
        Wed,  5 Aug 2020 15:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C97CAE5E47;
        Wed,  5 Aug 2020 15:53:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 1/7] fetch-pack: allow NULL negotiator->add_tip
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1596590295.git.jonathantanmy@google.com>
        <044a782863dd690ed4e430b3793538f701a850c6.1596590295.git.jonathantanmy@google.com>
Date:   Wed, 05 Aug 2020 12:53:21 -0700
In-Reply-To: <044a782863dd690ed4e430b3793538f701a850c6.1596590295.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 4 Aug 2020 18:20:44 -0700")
Message-ID: <xmqqo8noooni.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5189D0EA-D755-11EA-9A9F-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In a subsequent patch, a null fetch negotiator will be introduced. This
> negotiator, among other things, will not need any tip information and
> will have a NULL add_tip.

After reading the original code that the patch touches, I know what
"a NULL add_tip" is, but it would have been nicer to readers if you
said "callback" or "method" or "function".

With or without the "if add_tip method is set to NULL, return
without doing anything" optimization, it does make sense to refactor
two existing places that do identical things.  

If all the current negotiators never have NULL in the .add_tip
field, however, I'd suspect that it would make it easier to
understand if this step is explained as refactoring duplicated code
into a single helper _without_ the early-return for optimization,
and then the step that introduces the negotiator that does want to
lack add_tip method to add the early return.  After all, if the null
negotiator added a pointer to a no-op function to its .add_tip field,
things would still work correctly without the early-return in the
new helper function, no?

> Teach fetch-pack to allow this, and to take advantage of this by
> avoiding a ref and alternate traversal when it can. To do this, this
> patch combines all invocations of functions that invoke add_tip into one
> function, and that function first checks whether add_tip is NULL.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)



>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 80fb3bd899..6c786f5970 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -240,6 +240,16 @@ static void mark_tips(struct fetch_negotiator *negotiator,
>  	return;
>  }
>  
> +static void add_tips_and_alternates(struct fetch_negotiator *negotiator,
> +				    const struct oid_array *negotiation_tips)
> +{
> +	if (!negotiator->add_tip)
> +		return;
> +
> +	mark_tips(negotiator, negotiation_tips);
> +	for_each_cached_alternate(negotiator, insert_one_alternate_object);
> +}
> +
>  static int find_common(struct fetch_negotiator *negotiator,
>  		       struct fetch_pack_args *args,
>  		       int fd[2], struct object_id *result_oid,
> @@ -262,10 +272,8 @@ static int find_common(struct fetch_negotiator *negotiator,
>  			   PACKET_READ_CHOMP_NEWLINE |
>  			   PACKET_READ_DIE_ON_ERR_PACKET);
>  
> -	if (!args->no_dependents) {
> -		mark_tips(negotiator, args->negotiation_tips);
> -		for_each_cached_alternate(negotiator, insert_one_alternate_object);
> -	}
> +	if (!args->no_dependents)
> +		add_tips_and_alternates(negotiator, args->negotiation_tips);
>  
>  	fetching = 0;
>  	for ( ; refs ; refs = refs->next) {
> @@ -1575,9 +1583,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  				else
>  					state = FETCH_SEND_REQUEST;
>  
> -				mark_tips(negotiator, args->negotiation_tips);
> -				for_each_cached_alternate(negotiator,
> -							  insert_one_alternate_object);
> +				add_tips_and_alternates(negotiator, args->negotiation_tips);
>  			} else {
>  				filter_refs(args, &ref, sought, nr_sought);
>  				state = FETCH_SEND_REQUEST;
