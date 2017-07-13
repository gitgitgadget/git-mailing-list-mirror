Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD202027C
	for <e@80x24.org>; Thu, 13 Jul 2017 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbdGMWp2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 18:45:28 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36612 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdGMWp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 18:45:27 -0400
Received: by mail-pf0-f172.google.com with SMTP id q86so36008634pfl.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/YZCOs/HEDwWXYDU+q81kX9h0zs0vHWaIV0whDeLrDM=;
        b=R9HjG5vv5pSbeXbVkzXEDsXH3PZCpTbcLcZ2q8dkmMYIKPERcAOfXrb6ez1fLaujLu
         nU/49VtZUsWKsdqBqF8tRxhQwESTSx+8Ov3LGHy0qsU7VpKwU/YIe8EOyEOXlcXHI7H3
         nnp6LMXOmxcwY424msOljTqUBEZXSQ7ULAwBbPJV0KMB5h06/3s2ATaGfh4SgK6n+xH7
         bJpJF6kYJ1pA7e+6LNy+BcsrMBFis8koeXpZwvxHbUYwhJQCoB500QMIEop3kvQnMV6v
         3HCa6kvQdw0Qt4586TMxgHrL9inrgJFJNMjrewQAg4tX2plLEd41devaZ3fV0CDPUo0T
         12CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/YZCOs/HEDwWXYDU+q81kX9h0zs0vHWaIV0whDeLrDM=;
        b=B+XY5YozuDt55i2B5tMw5TetsV7XaxpcLTXxSTs8WrqXuhTct3y4XbIFkBGRYG3k40
         FxZyA70TOgTVE80DT8zTOniF85HgGj/3ow2YpO3XfPAXsbfBzIam8BjA5+rl3kyUyACt
         jrHnJY5bd7rS3BdECERSOVnK/znK9KwRV2DHUosohM//XeZOP7Iou9Q5KZr/OeexQlO1
         s8mFW/lTgEKn4iqkVRcFb4qkKniWk2kUrxLUsW2FNr7i/RuxODt1fmb0wJtw2L/0mCBj
         UuPc0b+EoOiKbXVODw9ioC3DsL8BUGHTa09EU7L+5Dwp4RVxm+tBapxgDRUXUxZkp5rx
         fjhA==
X-Gm-Message-State: AIVw110TRu+auhQE5jzXInMIbFSgUrkc3pxf5CNK30j+eK5LpAkE1UHH
        25FvQrPLfeumBQ==
X-Received: by 10.98.79.130 with SMTP id f2mr1897253pfj.133.1499985927030;
        Thu, 13 Jul 2017 15:45:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id k194sm11170219pgc.31.2017.07.13.15.45.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 15:45:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 05/15] ref-filter: abstract ref format into its own struct
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
        <20170713150118.eof3xgu4zujmo6u6@sigill.intra.peff.net>
        <CAGZ79kag1B37FBrmDzbRFNVODHp=n1h=xSq_pi1b7Fs4wLoRBg@mail.gmail.com>
        <xmqqlgnsulco.fsf@gitster.mtv.corp.google.com>
        <xmqqmv88t444.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaOfcvVGUewVZMyZ7zVUcVESyzsdOBnAvG6FebuZ5HFQw@mail.gmail.com>
Date:   Thu, 13 Jul 2017 15:45:25 -0700
In-Reply-To: <CAGZ79kaOfcvVGUewVZMyZ7zVUcVESyzsdOBnAvG6FebuZ5HFQw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 13 Jul 2017 15:01:19 -0700")
Message-ID: <xmqqd194t0qi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> So when somebody wants to do a "from design and explanation to
>> provider to consumer", we would probably want "doc, *.h, *.c at the
>> top-level and then things inside builtin/ subdirectory" order.  Of
>> course, on the other hand, "I do not trust me not getting swayed by
>> the fact that a developer more competent than me wrote the patch"
>> reviewer would want to use the reverse order.
>
> I do not understand what you say here? Are you saying:
> "I can be tricked easier when the order is top-down,
> specifically when the more competent developer tries to?"

I am not worried about the case in which patch author actively
"tries to" deceive.  It is more like "I am more likely to fail to
spot mistakes the patch author failed to spot himself", when I start
with reasoning, service provider implementations and then service
consumer.  When I am forced to think the problem myself before
seeing the answer and then compare the result with patch author's
answer, I am more likely to find such a mistake.

>> Can we actually express "top-level first and then builtin/*" order
>> with the diff.orderfile mechanism?
>
> By reading the code, I think we snap to the first match. And matching
> is done via the wildmatch.{c,h}, that claims it has special-case '/' matching,
> and '**' **  work differently than '*',

I took a brief look at diffcore-order.c; I do not think "/*.c" would
match only top-level .c files like gitignore files would.
