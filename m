Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFCBC433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056D360FE8
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhCaORR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 10:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhCaORN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 10:17:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F4C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 07:17:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ap14so17186602ejc.0
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zcvL05c4ihGYtgz7jA37FMEyHz2EQDKLY42fNPOKHgE=;
        b=tyDC63vesJYRZjpARlngr/V0xBoDjybp5kpKr1JXicTjGqO/KuMdma1jPhkZnZJN/M
         0oduBFQ3Wb8w7Xnm7+fvXL0xdDz3Nv2GEdwsbjCSorSYI79rkZZ87cxgl2wRvdY7EuHx
         7cc486m1DY7XVk/d4uhClLhe6bGqW6+l/fyC8MdXVj0CL5VTNe+kwRwN1BNwCqjzpwbZ
         1Oiza+lDC99/q5nUPa3pLGk3JUpSmCAJNByUvG12AuRC1j+d5uKmxkzfkJ/LQqgBwPAP
         0R2f0oRVT1SB4yDYYtp6aPUzsCtVonc8C/DRKTStceJ/zTRVxD6v8EXCznZZrHSdvaav
         DkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zcvL05c4ihGYtgz7jA37FMEyHz2EQDKLY42fNPOKHgE=;
        b=ep9EEroDcf1UGILLYDyOde7NlcAMU3WxZA57ZUQC0mjRCJp+P1i3q80ODP8YoIaMOl
         fVxV1x9D7SebOGtBIGxz8o2GZG8S/9mPp0233RI40fXAssQsC6MTqKCHLpq9qFIAn0XK
         njYV1ZWThLAoxpBfpB+2yB8RdpQ0Ov75uA8tzLkGcVm1t9OwsAR/YNag/AQ+NOe1EAce
         ODZhAnnRucjMF+ru7wwA+D+dyhtUG7jgJp9Od/siLWMh8at1B7qi3OKFxB0PyxKPoiQD
         Ecs+F5Rn7INzV2pJoZ4vIOwgP45Z9TtZH5+PHPIdLkr7kNHURNfa1TkcfrKg4dgXGgRi
         jZzA==
X-Gm-Message-State: AOAM5330vxfr3Z6csxrNf9gAwoZkzA3BRk2GYPzD/DhqnLWIcSqYht/q
        h28F8BuIidWXo+qUlwhrZCbgTtGJDEQ=
X-Google-Smtp-Source: ABdhPJx1VG82j3LRgVjrJjPU+O3NHiVdDGgGiZ1c85jEfs7ciYIRA99czzbKZr4n7EhBAJsM30Njog==
X-Received: by 2002:a17:906:5689:: with SMTP id am9mr3657303ejc.298.1617200231563;
        Wed, 31 Mar 2021 07:17:11 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cf4sm1663219edb.19.2021.03.31.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 07:17:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: rename objects in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
 <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
 <xmqqy2e5kegv.fsf@gitster.g> <87ft0dmtkw.fsf@evledraar.gmail.com>
 <xmqqh7ktfq3y.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqh7ktfq3y.fsf@gitster.g>
Date:   Wed, 31 Mar 2021 16:17:10 +0200
Message-ID: <87pmzfl861.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 30 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Really, does anybody else use "$(CC) -o $@" in such a way in their
>>> Makefile?  Having to do this smells simply crazy (I am not saying
>>> you are crazy---the platform that forces you to write such a thing
>>> is crazy).
>>
>> Yes, if you do say a Google search for "Cannot open or remove a file
>> containing a running program" you'll find that there's 15k results of
>> people basically (re)discovering this problem in porting their software
>> to AIX, and the solutions being some variant of "yes AIX sucks, just use
>> this 'cmd >x+ && mv x+ x' trick".
>
> What I meant was if there are well known upstream projects whose
> Makefile actually use
>
> 	$(CC) -o $@+ ...
> 	mv $@+ $@
>
> I wouldn't be surprised if AIX community maintained collections of
> patches to many projects to turn
>
> 	$(CC) -o $@ ...
>
> in the Makefiles taken from upstream projects into
>
> 	$(CC) -o $@+ ...
> 	mv $@+ $@
>
> to work AIX around.  As an upstream, however, I am not interested in
> forcing that pattern on users of other platforms.

Who's going to notice or care? We have some mixture of clobbering, "mv
$@+ $@" etc. now in our Makefile for various rules and I think unless
you're debugging those specific rules you won't notice.

The case of the $@+ being left behind is quite obscure, and with *+ in
our .gitignore won't be noticed (e.g. by a "git add ." or something).

> In any case, I do not care too much about the "I am building a new
> binary while running, without installing, the one I built" use case
> and do not agree with the idea of making the Makefile ugly only to
> support such a use case.  That is where my comments are coming from
> on this topic.  FWIW, AIX developers who do not do the "build, run
> without installing, and rebuild while the old one is still running"
> will not need the "$(CC) -o $@+ && mv $@+ $@" either, right?

I daresay that uses cases of:

 * The tests break, you login to the CI to run gdb, fix a small bug,
   compile (doesn't work), but being forced to close that gdb session
   would be annoying (e.g. maybe I'm just looking at a data in a struct
   I didn't change).

 * Ditto, but maybe debugging two things at the same time, having an
   open "cat-file --batch" session etc.

Aren't something obscure to someone wanting to work on a codebase. I'm
submitting these because this is an active impediment to me submitting
portability patches on AIX, of which I already have some:

    git log --grep=3DAIX --author=3D=C3=86var origin/master

Anything that makes that less painful is a win, and the tiny amount of
Makefile complexity seems worth it to me.
