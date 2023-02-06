Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89888C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 17:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBFRWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFRWI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 12:22:08 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9542917C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 09:22:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hx15so36163922ejc.11
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81gCwr4ktX+8y1ZXMkN4OZ+qywluP15tcqwtzBRwXis=;
        b=RY1kQNZCib91+Pi4+ztZMlTs2ox/MZT5e1mPBw5qf+TEIVjHp0Hrj/wthRJiCkfoAE
         N3A/d6Lhhx0jWuPXDaV3YXeqla9BZ6UpH4WoRPIiwBSzb4dhezt6zkcqv6ewrvMBF+yV
         qB8SUgjUFYaWeg74vwn2+ejbHXpbYgrYKDLWWxw1xn5AwTo+SFXIGqKTWP8Xt1aT5StV
         0yqmLKZtPI/bs4K1P4/6ntv9joPc6zvuQC1Kw0tCHUhK3DiN9Bpc9pB8WegmbKsPSdch
         GsXqXlfQtY8UboN7RabEQNK6IQDSELXiuNBYx/frxwob8hrkzXEh4Vas9PDO5yQWHwm4
         gNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81gCwr4ktX+8y1ZXMkN4OZ+qywluP15tcqwtzBRwXis=;
        b=t99NYKHbz/yG5DDEjFE3pDn7lF88LPlvq+uspjcWgdGQoEMXv5B6r70VZvYI06Bstg
         Elt/KQLwsYNjTpHChFa4G0O6Q3f8JzXqlv0nA6Kf/2sv1QrFcF+HRDH22FQKOvO6abe6
         HtLE8DuVH5TRvIOrLgGMAsTEA0YNIoYPVleGFLtSJlvjMLHNcBGFATz7fwyDZADUnI3w
         bGaWa9d+hKKwKO5nrZb1j42obD2p7IFyY8KypcP6Tn7S1wG0TPR7cE3AUGGronxlMzhx
         QRfrMG5a4JuuUDnwBr41vZAXT1GxWGf518oCg6qSII3tLzcagGYHJoguLZlw5IwRjMtJ
         khTw==
X-Gm-Message-State: AO0yUKUCOHlMvaZyPCcAwovnoOafBEe7yP+w8uKcDgPYwNF1VoBFs7hE
        ia/ifRh09aXA/y+JGy+3Juo=
X-Google-Smtp-Source: AK7set/isKgIDHOn+pHoBjYNunE52mhrgbw4jUXNkGM4YVhS2obRcV8k+reO6VyrzEf5S8/Cp5wauQ==
X-Received: by 2002:a17:906:111b:b0:87b:bbdc:468 with SMTP id h27-20020a170906111b00b0087bbbdc0468mr44018eja.70.1675704122548;
        Mon, 06 Feb 2023 09:22:02 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id lv3-20020a170906bc8300b00883410a786csm5627504ejb.207.2023.02.06.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:22:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP5Bp-000RDS-1r;
        Mon, 06 Feb 2023 18:22:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 19/19] push: free_refs() the "local_refs" in
 set_refspecs()
Date:   Mon, 06 Feb 2023 18:19:14 +0100
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
 <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
 <patch-v6-19.19-67076dfba6d-20230202T094704Z-avarab@gmail.com>
 <xmqqfsbnson8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqfsbnson8.fsf@gitster.g>
Message-ID: <230206.86o7q6675y.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a memory leak that's been with us since this code was added in
>> ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03).
>>
>> The "remote =3D remote_get(...)" added in the same commit would seem to
>> leak based only on the context here, but that function is a wrapper
>> for sticking the remotes we fetch into "the_repository->remote_state".
>>
>> See fd3cb0501e1 (remote: move static variables into per-repository
>> struct, 2021-11-17) for the addition of code in repository.c that
>> free's the "remote" allocated here.
>
> As I noted in my review of the previous step, the "if !local_heads"
> change we saw in the previous step goes better in this step, whose
> focus is on fixing the local_refs leak.

As I noted in the reply there it belongs in the preceding commit because
we currently *don't* allocate in a loop, it just looks at first glance
as though we might.

In practice we have earlier checks that would have died if the
remote_get() died, so the current "remote" sentinel value always
includes "local_heads".

I'll send a re-roll of this sooner than later with something to address
your 17/19 comment, but am keeping 18-19/19 the same, unless you reply
here/disagree/I've missed something.

Thanks.
