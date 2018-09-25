Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D581F453
	for <e@80x24.org>; Tue, 25 Sep 2018 23:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeIZFTo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 01:19:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeIZFTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 01:19:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so24991013wrw.6
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dq6YFfkOo+sA0aeAM1p+89XN4F17foORSAL6tKlakg4=;
        b=AojmVWnEw639cep3+7xWfj/N1qjk6UUlIihjziSmhNtH3qtzuDPdr4zuZrOEwxxWJN
         Xigp3IW0fRqq9Gna6IwXkXcdm7SWstQSpSeTFOBJwZiQDlGFvXHJVp8K4VlhSo9Pe0pJ
         W/1XNhq4x8kckz0rBM50UCLJ6jD33CyvuQlGK27S5zGqdTNCINk78qpWD6C2TQJ1E9qU
         j1a2LfMyRtPOw3iyd93N5stQ7xr+oMppYUAoBG3OTa0L0iqfm5CSoE1bmgOfGItuItXI
         rkU9LkSCCxAeunn/srp/TOehj6gIcWt4SHX/H1ZkGGF/bhrsj/v8+4cAxEfpRwc2XNQA
         So+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dq6YFfkOo+sA0aeAM1p+89XN4F17foORSAL6tKlakg4=;
        b=SnpKprTGixMf8EWXte0b2Wm8xwzGB+KoHiTXl62yaEt7R/Wt8UCF2DaB51lSanlRyg
         Z9thgpdMiLweaxaVs9y/vXi5eJqtyk8/OwwzDeGYoHeESRPAcS5Tf7USlfnc6a2PLY0n
         YXB0+9qrgtpwvYl8/a67pDLi3fGKIxeqdoLjPaUnXncFyiTogdS8McDUmT3HeFmEwzKc
         OcHqTPnku3HcJ0+keJtP2o4d8tO76Td4gYe63Qtg9XEpfXuizfsbm+UQJe8yZ2NDukJY
         YErZVbukzVlUbwKtiwKC45bVKrdnBctDrLRj7RRDWBRiY+x7CPwjEaX9RrKh1MjML/ha
         al/A==
X-Gm-Message-State: ABuFfohSqsGVZ01/vmV7rH3kN4wYDGki53q4nbXO7XFPsGCVyHQrfKGR
        918UXsj9NGzOTn0wDhMm0mk=
X-Google-Smtp-Source: ACcGV601qaG+NHlTs7y5vMOp+67QukPieoHPu+5yvPaVOMmgRXm4+Xu8BjtWpxLxh1kIibZxVM2CAA==
X-Received: by 2002:adf:ecc4:: with SMTP id s4-v6mr2978519wro.142.1537916990421;
        Tue, 25 Sep 2018 16:09:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s10-v6sm3252423wrw.35.2018.09.25.16.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 16:09:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] transport: list refs before fetch if necessary
References: <20180925225355.74237-1-jonathantanmy@google.com>
Date:   Tue, 25 Sep 2018 16:09:49 -0700
In-Reply-To: <20180925225355.74237-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 25 Sep 2018 15:53:55 -0700")
Message-ID: <xmqq8t3pnphe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/transport-helper.c b/transport-helper.c
> index 143ca008c8..7213fa0d32 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1105,6 +1105,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
>  }
>  
>  static struct transport_vtable vtable = {
> +	0,
>  	set_helper_option,
>  	get_refs_list,
>  	fetch,
> diff --git a/transport-internal.h b/transport-internal.h
> index 1cde6258a7..004bee5e36 100644
> --- a/transport-internal.h
> +++ b/transport-internal.h
> @@ -6,6 +6,12 @@ struct transport;
>  struct argv_array;
>  
>  struct transport_vtable {
> +	/**
> +	 * This transport supports the fetch() function being called
> +	 * without get_refs_list() first being called.
> +	 */
> +	unsigned fetch_without_list : 1;
> +
>  	/**
>  	 * Returns 0 if successful, positive if the option is not
>  	 * recognized or is inapplicable, and negative if the option
> diff --git a/transport.c b/transport.c
> index 1c76d64aba..ee8a78ff37 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -703,6 +703,7 @@ static int disconnect_git(struct transport *transport)
>  }
>  
>  static struct transport_vtable taken_over_vtable = {
> +	1,
>  	NULL,
>  	get_refs_via_connect,
>  	fetch_refs_via_pack,
> @@ -852,6 +853,7 @@ void transport_check_allowed(const char *type)
>  }
>  
>  static struct transport_vtable bundle_vtable = {
> +	0,
>  	NULL,
>  	get_refs_from_bundle,
>  	fetch_refs_from_bundle,
> @@ -861,6 +863,7 @@ static struct transport_vtable bundle_vtable = {
>  };
>  
>  static struct transport_vtable builtin_smart_vtable = {
> +	1,
>  	NULL,
>  	get_refs_via_connect,
>  	fetch_refs_via_pack,

Up to this point I think I understand the change.  We gain one new
trait for each transport, many of the transport cannot run fetch
without first seeing the advertisement, some are OK, so we have 0 or
1 in these vtables as appropriately.

> @@ -1224,6 +1227,15 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>  	struct ref **heads = NULL;
>  	struct ref *rm;
>  
> +	if (!transport->vtable->fetch_without_list)
> +		/*
> +		 * Some transports (e.g. the built-in bundle transport and the
> +		 * transport helper interface) do not work when fetching is
> +		 * done immediately after transport creation. List the remote
> +		 * refs anyway (if not already listed) as a workaround.
> +		 */
> +		transport_get_remote_refs(transport, NULL);
> +

But this I do not quite understand.  It looks saying "when asked to
fetch, if the transport does not allow us to do so without first
getting the advertisement, lazily do that", and that may be a good
thing to do, but then aren't the current set of callers already
calling transport-get-remote-refs elsewhere before they call
transport-fetch-refs?  IOW, I would have expected to see a matching
removal, or at least a code that turns an unconditional call to
get-remote-refs to a conditional one that is done only for the
transport that lacks the capability, or something along that line.

... ah, do you mean that this is not a new feature, but is a bugfix
for some callers that are not calling get-remote-refs before calling
fetch-refs, and the bit is to work around the fact that some
transport not just can function without get-remote-refs first but do
not want to call it?

IOW, I am a bit confused by this comment (copied from an earlier part)

> +	/**
> +	 * This transport supports the fetch() function being called
> +	 * without get_refs_list() first being called.
> +	 */

Shouldn't it read more like "this transport does not want its
get-refs-list called when fetch-refs is done"?

I dunno.


>  	for (rm = refs; rm; rm = rm->next) {
>  		nr_refs++;
>  		if (rm->peer_ref &&
