Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A2C20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 02:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeLNCJ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 21:09:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43116 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbeLNCJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 21:09:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so3911643wrs.10
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 18:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2tcKuhObgMjI8SRt5jtOZx9igRk6I03JLH/SDSi4rgY=;
        b=JaG3gKpixeQ5nzxK3lBs9PdRufJBhULk3KfQUPzUFpxmcAfqSoj+7DDJHtdVdo16JQ
         evx3OmZNFHU9W/kZ4zJE1UUIbifYnWk9jX0hREMJmAgDuvQPt1JBLlqQF+d2+RYOt4ns
         5NeWx93c6qdayf0/7H7MYp4qbpagDuoOj9hYNz+UIBRPIK1Dh+JLhs/adtfPEf8NFdvT
         v80v2cDvCFhAx3BzRwLFn9GWEjEHh48yVI8Dvc1wztCPTK8V8iV/Bvy8q4a9GYCV+1vU
         hQhGFyVuGn7bEbOojH6cVgtnh/lw6ibmd7B1FPUR/hJFJGsE7XC9y7bh41n+eeVEIuA2
         QQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2tcKuhObgMjI8SRt5jtOZx9igRk6I03JLH/SDSi4rgY=;
        b=K+Fw2pZIlXwRDVrKjSwQAMe9+SCizjy3wiu/Ao9otm1qwn2PsRwfNhjlXfDXgX3qz3
         YAl6pgY2JdcpaigTq9xl11xvnX6+k2uvaetoGGMK57rG2ajWYuoY9WR/UMADy4p0K+4I
         1Nb2aIsYIGmJzSI9jaSbdMhICO+IDUa7EDWWzmqMxdfhKoupZkhzCQGakn9mDr0okdV+
         T+B2VXl+WM4kHY8boHTwAaogo3pYJa82AXpJhxUSjlDt98hCW6Fby2GE2xsJZrLbWfPb
         GNCR8/s0aTh4RFUos78mp+SHF5hUIYR2G+jA6bSEK1uYjM3sWA1WaySZ2mnZqomAFgQW
         Rj6A==
X-Gm-Message-State: AA+aEWZo0U781chKx1IGblrqlDysKGSbU4fG3jkB6qBYWvRSwXOD96Yr
        Pf/I0qCLVSUu05JoUCPedEc=
X-Google-Smtp-Source: AFSGD/Un2mAonPYdR+dBBLAZTYmsmvbMq9CXREk7L9P5Fjbe920Sc9BAEFp3XLNEhKzWKyJMqjcHww==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr910345wrs.318.1544753395966;
        Thu, 13 Dec 2018 18:09:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c9sm4972912wmh.27.2018.12.13.18.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 18:09:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual commands
References: <20181211104236.GA6899@sigill.intra.peff.net>
        <20181211104342.GA7233@sigill.intra.peff.net>
Date:   Fri, 14 Dec 2018 11:09:53 +0900
In-Reply-To: <20181211104342.GA7233@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 11 Dec 2018 05:43:42 -0500")
Message-ID: <xmqqo99oeu4u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In protocol v2, instead of just running "upload-pack", we have a generic
> "serve" loop which runs command requests from the client. What used to
> be "upload-pack" is now generally split into two operations: "ls-refs"
> and "fetch". The latter knows it must respect uploadpack.* config, but
> the former is not actually specific to a fetch operation (we do not yet
> do v2 receive-pack, but eventually we may, and ls-refs would support
> both operations).
>
> However, ls-refs does need to know which operation we're performing, in
> order to read the correct config (e.g., uploadpack.hiderefs versus
> receive.hiderefs; we don't read _either_ right now, but this is the
> first step to fixing that).
>
> In the generic "git-serve" program, we don't have that information. But
> in the protocol as it is actually used by clients, the client still asks
> to run "git-upload-pack", and then issues an "ls-refs" from there. So we
> _do_ know at that point that "uploadpack" is the right config context.
> This patch teaches the protocol v2 "serve" code to pass that context
> through to the individual commands (a future patch will teach ls-refs to
> actually use it).

Thanks for a clear description of ugly status quo X-<.

> diff --git a/ls-refs.h b/ls-refs.h
> index b62877e8da..da26fc9824 100644
> --- a/ls-refs.h
> +++ b/ls-refs.h
> @@ -4,7 +4,8 @@
>  struct repository;
>  struct argv_array;
>  struct packet_reader;
> -extern int ls_refs(struct repository *r, struct argv_array *keys,
> +extern int ls_refs(struct repository *r, const char *config_context,
> +		   struct argv_array *keys,
>  		   struct packet_reader *request);

One thing I wonder is if we want to pass the whole *_opt thing,
instead of only one field out of it.

>  #endif /* LS_REFS_H */
> diff --git a/serve.c b/serve.c
> index bda085f09c..70f89cf0d9 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -48,6 +48,7 @@ struct protocol_capability {
>  	 * This field should be NULL for capabilities which are not commands.
>  	 */
>  	int (*command)(struct repository *r,
> +		       const char *config_context,

Likewise here.

>  		       struct argv_array *keys,
>  		       struct packet_reader *request);
>  };

Thanks.
