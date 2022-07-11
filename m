Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEF0C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiGKMU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGKMU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:20:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D6E1758A
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:20:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w12so5260896edd.13
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IZM2K72xWO72dzi6mAc+/4PQJLqIJ0u+hR7eSUeEyak=;
        b=ZNCIJWdforI28Mv7QkKnmGMt2JfJtbl5ZAP/Ftpyv74fNZxNv8Te5f9P7CcyIGCWGO
         OzKUzT0vuMxZ/0WQXcRko7TUIhq891ymnqwh6izeEYYH3XwHPqujMu6fQtSSzn98fi5A
         J1JM7ab1+/YPu4YqE59sTrYZNFUgd8EMABRVYonnZl0l+kW4xC7OcNMapY5mD9DTdxIR
         SpQwr0g2BCTLbiR9by/xSGTuyOdg2rD8DAK4zpKAqMMai+ecpVfRGnGbfXqZyBroF0RV
         kOPvCU4wXVHfGF1sHbog0+n2CADus8+j6iqOqZBVkTYIaqq/wwYwuOhdRw0iN2ZlgyMG
         1rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IZM2K72xWO72dzi6mAc+/4PQJLqIJ0u+hR7eSUeEyak=;
        b=ceCS7L/jItVpNi7eAthE07Xba7vBzET6dEMSgfnJ0fi944QAR9Q8XA0xAPYhidV067
         bdM9uuRGvIIm1g4NA3OyRBU/la2sDJE4sBpsP3yF0RzajVc2ruH93dDrYsgy1SHzffgs
         dSDRcCpsqaN+4KvX4c/ioqsnlbjVaqSCJNxLUbk2wwOR59km0bd+XzktX9RIu4Qa04TD
         dNksEZFyyIa/AP3C8vld8YuKDWwaUl1PBjI+pCa/GNZfGPoCOst6lHlhEQXDwF0X5gNt
         ewPES314nzFUiGZCTwbEL1A1wJn2nfrkQ4tZiw4nBjlr6DYeKs5X5IJoAS7BK99E9P+C
         besg==
X-Gm-Message-State: AJIora8E2edOi64OZG+1taU/5Vk5zo3WD9u4tyIT6I42idiRgI85YP4O
        cnc7V7ioDHP2B/UuYZ4b/Pc=
X-Google-Smtp-Source: AGRyM1v0J84djEVnx+w7qsDDIk1RK9UaZsR2VaJRoCj/ea9R5sRKUWWIz+Az1xfjMFWd1Cmh2P9eGw==
X-Received: by 2002:a05:6402:42cb:b0:43a:5df2:bb5d with SMTP id i11-20020a05640242cb00b0043a5df2bb5dmr24664589edc.36.1657542054567;
        Mon, 11 Jul 2022 05:20:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q7-20020a1709060e4700b006fe89cafc42sm2653281eji.172.2022.07.11.05.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 05:20:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAsPE-000q1p-TI;
        Mon, 11 Jul 2022 14:20:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>,
        git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
Date:   Mon, 11 Jul 2022 13:47:06 +0200
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
        <220710.86r12t82ea.gmgdl@evledraar.gmail.com>
        <20220710145502.GT17705@kitsune.suse.cz> <xmqq1qutrkm8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq1qutrkm8.fsf@gitster.g>
Message-ID: <220711.86sfn77sd7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 10 2022, Junio C Hamano wrote:

> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>
>>> What do you think about this old patch of mine to add a 'git praise'?:
>>> https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com/
>>
>> Since you are asking .. I think it completely misses the point.
>>
>> I would consider it effective if users of git-praise(1) needed no
>> knowledge of existence of git-blame(1).
>
> I think you are the one who completely misses the point of him
> sending the URL (hint: what is the date of the patch?)

I wrote it as a joke, but that was in 2019, and I think at that time the
idea that we needed to do anything about the "master" nomenclature was
equally far-fetched, but here we are.

While I wrote it as an in-joke, I think some version of it might be
something we'd want to integrate, whether that's (optionally?)
advertising git-annotate over git-blame, adding a git-praise or whatever
else.

Clearly some users care enough about this particular thing to keep
showing up with some regularity to point it out.

Personally I think the "git-blame" argument has a lot more weight than
the "master" one. The latter seems to be the result of language zealotry
extending to usage that really doesn't have anything meaningfully to do
with the underlying issue at play (i.e. a US-based political movement
that seems to have had its zenith in 2020).

Whereas I'm pretty sure that "blame" really does mean "blame" in the bad
sense of the word, but "in a good way".

I.e. I tihnk it's part of a history of playful language use deriving
from early hacker circles, *nix command nomanclature etc. The BSDs in
particular have a lot of that (e.g. "daemon" etc.).

Now, I think making a fuzz about this sort of thing is a bit silly, but
on the other hand git's used in a lot of different environments.

Depending on the proposed change adding a "blame" alias (or promoting an
existing one) might be a lot smaller of a change than everything around
"init.defaultBranch", so *shrug*.

In any case, I think anyone interested in pushing this forward (and I'm
not) needs to come up with some patches to move it forward, or explain
in some detail what is/isn't OK about some existing ones (e.g. my April
1st, 2019 "git-praise" patch).

I understand Michal's and Jonas's upthread suggestions as us doing a
s/blame/praise/g or whatever on the codebase. For backwards
compatibility concerns that would be a non-starter.

But users "having no knowledge of [the other command]" can stop short of
that, and that seems like a good idea in any case. E.g. we have a
long-standing wart of "git stage -h" referring to itself as "git-add",
and "annotate" has the same issue.

There's really no reason we shouldn't fix that, i.e. if we have an alias
and a user uses it, we should at least refer back to it consistently
when we talk about the command the user invoked.
