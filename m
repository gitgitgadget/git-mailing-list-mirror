Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E62DC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 15:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhLUP1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 10:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLUP1D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 10:27:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F3C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:27:02 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y22so53598857edq.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FOA10efqhFwotqth8hk3aSu7CFPCOzyZVpzhwFyYZk4=;
        b=TF3Dpg2CoHP/VAGgPr7GZa060vUtgUMcHTDVN1Ui/5FdEfQjYKtfvvWULYbNOMT+Ek
         Rf6dc6LoqJwhDqpyju2eaEj2XuxdNERFd3PJvaMdo8/3BfTxip/dipus8yqe03nZOAqM
         /zm7hGC8SOTpn4uXTF2QCeb+ALH1/aW3A432fC1SERLkLT5ziUFWSgzS5R1uyzoIOWlh
         cDPDr2NqPG6dqelDseNecc/YMjTdHDPbmDLwlVgpAZY5F3XhPac11JhV7iixqrxnl1Vm
         YjamC4kRHZMXmh6HpWMoldSvUKIxowZMcDt2piHfAcF2YpCiUImSityjxE7m8Mcvgy31
         +wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FOA10efqhFwotqth8hk3aSu7CFPCOzyZVpzhwFyYZk4=;
        b=Xe4J2F9HtWLzMEMY3JrtzxztYCGC0Ksb6/aG4cAD97S9hkWGFZ16fhQ7yNnvg+K678
         NeG29tAi2JV6cfj/Pe6XDAbtihs3ruYJqWpI2z2rzmVqjvEcjW6MRgLeYamfdiHaxAgS
         jHP3bUTUW8jACYD01uJp4zhNG1kmiZkMzCUAGjdwUvo/7bDmqRRKBQFrurNwMqnyq0oo
         uBMisqscHwMnq13mR7HOHyr9gtQaji/qvHrJ3whxszUycBKgfMzorDs+X6jN7/l+hxqa
         6MFEXl1md974OY7W5wmXSaC2NbEdMrwcdkaxnw/P48AIRnMEQPn2JGmXUgY9ahm/1Kv8
         uHNw==
X-Gm-Message-State: AOAM533C55xbJPxY+pt/u87rt+zktHbq3+cTNeaTp5kBoKj+9AXQHFXu
        iN5WAwjatdbFVPCKHA+bt8U=
X-Google-Smtp-Source: ABdhPJwWTsD14e1pqmbygoWBcfnyoV0GX4w2UG68K5y1AwApKAOFZ4MxVITZvcJQqMlW8rmWZe5ciQ==
X-Received: by 2002:a05:6402:424f:: with SMTP id g15mr3369582edb.217.1640100421320;
        Tue, 21 Dec 2021 07:27:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j5sm6692626ejo.171.2021.12.21.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:27:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzh2a-000mj1-8y;
        Tue, 21 Dec 2021 16:27:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/9] reftable prep: have builtin/reflog.c handle
 "--verbose"
Date:   Tue, 21 Dec 2021 16:21:06 +0100
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
 <CAFQ2z_McOfm545Xd8hF7YDgzyOjDmcGxpWZ6pQ-yaKAEWMMbgg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_McOfm545Xd8hF7YDgzyOjDmcGxpWZ6pQ-yaKAEWMMbgg@mail.gmail.com>
Message-ID: <211221.86lf0eq8qj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Han-Wen Nienhuys wrote:

> On Thu, Dec 16, 2021 at 2:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> This series refactors various small bits of builtin/reflog.c
>> (e.g. using a "struct string_list" now), and finally makes it handle
>> the "--verbose" output, instead of telling the files backend to emit
>> that same verbose output.
>>
>> This means that when we start to integrate "reftable" the new backend
>> won't need to implement verbose reflog output, it will just work.
>>
>> This is a sort-of v2[1]. I ejected the changes at the end to add
>> better --progress output to "git reflog". Those fixes are worthwhile,
>> but hopefully this smaller & easier to review series can be queued up
>> first, we can do those UX improvements later.
>
> Thanks for sending this.
>
> I looked over all patches separately. Overall, the series looks good to m=
e.
>
>> int a one-line terany instead.
>
> ternary.
>
>> "don't do negative comparison on enum values"

Will fix.

> I would describe it as "use switch over enum values", as this doesn't
> involve negative numbers.

*nod*

>> collected.reflogs.strdup_strings =3D 1;
>
> This puzzled me. Why isn't the init done as _DUP ? Warrants a comment
> at the least.

Will comment on it. FWWI this is a common pattern with the string_list
API.

If you declare it "dup" and push into it you'll end up double-duping,
but if you don't declare it dup'd and free it you'll leak memory. It
won't free() a non-duped list.

The other option is to declare it "dup" and then
"string_list_append_nodup", will try and see...

>>  .. goto expire
>> ..
>>    return 0;
>> expire:
>
> (personal opinion) this is going overboard with gotos and labels. Either
>
>   if ( .. ) {
>     expire =3D 1;
>     goto done;
>   }
> done:
>   if (expire) {  print stuff }
>   return expire
>
> Or wrap the existing function (without changes) in a callback that
> does the print for you.
>
> your call.
>

Will experiment & see, looks like a wrapper might be easiest here.

Thanks!
