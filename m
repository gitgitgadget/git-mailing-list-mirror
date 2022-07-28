Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E985C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiG1Q66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiG1Q6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:58:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF1B675A1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:58:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l23so4172230ejr.5
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=GPKKMC8n7ubYei8OYly7tt3tFLueqRMZ+nZ0MYEXcd8=;
        b=fNVmGmoG1RencnO8rdKJPcsLJiHOBhk8IwRhANm8ijDeeDgu/LrMSrz/3Up1gAGFOd
         zN+vqaPejvNssp9L6gEWIhNxQtbmipAK3NbUnxzWYmzQFHTLeOe7LiwnFhA5AzSV046X
         cKOwK0TbXarwGXIKaAe3FkEaAW/YoYsd2v6goJ8FS5EOeGPYIDJ+QyvDqI/XfVYv96Cj
         jGQp999Nt8diwM6mEDpFzr3kN5KCFnBu+o10o/cQaPZvSDtHMYIq7EWLRSE2z6BB+GkV
         qf73gkwVQ9kLrJnqFd7liNIqPIPvVx5Rhb23rOfHyUvpOWxoNcTGumPXTNxWUmYThY68
         8QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=GPKKMC8n7ubYei8OYly7tt3tFLueqRMZ+nZ0MYEXcd8=;
        b=J50n1Jz/1KJZxqF5elQ36pIhIZ39ewfqUk9nW8S/HzUjr/03pb9vl6JcCxKH6oXgug
         Ps5llqvbCg36W0LxMu+Kx7UaiF2D1VaywT6soDEp3kt9DyQ7aeOyuDP0n/tJ8aq0RSUe
         VI/Fuw8ouWgXEtUTOVaV/XcMcdF4I6dZd/jNiFVUICwpi/givAznj7fxZg4F0QCyfJhj
         r5bUtfoemVcyrvKAy4Kf6e8v4ACKik6I7kbuC++Cdb2ERv4dl5ThFa3xoXGlBza53yjz
         eSY4vDnqsN5w/mSpljFPVSuylIDw/qSDTVvX6vr5gvMXW7frgAsGA7SGV6PAuLYzA2dK
         fjpg==
X-Gm-Message-State: AJIora+K2+cqt3wVBdXd6gL+fYyQBLo83AaIL4AkgCOhlH0zwnecsd9B
        i7LaLrKPbeXtoH1Qgxs/NGHoSIpeJFVG6g==
X-Google-Smtp-Source: AGRyM1uO+3XNqXtJsE4rChkGd0a9sNqnzutQblpf4YWcZtvCYFyEM6dLf39uLiIluQ8AybRae+iKbQ==
X-Received: by 2002:a17:907:7ba9:b0:72f:2994:74aa with SMTP id ne41-20020a1709077ba900b0072f299474aamr21786247ejc.85.1659027531753;
        Thu, 28 Jul 2022 09:58:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fh22-20020a1709073a9600b0072fdb26bd9dsm605476ejc.173.2022.07.28.09.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:58:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH6qY-007BbF-LF;
        Thu, 28 Jul 2022 18:58:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Date:   Thu, 28 Jul 2022 18:54:37 +0200
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
 <YuGPeHn9wfF6tWA5@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YuGPeHn9wfF6tWA5@coredump.intra.peff.net>
Message-ID: <220728.86o7x9jhrp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 27 2022, Jeff King wrote:

> On Tue, Jul 26, 2022 at 01:09:13PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Per [2] the GitHub fork of git.git runs with these in CI, so it's
>> already useful to some forks of this repository.
>
> Yeah, it has been helpful there and I think this is worth doing as part
> of our CI. It's a lot of CPU versus running the test suite once on
> Linux, but probably not compared to the overall cost of our current CI.
>
> For the GitHub fork, the code-coverage issues you noticed were easy: we
> only built one variant, so we could just test with those knobs. ;) But I
> tend to agree with your approach here to just test on one platform,
> which covers _most_ of the code. It's certainly better than the status
> quo, and it strikes a nice balance of CPU versus coverage.

*nod*

> One thing I'd say...
>
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index cd1f52692a5..4f59a7aa44c 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -251,6 +251,12 @@ jobs:
>>            - jobname: linux-leaks
>>              cc: gcc
>>              pool: ubuntu-latest
>> +          - jobname: SANITIZE=3Daddress
>> +            cc: gcc
>> +            pool: ubuntu-latest
>> +          - jobname: SANITIZE=3Dundefined
>> +            cc: gcc
>> +            pool: ubuntu-latest
>
> There's really no reason to split the "address" and "undefined" builds
> into two jobs. We expect them to pass, and if one fails, having the
> results split is not likely to give any extra information. So I think
> one job with SANITIZE=3Daddress,undefined is fine, and reclaims some of
> the extra CPU we're spending.

I'll do that in a re-roll, pending a resolution of the naming discussion
at:
https://lore.kernel.org/git/220728.86sfmljhyx.gmgdl@evledraar.gmail.com/

But note that it *does* give you extra information to split them up
currently, i.e. the "test_expect_failure" that you get with "undefined"
isn't conflated with the non-changes that SANITIZE=3Daddress flags (sans
outstanding recent breakage) in the test report.

But just having that "TODO" test sitting there will suck less than
potentially having CI run much longer, or taking up resources from
concurrent CI runs, so I'll do this.

We also leave a lot of CI performance on the table by e.g. doing "chain
lint" in every single test run (except Windows), there *are* platform
edge-cases there like with SANITIZE=3Daddress, but I wonder if we should
just declare it good enough to do it in 1-2 jobs.

Ditto TEST_NO_MALLOC_CHECK=3D1 & --no-bin-wrappers, but we can think about
all of those some other time....

Thanks for reviewing this.
