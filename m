Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C4EC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1996120A
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhIKCuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCui (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 22:50:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D3C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:49:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bt14so8151018ejb.3
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vAU2+piE0CwAHZwAD0rHt3BnH6UC18S+Gd6mz6ax4jc=;
        b=f6UHDnQ6O1z+/nrhGQPgnjeJ/jNjqETJ32HwiR94gx6tBuZ+RN+sleY0D2IrD40kH0
         jzoBKvsPjP1m4hW32fTAimGgZkjgN8Y0kXFjbEKQ5+pc+iawyWzPDpPekE5pQWo8W/PW
         0BvpZv1tGdGwxA7s2gIKxyGrAuPP5oDIBAVCP37iktKAb8pduKbIMsK/P41Wb9r9jPDW
         J4c/rHiEafMZcNb3A2113dEwHdbiNCZ8M57ZtN8fp23OdRHgsfg/2xd7eUOyMd3CzScA
         Wh59fPAGut+BSGlM3DQT2SWymHOzyH8OlfollQI5cfWCh82AmlDqkQ4uEaE6L/a4GYPe
         1qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vAU2+piE0CwAHZwAD0rHt3BnH6UC18S+Gd6mz6ax4jc=;
        b=nx/cY88BiRYDhf936q42FvtglDjYw/8onXI0DKEcIbV/C3zAwtskk+HvuFcuISSzRA
         SRhM/CJFhOGmWtMJ3gH64PMcIKFk6Va3HLRsW3lRE2ScD4j6W10XdtJv+iiCoGcczaE/
         7egfE2Nt+p63dlK2NpIYfzn2O6M7xpINb2/aI0RE5hgPIoOekixvjyw033zB0VZHfgkI
         tPUfAnmV5D5R2uUa9mS3z2EuoJ6qr7R4jOwypMu6VNBwQQpe8l4WWykG+LCpTRiUs5fT
         h6cys8pKRIfi6yA5xozPCwGznRm1tz0RJFCarUVznSaxTSwD5SJ/9UG0x9REclsDbUwT
         tgcQ==
X-Gm-Message-State: AOAM530vL8bWJCIcIKhhVoDjGyIFbo48kW4HzSn1pFf/NlnYyfbeKxUQ
        jlY3iNnbTxRZD8XeMD45/6h466uiD7vmGw==
X-Google-Smtp-Source: ABdhPJwQRLJWkqkSXc7wiAlBDFBlB8psJ1uBS7pJxBjHB9ak4Ypwhzw71ktYem9in0ea4GyPpzd9fg==
X-Received: by 2002:a17:907:d23:: with SMTP id gn35mr815821ejc.556.1631328565099;
        Fri, 10 Sep 2021 19:49:25 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm184730ede.97.2021.09.10.19.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 19:49:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] parse-options: stop supporting "" in the
 usagestr array
Date:   Sat, 11 Sep 2021 04:46:39 +0200
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
 <patch-v2-3.6-11f4a119563-20210910T153147Z-avarab@gmail.com>
 <xmqqlf44otbz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqlf44otbz.fsf@gitster.g>
Message-ID: <87r1dvaksr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The strings in the the "usagestr" array have special handling for the
>> empty string dating back to f389c808b67 (Rework make_usage to print
>> the usage message immediately, 2007-10-14).
>>
>> We'll prefix all strings after the first one with "or: ". Then if we
>> encountered a "" we'll emit all strings after that point verbatim
>> without any "or: " prefixing.
>>
>> This gets rid of that special case, which was added in
>> f389c808b67 (Rework make_usage to print the usage message immediately,
>> 2007-10-14). It was only used "blame" (the "credential-cache*" use of
>
> used *by* "blame"
>
>> it was removed in the preceding commit). Before this change we'd emit:
>>
>>     $ git blame -h
>>     usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>
>>
>>         <rev-opts> are documented in git-rev-list(1)
>
> The most crucial information is missing.  It may be shared with the
> previous step but it is even worse in this step.
>
> Why is this loss of feature a desirable thing in the first place?
>
> What are we gaining by breaking the "after listing the alternative
> forms concatenated with 'or:', we can give a general description,
> before going onto the list of options"?
>
> Without that explained, the remainder of the proposed log message
> reads more like an excuse for breaking the feature, justifying that
> the loss of feature can be worked around, than the description of a
> solution.

Making it the same as how "git bundle" describes it doesn't seem
anywhere close to breaking it, and that also goes to the point you had
about brevity on another patch.

I think that passing custom or generated help advice here might make
sense generally, i.e. we might eventually want to expand that to all
built-in as part of improving the -h and --help output, see e.g. the
note at the bottom of "git --help".

But if we do that let's do that with an API where we simply pass this
custom string in as another parameter to the function, rather than
having a state machine to parse it out of the array we use for the
"usage:" and "or:" list of lines.
