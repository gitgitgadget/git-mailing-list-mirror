Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB1EC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiHATBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiHATBB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 15:01:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088941EAF4
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 12:01:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p5so14930165edi.12
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9jPDIWvwc72BBf6NhEMFkRqWALhgWXyisr2fFIwoGSc=;
        b=JfsazYU7eDCufWZwOJgnKwGD0l9rVvQY+yTUiZlNqKbBuJiw3m73cCg0tCBeuhbhAW
         a6NxVaUEd5dMgpYUaMIUNJP0RTnst6a4Mp0767juCM2PEirvxDQwcL2fOazh9pqmFI8x
         8tDq9UExI0Ncpaur/T4KP4DdCp1xKZoTdbm7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9jPDIWvwc72BBf6NhEMFkRqWALhgWXyisr2fFIwoGSc=;
        b=MEvOF1/1avhlVGE2U+6k+3r4dA1dOc3O8AbBGFtzLoHrrn9+v8KWWyedSBUQPXAkg4
         77oroO6su4uRcGiD726Nhn2D/P9R/qkB3AH/AYSU3nz4G+rEixLHi1vrHksOsIntCJDT
         0RpVRB18GbZvDMCOmn2FMT+55kjuQlxAlFWBqxFCEAYm1j1I/KeIpdVdODbIVg3hyyS0
         GArcITl1Buuu4CogyAYsTb3nV+E5mm5CqNsstv4GIdKyXMNhuSsxw/G8D9/DYL26cyyQ
         NRa3QdkQ5C/zDsB2766+FWzYEkboeSd8XsEi3x64qnxik7IwHqbHz5PZNlyLxo1udeW/
         Xvaw==
X-Gm-Message-State: ACgBeo335ZOJXnoMXRTMFDBW3VsTyse6vagY3+VQkkHnainva7cHMfrH
        LFtntRfls0H/ZSspL2UdMHw/3b9xJLuHPuvrH+M=
X-Google-Smtp-Source: AA6agR6VPlNxZUlEBx67A5CioJ1KH1yehxvizcp2PDU2/UFx76PUFtcVmqwQB5DlR2VRUwAkVvOgJQ==
X-Received: by 2002:a05:6402:35d5:b0:43d:a02f:cbfb with SMTP id z21-20020a05640235d500b0043da02fcbfbmr6392227edc.275.1659380458324;
        Mon, 01 Aug 2022 12:00:58 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b0072af2460cd6sm5455280ejt.30.2022.08.01.12.00.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 12:00:57 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id l4so15270003wrm.13
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 12:00:57 -0700 (PDT)
X-Received: by 2002:a5d:59a4:0:b0:21e:8704:ea35 with SMTP id
 p4-20020a5d59a4000000b0021e8704ea35mr10389778wrr.442.1659380457273; Mon, 01
 Aug 2022 12:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net> <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
 <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
 <YugQqp4oN26OFOpt@coredump.intra.peff.net> <YugYNzQYWqDCmOqN@coredump.intra.peff.net>
In-Reply-To: <YugYNzQYWqDCmOqN@coredump.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 12:00:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh64fFWR_=tMFLVW-ozHb5w2VoAGgpsMAuSNDVYexRRDw@mail.gmail.com>
Message-ID: <CAHk-=wh64fFWR_=tMFLVW-ozHb5w2VoAGgpsMAuSNDVYexRRDw@mail.gmail.com>
Subject: Re: "git symbolic-ref" doesn't do a very good job
To:     Jeff King <peff@peff.net>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 1, 2022 at 11:15 AM Jeff King <peff@peff.net> wrote:
>
> Just to keep things moving forward, here it is with a commit message. I
> left you as the author, but if you're OK with it, please tell Junio he
> can forge your sign-off.

I'm certainly ok with that.

That said, I'm also ok with not getting the authorship credit for this
at all. Not because you wrote the commit log and updated the patch
with REFNAME_ALLOW_ONELEVEL and added a test-case, but because clearly
Michael Schubert already did basically the core of that patch ten
years ago.

So Junio, feel free to add my

  Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

but feel equally free to give credit to Jeff or - belatedly - Michael.

                 Linus
