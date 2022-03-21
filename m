Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EEC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345259AbiCUSQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 14:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352049AbiCUSQc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 14:16:32 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259B124C21
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 11:15:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so6080371ljw.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkpsltLW6uRdarAKeA23kTUh7VC5J0V++3oHshJkx7k=;
        b=VlJK55G4Sr6qJ/fcR7o+5bVPBeePLxv/5ENZEXDV0TQqk1joPwNIdwuKeWh3IQIlWd
         wQtvR8w3FJHRdR6NnBZE+V1pgjjOsQ8Lij1SLHWMC/WyxB8rFjRPonIxtYu8EOqbgFg1
         KetbSO3zAD7FHzulfyIRyUsLdzk1J4BHSCpS3/8rBlsYGD8ojzNyKUtDf2oS4kUix03X
         k8YF0QrY3rfhuiqSlGtz0KZQPqNe81Ml+l1lf0Q/rXfhEDzA6vryScGB6LRXgTJ90P/f
         QZC9Zs8bzsIbVRtAvDBi2m9oGWS7Rqs7bniEwk8SIe+lEaV6F/ySLltrXg4hEEma5m+7
         9KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkpsltLW6uRdarAKeA23kTUh7VC5J0V++3oHshJkx7k=;
        b=Tl/E347tzb7Sq0hzTuyfMNM2LvzUY6mjjqQmfCNPCFpw/2ECZ2ZxdNYzGTDsV4Ikw2
         ISh3Q/wP5R76c/SW0JcJNg2+A44fA5pXVc6An1rJ0t8nZAeaG/VoFObDlsX/i6TfKyv4
         ICi+aYg5i/t+g2nOJftjekHYQlbm+2h7CDTXtd0jYg8U0197CErOhOkQ8lKCjP9KaHOb
         fCtQgAJsGq/k2sDoCnk8rSxr4ckoc52sYD+tdAk94C+Xf9LBTLS5YnPxtpJnkUtklvKs
         lAF1W8YS/AtuzONfOgtRsNvXqdN12E5VzJPeRwIhmzX+YeRnL+pgJk7E+jukE/skRxLN
         FZGg==
X-Gm-Message-State: AOAM531CsVkObHBeMSZppZW5aFloGt8T88YPEJPpJ3aqeArOg174Gt0p
        PoSHEWYztuc9eSXbVzqWcMxQIdvFw/k5nwVGbco=
X-Google-Smtp-Source: ABdhPJyk++z+IGSL4oK7BB7oBbdOezvXsEDPdJ4P3YcqKB88FarNe8b0zo6PhjJ5077xnOTUmJwVw/Js8Ge3qI/5MrM=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr16018289ljq.172.1647886504603; Mon, 21
 Mar 2022 11:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <xmqqpmmf1bm5.fsf@gitster.g>
In-Reply-To: <xmqqpmmf1bm5.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 11:14:53 -0700
Message-ID: <CANQDOdfCJy68z0bNrhSmwo_uEVa6=y4V1dY0kZDq7JOTUD+6iQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 10:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> >  * Rebase onto 'seen' at 0cac37f38f9.
>
> That's unfortunate.  Having to depend on almost everything in 'seen'
> is a guaranteed way to ensure that the topic would never graduate to
> 'next'.
>
> For this topic, ns/core-fsyncmethod is the only thing outside of
> 'master' that the previous round needed, so I did an equivalent of
>
>     $ git checkout -b ns/batch-fsync b896f729e2
>     $ git merge ns/core-fsyncmethod
>
> to prepare fd008b1442 and then queued the patches on top, i.e.
>
>     $ git am -s mbox
>
> > This work is based on 'seen' at . It's dependent on ns/core-fsyncmethod.
>
> "at ."?
>
> In any case, I've applied them on 0cac37f38f9 and then re-applied
> the result on top of fd008b1442 (i.e. the same base as the previous
> round was queued), which, with the magic of "am -3", applied
> cleanly.  Double checking the result was also simple (i.e. the tip of
> such an application on top of fd008b1442 can be merged with
> 0cac37f38f9 and the result should be identical to the result of
> applying them directly on top of 0cac37f38f9) and seems to have
> produced the right result.
>
> \Thanks.

Thanks Junio.  I was worried about how to properly represent the dependency
between these two in-flight branches without waiting for ns/core-fsyncmethod to
get into next.   Now ns/core-fsyncmethod appears to be there, so I'm assuming
that branch should have a stable OID until the end of the cycle.

Should I base future versions of this series on the tip of
ns/core-fsyncmethod, or
on the merge point between that branch and 'next'?  I guess it doesn't
really matter
if the merge is clean.

Thanks,
Neeraj
