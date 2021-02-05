Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ABFC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425B764FF9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhBEW2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhBEOWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293B0C0611BD
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 07:49:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jj19so12675397ejc.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Et+YzlxYFoX7Fky5Da0s/Ta8TnwbZBjWzflD9UtIKs8=;
        b=n3r32B3vuXsuNvcXn45b94UnosK6ekp0iWWpn9qbVih05bPOL9oWp3fszBx3RQGOMQ
         A+vwNeuecVdKf42vEFgNpT1VywvY/9iZVA8gtKLbUVrUlCEITVy2YEs8Qfy+M83eAB6T
         rbwZdSnJUyY9CpQjy0xOELBupLeHkMbPHHY+BYDBciXtll8Laf6y/pU0/JxvVr1NPTqB
         7ekBsHl+awU8OgiD4GeElmQgZjSMbhKko/1BAON+FpeFO9TDlVRg6CqMvtSBvXi+gGWf
         e1keqmpY+qTtTiBsGkX0zo+CS1kCTyYtbZTMYfIDsQScljkqo+IsQv97KA4Db52acxuB
         rExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Et+YzlxYFoX7Fky5Da0s/Ta8TnwbZBjWzflD9UtIKs8=;
        b=R7LHU7peuhVHr7Cvk8zpwTXPTXrJGNzBtVCike+w4XQbqXooTRhTlwRWvohCabYjJ4
         4p/NOoXvYrIN9/1zfVTRMtS5jwCa+4P/aeGvxnhF/iuQiaSf4X19yaR+KI9PBu2Ooi76
         vu6b/e8iQ1FVSwx4srtIZo64XFboDWyKVI/g0xzB7rDSpeJW3NpGL6Ic7ajX//XTSvz7
         EibJ/wbFQERMx95LgLSnmr8F83JLMaAFY3Yuf4giaFkxhfDQety0V05Nt9DEzr1yb6S6
         kZwuyIg+SIpUkcuQ9UxzhEf7diDLIPV1CQoKJ9K0MpJH5f8xNJ9qDWMfXwz+iYs/UUIf
         jyYw==
X-Gm-Message-State: AOAM533pGO83LXeeWK2nQEgOBiIiGMZaLdsPrw0ykIfRKajMNph24+Es
        RkIWaHfip6TbLPEjwdTjoL0Ozef9fEswXw==
X-Google-Smtp-Source: ABdhPJwEQOXiZZyro9i8ITckh8uGlRlEbWgONi0Qk4+DKNS1nbwWYSS9XiiWwnw0JknTJkAP/qTydQ==
X-Received: by 2002:a17:906:82c9:: with SMTP id a9mr4464572ejy.547.1612538724405;
        Fri, 05 Feb 2021 07:25:24 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id b17sm4070835edv.56.2021.02.05.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:25:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: Why does fast-import need to check the validity of idents? +
 Other ident adventures
References: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
 <pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com>
 <87bld8ov9q.fsf@evledraar.gmail.com>
 <xmqq7dnpc610.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq7dnpc610.fsf@gitster.c.googlers.com>
Date:   Fri, 05 Feb 2021 16:25:23 +0100
Message-ID: <87k0rmcza4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 03 2021, Junio C Hamano wrote:

> "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=" Bjarmason <avarab@gmail.com>
> writes:
>
>> But I was wondering about fast-import.c in particular. I think Elijah's
>> patch here is obviously good an incremental improvement. But stepping
>> back a bit: who cares about sort-of-fsck validation in fast-import.c
>> anyway?
>
> Those who want to notice and verify the procedure they used to
> produce the import data from the original before it is too late?
>
> I.e. data gets imported to Git, victory declared and then old SCM
> turned gets off---and only then the resulting imported repository is
> found not to pass fsck.
>
>> Shouldn't it just pretty much be importing data as-is, and then we could
>> document "if you don't trust it, run fsck afterwards"?
>
> If it is a small import, the distinction does not matter, but for a
> huge import, the procedure to produce the data is likely to be
> mechanical, so even after processing just a very small portion of
> early part of the datastream, systematic errors would be noticed
> before fast-import wastes importing too much garbage that need to be
> discarded after running such fsck.  So in that sense, I suspect that
> there is value in the early validation.

What I was fishing for here is that perhaps since fast-import was
originally written this use-case of in-place conversion of primary data
on a server might have become too obscure to care about, i.e. as opposed
to doing a conversion locally and then "git push"-ing it to something
that does transfer.fsckObjects.

>> Or, if it's a use-case people actually care about, then I might see
>> about unifying some of these parser functions as part of a series I'm
>> preparing.
>
> I think allowing people to loosen particular checks for fast-import
> (or elsewhere for that matter) is a good idea, and you can do so
> more easily once the existing checking is migrated to your new
> scheme that shares code with the fsck machinery.

...allright, depending on how much of a hassle that is I might just add
tests for the differences and leave this particular problem to someone
else :)
