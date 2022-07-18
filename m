Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC1C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiGRNkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiGRNkj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:40:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA518349
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:40:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ez10so21242644ejc.13
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rkVj+mPGeMUtvOWc4cwaJJuJ3vOFqDaf+PV3JXsUxYM=;
        b=hlmUqjVleQko/o/0faEOZxiTlonQupBfvJYzbTKVhUrUXB7WRo0gh0iTcZpcOacjuI
         IAWEwZ4izsTPmQ7nCxchM+hIFQ2CepoCvmhxaxsMMahgOH2hGUDceVhTXVJ3yMjhBkaD
         oC3BqC8w9ZW2MaiH28Dxq4Tk4LBDix++ixunFiZ+M6jM/WB705k4PG16bkHUYpWY3TGc
         SC43ejzuHyx28KrBNHoH7/aqH3zSC3PmuXw0TlsZBF5tg7qzM5YpHR6f51hHKlquu0cA
         ZfXA62tuo5+mZVj1tQoFt/1/jOtIPAR4N4SHtlPHdLV7wJiAo2wSg6VSJ4S/WsajEpYa
         6ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rkVj+mPGeMUtvOWc4cwaJJuJ3vOFqDaf+PV3JXsUxYM=;
        b=IPvX3Bpp0PdZ9/rZ+51h2vaZNfgeuddHuj7wKZC9RCYj3N8wx0hySWo3lQhigBAIYd
         C0XD4yve4ZLiswHv3yyAQBHOA82G+rq9a/387Dc8Ira0HEt7owPh++dTrjCo9U35GTlF
         uUZUQD55Qgdkt4VgikZFlHv62ArK5VeWBJwI2pSr3kLgYwan8w1tOhdmugE5Bt5EGAFF
         AfNWqQSS4mSaIPvygObxx1PmmfQm2YLa62ter1CiUXrln/Dqy4lnFE+d3HK7hk3QVUYx
         ODm8e9PXjxQwTOhYBA16VGKw4XsaCmccKyMxW1PO6xIbGtEw3VcWH5Pnv5g42QF+p2L7
         qKqw==
X-Gm-Message-State: AJIora+n99Q+5S6XPJJj16BBG5AyoufktuKvFoYdc527JTlf8lFGLKSr
        qtnwx+KbIie+8l2uc1IqbdCtMkMVdhabmA==
X-Google-Smtp-Source: AGRyM1tz7qYOryeLYhhj11fwVsnresi/oQffx1H1Xuwx2lKqfFcM2kLntjRRPaoi4ik8zmSuf1j/dQ==
X-Received: by 2002:a17:907:7395:b0:72b:86f2:4fd5 with SMTP id er21-20020a170907739500b0072b86f24fd5mr26496843ejc.332.1658151637080;
        Mon, 18 Jul 2022 06:40:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p5-20020a170906b20500b0072af4af2f46sm5514407ejz.74.2022.07.18.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:40:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDQzD-0039Yb-Rf;
        Mon, 18 Jul 2022 15:40:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
Date:   Mon, 18 Jul 2022 15:38:19 +0200
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <85r12iu10e.fsf@gmail.com>
 <CAPOJW5xR-MBU74h2mM3wENf_XjU-xm6n7qis0FLjFxZsUHsHAQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPOJW5xR-MBU74h2mM3wENf_XjU-xm6n7qis0FLjFxZsUHsHAQ@mail.gmail.com>
Message-ID: <220718.868roqy1ws.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Abhradeep Chakraborty wrote:

> On Mon, Jul 18, 2022 at 4:43 PM Jakub Nar=C4=99bski <jnareb@gmail.com> wr=
ote:
>>
>> Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:
>>
>> > Hello,
>> >
>> > I need the CRoaring[1] library to use roaring bitmaps. But it has
>> > Apache license v2 which is not compatible with GPLv2[2].
>>
>> Actually Apache License v2.0 *is* compatibile with GPLv2 and GPLv3
>> in the sense that you can include the Apache licensed code (like the
>> CRoaring library) in the GPLv2 project (like Git).
>>
>> Quote from the cited "Apache License V2.0 and GPL Compatibility"[2]:
>>
>>   The Free Software Foundation considers the Apache License, Version 2.0
>>   to be a free software license, compatible with version 3 of the GPL.
>>   The Software Freedom Law Center provides practical advice for
>>   developers about including permissively licensed source.
>>
>>   Apache 2 software can therefore be included in GPLv3 projects, because
>>   the GPLv3 license accepts our software into GPLv3 works. However,
>>   GPLv3 software cannot be included in Apache projects. The licenses are
>>   incompatible in one direction only, and it is a result of ASF's
>>   licensing philosophy and the GPLv3 authors' interpretation of
>>   copyright law.
>
> But the same article also says  -
>
>   Despite our best efforts, the FSF has never considered the Apache Licen=
se
>   to be compatible with GPL version 2, citing the patent termination
> and indemnification
>   provisions as restrictions not present in the older GPL license. The
> Apache Software
>   Foundation believes that you should always try to obey the
> constraints expressed by
>   the copyright holder when redistributing their work.

...indeed, and for those that don't remember around the time the GPLv3
was being discussed & eventually released having it be compatible with
the Apache license was a major thing that the Apache Foundation and FSF
worked towards.

But we use GPLv2 only, which as you note is explicitly known to be
incompatible with Apache v2.0.

