Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D3BC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 12:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbiANMAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 07:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiANMAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 07:00:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352BC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:00:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u21so34115464edd.5
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6zEB0cEJIPBSpTzE0bibjstAbXigSXi8lt+S0Y+Zq88=;
        b=k2g3vm2u8eEtCY7ipS0lh8JXTRkBodgG2+cv5H4/DocnpNwQLOPhqatpzuuTO4kHlc
         c1p2/KguP1MQI0sWRyQ0Dde+pbY4TIEtPpanV1HbbZrmGetxn5i8eWQ6BPX6uE6/xOP2
         JDF9gN6uLktbf/HbQU4dFXGGBQomWVShufN3u0aB1v4fqm6OfH/wJwdoap1jzZK4/BOl
         2ON1Oy89pqv0jmrDoejeE0OpHWQYgXluHVOSJ0DWQyBVP795lrL3W1ULbURGkBt6aBL3
         vWjw/bh1BfEEtaJ22xjwDGjmNMbgjuKuC1LON7INKJIoWs5N7n7MYMrqJuUfls3OXoFX
         X3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6zEB0cEJIPBSpTzE0bibjstAbXigSXi8lt+S0Y+Zq88=;
        b=KYaOlqaBlpSqA2XZ6qlPyt8BfembXEG5X4JEAr5aHfwSplDnpO9Qg3trNhRSG5cbDA
         Q86T/TZPorRUj5CAtbL5CttJvMPjqY+q1aG0pM8e1rjQCok2vIi57hzH88bGmn+rd+Wx
         ad9zULo8A2HJrKlNQ9nwESADCEAQdhe/xJqnyofkPW8y/haxNt0HPR6VZvd3jzdsntqN
         xj9hYD5Uxr+EfUwPmXiauBTK/t9tWN94jEksqGzKPVP3RKVJLWFvP1VlHHsV63+axQ8R
         VFXYPOUWm2U+/vkD5ZfqGENJ1wrkXQLncGh9a4xyGcfcwnEX5HXv55lDzW9k8VLinXx4
         ekcg==
X-Gm-Message-State: AOAM533SAquY8V8ksd8upZYSyXpzBF8nLFWBT8M/J3e1g0zWzyEhKXEv
        98GT+7p+KiQVmEdZXWBzqBM=
X-Google-Smtp-Source: ABdhPJzHMxrmKCWmga+HDuLhfBJ/9gXDMiuSLzKbznUqyd/Hy21e4DVuZEd8jbnR0DkIP0I0lIHvmQ==
X-Received: by 2002:a17:907:a414:: with SMTP id sg20mr7016248ejc.42.1642161620673;
        Fri, 14 Jan 2022 04:00:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c19sm2331521ede.47.2022.01.14.04.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 04:00:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8LFj-0015Bq-HJ;
        Fri, 14 Jan 2022 13:00:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Teng Long <dyronetengb@gmail.com>
Subject: Re: [PATCH v10 5/9] ls-tree: optimize naming and handling of
 "return" in show_tree()
Date:   Fri, 14 Jan 2022 13:00:05 +0100
References: <cover.1641978175.git.dyroneteng@gmail.com>
 <b04188c822c32aab6ef59099a0c9078aeda065c3.1641978175.git.dyroneteng@gmail.com>
 <220113.861r1cxgxx.gmgdl@evledraar.gmail.com>
 <CADMgQSQ3oWAbDMK73hEwZKJHhO_k8CuJdC2TNWW0+kv1TzYfRQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CADMgQSQ3oWAbDMK73hEwZKJHhO_k8CuJdC2TNWW0+kv1TzYfRQ@mail.gmail.com>
Message-ID: <220114.86ee5attm4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Teng Long wrote:

> On Thu, Jan 13, 2022 at 2:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> Re the $subject: Is "optimize naming" here just referring to the
>> s/retval/recurse/g?
>
> Yes.
>
>> Personally I think just a s/retval/ret/g here would make more senes if
>> we're doing any change at all, and in either case having this variable
>> re-rename split up as its own commit would make the proposed control
>> flow changes clearer.
>
> Do you mean that I can split the current one into two commits,  one does
> the renaming work and another one does the left work?
>
> If so, I will do this in the next patch.

Yes, at least I would find it easier to read :)

>>
>> This new function is a re-invention of the object_type() utility in
>> cache.h, and isn't needed. I.e....
>>
>> ...just drop it and do this:
>>
>>         -       enum object_type type =3D get_type(mode);
>>         +       enum object_type type =3D object_type(mode);
>
> You are absolutely correct.
> I will replace get_type() to object_type() in the next patch.

Thanks!
