Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF5C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 09:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhLGJ3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 04:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbhLGJ3K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 04:29:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2596BC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 01:25:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t5so54356165edd.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 01:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=H7aBhc0eZ+2UT7FabqR+Z8UoWmt/OWc5MbCVaDJC/IE=;
        b=qEOOyX83eKDq0UIDvV59ja7Qa9qC5/CAId2ZG7NZKrz1Ning+r81sDYaL8kCDsqz0K
         YXCFdRxr0AVj88NTZ2SAAC9jybHmE3pVsbFsRK8JI2Evv5UPfw7zX5wjQzFKVpV7YRav
         WwQk1AcF2D5Jgw+XYQgHwOkPZ5jBnbhbozOiOWfqjNDT3xfdu5gBzfb/fJxRz3+GYal4
         lPGbNItVNOJK/eCyiw+MMlnxxabIwn0qj+2ZEZ2ZeRuCPX9YZ7TeUK/2Qrz1TofKApDH
         057wF1JWDVAR6EwvlYL4TF31kevRW/f1zPA7Ncwe7i1mZ2C4as3dWinrr1FzO8zpXjcs
         lXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=H7aBhc0eZ+2UT7FabqR+Z8UoWmt/OWc5MbCVaDJC/IE=;
        b=fivYSD4Hoa4nT9n60uGVo+5bkt3FhwJE/GvGdOkr1o4T6nLGj+KhMHmJUP/gblOgpv
         /2VnAYDnJvf4Jc1W+LtpcM/ZgkZUlNJIogdb8k761Ueg2qEE8sCCVzyKCiCOGrsML/Ec
         oHVtyQ0Yma4KTSp/ZMhb9RLvKUzRIb9cIkgV5UWx+kPsA0irUljbXP2kT9QRNirb34vE
         WOzpYYbSmHhxOkRuZM9C5Yc3tuphDWNeu36CIaJSm6KmG9egbV0OFh+cGGdUzyK3OJZz
         eX8WAjJgwcMijsFCmC4/eCfQEBAKn8zMW0SUWL/4rLbz/Mvihyv7dQqm1s6U4tni98Of
         wI/g==
X-Gm-Message-State: AOAM530Bl1wnEWsBrOMYjG/nLqIYSKxTfpMw3gC9LQP3xO/hXsCJBrMj
        W9bnnAsDCBHhwUoRGnzTCrM=
X-Google-Smtp-Source: ABdhPJyP9bRu4+JBAC/6Aw+cUS4agchE1Rli85fx3UiRdPT1scGOM9JSHd3DoFCj91NCElZvwJPzAw==
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr52501148ejc.12.1638869138134;
        Tue, 07 Dec 2021 01:25:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yc16sm8149250ejb.122.2021.12.07.01.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:25:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muWjA-0013eq-Rn;
        Tue, 07 Dec 2021 10:25:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: en/keep-cwd (Was: Re: What's cooking in git.git (Dec 2021, #01;
 Fri, 3))
Date:   Tue, 07 Dec 2021 10:17:53 +0100
References: <xmqqh7bpqhf0.fsf@gitster.g>
 <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
Message-ID: <211207.86ee6opy0f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 06 2021, Elijah Newren wrote:

> On Mon, Dec 6, 2021 at 5:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * en/keep-cwd (2021-12-01) 11 commits
>>  - t2501: simplify the tests since we can now assume desired behavior
>>  - dir: new flag to remove_dir_recurse() to spare the original_cwd
>>  - dir: avoid incidentally removing the original_cwd in remove_path()
>>  - stash: do not attempt to remove startup_info->original_cwd
>>  - rebase: do not attempt to remove startup_info->original_cwd
>>  - clean: do not attempt to remove startup_info->original_cwd
>>  - symlinks: do not include startup_info->original_cwd in dir removal
>>  - unpack-trees: add special cwd handling
>>  - unpack-trees: refuse to remove startup_info->original_cwd
>>  - setup: introduce startup_info->original_cwd
>>  - t2501: add various tests for removing the current working directory
>>
>>  Many git commands that deal with working tree files try to remove a
>>  directory that becomes empty (i.e. "git switch" from a branch that
>>  has the directory to another branch that does not would attempt
>>  remove all files in the directory and the directory itself).  This
>>  drops users into an unfamiliar situation if the command was run in
>>  a subdirectory that becomes subject to removal due to the command.
>>  The commands have been taught to keep an empty directory if it is
>>  the directory they were started in to avoid surprising users.
>
> Very nicely written summary.
>
>>
>>  Needs review.
>>  There are some comments on earlier rounds; the latest one needs a
>>  serious review or at least Acks from past commentors.
>>  source: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
>
> If it helps, there are two parts to the review:
> - Do we want this feature?
> - Does this patch series implement the feature correctly?
> Let me mention both:
>
> Much of the discussion from commenters was actually related to the
> first point.  While Peff suggested the idea, and Taylor and Phillip
> (Wood) spoke up in favor (and I obviously cared enough to write
> patches), =C3=86var didn't like it at first.  After a lot of back and
> forth, we eventually discovered some misunderstanding after which
> =C3=86var, while still not a proponent, dropped his strong objection ("I'm
> much more sympathetic to this approach now."[1])  I was unable to
> determine the opinion of other reviewers/commenters on this point,
> though if I had to guess I'd say Junio is at least marginally in
> favor.

I just really wanted you to pick up & run with the "let's not die then"
WIP work I had, but I also want a pony. So ... :)

IOW I do think it would be really worthwhile to pull at the thread of
not dying, and I just find it a bit conceptually unclean to not /try/
and just die (or recover) on the actual OS error we get.

But I also think I'm just nitpicking / being overly pedantic there.

I can't really think of a realistic scenario where users will really
mind the behavior change you're introducing (in a bad way), but the "in
a good way" case is clearly something that addresses an actual problem.

So I've got no objections to these changes going in as they stand. If
anyone is interested in pulling at the "let's not make it die" thread
that can always be done later, or we can make it configurable or
whatever.

I don't think this needs to be part of your initial series, but just a
question:

Isn't a logical follow-up after it to change the various things like
"git bisect that refuse to run in subdirectories to happily do so?
I.e. the reason for those is specifically this "cwd goes away". Both
because of our bad handling of it, and due to any user confusion that'll
be addressed by that cwd sticking around".
