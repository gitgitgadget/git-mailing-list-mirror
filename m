Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A8C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 02:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhKXCHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbhKXCHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 21:07:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD48BC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 18:04:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so3145312edc.6
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 18:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kFotKgttT5ZjrV5/5XmpnTFCJ84nazlZDTHhH3Rd13o=;
        b=FClmrspmCH4ym/Tce5sYwImEqhl4GnDyV2Nu8jwiJZ3+2mtGzDjRkDZopHoFC04RIp
         9wfq9W/gSwFaz2TEaF+ZowPCdZgEnQxfEIk3VGr5s3UqBT0EicE3NOKhUEembQCFWZfr
         qV14PUVB3GukNlbSpc7d2VkrhXUmyssrDICYt0aV+YkmN1LKHvWCj6qKZfj3O8uqzLEK
         D82MJ35eXgCZzDqw6UNf228hPA67ZXUuOrBjYsCVvHORJcGFgUt7DSzj22EYylgD7wLd
         hk7/jNW8ZnAI+XAssPCS7pE5UpHjsjeR6diD6so8fngnf1iDPTlZFdQ/VjNXqRxUntNX
         8f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kFotKgttT5ZjrV5/5XmpnTFCJ84nazlZDTHhH3Rd13o=;
        b=HXLpn0vfs6e7yoxXgF1TBkb+7MHdHjtk0f/U992j6rnti3Jc366fjmu+aGXDirc4Ak
         +KmHcKpgnky3JO5Ptnqg0IhpPSd4e/gsmLhPLeWFpiceswl0J13i2rWto4GgC8v05jXn
         bUA6ILTx9sRLnMnbHe4kl1+aIkwSAvU1I+agGnTGQEeazJYhgm30zFiH1fnSSUvWTlXG
         oGLkizZ6rh7dfVxA4ieTGbv8fehxT/UCS/lBu1tc9ejW7fD+7DXdLy+UVmpuYJCskxzx
         R+XWXa02UrS9xDOCLttHsZK0fdGEbir+MM0VsfWXJyDeBoaoqxJNgWYU+ZRPiFkq+vW1
         96Fw==
X-Gm-Message-State: AOAM533oWwyVpwe2xyUyjRFVoDIBA2aQSc5c1105iJXsf/9V1B5Uwd2K
        Q6M+VygGOtzr+/5ctq5P5Bc=
X-Google-Smtp-Source: ABdhPJy1PG6SffQWNhMezOwYA3COlB5JRCA/jlo19iIGczf5mVrWilDPCjOcXSxd+gHOActDiq134A==
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr18043096edc.328.1637719481448;
        Tue, 23 Nov 2021 18:04:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e1sm5803476ejy.82.2021.11.23.18.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 18:04:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpheK-0008P7-Az;
        Wed, 24 Nov 2021 03:04:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Date:   Wed, 24 Nov 2021 02:55:20 +0100
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
        <xmqqfsrplz3z.fsf@gitster.g>
        <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
        <20211122145222.m2zrmtbaeu5kzbtt@cyberdelia>
        <xmqqczmsi0i5.fsf@gitster.g>
        <20211123164015.6zkbf3xmnofykedz@cyberdelia>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211123164015.6zkbf3xmnofykedz@cyberdelia>
Message-ID: <211124.865ysie2br.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Enzo Matsumiya wrote:

> On 11/22, Junio C Hamano wrote:
>>Enzo Matsumiya <ematsumiya@suse.de> writes:
>>
>>> I'm preparing v3 with the above suggestions in mind.
>>
>>Thanks for an update, and thanks for working on this one.
>
> Btw I'm on hold until =C3=86var's patchset is sorted out, which seems to =
kind
> of overlap/invalidate my fix.
>
> Sorry I couldn't follow much of yesterday's discussion.

I think per https://lore.kernel.org/git/xmqq7dd0giwp.fsf@gitster.g/ that
Junio's in turn waiting on you, and in my v2 re-roll of my topic[1] I
ejected the test derived from your report, on the assumption that an
earlier fix from you would land first.

I.e. I understood that Junio wanted to queue up your more narrow fix
which would fix the segfault, and my larger topic to remove "argv" and
"env" might come some time later.

I don't mind either way as long as the root cause of "argv" and "env"
gets fixed eventually.

I do wonder re [2] and [3] if a simpler and self-contained/isolated
patch in this area might not be a mirage of sorts. I.e. to know whether
the approach in [2] and [3] is safe we basically have to reason about
all the callers of this API anyway, which is what my larger series does.

But I honestly didn't look too deeply into your approach & what could be
done to safely work around "argv" and/or "env" on the current "master",
since I had the alternate patches to remove them entirely :)

1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20211123T115551Z-av=
arab@gmail.com/
2. https://lore.kernel.org/git/20211122153119.h2t2ti3lkiycd7pb@cyberdelia/
3. https://lore.kernel.org/git/YZvFkwivicJ%2ftFAo@coredump.intra.peff.net/
