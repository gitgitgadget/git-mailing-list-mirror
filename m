Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B823AC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIGSbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIGSbr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:31:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A898A7D8
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:31:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw17so8801803plb.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=Nk+mzw42CqbfKFpTP5YXWxNI6pUUa++jl41qkSuc2Fw=;
        b=pg8gq8bEXSeD1y2mPU/wwqzcQZs5oG/IF4rGoZ2OdOGrrdb0DC+k0486muzgZOXzD2
         rqch+Vk1ctjUXK1Gqs5NVeuGlZG9Smqt9LtS2/1B9xEKlj4DQHyjkd15gZaPNQJJUnzM
         bUSvOiWYFf5cceCg2XwmZpjena+xZk3EocdpbbIWmhNvT0gv+9edHN1gzFOTbH2cdCkS
         f8gjz19qeQZz+ToM0wkJsLS5TdlIhcxkm8aBm4rUdQ41ooCqkY1JVcLOG04QBwAuEifB
         ZRYxDuHNom82MvYJRuUDqGkS2DwGq+FrZePm5dbpcb6PRT74KrCzdQ/5VqOgd1mGpXtF
         bLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Nk+mzw42CqbfKFpTP5YXWxNI6pUUa++jl41qkSuc2Fw=;
        b=sBRbJdpqpHOW3Ad6lpyecGf2YID8oNsinb7ZuczG8qdHj4RQ+qoTLupt+WR/HJAGTD
         DaPbzvEoF4ob+Zxtp77VV5BedLVeemhRo+CwKccSnY5riBxZD8U7V0PszZD4BOz5Khuh
         6Z5jdaSbodj9s/SUg/ItAPuSwiH/0SrFUarFKwQ+mbzv7omrTk9EY/+rW8DM+xN9qszt
         Ur7SIepK9PDczznJ4YQZg9cY8E9APJ2+qPiRqXfAwrW4FQCtWaOCkuH5QIusBNvmGY2b
         Au+fyRq5VgFsAn2QY/HqIcxx4hjxDHnFl1u0LVScSldStsSBkKtxEw4KJUs3bqGoS/9z
         AXDg==
X-Gm-Message-State: ACgBeo0j2L581JyDB7WX3ECErqeFbhCFn4PpCDqL2ECMPvv+WUDeswSG
        O+iLVKJLhtkfIi7ek2Ek4bM=
X-Google-Smtp-Source: AA6agR6NXgz2MIv2pKQ88O8xn2F1WpOhm4P1WSD95mhHwDGNrCvm2qQROupMi6tzF2yhYd3UBtOG5A==
X-Received: by 2002:a17:90b:1c07:b0:200:9728:b8cd with SMTP id oc7-20020a17090b1c0700b002009728b8cdmr11630797pjb.139.1662575506031;
        Wed, 07 Sep 2022 11:31:46 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0053e5ebafd5csm2720971pfk.189.2022.09.07.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:31:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 1/2] diff.c: When appropriate, use utf8_strwidth(),
 part1
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220903053931.15611-1-tboegi@web.de> <xmqqv8q1zgzi.fsf@gitster.g>
        <20220907043040.idqqivi3jt35jyst@tb-raspi4>
Date:   Wed, 07 Sep 2022 11:31:45 -0700
In-Reply-To: <20220907043040.idqqivi3jt35jyst@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 7 Sep 2022 06:30:40
 +0200")
Message-ID: <xmqqedwnujce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>
> OK - the comment can be removed.
>
> I didn't know how to read this comment:
>>...but the former may chomp a single multi-byte letter in the middle,
>> which would need to be corrected as a part of this change.
>
> After diffing into the code some more times, I think that we don't
> chomp a single byte out of an UTF-8 sequence.

When turning a/b/c vs a/B/c into a/{b->B}/c, two steps are involved.
Take common prefix and suffix (in this case 'a' and 'c') and turn
'b' vs 'B' into {b->B} is one step.  The other is what to do when
prefix and suffix are long.  After turning aaaaa/b/c vs aaaaa/B/c
into aaaaa/{b->B}/c, if the result is overly long, how we shorten
the prefix (i.e. aaaaa) and the suffix?

I knew the code that produces {b->B} honored '/' boundary, but I
just did not remember offhand what diff.c::pprint_rename() did in
its latter half, specifically, if it just chomped pfx and sfx as a
sequence of bytes (which would have been wrong) or insisted that the
common sequence search honors '/' boundary (which would be OK, as
byte '/' will not appear in the middle of a single multi-byte UTF-8
"letter").  I think iti s doing the latter, so it should be fine.



Thanks.
