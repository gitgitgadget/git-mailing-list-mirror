Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC8C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0272604D7
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhH3Nm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhH3Nmz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:42:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC975C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:42:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso8206wmi.5
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xcCu3gZbxG6HFYESt3Tpl3SDLmsTj+/SZJiM7FTIe/Y=;
        b=cZVdkVcALGilwiWhcQm20jxBc7RCiWU/5JuOPnZ/QljP49OpjGm1aR264M7TXQ7Pq0
         z4LbLFEA2aJvdlY1nCz1V10nRXKgtweAAHIKzlvZWucgfo72ppdLzVWNxNij+7SaDWQB
         SXpjJhhiNx6UDqX54w6xMH1DxP7sTd4WoaWwefGK4serQZPg22L0tWlpIgpHqJXQ33x9
         tafwHz13Q0sQnf7SzHC2e78eegpQKynYMJwiWCmGMVL9EpLh8oKLuHO91ZmbnhIrD4J5
         yPR9EwsQ5XVI/1fcSXVNVP9oAoOQxxMxUqgGfi4x5knQkxduCxL9E7iUAPvxov2y9LSi
         Xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xcCu3gZbxG6HFYESt3Tpl3SDLmsTj+/SZJiM7FTIe/Y=;
        b=K4j2y18qUmWNgCOcKsvqYqZ8OPpBBC5KlXgwtDtigaYQ9nn5rG1wIrTMDe+jkAYVSs
         eB60AazSY4mhVKcWdxQ99pvb3XHDWOtzBPmNXtmG3R6KtehgdxmlmI5LWiSB3MdPGjTi
         DbYPFG71zfMJSRJ7/Bd4XtaO5f9KTNaUYodMC5lY8znwPovRSbYlYBO/xy3WcqUXF6o5
         +fTSt1IVXULTX/NK6CrevEqDG+y2DrfQlCTDVonUa+n1pyHtLkDxFCFpM/09FhxIvFSq
         YtBG6mQkWvHJOuvla1QCd0RDJHRC19nzyrHAnSWqTu7CpHcNdXVglPrqGymRB1qZyfxY
         r06Q==
X-Gm-Message-State: AOAM5327DDGL7R+0RrpnUMo8LswufOS30Z1a1k+jOMcfW+u1DZHjtAUI
        33ZwHZozx9YdM8f5XkFL0c8=
X-Google-Smtp-Source: ABdhPJyixUD8S7L9rWKYWYCOaquKzz2UtTRwBJ01dmTDzDV6+w3D1r3p4alHb4LgmRJCYvukWmZfyw==
X-Received: by 2002:a1c:9acc:: with SMTP id c195mr33397699wme.69.1630330920481;
        Mon, 30 Aug 2021 06:42:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o5sm15279161wrw.17.2021.08.30.06.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 06:41:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Clemens Fruhwirth <clemens@endorphin.org>
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
Date:   Mon, 30 Aug 2021 15:27:03 +0200
References: <xmqq35qr7mq5.fsf@gitster.g>
 <87tuj7xhqo.fsf@evledraar.gmail.com>
 <CAFQ2z_PCUr3D0H-fzfHcFFayzdDJc64=JgVM5_2kuLJn-G9awA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_PCUr3D0H-fzfHcFFayzdDJc64=JgVM5_2kuLJn-G9awA@mail.gmail.com>
Message-ID: <87o89fxd5l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Han-Wen Nienhuys wrote:

> On Mon, Aug 30, 2021 at 2:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> Han-Wen: It would be really nice to have this re-rolled sooner than
>> later, my and Junio's "fixup" commits at the end are a band-aid, but I
>> already ran into wanting to bisect something between master..seen that
>> was unnecessarily painful due to the series now not compiling without
>> the "fixup" commits at the end.
>
> I am folding in the __FUNCTION__ fix.
>
> However, I thought patches should be sent against the master branch
> and not against some intermediate  version of 'seen' ?

No, per "Decide what to base your work on" in
Documentation/SubmittingPatches. See the part about "A new feature
should be based on `master` in general[...]".

In this case the topic on Junio's side isn't based on "master", hence
the bisect breakages noted above.

I don't know per the upthread what Junio's intended pace of merging down
ab/refs-files-cleanup and hn/refs-errno-cleanup is, depending on the
answer to that perhaps it would be best to wait and re-roll on a new
master.

Also for any re-roll of hn/refable, see my
<877dgch4rn.fsf@evledraar.gmail.com> for notes of other breakages in
it. I also had the impression based on my
<87h7jqz7k5.fsf@evledraar.gmail.com> and your reply in
<CAFQ2z_P8vgY0RRT+XSH9K3VDQt39FLqXx6qfeZqaZPkwhq1w+A@mail.gmail.com>
back in April/May that the intent was to re-roll this topic in a way
that would be more split-up as described there.

I don't care much about the exact end-state there, other than:

 1. Trying to land reftable/ in some shape where we're not constantly
    re-reviewing the "add upstream library" part of it.

 2. Not have something like hn/reftable in-tree which per my above is in
    a demonstrably broken/experimental state, but our docs are in state
    of noting it like it's just another ref backend. Hence the
    suggestion of first landing the library with its own tests, getting
    the integration and GIT_TEST_REFABLE passing, and finally updating
    docs etc. to advertise the thing to users.
