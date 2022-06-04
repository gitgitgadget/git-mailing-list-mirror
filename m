Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D60C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 16:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiFDQVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiFDQVX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 12:21:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8123388F
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 09:21:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so8268450ejb.11
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=r2TfaQWG8hyNTA41N67YFuQ3ST7+ptz4mpqEvSfhirs=;
        b=RGnqyqDXO+a4jJsjSiDsZ5BX/bPIMWzxU9v5FrLRJHJwR5aiNwPZYKQBUhZFG53HdP
         119L2aLx9WObELnHWiRZ6yNgOOnXphrrQYHmWNIfaPEmDyOwZqour6EKj8v8OV938owx
         UUVFWNmAHR/ORxiWBHLgu9GMc3hRvDew0SvJyLNj4YVphvlL7FrdAonjCRS1ULHdj2pR
         FAggxR/xADoZ7fiEucsx6u2SY2QL0pf0Q/ozh4lVXxvUBUa1iY4YYGVQGY0/0CwjOYTg
         A/swUiWStj4dutMACTvHGhJU27s3w5zr2tpWncQceItf3/auxGEzQTNicRZCJ3DZRNOi
         iiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=r2TfaQWG8hyNTA41N67YFuQ3ST7+ptz4mpqEvSfhirs=;
        b=NIXvZUtljH0JCn6upxVXG9nrm0q4Cx7pF9fg/WzeBl7HIgZwtcpLksi9GGNiulPq9S
         1BFJOrQ3Kej8zTqzcXaR3s/qgVE4L0GvStu50wlkR3GX7jg7UOeohE4Lc4yiYCNsiSZs
         sNMKAwKcXGbCFKRPMvzt8Jc05OMkOingqOVTGZGDFrwG2jZLMuYQPbMnJ7q9qozH+b3w
         aUjKb7uHFmyp7w8AKV//RKrQSnPAWv7cuFJRdUP5aBISIMbuRnI0wpSERPT04rbLSKQa
         5hTBmz/dJNrXRTK6d0Be/NyQifRTP18gs/k51r4wALC9u4RG4MEGMMOUh8r/IJ8cEtuz
         ppWg==
X-Gm-Message-State: AOAM53057olhtNqBCzjrHmOI4JfSUnXCHRNe6w01bvDtAj/d4vFKg6kP
        HaVZG10g4ojyRYckXpJX2sY=
X-Google-Smtp-Source: ABdhPJzqq17rvQYW1cHXsi6d5zwS5+UZAEIk+v0DuumJP+zeJS3syY55IvTtV7HaBZwZP2JyCcQquQ==
X-Received: by 2002:a17:906:478b:b0:6f8:5850:4da9 with SMTP id cw11-20020a170906478b00b006f858504da9mr13594770ejc.619.1654359681490;
        Sat, 04 Jun 2022 09:21:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709067cc400b006f3ef214ddbsm4165694ejp.65.2022.06.04.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 09:21:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxWWc-001zz9-Le;
        Sat, 04 Jun 2022 18:21:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 01/15] remote.c: don't dereference NULL in freeing loop
Date:   Sat, 04 Jun 2022 18:20:54 +0200
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-01.15-b3a678d934a-20220603T183608Z-avarab@gmail.com>
 <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de>
 <2064938784.539963.1654347067250@apps.talktalk.co.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2064938784.539963.1654347067250@apps.talktalk.co.uk>
Message-ID: <220604.86h750wgap.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 04 2022, Phillip Wood wrote:

>> On 03 June 2022 at 22:07 Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>=20
>>=20
>> Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> > Fix a bug in fd3cb0501e1 (remote: move static variables into
>> > per-repository struct, 2021-11-17) where we'd free(remote->pushurl[i])
>> > after having NULL'd out remote->pushurl. itself.
>> >
>> > While we're at it let's get rid of the redundant braces per the
>> > CodingGuidelines, which also serves to show in the diff context that
>> > we were doing a FREE_AND_NULL(remote->pushurl) afterwards too, let's
>> > keep that one.
>>=20
>> The extended context is helping, but the brace removal makes this change
>> harder to read.
>
> Indeed, a small style fix in a larger change is one thing but here at
> least 80% of the changed lines are unrelated to the bugfix. I'm afraid
> my heart has started to sink when I see the phrase "while we're at it"
> in a commit message.

I'm happy to omit it, I thought it was helpful to force the context to
be shown, will change that.
