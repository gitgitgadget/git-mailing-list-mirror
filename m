Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42EFC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 06:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiI0GAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI0GAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 02:00:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545AEE02F
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 23:00:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso537766pjq.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+7BJeJMbwvQkSM72OOV0m34gU6ugKEUzryv6VmGCyNc=;
        b=InPco4y31PUTLgeX/qOBHzOUqneq7OTNoyr8B+RIjFm5TXti8Gfod3clHHVi/YY5me
         X0h1QZ3de39ORn5y51jbI2L3W6MwTAVLqiJHlHhBcUcmzK5aTwU31NiDHngWrkktz9nN
         zPvL0i7laxnud3c84HU3u2OmEiJJ3FqTKh0Wr1B4IdZa5jF/NK6YZSVep3f/a56Qn7Zk
         PXPzroJQDMcFyCmQSBe6+TfWZtoOVMjpQYp2n8auLWTe+kepI70YFt/lbPneCaPu7XU2
         Ti+64u5QblgCBayDoES4/FNouBN74FybZ/S6ND3XpW+s8AhuyFTcgrCv5XJMXkwWU0IA
         s55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+7BJeJMbwvQkSM72OOV0m34gU6ugKEUzryv6VmGCyNc=;
        b=cuZUPXs5SNchM7uNnC0Y11Ers9ovZuz2tOPIGxqVrVgTi13xqsFfIUYgYrOOQ6HLev
         kNcpr6OpKrPmZ/lCSIho+0ges++Giewd5NbOzfRvwmFmbG5iAe/E1LvY3/0SfMo3qe9A
         d6qfy7Yn17ifWCisNvJa5Rr/+UOIjehlG0YPaYT5/uCtq0sgkSYaTx626ERrV/4/ghEV
         cIR16P9AOyjTgTHU1bhCyH9fs/1Qj9XH+gOJ9PMztfwlQD8SlWPaGxAGcMSxgp2JoEJy
         cba7vFZ66GVYDP5yXlXuTLev/Q5cq6u0SuelaWzGQwRNXlOP5exDm6/LvLE+eyvViEV1
         QpYA==
X-Gm-Message-State: ACrzQf1esBrVG/rZ7Bgmp9Qb9oDwEUzJXK1McT6CgbRTlqotWRM1pnvr
        2v+qRRNLF+SXwJO5HKrwV05SCwZyovBXVyS/nA8=
X-Google-Smtp-Source: AMsMyM6jkqmTSqmtWFmuJWF0WHyI4XX/t3fJz/n1L/xAu+VO6a5FpXa/yKY9JlRS3DqzDn1bh1mf4Q4xZSkh+RbStwU=
X-Received: by 2002:a17:903:32cc:b0:178:3d35:dfc4 with SMTP id
 i12-20020a17090332cc00b001783d35dfc4mr26220249plr.116.1664258405843; Mon, 26
 Sep 2022 23:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
 <CAN0heSra_LsBzYCNFh0cZOZ0pmk1Wb9RtNTLwi93UM=f-53Uxw@mail.gmail.com> <xmqqfsgene5i.fsf@gitster.g>
In-Reply-To: <xmqqfsgene5i.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 27 Sep 2022 07:59:52 +0200
Message-ID: <CAN0heSr0V+coALLaUkN2Su-xQ-xRpWuMz0TMr5kYpO0n6LNbaw@mail.gmail.com>
Subject: Re: [PATCH] ref-filter.c: fix a leak in get_head_description
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 26 Sept 2022 at 21:12, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thanks, all.  Will queue lest I forget, but I presume this is not
> release critical?

Correct. This regressed already in v2.30.1 and v2.31.0 after the leak
was originally plugged in v2.29.0. So almost all recentish releases have
this minor leak. I'm not even sure it's possible for a single git
process to hit this leak more than once today.

Martin
