Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9599BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 12:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B52A60FBF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 12:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhIMMrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhIMMrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 08:47:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838BC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 05:45:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t19so20746849ejr.8
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4sKKLTJrec1e7ETq04z7B+qSfIEnq38BzDIu/JwVxjQ=;
        b=M2gKKy/tFwsEoKshw/kofmw9b4OqmtxBmU5z1ALpm91K4QG1bAP/xzRR4prG/3hR/c
         TUC9qI1euOGlwtWppV/0eH3yMdcmEzi9S7mvK900esufXEt3jbDckPQ9fXMeZwCsKS23
         UpkvbP3R1y/+yyqYuEw3zoHKMIL09BDYLoa8K93uqzLpXvorrDVUQW04eQQ0Ec8B0Ow4
         QRnMOWoFRXlLij4EttdstYebk5OfquYH4ezqQIEa9gcB41UtjbPEQU+l8JY6mOqd0WeY
         j14ORDc+5zxsSLa5SHXIE16xCn48DhzkEAN62RiHWiZ+lHuUzYQ07LYabAPSeMtrDwt7
         vxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4sKKLTJrec1e7ETq04z7B+qSfIEnq38BzDIu/JwVxjQ=;
        b=oiDBSkfl4ok+B//1hKD7JGqUZNu9irIR+zKeccMCrzjQGGdkcqvthSQolslpqbIaLD
         bhRBARBmt3grvy1O3pBmwsIvYfAYfh4JfZ5QhHz+RTrfugJwVub7ycMxFuAxw6b1lgNN
         2cl3vJ5fxU4JIL0TqLKkV3O7hEzYRYm4zqqNSt8OmYLfWkb4sX8O3C1fA2y03Q0Uf3H7
         +CvLrHyJsyujwt1v/25BggBq6W13kFfWvkZkyjujDe4NtEcZ9c3rGB8tN/fiud9OvQrr
         00+KQIle94rzkNqPGRO8XzAIoQWHTBns8CK/drFUP4bwvEzmhIouJ0btAQcKeD+y6HzP
         IkGg==
X-Gm-Message-State: AOAM5331xmDp9e1RR69bRnzEHmKzBGURBmV6ndQIS0/DkF4MS+CfhV/d
        DJJXDzUFQVLw8v4qyUWuTes4BvAoYB1bng==
X-Google-Smtp-Source: ABdhPJz6v12fqPy1ZrsMsFO3DsFey4f76xztYKXblAiSa1Jep3CUDM3yzdkhYkRIB7RALD+JXmhAfA==
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr12468243ejc.78.1631537142759;
        Mon, 13 Sep 2021 05:45:42 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i26sm3824332edj.88.2021.09.13.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 05:45:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/7] strvec: use size_t to store nr and alloc
Date:   Mon, 13 Sep 2021 14:29:01 +0200
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
 <YT586/CO7QsTb3TK@coredump.intra.peff.net> <xmqqlf41ghmk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqlf41ghmk.fsf@gitster.g>
Message-ID: <87mtog4pai.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 12 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> I'm a little "meh" on some of these, for a few reasons:
>>
>>  - anything calling into setup_revisions() eventually is just kicking
>>    the can anyway. And these are generally not buggy in the first place,
>>    since they're bounded argv creations.
>>
>>  - passing a strvec instead of the broken-down pair is a less flexible
>>    interface. It's one thing if the callee benefits from seeing the
>>    strvec (say, because they may push more items onto it). But I think
>>    with strbufs, we have a general guideline that if a function _can_
>>    take the bare pointer, then it should. (Sorry, I don't have a
>>    succinct reference to CodingGuidelines or anything like that; I feel
>>    like this is wisdom we came up with on the list in the early days of
>>    strbufs).
>>
>>  - if we are going to pass a strvec, it should almost certainly be
>>    const, to make it clear how we intend to use it.
>
> All true.
>
>> These cases are largely stupid things that real people would never come
>> across. The real goal is making sure we don't get hit with a memory
>> safety bug (under-allocation, converting a big size_t to a negative int,
>> etc).
>
> Yes.=20=20
>
> =C3=86var, I do not mean any disrespect to you, but I have to say that
> topics like this one are starting to wear my concentration and
> patience down really thin and making me really slow down.

I'm sorry. I'll try to lay off on the patch firehose until the delta
I've got in master..seen is way down from what it is now.

> Perhaps I am biased by not yet having seen what you eventually want
> to build on top, and because of that I do not understood why and how
> these "clean ups" are so valuable to have right now (as opposed to
> just letting the sleeping dog lie), which you would of course have a
> much better chance to know than I do.

I could go into that, but it's probably best to leave it at: Yeah for
these seemingly going nowhere small changes I'm generally taking them
somewhere interesting.

But figuring out how to split that is still a hard problem. E.g. I've
had one series (the fsck error message improvements) that's been stalled
for ~3 months due to size/including the "interesting" part, but recently
relatively small increments of prep code changes seem to get a lot of
review traction.

As for this strvec.h s/int/size_t/ topic. I'm not taking that anywhere,
Jeff suggested it and came up with the patch, I figured more helpful
than "if we change s/int/size_t/g for x, shouldn't we change that for y
which whe assign x to?" would be patches I had to do that, which I'd
come up with after Jeff suggested this direction in response to another
topic.
