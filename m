Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2047C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C891660E77
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbhIGUXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhIGUXC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:23:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A60C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 13:21:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g22so15596332edy.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Sb4WxW1fUhg1l4R2T9Bqj7OuY6aN4AsBJ0a3eCgr19I=;
        b=VQbHFMF4ke021LSZXgsPWQT1po2nSJwhplBk+3zylzMhOjM4VF1lybThnTyjmuU3H3
         2qhHzWjeu4M47Xv35fEbMOG9W07bBRc+qNUYu7hLqm5NFL3wMx39RIA40vqbcW0MzJ8F
         h5kErfa9341WNaYCZvhGrDwmKwDRDN+0kCnT0Q7/Zp74cQHXJ/rza0db8WMHTx15BAL2
         2uZ6a6uBMZKDvrWsWCsKuMv9qlSswNNRag5roil8wifJtvP3RBxT+f5W1jU5LFJJVY1H
         wowhwIXMoQ7SpKrTdgcdy8flEr1dUSyFTl7Uf6pePL68xQV/QccRHtQTZUbO/MdpNZ3h
         jaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Sb4WxW1fUhg1l4R2T9Bqj7OuY6aN4AsBJ0a3eCgr19I=;
        b=m/6LGzfjPN/FvfqdlS8P3mJcBdqmx/SqLtk/pAsWjMfk3VG6YL97ydiOBTYekcJzX9
         4r8xU4ojJrRB0NSEPT5KPy6RIbPvS5SJH0FEXClU4MSscq3vuakpkoQQ8DxKRo7HS6En
         vjGMlgkIVzFjLZ7sRh0UrddQUYyINcBKPcw+UycXQydl2Pc+W4y9SVkRrwfJXM5kX2F2
         b3TlyMWfl1cg2fC5FRPqiS3VT8o9i6AUngIlhlQUiD9kXhuB5SY7PcyvSBg5leC0yvCo
         eivcxTFPsKXo6ru/D3/ZWSo16c1YQQaaNSp3uK9Aux7A1Uf+1SKVZ8qTzT/3Wd8YS/i4
         9uOg==
X-Gm-Message-State: AOAM530DrOozGUk/9rYMl9+g6x1Utxs9mVz6vHvIlHJoioNi6okpdftr
        G2Ah2kd1g+dhisumknz+esw=
X-Google-Smtp-Source: ABdhPJzf0Rfup33IwphkETxNV+WH6C9y2J364Opfd4HD5SObrqOyy72ZY2MuWt742oJAmrsVbhVaaw==
X-Received: by 2002:aa7:cf1a:: with SMTP id a26mr81580edy.116.1631046114593;
        Tue, 07 Sep 2021 13:21:54 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n18sm5941816ejg.36.2021.09.07.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 13:21:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 1/7] git-sh-setup: remove unused git_pager() function
Date:   Tue, 07 Sep 2021 21:58:11 +0200
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
 <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
 <55293c43-811b-b030-9512-7525f5ebfd12@gmail.com>
 <87czplnxn3.fsf@evledraar.gmail.com>
 <8912317f-7eb0-edae-29e3-2e05099bc696@gmail.com>
 <87eea0n04u.fsf@evledraar.gmail.com> <xmqqh7ewb5a8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7ewb5a8.fsf@gitster.g>
Message-ID: <87tuiwjfvi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> No, they need to know to call 'git var GIT_PAGER' rather than using
>>> the environment variable directly to pick up core.pager[...]
>>
>> Sorry, I should have said "...directly via git var GIT_PAGER". I also
>> see that we could improve some of the doc cross-referencing here,
>> i.e. "git help git") doesn't make this explicit or point to "git var",
>> but we cover this in "git help var" itself.
>>
>>> [...]should be checking whether stdout is a tty. That is why this funct=
ion
>>> existed and we didn't just check the value of GIT_PAGER in our scripts
>>
>> For a hypothetical out-of-tree user is this really something anyone
>> strictly needs? It's just an optimization. If you don't do it you'll
>> just use your pager to pipe output to a non-tty.
>
> The question we should be asking when we advocate to remove things
> is "is this really something we absolutely cannot live with?"
>
> But answering your question, if an out-of-tree user wants to behave
> just like Git, pretending that it would have been part of Git and
> the only reason why it is not is because it weren't invented here,
> yes, not forcing the end-user to pipe the tool's output to pager is
> something they would want to have a handy way to mimic, I would
> think.

I've made my preferences clear, but can live with whatever criteria we
come up with.

I am having trouble squaring the desire to keep git_pager() with the
view you're describing, unless it's also an implicit endorsement of
reverting a89a2fbfccd (parse-remote: remove this now-unused library,
2020-11-14).

I'd obviously prefer to see git-parse-remote stay gone. But if we're
worried about removing once-documented "git-sh-*" libraries from under
users who peeked under the hood at some point to see & use functions
within them, I'd think bringing back "git-parse-remote" would be more
likely to help those users than having a git_pager().

And once we're rid of all our own use of these libraries but still want
to ship them forever for such users, I'd think we'd want to bring some
version of a revert of 49eb8d39c78 (Remove contrib/examples/*,
2018-03-25) back, i.e. just to make sure we don't break these going
forward, as once our own use of them is removed they'll be completely
untested in-tree.

Anyway, as noted in <87eea0n04u.fsf@evledraar.gmail.com> I was hoping to
take a small step towards finishing up removing the libintl dependency.
But after this discussion I think I'm back to mentally classifying that
as too tedious of a task to even try, so I wouldn't mind dropping this
series of cleanups if we've landed on a consensus of keeping
git-sh-setup bug-for-bug compatible going forward, and by extension
git-sh-i18n.
