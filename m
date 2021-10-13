Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E3C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 15:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E945B60EE9
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 15:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJMQCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbhJMQBy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 12:01:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE79C06176C
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 08:59:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g25so10042991wrb.2
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5Be9LvAMKwY4q6iqSFMJsrgynoeAjbr2Hr9nfu06Xxs=;
        b=Zobk6v83lJp3GgRX0MkTYJBWXTBl62J37g/F+6qUMANPoHU2WoB9xdplI0UzxjG4v6
         Z0mtMmaN/JZKDBqm7HpNA7GdMgHFHSqj7WkIi3otZ/9zVN49iUdbZ/yzXYPyUgLq5ao7
         bS0dWDZVoiq9B/Ng9qr/s6Q0VxgAauSwabydQzwGJZGSd7XMrH1gd7om6luMbB2dvBia
         lHWJ1KjOmeLfqrU+MiKUwWYL4OUOSuJpda+/SZVc6UqbL7bLAVdQOZaFdrAr+D7/7ftv
         9RhRAtBwHK77S+0bYu0J62/yRBUbKlj8qRWs2TyqK1WovK7ecNca32GeU6xkjxhbhlO7
         Es0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5Be9LvAMKwY4q6iqSFMJsrgynoeAjbr2Hr9nfu06Xxs=;
        b=pvCa5tjS3HQE2NKoqWlUytoXn0fp2YadDwoTf2gxIkNVTR9JuDyluA3GFUa6z6OZDS
         IBjRTMVRnGZJ4U2ca9Rc5oPcVV7LX+dwFbpFwcGgUDgfF9YLLvFnVn0t4AjRCkkSXHOc
         LbO1Hh1eUAZGCzp6OXlSG+ntWoDkAzf+mLLYR0jD4m2RHs+4rYwGX4sxJ7aM+OqSBQ0Y
         5YPZqjw/IayBjjxcqNBO8hHO7JhGOBPnYceWn/VYxIeUFZDSfYkwp/vAq/Wimc2+cMUV
         dEFthGeuslRp2Gkt1vaKT1sTKIkjF7McVyPf1KmSsmdTj7ssUEdocfgJvPjB3YdR5r0z
         o1wQ==
X-Gm-Message-State: AOAM531cntsVAufTbY99ej57dWive6oLmJyn3fXxYkatq2DmnjE7ubdK
        TpU//QoD+/+a8ZcsqlmhSMA=
X-Google-Smtp-Source: ABdhPJwvcVrFmffQK87AXl+1S7M2c9wRQG3EYQFnAEoUUa0BYeUzJ9laeXuFvGA6TRtyFtJRO4Pp3g==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr12207wrr.106.1634140789424;
        Wed, 13 Oct 2021 08:59:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v18sm12595171wrm.63.2021.10.13.08.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:59:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
Date:   Wed, 13 Oct 2021 17:57:57 +0200
References: <20211005001931.13932-1-chooglen@google.com>
 <20211012174208.95161-1-chooglen@google.com>
 <87wnmihswp.fsf@evledraar.gmail.com>
 <02947b5e-7ce3-4760-0d27-621c7362f839@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <02947b5e-7ce3-4760-0d27-621c7362f839@gmail.com>
Message-ID: <87pms8hq4s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 13 2021, Derrick Stolee wrote:

> On 10/12/2021 4:34 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:...
>> If I comment yout your addition of GIT_TEST_COMMIT_GRAPH=3D0 in that file
>> I see that we fail N number of tests, but all of them are actually
>> fallout of just this test:
>>=20
>>         git replace $head_parent $head &&=20
>>         git replace -f $tree $blob=20
>>=20
>> I.e. we've created a replacement object replacing a tree with a blob, as
>> part of tests I added to test how mktag handles those sorts of weird
>> edge cases.
>>=20
>> This then causes the graph verify code to throw a hissy fit with:
>>=20
>>     root tree OID for commit 0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 in
>>     commit-graph is da5497437fd67ca928333aab79c4b4b55036ea66 !=3D
>>     0fbca9850869684085d654f9e1380c9780802570
>>=20
>> I.e. when we wrote the graph we somehow didn't notice that the root tree
>> node we wrote is to an object that's not actually a tree? Isn't this a
>> bug where some part of the commit graph writing should be doing its own
>> extended OID lookup that's replacement-object aware, it didn't, and we
>> wrote a corrupt graph as a result?
>>=20
>> If there is a legitimate reason why we're not just hiding a bug we've
>> turned up with these fixes let's disable that one test, not the entire
>> test file.
>
> The commit-graph should be disabled if replace-objects are enabled. If
> there is a bug being introduced here it is because the commit-graph is
> being checked during fsck even though it would never be read when the
> replace-objects exist.
>
> Thanks,
> -Stolee

Thanks, isn't the obvious fix for this to extend your d6538246d3d
(commit-graph: not compatible with replace objects, 2018-08-20) to do
"read_replace_refs =3D 0;" in graph_verify()? That works for me on this
case.

I.e. if we ignore replace refs when writing the graph, and we don't use
it if there are any due to commit_graph_compatible(), why would we
consider them when verifying it?
