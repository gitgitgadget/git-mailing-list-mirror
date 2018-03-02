Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020C41F404
	for <e@80x24.org>; Fri,  2 Mar 2018 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeCBWZI (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 17:25:08 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41306 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeCBWZH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 17:25:07 -0500
Received: by mail-wr0-f193.google.com with SMTP id f14so11542518wre.8
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K9hL8fTdC33AhpNqiys2IsAB/hm4roYu/2Z4y2yEf94=;
        b=mmE0tO04QrSrCoSD4A2HWGjQATfhO9I1Go1BGvNujQWYbuMWN//I1t7H6oQUk7uiqN
         U71vHDGZKN9v3g7XvD8SLgA5zx5/LSioLs3xAG/HkuxhKmCjclRwnLHRokrYwHPI8yHK
         04ke6RW8x7cO3y0eIhYvXsNhYmo7iGzy7wqku5kY6LgN7uBT5KaChiFQPGUFD73hqjox
         tmOtTf+gFTwKTL8PA2gL4vH2XZmBfvwfW5nLreSPTJOq32+ziEmrEpBaUzj8B7TigYuc
         x5Vde5jc7rWUEEcw4ZB78VG3HEhh0G+fJ9HRfD2OIZrmjq7UxCYjvGj86bdZAjvQ0Flr
         oK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K9hL8fTdC33AhpNqiys2IsAB/hm4roYu/2Z4y2yEf94=;
        b=JDc0cVTw7wICMJ6p3cQo8LXMs9EprYDay5OD4XKtDXwwmHYkyuFwkmlVk4aBIuCWuR
         6PAVsgHh3c/29Yx++SUg35Aj2fqcYk3pDshe0OkX+ni1jNvqsIm72V9k+q0Vj0QdNx+5
         UJD3i5itLYUG9An0iYRd7/4S8fxNZ6Os+b7ZcqCkI/0MmicEffk/L3p1SClMAxDLRLoF
         WfkrU3/BnkPGtvURsdOCh8aMUkwtqUxGFzwo9HeUA1be9lSz+ZsD/OrxPIS8cXfQ1yny
         QjRb8oDeWIlVdeEq1wKnDP48ip8c4RUJK+yMX1qYeKRjhNT6C3b71FZukqhrytpWYwlo
         a47Q==
X-Gm-Message-State: APf1xPCLV058vtJztiXi0i34j3s0Y+zoSVKa4C/hmGw71qdJoizz++5d
        RtjVluTCpN49KfcxOX6lyWc=
X-Google-Smtp-Source: AG47ELs8kjFhXuvJUx/IfQ9uQgjiiEdsbPydlougp/PjmRB67iGW3E7QfEA2UuLTZ1XxLd/5p7SWlQ==
X-Received: by 10.223.177.138 with SMTP id q10mr5768511wra.132.1520029506167;
        Fri, 02 Mar 2018 14:25:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s78sm16243050wrc.93.2018.03.02.14.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 14:25:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 19/35] push: pass ref patterns when pushing
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-20-bmwill@google.com>
Date:   Fri, 02 Mar 2018 14:25:05 -0800
In-Reply-To: <20180228232252.102167-20-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:36 -0800")
Message-ID: <xmqqzi3q9ku6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Construct a list of ref patterns to be passed to 'get_refs_list()' from
> the refspec to be used during the push.  This list of ref patterns will
> be used to allow the server to filter the ref advertisement when
> communicating using protocol v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  transport.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

When you are pushing 'master', we no longer hear what the other end
has at 'next', with this change, no?

In a project whose 'master' is extended primarily by merging topics
that have been cooking in 'next', old way of pushing would only have
transferred the merge commits and resulting trees but not bulk of
the blob data because they are all available on 'next', would it
make the object transfer far less efficient, I wonder?

I guess it is OK only because the push side of the current protocol
does not do common ancestor discovery exchange ;-)

>
> diff --git a/transport.c b/transport.c
> index dfc603b36..bf7ba6879 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1026,11 +1026,35 @@ int transport_push(struct transport *transport,
>  		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
>  		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
>  		int push_ret, ret, err;
> +		struct refspec *tmp_rs;
> +		struct argv_array ref_patterns = ARGV_ARRAY_INIT;
> +		int i;
>  
>  		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
>  			return -1;
>  
> -		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
> +		tmp_rs = parse_push_refspec(refspec_nr, refspec);
> +		for (i = 0; i < refspec_nr; i++) {
> +			const char *pattern = NULL;
> +
> +			if (tmp_rs[i].dst)
> +				pattern = tmp_rs[i].dst;
> +			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
> +				pattern = tmp_rs[i].src;
> +
> +			if (pattern) {
> +				if (tmp_rs[i].pattern)
> +					argv_array_push(&ref_patterns, pattern);
> +				else
> +					expand_ref_pattern(&ref_patterns, pattern);
> +			}
> +		}
> +
> +		remote_refs = transport->vtable->get_refs_list(transport, 1,
> +							       &ref_patterns);
> +
> +		argv_array_clear(&ref_patterns);
> +		free_refspec(refspec_nr, tmp_rs);
>  
>  		if (flags & TRANSPORT_PUSH_ALL)
>  			match_flags |= MATCH_REFS_ALL;
