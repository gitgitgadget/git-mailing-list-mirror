Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1DBC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01256109F
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhIFWZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIFWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 18:25:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E5C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 15:24:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bt14so15895158ejb.3
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MZzt4A1Ht8rYVohRG9YNVSrqBkGxlT4oKemCwvXEyDs=;
        b=lctMWfp2QsAYa0BW/Y5tszz3Ac/StjHgu203go3AXW1hNki/PzACHqAJ4q8yag+8Gf
         V64SzKsbfDhDXe8gbnKGKWDbOude8OF3Nv8KF+XH77JU8ZNLJgZbx2AZvmH+yO71f0rp
         EStECUBEn34V1V6qeaDCdJ1Wc2noca3tEdnrcT5eIux0NP5b3/+OUieCvuj9qiQBekHW
         VXH3aS+JRzrTp7wpF93Nsf0KPmK88PKAHoh+rFqxEMBQhmZJrcAbkNyCp6BsF0haipWi
         orKH0Gg3e65VLI5zRBFUtu6wdr0KHGoA6r2LEZWUA4heBusE6oUwoJLC6NKP4YFb6PjN
         P05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MZzt4A1Ht8rYVohRG9YNVSrqBkGxlT4oKemCwvXEyDs=;
        b=LjvjSYG1VXUe0L4WKnQMHMoQGpfesBkxLA6y+qo2zbXiHlt4CLkh0iEwh+rQa1QqvN
         iWHX9LKOR8oYcrIEYoOmmvzCwJ3+Cwg9dMRW61001F1ZeKDvI0bN5OztCQDfs8gm3Pj2
         c7Bvp+pkbGLgb+rqvpOyLzijeOEfokQKhpOBJUkJCGpvRIjCf4xgO1vHY+1HrqMKb9MJ
         iw21/RDVNcyKXbi3iRpqx9eM/RSixf54CGC26rts8vGMjYOCl01O/TZHNCz3Gw21/CY0
         vXiZYNH6FQ2eXg9tB6Yc3v1s9chKoc8iiu0kweF7f8/BIf40QLhymXtCXuLU/P/JPoA4
         xeTA==
X-Gm-Message-State: AOAM530j1QFZJljr76wGuCywrCcxISNloyuGOoMmtOmcUz0fCidbVspR
        1T57N1Kj1Ry50He2tWoM3t8=
X-Google-Smtp-Source: ABdhPJzjOqfFvRFMbEFBlf1fXDP/ESckeQwk7xXqzf8S3e31l0NsRHWH1zFlbZEBefuPQNjXwjZWBg==
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr15316866ejc.537.1630967091260;
        Mon, 06 Sep 2021 15:24:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e3sm4500738ejr.118.2021.09.06.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:24:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
Date:   Tue, 07 Sep 2021 00:21:28 +0200
References: <xmqq35qmiofp.fsf@gitster.g>
 <CAFQ2z_N8pUsp3cdBpybHBD-V9_1sARCZvSxr0UkMfcwCoQfCbw@mail.gmail.com>
 <xmqq4kaxe5dt.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq4kaxe5dt.fsf@gitster.g>
Message-ID: <87h7exnxzh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwen@google.com> writes:
>
>> On Fri, Sep 3, 2021 at 12:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>>> * hn/reftable (2021-08-26) 29 commits
>>>  - SQUASH??? https://github.com/git/git/runs/3439941236?check_suite_focus=true#step:5:700
>>>  - reftable: fixup for new base topic 3/3
>>>  - reftable: fixup for new base topic 2/3
>>>  - reftable: fixup for new base topic 1/3
>> ..
>>>  The "reftable" backend for the refs API.
>>
>> I posted a subset of these patches as
>> https://lore.kernel.org/git/pull.1081.git.git.1630335476.gitgitgadget@gmail.com/
>
> Thanks for a ping.  I saw it but haven't read it.
>
>> As discussed with AEvar, it will probably speed things up if we can
>> focus on getting the base library submitted without hooking it up to
>> Git. This would avoid cross-interactions with other pending topics,
>> and reduce the size of the more controversial topic (hooking it up to
>> Git).
>
> My worry is that a "base library" that is not hooked up to anything
> that works in the system would not be properly reviewed at all.  Of
> course, without review, it would speed things up, but it is unclear
> if that the kind of speed we want.
>
> Anyway, I'll eject the old topic and replace them with the latest
> one soonish.

The proposal is to still have it hooked up to t/helper/test-reftable.c,
the build system, and t0032-reftable-unittest.sh.

So we'd build and test it on all platforms, getting that working in some
stable fashion would already be a big step forward.

What we wouldn't get right away is the series as of things like
0a0d5fe74d4 (refs: RFC: Reftable support for git-core, 2021-08-17),
i.e. hooking up refs/reftable-backend.c, changes to refs.[ch], running
reftable with some mode of "git init".

As discussed elsewhere that step would currently fail with some tests
failing, but most/all of those failures are due to the integration of
the reftable library into git, not failings of the library itself or the
reftable format.


