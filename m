Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830BC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 07:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiDRHcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 03:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiDRHcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 03:32:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192F17077
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 00:30:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g19so9121861lfv.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RLRqmddJxPhV11dKQOAYcfkpfICKlva3M6DKLUnwcq8=;
        b=pQbsOg9Lky6QiJqn0o8FzcQgj8ZpaIE9LQ1Zc91VCR+d/3qMH4QshOxblvjPnU3Rae
         7SfNkwTA6r3xssnCrZifmHyxV9jHygdsimMX5D65eDgfHaVMDNbI5grEgfxYcP06AZIk
         WwwQfcMoV+IEC4x4oQhb6PuDX0z1HFOBUD3g97w2ypFENRicJAqqTTNfT368Mu+W+n17
         EvuXf9UK+Y+t7MhbUixPa/RcaCYRpHVh4wVwJqbE1OupwHtwcF7h9pnNXVTfdtQOmFz+
         ifxa2sdc6GSKwYptc2WruVa7ZT7Tf50+Ehn6V/7iy8mY+x/TLMwTa5VXA2U0M3/aG2ta
         ZA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=RLRqmddJxPhV11dKQOAYcfkpfICKlva3M6DKLUnwcq8=;
        b=RwsWEUYAxEOnc1jArrQclUnnAgAD9oYWwbn2vjjEYURtsZXLmretrn3sfqGPe5avMg
         F8g5w/uzpts/LhmWvlmP5ZbkIQg6R/An8bosWqNmVYW5OO231VkdIm5JU+Fj8I9du7Yp
         7V6+06RBW3tIM0E7zxIvZFXt0loPMldxYIwgkyzfM2wjmY7ssP0IDZYGC5AghcwgJYFC
         v/C0lPqcYWiP2i5XkNfDru75xblI6PLhiBPeu3nFzNPiVIa39nfPyyISnBILDLeVTFxT
         CPTxYyIx+prSpDiIXAXprhv4lWztyfYrLiR3iChwCLfizRjWyuj62Ta5CFRYLzz+N8da
         JbUw==
X-Gm-Message-State: AOAM532soxtrfDlL/uz75MCTOmxDXU3xfi0v7l36QbvfDNE/MKQjObTR
        tTq8KuzjqagN9Rz+ptd+YOOIwb+rrJE=
X-Google-Smtp-Source: ABdhPJyqiU7OrVCA1VXT4v5mJJhm8ahCk098vIDhssp556uFILe/PvDp4NSckAPfdV2vy3402tvriQ==
X-Received: by 2002:a05:6512:c28:b0:471:9a7d:de9e with SMTP id z40-20020a0565120c2800b004719a7dde9emr1359641lfu.440.1650267002038;
        Mon, 18 Apr 2022 00:30:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a13-20020a195f4d000000b00443a5302315sm1136804lfj.30.2022.04.18.00.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 00:30:01 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [RFC] introducing git replay
References: <20220413164336.101390-1-eantoranz@gmail.com>
        <xmqq4k2wap8g.fsf@gitster.g>
        <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
        <xmqqbkx2ccj4.fsf@gitster.g>
        <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
        <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
Date:   Mon, 18 Apr 2022 10:29:59 +0300
In-Reply-To: <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
        (Elijah Newren's message of "Sat, 16 Apr 2022 22:05:46 -0700")
Message-ID: <87lew226iw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Apr 15, 2022 at 10:41 PM Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>>
>> On Fri, Apr 15, 2022 at 10:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > It would be wonderful if a single command like replay can be used to
>> > say "In the old history master..seen I have bunch of merges.  master
>> > used to be M but now it is at N.  Rebuild M..S on top of N _but_
>> > with a bit of twist.  Some of the topics in M...S may have been
>> > merged to 'master' between M..N and the replayed history on top of N
>> > does not want to have a merge from such 'already graduated' topics.
>> > Many topics are updated, either by adding a new commit on top or
>> > completely rewritten, and we want an updated tip of these topic
>> > branches, not the old tip that I merged when I created M..S chain,
>> > when replaying the history on top of N."
>> >
>> > That kind of operation is quite different from what "rebase" does,
>> > and deserves to be under a different name.
>> >
>>
>> Let me work a little bit on your workflow to see what I can do.
>
> Replaying merges is something I've put a little thought into, so allow
> me to provide some pointers that may help.  Merges need special
> handling for replaying, and in my opinion, doing either just a new
> merge of the new trees (what rebase --rebase-merges does), or just
> reusing existing trees (what you proposed to start this thread) are
> both suboptimal, though the former is likely to just be annoying and
> require potentially unnecessary user refixing,

It silently drops user changes as well, and that's the worst thing about
it, not annoyance.

> whereas the latter can silently discard changes or reintroduce
> discarded changes and could be dangerous. More details on both of
> these...

Please consider yet another option:

https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/

that at least is safe with respect to user changes.

-- Sergey Organov
