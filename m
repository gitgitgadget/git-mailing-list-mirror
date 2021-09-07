Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6635C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CDC61131
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhIGTzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbhIGTzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:55:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28557C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:54:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jg16so533578ejc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dgsR13DwLrGbXXrnAzMgg/dIKWIoUGc8pKLcY3EqUZE=;
        b=Gh+0w8ImC8d1utqh9S8p7dvETvOyvwsuy3FUiM22wkKsKsR+mDU2g+sbh8Yqih6Xv0
         4a3eDupixHKcRHFlFdVpxaG3B3Lp48hPaEkfZT4aDbrNt6jCk5tbTMqBhtGmY8WUvKWu
         CIPite2AML0n7lbRwGA3lv6cBsCKlDaK9zgM20SD8p62hO+/K1JuoKpNPSTEJLyLo3OS
         5HX1Ve00pBYdjE7z10bfDMnFqPpqprDzGYQ19o3Ug1bjFXcyRABysr6R2sO0Steh1LEi
         lujM6DSaj6oIMi+Hce5iR0kivYK0FYJ1xJfqUPg/Ka/kpfUY12nEdjbHI0CgGg0gPG6H
         K8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dgsR13DwLrGbXXrnAzMgg/dIKWIoUGc8pKLcY3EqUZE=;
        b=dOAeTovuvhVJprKed5h5MRTWRBJHRboe/CBaXhMTTAtIh9quUkA7Hx1LhFmrWeARya
         CzIH5kzVbaX0mOMAj9KxFoYr52p2w4FFOZkxIfYSIA38liE9ol3G7Gd7C3AxDCRL9gB0
         Cxj3hTRdmK7GNXqM3q1KF6tVxmy7u+lheDSvGg7Lx5mVnOfUpuR6C4w2gdHJbijhQkgV
         Od9wy9uZAc0H7xgARFvDPR8zMtr7D+aeh/L40U8+qUTROuZExaVnvvBFgyQdCdf/vJMt
         c7NSqawdmnGcbYtnB2yw7s4t/f/fVF7x94NUM9Zfz6NDHzVkiySA/Yi7Hy+AhPM0ax1A
         q/7A==
X-Gm-Message-State: AOAM531OLkGiHkTe3hmvE3Mn7eteJChVZYaZvRUIyCGmcJHAgkle9jmy
        bzWatuSNbq3RsLw9tD6bDM4=
X-Google-Smtp-Source: ABdhPJx3rW9Sva/zKWV4KIRfkuue8QFugBtEHfQXSTEtCBLG9ig1XAbBVpasi0W7UbrMtExAFIb8sQ==
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr9097eju.295.1631044438130;
        Tue, 07 Sep 2021 12:53:58 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k15sm5951209ejb.92.2021.09.07.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:53:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
Date:   Tue, 07 Sep 2021 21:52:54 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <xmqqk0k0ndbq.fsf@gitster.g> <87y28anq98.fsf@evledraar.gmail.com>
 <xmqqpmtkb5r7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqpmtkb5r7.fsf@gitster.g>
Message-ID: <87y288jh62.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Sep 01 2021, Junio C Hamano wrote:
>>
>>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>>> writes:
>>>
>>>> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (whic=
h was
>>>> included in v2.22.0), we officially deprecated the --preserve-merges
>>>> backend. Over two years later, it is time to drop that backend, and he=
re is
>>>> a patch series that does just that.
>>>
>>> A good goal.  There is no remaining use case where (a fictitious and
>>> properly working version of) "--preserve-merges" option cannot be
>>> replaced by "--rebase-merges", is it?  I somehow had a feeling that
>>> the other Johannes (sorry if it weren't you, j6t) had cases that the
>>> former worked better, but perhaps I am mis-remembering things.
>>
>> Fair enough. To be clear I think this series is fine as-is, we've just
>> usually done "now that this function is dead, rm it" as part of the
>> series that makes it dead, so I figured fixups/squashes to change those
>> parts would be welcome & integrated, likewise Alban Gruin's suggestions
>> in <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>.
>>
>> But the git-sh-i18n.sh change and/or his suggestions can be done after
>> this lands...
>
> I have this funny feeling that the "Fair enough" is thrown at a
> comment that you didn't intend to ;-)

I think I meant to reply to
https://lore.kernel.org/git/xmqqlf4aejko.fsf@gitster.g/; I don't know
how I got them mixed up, sorry about that.
