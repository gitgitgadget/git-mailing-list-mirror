Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444D8C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F72D227BF
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbhAJTBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 14:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbhAJTBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 14:01:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC1C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 11:00:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r5so16506551eda.12
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 11:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=r82NCtHmbZL9b4gqtTvgtNRIPaXaOYrQBXcSJ4oV48M=;
        b=bQk02rgwh9XvbxC2ZmwvkiBUfWMVQC2HM15rECCTPoTy1/rUjgc5d1wQot5QZwWrQr
         aUsfPVbyFgQyjfEAnmEazpV52d7GMOVEEFTSv0p2cDWRrqFqlAzliV7hua3Mkc7fP5pg
         BKu95J74u1dIOmdT9Wj0Hnl3wGu6gIQPRZF/WGwpSbFYBQhp5SrK4nGGMGt1LSkysqtn
         nBDsuu+xG3z7zVl5XX1aX//KmdCYRv8WqEiZwt8JsDcWhF41dvkrc2q925tZwrAIBulU
         sangoILQLDWDxCx+sNGLgJAqJ/qrdCy9aEzXXSiWEF3nulYnzliN524xvLCierUnACVC
         drZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=r82NCtHmbZL9b4gqtTvgtNRIPaXaOYrQBXcSJ4oV48M=;
        b=iJOlz3nBSaFN+IBtBzov/jmOAtKxNkGpZETcP+DEN/uKgYRwilHNBCm6oUpp9BwSGe
         CB5MOr3E55J5fQahDPV9k69XmNSqouVUP9yb7K3wglWGXoVzsWo2UnQ7IVx1dRyvWGwS
         w3y4XBAOX00z5HBM0Spk2izhjq0eZj3pPhwtdO9+Bwo6UoBqPw85Zs6jKIwOwokxs62S
         4jCSL9hUX7yYnl7g4FlZ/vktisRwLSTcAKQ/iqgy71Zum/ildeGkkkbRfV/oGDO6PZvI
         AAgA2wahxzC3vEVUot2njdYJpLzOgzn2QP8k2gyP6UuPdV/7WoLuVLsjXsmPVmid/f67
         PHcA==
X-Gm-Message-State: AOAM5304saO8RYStUPZaclNK4Mve8iJ5mUK7isxHgyJd6SzDLs0L5w0y
        vqJi1topvbbCEeeeQlqygE8=
X-Google-Smtp-Source: ABdhPJw8qz8FA8IBQ/BxTbAF0tM2Gc5YayX0uSbw20uOwlahqayGbeObWLKAVt1fn/4Yre9QJ8oJdA==
X-Received: by 2002:a50:955b:: with SMTP id v27mr11773351eda.324.1610305248272;
        Sun, 10 Jan 2021 11:00:48 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id j22sm6030235ejy.106.2021.01.10.11.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 11:00:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
Date:   Sun, 10 Jan 2021 20:00:46 +0100
Message-ID: <87v9c462ht.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 09 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> I forgot that, oops. Is just declaring here that all of that's:
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>
>> Since you have some acks etc. squashed into it at this point...
>
> Puzzlled.  The patches on the trailers topic were all signed-off by
> you, unless I was careless when I checked before merging them to
> 'next'.
>
> Do the above three lines refer to a different topic, on CoC 2.0?

Yes, I accidentally snipped out the part I should have been quoting. I
meant "please assume my signed-off-by" to be in reply the CoC 2.0
series.
