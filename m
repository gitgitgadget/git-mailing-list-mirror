Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CCC20A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeLOAbS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:31:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLOAbS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:31:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so7005316wrs.10
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OFsXfJJbjey3MVo5dLaDtibnu/l6af0N8XeVGOJoBOg=;
        b=DIynHF5uTAZ+MTuvNFeD+6diQNmLMln12Jwd5Vr8CMU7idge1tI9WUaXZJPGjnyss+
         MxwTbPj6jomIpvPEtEiwefCE19PND+G5ecFAatmFSGpLRHT1ndrbD+64DZJQJjnyLuoo
         E7I/xI1r9OZtnUFrvzWgEYhw/DCLxY7Y/FDigZA6rh6Zdfh7J1nxcSl/Xb7rNPzrIWyI
         YG3TRGQu4vh2g1KOhob21BFJykr9KgPbjzpq+qo5HlXJnlKbdfXTKcDUHjWThYhoyMVT
         Hqx8FUPXdTrXQjWhZNaUENFfRd542Z70BSmqLlyW38uPXVaVUqVfC1B7IzmeZlpBA3Qv
         9u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OFsXfJJbjey3MVo5dLaDtibnu/l6af0N8XeVGOJoBOg=;
        b=idePPaleiZ16WNSetv8WdCpWzLI7w2gY1+dZoFYRmI1q0kXv2aO+eNBhQyhCxPPq46
         4gHQCEmkWgM+Z7O64H7bzx3yMmFgso6g9BmSHOOEbA6Zt/1Tmh2ORENT6ZSlZ/4OrP/2
         CxaYzMmPjVbv0c8ZFMf4RZvJ+0LPiXUky6RYvSyrDISaYFCFgasW84ma/GQMyw2V1n1D
         yD7OY83k0SNuh3JWAS4QAjzGJf4q6exPPEzg078FQMI0xExUpfWUokycIT0oBwH2ymtq
         PeX7zvFLrDvTXQfeHHgE/oe1grY8tf3KBluFAT/MgCUVYW7ch3c/AvcpPMIAMZ10ySev
         0SXw==
X-Gm-Message-State: AA+aEWZpqRZs8PA/0qIG1ouMnkhOe8en57Uwps6gXKVucZS+JK2trBI3
        61+Do3nnuhBcSykZRZJsVHRt7cfn+rk=
X-Google-Smtp-Source: AFSGD/WqwgS2bmciilbyBG75iAfPJPQz/4fG6SuczJfxGrN5L+TWCFJ+ls40ur7uIqeqzAMdWnFLuQ==
X-Received: by 2002:adf:c5d3:: with SMTP id v19mr4073024wrg.30.1544833876081;
        Fri, 14 Dec 2018 16:31:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d16sm7414353wru.52.2018.12.14.16.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 16:31:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual commands
References: <20181211104236.GA6899@sigill.intra.peff.net>
        <20181211104342.GA7233@sigill.intra.peff.net>
        <xmqqo99oeu4u.fsf@gitster-ct.c.googlers.com>
        <20181214082050.GA11777@sigill.intra.peff.net>
Date:   Sat, 15 Dec 2018 09:31:15 +0900
In-Reply-To: <20181214082050.GA11777@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 14 Dec 2018 03:20:50 -0500")
Message-ID: <xmqq5zvvd418.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I actually started by doing that, but "struct serve_options" is not
> currently known by ls-refs.c, upload-pack.c, etc. So they'd have to
> start including "serve.h". I don't think that's the end of the world,
> but it felt like a funny mutual circular to me (my mental model now is
> that ls-refs, upload-pack, etc are low-level commands, tied together by
> the "serve" stuff).

That matches my mental model, too.  I think the difference between
us is what *_opt struct is.  I viewed that it was like diff_options
struct where the driving machinery keeps state of the ongoing
operation performed by lower level routines to fulfill the request
by the API caller, i.e. holding both wish from the caller, and
scratchpad data for the mchinery and the lower level routine to
communicate with each other.

And the new field feels like the last "scratchpad used by the
machinery to tell lower-level ls-refs helper what context it is
operting in".

I dunno.
