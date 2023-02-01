Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BDC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 19:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBATgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 14:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBATgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 14:36:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA97C736
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 11:36:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n13so4027945plf.11
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OV+sKZZNfN1LZ1zWZOblvkBGXJMdWlVovdyQPURLCs=;
        b=hjMLO/lF5OMueJejfxOSMubl/qWjjZjsJqbOl+oUpFu2gZTWhclEarFu1gcmpqglL3
         0uYglAR+Zdco2PKlsXWCjMMWCS0CHdrCIXz4wKlo2+oDYqh0/SyOr91IBSg18dPcDWBW
         P1ji0FKlQ9OdPFn1UqnsuyVcWrHEjlfOax5IHnnh8PG9gJgyWgBycN/AjQjHza7Pd02g
         JsAgCsGhdhlb243fzOiP4XuwXUbrNFJV1yZGyjW3xno6CYTLxX1uk9RUGAeiID9lUZ2F
         jkhL6NQcoRvqUQGn+C0O2ecgSCE9zNkfAfihqbbTVRVMHK50rRR11kj/ANM8qB3JTe+F
         LPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1OV+sKZZNfN1LZ1zWZOblvkBGXJMdWlVovdyQPURLCs=;
        b=w1UdSC3pDURtiBgC2VkEFVVfQ/pBuMgEnVirdbAyg2HZturLaojgZCKNyZtE8dG0sM
         DTyOmcXpC/c8u2o9syI/BhCSjiZGp+XnrcjuIlDtJm0LU4S7ccASPy6U6qQOC6YbNIvy
         W7mdw31yek5nZlPsg8bIQhKyf7LPcAnjswYETZF8NNvNd9xcZwSNMtNl1ffErbP6Ot/P
         22fdc/StdF/KDQ+C14cqGQX/nIE3xZl/r1YocIyl/HisMiI38cUxrtXoghl2GS44gcM6
         IjkDVfKt8wTrubxkxaPJZ8TCrwrGcSMbkY+98TvjG0y294guOfNjNydzfm57uwFcdLwG
         BSPg==
X-Gm-Message-State: AO0yUKVb4UV6dVhjzy5eBlO6XyFpSI+z77Y9JrGyYPYOIfhSEP/lk3ws
        yqkG3Pi1ToV7/v+Yyn9EPFWpkQ==
X-Google-Smtp-Source: AK7set8WtH23H78dMJcWSrRAYZ9IHmYQkF9DuE86oznUkH7BdTWIX0qsCJ8nDgB2xmNqdMHDBiTfEQ==
X-Received: by 2002:a17:902:e548:b0:189:cc58:7784 with SMTP id n8-20020a170902e54800b00189cc587784mr4836119plf.45.1675280197027;
        Wed, 01 Feb 2023 11:36:37 -0800 (PST)
Received: from [192.168.220.208] ([50.54.137.247])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b001949b92f8a8sm9331193plb.279.2023.02.01.11.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 11:36:36 -0800 (PST)
Message-ID: <df7fb59a-ea74-d724-46dd-9a4c32779a30@github.com>
Date:   Wed, 1 Feb 2023 11:36:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Git over HTTP; have flexible SASL authentication
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Rick van Rein <rick@openfortress.nl>, git@vger.kernel.org
References: <20230127163434.GA784@openfortress.nl>
 <xmqq7cx7aov7.fsf@gitster.g> <Y9pL0D2WuKqqwB7X@coredump.intra.peff.net>
From:   Matthew John Cheetham <mjcheetham@github.com>
In-Reply-To: <Y9pL0D2WuKqqwB7X@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-01 03:24, Jeff King wrote:

> On Fri, Jan 27, 2023 at 09:06:36AM -0800, Junio C Hamano wrote:
> 
>> Rick van Rein <rick@openfortress.nl> writes:
>>
>>> Git providers are inventing proprietary extensions to HTTP authentication
>>> for Git.  It seems smarter to use SASL for this purpose, possibly allowing
>>> the client a choice and authentication ringback to the client's own domain.
>>
>> To adopt things like this, the work to extend how to make extensible
>> what is on WWW-Authenticate in the thread that contains this recent
>> message https://lore.kernel.org/git/Y9LvFMzriAWUsS58@coredump.intra.peff.net/
>> may be relevant, perhaps?
> 
> It's relevant, but I think there's a ways to go. That is just about
> passing WWW-Authenticate headers to helpers, which can then try to make
> sense of them. But Git would still only understand getting back a
> username/password from the helper, and passing it along to curl. And
> hopefully we'd do it all through curl's SASL support, and not invent our
> own handling.
> 
> I'm not sure what all that might might look like. I'm sure Matthew has
> probably thought about it, so I'll let him say something more
> intelligent. :)
> 
> -Peff

These are the same thoughts I have on this. My patches only add support for the
Git -> helper information flow, but don't make an attempt to change how helpers
can change Git's (curl's) response or behaviour.

I had earlier iterations [1] of the patch that included the ability to change
the auth type/headers that curl would respond with based on the helper's output.

For example:

protocol=https
host=example.com
password=<TOKEN>
authtype=bearer

..would have Git configure curl to set CURLOPT_XOAUTH2_BEARER. However I pulled
these patches to keep the scope of that series smaller. It's still my plan to
reintroduce such a patch series in the future.

I'd imagine that Git could advertise to helpers that its version of curl supports
SASL and a helper could enable or select this mechanism. Alternatively it could
just be a Git config to enable it outright `credential.useSasl` or something.
I haven't had chance to review SASL yet.

Thanks,
Matthew


[1] https://lore.kernel.org/git/230118.86k01kxfr7.gmgdl@evledraar.gmail.com/T/#m37fffe327593ca4f7bf32a205b7ee1d1ecd1ed46
