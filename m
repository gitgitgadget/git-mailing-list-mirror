Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E8EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 23:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53356103C
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 23:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbhIPXO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 19:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbhIPXO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 19:14:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10255C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 16:13:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c22so22699965edn.12
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GyR95eCEWBSjzOsbMRNsAVxMwGURaXfSpXSHLb4Tmac=;
        b=XMGgAN8XUnenZTRfNcyC1qajMsq5nyrwrjvZHHvHQXrYFlVj05zwT52ZYgah821Y3j
         xQ4AuQHdLmvIxOPLfdtC7gpvsX5rMCe3P0RvjYvGRMhXZ4nCKgDmSWYK/6YZu+mXRx0b
         +5xvLvyiRMIppadlS+9zMR/NQReUpj+oKpJHuIiEb66oMLB9DZQG2KJ6ilWViJVmJU5J
         rKjuA7MCiU87TzGJxO8tgZZ5PxXcynL47WAiei3XhBfmuHeuXAiRV3dm21CFAhwn9ELi
         SDAi1xbZhoEKmoOW/f5wZcQmtkd/la1Osy2TJlE2Koh4kXlw3M2JL8Z+YZ3LOIqRlh19
         M7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GyR95eCEWBSjzOsbMRNsAVxMwGURaXfSpXSHLb4Tmac=;
        b=wcFHLqY6Ub2/PYgnXS77kPjVER4w1Ny/AH1fpYB98OKhl/MjCI1WITV1DYMPJQ3M0m
         moumCyi1BrpVGj1Zkv8ToxfQ/rsjaZ3T8GaFqsRdSDDe3qZML1Gqzm708am6eiZFpd+C
         B0IdQ6+kUwfgnHBsmJniH7+csleqNDGk8bIr73ibFFNT/oXJOZiBORszNiAcoEBZxmgj
         CTV6yurmYNK/4qcRIXmsKsCGGjRYMixSqc2Id5dC7U3Rvj8p8och1z/ZML1G/+v6P9St
         kw9Pp0W3a0TYaQVe7CfD0Ko0s6caDouP0N62GMfRsLLa7hlW9ESR+b/YgHj0f5QVOucn
         l+iA==
X-Gm-Message-State: AOAM530v/vTfMsnBslOybZacRC6VkpVonpVLoq5BQ6wAKMHaMV3Af84M
        e6xKoCvGLqsaJ+BK2wiOldM=
X-Google-Smtp-Source: ABdhPJyJFD/bUj8U3C5bWHm9hspTtLVdsoqPylG8rbEc8o0dCyoSmI9LJIOWl/dFcfYjMlFqmormyw==
X-Received: by 2002:aa7:c1c6:: with SMTP id d6mr9251324edp.117.1631833983491;
        Thu, 16 Sep 2021 16:13:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z12sm1890455edx.66.2021.09.16.16.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 03/22] cat-file tests: test for missing object with
 -t and -s
Date:   Fri, 17 Sep 2021 00:52:11 +0200
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-03.22-d442a309178-20210907T104559Z-avarab@gmail.com>
 <YUOhqnj7vwr00Qap@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUOhqnj7vwr00Qap@nand.local>
Message-ID: <87fsu4f729.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Taylor Blau wrote:

> On Tue, Sep 07, 2021 at 12:57:58PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Test for what happens when the -t and -s flags are asked to operate on
>> a missing object, this extends tests added in 3e370f9faf0 (t1006: add
>> tests for git cat-file --allow-unknown-type, 2015-05-03). The -t and
>> -s flags are the only ones that can be combined with
>> --allow-unknown-type, so let's test with and without that flag.
>
> I'm a little skeptical to have tests for all four pairs of `-t` or `-s`
> and "with `--allow-unknown-type` and without `--allow-unknown-type`".
>
> Testing both the presence and absence of `--allow-unknown-type` seems
> useful to me, but I'm not sure what testing `-t` and `-s` separately
> buys us.
>
> (If you really feel the need test both, I'd encourage looping like:

Thanks, I'll try to simplify it.

>     for arg in -t -s
>     do
>       test_must_fail git cat-file $arg $missing_oid >out 2>err &&
>       test_must_be_empty out &&
>       test_cmp expect.err err &&
>
>       test_must_fail git cat-file $arg --allow-unknown-type $missing_oid =
>out 2>err &&
>       test_must_be_empty out &&
>       test_cmp expect.err err
>     done &&
>
> but I would be equally or perhaps even happier to just have one of the
> two tests).

A loop like that can be further simplified as just (just inlining
arg=3D-s):

	test_must_fail git cat-file -s $missing_oid >out 2>err &&
	test_must_be_empty out &&
	test_cmp expect.err err &&

	test_must_fail git cat-file -s --allow-unknown-type $missing_oid >out 2>er=
r &&
	test_must_be_empty out &&
	test_cmp expect.err err

:)

I.e. unless you end &&-chains in loops in the test framework with an ||
return 1 you're only testing your last iteration. Aside from whatever
I'm doing here I generally prefer to either just spell it out twice (if
small enough), or:

    for arg in -t -s
    do
        test_expect_success '...' "[... use $arg ...]"
    done

Which both nicely get around the issue of that easy-to-make mistake.

We've got some in-tree tests that are broken this way, well, at least
4cf67869b2a (list-objects.c: don't segfault for missing cmdline objects,
2018-12-05). But I think I'll leave that for a #leftoverbits submission
given my outstanding patch queue..., oh there's another one in
t1010-mktree.sh ... :)
