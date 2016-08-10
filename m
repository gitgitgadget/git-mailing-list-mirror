Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41AE81FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbcHJSFW (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:05:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932375AbcHJSFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 82CF532681;
	Wed, 10 Aug 2016 14:00:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L9yEZWakm2RpfQwAZs3hJFPxmco=; b=PZ2HSc
	0U0oHdPe3bSK6KbuKlK96/bJlK7K9anKP5n/WbR9V3ejzkcg/znrTnAQJR0lcozw
	nmQmufoSTpTm6jEoxXTDsHSF6axwB7rD3atb0On2vxs4gxb1X8C59UWlUYh0sxCH
	YVvDztCfIZLxHcwIYIN4J1VNEj36/b2JmAPUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J3Q4rPPdocGDmfSI4QAV3O+0c5qHTNtq
	x+Mjvq4sNHCmN7coWFmq59CRqXvs+0CbCMMUNGGpI4MsoGF05Q8Emp1bDhYy0Rj1
	aK7rC74qF3kdS+oDYJBgS205D4czJ9sRD+QvXjXaLnq3PGmVkLpi5akx/Fh8zHdp
	gmc1Lxm+Xfk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B33232680;
	Wed, 10 Aug 2016 14:00:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 021FE3267E;
	Wed, 10 Aug 2016 14:00:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] checkout: do not mention detach advice for explicit --detach option
References: <20160810172800.23575-1-sbeller@google.com>
Date:	Wed, 10 Aug 2016 11:00:21 -0700
In-Reply-To: <20160810172800.23575-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 10 Aug 2016 10:28:00 -0700")
Message-ID: <xmqqd1lg5wsq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F97D758-5F24-11E6-ACCB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When a user asked for a detached HEAD specifically with `--detach`,
> we do not need to give advice on what a detached HEAD state entails as
> we can assume they know what they're getting into as they asked for it.

Makes sense; I agree that "Don't be noisy if you did exactly what
you were told to do." is a very sensible principle.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 27c1a05..fa2dce5 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -655,7 +655,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
>  			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
>  		if (!opts->quiet) {
> -			if (old->path && advice_detached_head)
> +			if (old->path && advice_detached_head && !opts->force_detach)
>  				detach_advice(new->name);
>  			describe_detached_head(_("HEAD is now at"), new->commit);
>  		}
