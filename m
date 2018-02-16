Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FD51F404
	for <e@80x24.org>; Fri, 16 Feb 2018 19:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbeBPTZD (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 14:25:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40532 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeBPTZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 14:25:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id v10so4914989wmh.5
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 11:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nEND1TTu58zVXOpUSgYAcBghcJPsNHajwxJuGdiMUjA=;
        b=aDz3rku85EZhsAy1ey4q1CWbRn8HHwi3ns1URvIvJIGMYhj4ec08QnXhaXH7NF36/L
         ugEkSAXVqZlJ0oJ5qwZwMEo91Jo3vcpotZBTnZ8vLn4QAViKaA/prAeGi7lyfPgWjgHm
         Gpbb7b0phH6wXBBkhn85K3AxAzsMOYgTZdL0uWVfxpXz4kga0NASlTaUcz747edSIWxX
         oNPYoqvgphBvBtOy7EL0q0n1GZA8V2w3+IrfF4k3nLOqawxJFDSyemgk7P4SR2exnOw3
         Sl+8s3e5w8Tne+g1pv/bRpYlHRMjS/oWhS16ZVNWxJ9cNlYx5WBn+gmhQiIVzdJxCB7E
         kzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nEND1TTu58zVXOpUSgYAcBghcJPsNHajwxJuGdiMUjA=;
        b=fveDDo87ZTB/dYUAKtHJmW68KY1LPdFNOXs8AZISmVNRSzQsaMr6T4imt+qi8TM3Ru
         bC+8MF0OU8r5JrHlycUx0bRfkhag+e1nXzGhVujMrrj1QwckOHSp6Wkb3AiNvFtuEOpu
         g6PEasmQHbKadjZLqnRj5/gatQt02tadGcbG3hCG/+VCN9ZjxMSldA/D8mM361fyvFa1
         EBvgUqQjKwmWelicwO6XoMEim725p7Ek/MxD4UGLnjJhwFEJ9c4EyVozLfVBz4RlWpu3
         cvS4nR/N34AEeSnVogqNY4o5OrvTRL7OraCLGyHaFuNQ3iwKGNB/8It0LVYbYnpdyR+g
         bNHg==
X-Gm-Message-State: APf1xPBbz4IToXC94b0Wl2GQDi7qrCQgvzd+VZgpsex+0ZCPV+4KJQ6A
        +XPdnUfcwBJ0OZwu2gBJz3E=
X-Google-Smtp-Source: AH8x224TOKSSTR9Rjp+kKGg/W5u0DHNPmaV1NkLjo+MCMCjmkZBBi6QqpskIW6Nz9kUg+t3DbZSrUg==
X-Received: by 10.28.169.200 with SMTP id s191mr5994803wme.9.1518809098650;
        Fri, 16 Feb 2018 11:24:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b79sm14061183wmb.18.2018.02.16.11.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 11:24:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] grep: move grep_source_init outside critical section
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
        <20180215215615.21208-2-rv@rasmusvillemoes.dk>
        <20180215221713.GB23970@sigill.intra.peff.net>
Date:   Fri, 16 Feb 2018 11:24:57 -0800
In-Reply-To: <20180215221713.GB23970@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 15 Feb 2018 17:17:13 -0500")
Message-ID: <xmqqsha068l2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this makes sense. It does blur the memory ownership lines of the
> grep_source, though. Can we make that more clear with a comment here:
>
>> +	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
>> +
>>  #ifndef NO_PTHREADS
>>  	if (num_threads) {
>> -		add_work(opt, GREP_SOURCE_OID, pathbuf.buf, path, oid);
>> +		add_work(opt, &gs);
>>  		strbuf_release(&pathbuf);
>>  		return 0;
>>  	} else
>
> like:
>
>   /* leak grep_source, whose fields are now owned by add_work() */
>
> or something? We could even memset() it back to all-zeroes to avoid an
> accidental call to grep_source_clear(), but that's probably unnecessary
> if we have a comment.

I share the same uneasiness about the fuzzy memory ownership this
change brings in.  Thanks for suggesting improvements.
