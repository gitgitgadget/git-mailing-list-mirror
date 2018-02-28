Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABAC1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965021AbeB1XjS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:39:18 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42302 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965002AbeB1XjR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:39:17 -0500
Received: by mail-wr0-f193.google.com with SMTP id k9so4210329wre.9
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cP186785BsarmyQV1vfjmmxda9K2l87i2VfM+1Og3JY=;
        b=Tt8guVhW7cmaX3eBoe9RVcrOnezNLt4Yz+WnePl7LSyv1CADLezy1KL9JU1baRGViW
         kDvambNWLsolIAyMJS6P5Ol8tb9xVJI5IITWXjIhp8r/zubWrErPRC21aSbTvjIP/AxF
         K3gQkve6SmmsG+xN+zIvWGAeidCMWtAJ+WeuNJdIvkWnEDPtvYFjmlFLlTWHjFK63Kp9
         2C8RPzwLWqXbkmx1riw8zb3Ezx7H5qEODRes97/gSLWNkt3+9pesxR1MhX5MRQgYFP8S
         Ud9vPch4R+t+gFs040AMJXProaJ+gKflGMa28WSXHZKMzf4TcToPL2YlzTPRT7AR9Gd9
         dUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cP186785BsarmyQV1vfjmmxda9K2l87i2VfM+1Og3JY=;
        b=rXCAxpFukzpoEVxKmg8IM4rbEg1vOJSshl3ftMfXglH+pZRDadKQGBh72Q4jDsI50C
         3W0bHkvCFXcDIE9r8D9PyrAZji5cQKl88NGBzhNAuXH20VTb6aJhFbwD/d/11ZbeMEQc
         MRRaQ9g0Ykc7fFfBUz7FAurCjFmjTptOQcq4D40G/cA/RW1lexiOuaFDj4woPZhU0abH
         NZiZxPRmiiKhnGKUu+MpsBR2i+e8q6dmIf+NFT7vlB4srrYlhDRf2lgzoDkVPzBHNTFU
         1FuNrwXzqTUpbK2yArBMDorMcDHMie02HC7sWQAfP6z6zI09iGSDTFU79SYu2HqlgpJ1
         vZCg==
X-Gm-Message-State: APf1xPDecDeNkYHZ/ZRon5LrPSoFrXt2cVU0AmcKpawcRNPQJRD9v7s8
        hS6P8g7mdSqFYMnPEep9ZDs=
X-Google-Smtp-Source: AH8x225O2ERZKCGocC+ne+MSjcDvmWXaCxcyxJD3wXeIyiym/R6khpJACtt70pshIs3ugTKlvD7Lgw==
X-Received: by 10.223.164.221 with SMTP id h29mr18906916wrb.259.1519861155933;
        Wed, 28 Feb 2018 15:39:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u48sm2555867wrb.85.2018.02.28.15.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 15:39:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] commit: run git gc --auto just before the pre-commit hook
References: <xmqqzi3siw88.fsf@gitster-ct.c.googlers.com>
        <20180228230425.14952-1-avarab@gmail.com>
Date:   Wed, 28 Feb 2018 15:39:15 -0800
In-Reply-To: <20180228230425.14952-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 28 Feb 2018 23:04:25 +0000")
Message-ID: <xmqqmuzsit0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> Change the behavior of git-commit back to what it was back in
>>> d4bb43ee27 ("Invoke "git gc --auto" from commit, merge, am and
>>> rebase.", 2007-09-05) when it was git-commit.sh.
>>
>> ... which was to run it just before post-commit.  Do I retitle this
>> patch before queuing?
>
> Do'h. Of course I screw up something simple like that, sorry. This v2
> fixes it, and I also rephrased the commit message a bit (more commas &
> full-stops).

I guess I still need to retitle it ;-) But that can happen tomorrow
(I have the previous one with local fixes that pretty much matches
v2 modulo the body of the log message on 'pu', ready to be pushed
out).

> I wonder if it would also be a good idea to run git gc --auto on "git
> push". It itself won't create any objects, but it would be a nice
> proxy in many cases for picking up anything else we missed due to
> various object writing commands that won't run --auto.

Before "push" starts producing a pack might be a good optimization,
as reading from a packed repository is often more performant than a
repository full of loose objects.

