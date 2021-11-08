Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D3C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B097D6152A
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhKHU0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhKHU0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:26:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4597AC061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 12:23:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f4so67164550edx.12
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 12:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9pduK+3RHUG5sLfd2pnj+ctoDxe1KVAgYHhyX5ibN/o=;
        b=e9SuJknLH+dZxvlCfJojG611IChPApXs9/Lzi+nGCanqcQyB/qF5W5WgWx8LeSxtld
         nldbaZwjvHxSZqvrEgTQLRfeXVEztSa9Ll8qhG9L9YZhfcHfXEa2DyGekTPlD/gkR+U0
         G878nb1Gb28x7VzR0YrLqbdyr1QSFbVgmhm1u1jZpW5HXtbYRbcr1uJZUULwGVf/k8WS
         SvzwppMr1gIuhT4WdqX3Bt2TOLETXSm7D+KS2X4MrpMzpdvoey32Co6+T9BU0LADItYK
         J0P3Ozb8Po5TtGI0xkFzG0wvw3wlNmj2ZFO0VHPewYSgJHNxr3tf5mSGrlwkyDf3ugq2
         MqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9pduK+3RHUG5sLfd2pnj+ctoDxe1KVAgYHhyX5ibN/o=;
        b=bGhyt44gE3FJaC690HYPUQyjc0LX3ZYsPxB4EeXQoY3pTKZQSAzaqjmV9wiAOmj3BL
         lm9h9nTaPMX8quiU5tKcNqKXIYtBEW9/mvlOCvwKXsw0Z9jzinAGcvuHtCAaeIvXtEDF
         kfLhaEzgbmQCz3o25kCnet2c/ebkehuMBIp9vC8MZUt75GOeFRGxyD6iTiXCdXtqydgo
         h0LGtrOJd5rRPqO6t27yROihq4/UlcO1DhKocZGpjES8fFA2wYmtC5MK0hWusvEM59/B
         22C/Q5HPFiu8ZLI5aD6zIl7OUCEUKKZ/CHTXsyn6v9M6238EDh3C5jUUw1XrtgGxickD
         o7vg==
X-Gm-Message-State: AOAM530NDhfeEKe/cIZIikntByZ0KBjrI1h7Wui79LUOq5/kcgVBjDa5
        eCNhBHbkfYjUIOW7Pw7Coz9eHx2X2Es=
X-Google-Smtp-Source: ABdhPJy+Hx4UxK7IoSS+y4FY1SZaOTdOp9Lp2Kpo+128Ik35x+JhzP/zcccxacKPt8+8ZlVTSBKbww==
X-Received: by 2002:a17:907:a42c:: with SMTP id sg44mr2276681ejc.335.1636403006818;
        Mon, 08 Nov 2021 12:23:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lv19sm3217865ejb.54.2021.11.08.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 12:23:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkBAr-001FCu-Uv;
        Mon, 08 Nov 2021 21:23:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: move some test-tools to 'unstable plumbing' built-ins
Date:   Mon, 08 Nov 2021 21:19:10 +0100
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
 <xmqq35oaxwnz.fsf@gitster.g> <YYWBz6rjF+I+JkO3@nand.local>
 <211106.86fss9hq3f.gmgdl@evledraar.gmail.com>
 <YYgHhaOAsv7pVAMi@nand.local> <xmqq7ddiv4oi.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq7ddiv4oi.fsf@gitster.g>
Message-ID: <211108.86zgqee6rm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> In my experience I *rarely* rely on test-helpers when debugging wedged
>> repositories, and much more often end up either in gdb, or in an
>> anonymized copy of the repository on a different server. I would imagine
>> that others have similar experiences.
>>
>> So unless we had a much more compelling reason to have the test helpers
>> more readily available, I do not think that the risk our users will
>> begin to depend on these unstable tools is worth taking.
>
> OK.  It sounds like a sensible argument against such a change.

It's an argument against not flipping "make installing them be optional"
flag on by default, but we could otherwise move some of t/helper to
builtin/, which would help by encouraging us to write at least
boilerplate docs for them.

Git developers & similar parties could then set them to be installed for
ad-hoc debugging.

Whatever anyone things on that, just on Taylor's "begin to depend on"...

I really don't buy the argument that there's no amount of warnings in
our documentation that we can include which would give us future license
to willy-nilly change certain things.

If that is being argued then that seems to categorically exclude certain
other things, e.g. including "scalar" in-tree at all, because if we
can't trust users to read the warnings about it being "contrib-y"...
