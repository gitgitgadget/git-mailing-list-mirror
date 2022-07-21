Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE4C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiGUTBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiGUTBI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:01:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C37B796
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:01:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sz17so4739748ejc.9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9dP4/Yx1UWg1cn3u6g7ngQPzziudMC+RtfSWH6S7KpU=;
        b=RSQt9bxIedpTiA91sBezKnk6Hs4G1MRdaCsO/kq59i0BqVP7YLqU8ySIi6nlXoySDp
         UdYFgSLBEk267QRZpPnOcMJqCj/AtI4LNthi8RCawd6NRz5tvvGrz6f/IYvdLl46U/DY
         wsWEGeUT2WqnhmmabLG9wAxQfqv99KVwYvef1lzRBRie597W17kiqldqvhR7hnWfM00d
         N8/gWi4Xm3iF8d96mz2gYymI7RoWH/bBYLDhuyKgbQFQarO6TQdzg4VZB49n+4z6b/yq
         kKWBSDMC6lEswm9wTwIHVYt6c7K0tlpr8HP9VCWeGhbeXHGg2eXxWk4I1ox/pFFMXu4S
         wEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9dP4/Yx1UWg1cn3u6g7ngQPzziudMC+RtfSWH6S7KpU=;
        b=itPBweYP40keRx7+CSNJrcyfJPLp6rPe+4p1DdrMinWzzDVnvZ4N/jcz/SanGq7hw7
         Gp+cKvIoBphECd9LWOgXl1ReDKcxAQjDFdIxkTYp/F8vETXVj7s3zkED8M1ZsHuibDLb
         Bdlc0uxvSiYmHzEtxw9mLSkKoLToVyGit/n6WRgHVxm/l/8mE+QikaMVobek+2bMP70Y
         /6rMD/zgqbb45jZaybkUKErxqbmoFFlq9f/4SHbDo++X72lajw7S4OXtz0cPzNrY3u93
         2FnlQqa6hZFjOlUPnn163PhDqTg5nAZ0tYPVHQDln+zisILh0eI+J85mTmRc7nF4pkkU
         U2Qg==
X-Gm-Message-State: AJIora9Ag4SDZ4q/Ajs4xolnyTttLVkYsDhzo/Ze+/2VO7euAYKxBAhj
        1kGe9ZU4RFa0Ilu+pNAyZAVCj+zJFqUdWw==
X-Google-Smtp-Source: AGRyM1scEUKE1A6JQ+O9JMm7hmiNiLJBCf55eSUc7e+2IDcd/XLUxrG/OExhjPOyvWre2z4mQ2ewAw==
X-Received: by 2002:a17:907:2ce9:b0:72b:30e5:f1bc with SMTP id hz9-20020a1709072ce900b0072b30e5f1bcmr40581105ejc.127.1658430065246;
        Thu, 21 Jul 2022 12:01:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky13-20020a170907778d00b0072f112a6ad2sm1112197ejc.97.2022.07.21.12.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:01:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEbPz-004mdc-KZ;
        Thu, 21 Jul 2022 21:01:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: On-branch topic description support?
Date:   Thu, 21 Jul 2022 20:58:44 +0200
References: <xmqqilnr1hff.fsf@gitster.g>
 <220721.86mtd2tqct.gmgdl@evledraar.gmail.com> <xmqqwnc6idxr.fsf@gitster.g>
 <220721.86a692tkva.gmgdl@evledraar.gmail.com> <xmqqy1wmgx8t.fsf@gitster.g>
 <20220721182645.45xrwf2buohibcaw@meerkat.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220721182645.45xrwf2buohibcaw@meerkat.local>
Message-ID: <220721.861quethn4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Konstantin Ryabitsev wrote:

> On Thu, Jul 21, 2022 at 11:02:26AM -0700, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>> > But this is worse in that "git rebase" will get rid of it by default.
>>=20
>> FWIW, I think I like this much better than Konstantin's "there is an
>> empty commit at the bottom", for exactly the same reason why I like
>> the original "empty commit at the tip", i.e. simply because we can
>> strip away the "extra" commit that holds the topic description
>> without having to change all the "real" commits.
>
> I'm happy to consider alternatives if I can have a reliable way of tracki=
ng
> "the series we're working on starts at this commit". I know that this is
> antithetical to git's design, but I also can't think of anything else that
> reliably survives rebases.

Aside from any discussion of how such a "cover letter" thingy gets
represented in the DAG, I wonder if rebase should be less aggressive
about wiping away merge commits in general.

It's really handy to e.g. fix something where you've got repeated merges
of the "master" into your branch.

But if you've got some novel merge structure that's existing purely
within your branch perhaps we should at least show some advice() before
proceeding, or suggest --rebase-merges...

I haven't thought through all the edge cases with that, just food for
thought.
