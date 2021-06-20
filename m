Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E3C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CE5610CD
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 13:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFTOBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFTOBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 10:01:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90134C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 06:59:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l1so24165118ejb.6
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=n0eXFM9wy+tiFAGKokOvDVXKWmIpkQFFv0pa53e9Y4U=;
        b=vZcXMVM6GgonVme0ZRAgVR/8XDJHJOAn/J1LCtxbnlHEH4epuHaJB1o3ITu3SroOv7
         hESqzeRC981a42pP8bPO214i7MsCP99FQfNKyT+/TWhhAd0WqVgWwnwso75xYJurKEfu
         eqDbiGJXWgzx8oaYGAN1Ol66EWBjDjQ5zfhyLe8TIvTYMUTzSo9rMooX5ITj84f3n5Ja
         ytF+5WslzdjXnMGE1STy+Jw+SwDyK6qYsJmd04GLoPTwGpjJqqMO7mw2Yc19BjpvrJot
         6Wm1NeUnghqJtIxiCCqh+VfY/IWWNV4kvP6Gy5nY7GoJf3gBv7O/r2056ztwqhKYECf9
         XLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=n0eXFM9wy+tiFAGKokOvDVXKWmIpkQFFv0pa53e9Y4U=;
        b=B9Aaz7/DfCT0ThCB9hOnHD4rQyJwgfS3/Sw3p5INhHbS8SLTI3zfs9t6NrmrAFIvDc
         FRBBP5qGu3fi+nPQMW7qBINtkZrDFRJm3PQzb1hRpcuY9diaStLeUF6pgiinDQBYQcul
         NL3iQBJHwEvYD1CdGRwr9N2itZTmwmuh1LDAjCB1u7VEpsyokX26AhK7F4uyCp1QJAwP
         FlSEBdI37zl87yiqY2k1TkS5WH5iUfb2R0j2qg/z8wIpQUD+SXhehdG/MxYnKRS7HRaJ
         6ETENd/eHf7FkmrKJosTL5iHCCOyMRzx81JXwvcmmp6ALwm/dpmBsBcJDe9cWnBHmSmL
         aJ3w==
X-Gm-Message-State: AOAM5317iBejIpK/ms4O7diCql6KpTsU0WV+tvCohdceVZ6nIRl6W8LX
        ke7Yz422Oi719eUvZV0UfME=
X-Google-Smtp-Source: ABdhPJwtFvMEbjq1I+VC7PKWOBw4rb6vQMYpRJdriy4ZSmrwis07bAgAzenkaEW73slzmGbkxyqNAA==
X-Received: by 2002:a17:906:b254:: with SMTP id ce20mr10599807ejb.480.1624197540907;
        Sun, 20 Jun 2021 06:59:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x17sm2525399edr.88.2021.06.20.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 06:59:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
Date:   Sun, 20 Jun 2021 15:53:35 +0200
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
        <patch-3.3-f343fc7ae6-20210617T100239Z-avarab@gmail.com>
        <20210618170550.GE6312@szeder.dev>
        <CAPig+cQvn+_56iuZmvHVDFSVYto-FMX2vp5aaEGrdr8L8+NY0w@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAPig+cQvn+_56iuZmvHVDFSVYto-FMX2vp5aaEGrdr8L8+NY0w@mail.gmail.com>
Message-ID: <87lf744oyk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 18 2021, Eric Sunshine wrote:

> On Fri, Jun 18, 2021 at 1:06 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>> On Thu, Jun 17, 2021 at 12:09:36PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> > diff --git a/generate-hooklist.sh b/generate-hooklist.sh
>> > @@ -0,0 +1,24 @@
>> > +#!/bin/sh
>> > +
>> > +echo "/* Automatically generated by generate-hooklist.sh */"
>> > +
>> > +print_hook_list () {
>> > +     cat <<EOF
>> > +static const char *hook_name_list[] =3D {
>> > +EOF
>> > +     perl -ne '
>>
>> Why Perl?
>>
>> At the moment I can run 'make' and get a functioning git even when
>> Perl is not installed.  With this patch that wouldn't work anymore.
>>
>> Both 'generate-cmdlist.sh' and 'generate-configlist.sh' can process
>> the documentation into a header file with a long list in it without
>> resorting to Perl; I'm sure that hooks could be processed without Perl
>> as well.
>
> That's a good point and not an idle question. It wasn't all that long
> ago that I rewrote `generate-cmdlist` in Perl and got a complaint that
> the Git project was no longer buildable on FreeBSD[1], with the result
> that I ended up re-implementing it (again) in shell[2].
>
> [1]: https://lore.kernel.org/git/loom.20150814T171757-901@post.gmane.org/
> [2]: https://lore.kernel.org/git/1440365469-9928-1-git-send-email-sunshin=
e@sunshineco.com/

I'm sympathetic to changing this from Perl, as can be seen from the "v1"
(as part of another series) I intially used an unportable grep flag for
it. I'll test and probably convert it to Ren=C3=A9's few-liner.

The [1] link is not it not being buildable on FreeBSD though, it's
someone understandably not understanding what NO_PERL=3DY means, because
we really should call it PERL_ONLY_FOR_BUILDING_AND_TESTING or
something.

Aside from this series it would be useful to clarify that point, what do
we really think it means? I was under the impression that it meant that,
and I really shouldn't be giving it a second thought if we introduced a
perl dependency during the build or testing.
