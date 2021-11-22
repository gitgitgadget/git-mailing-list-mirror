Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B04C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhKVShY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhKVShX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:37:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB47C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:34:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so80673416edv.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2MKW+465dUj+27Cb6VvMzDMIKu9r4slad6XjPlTp7Uw=;
        b=VGI7d00+iCFtBTEHEBT59Ks6ADCTbXSVejMM0bgiZnou2Djqgb1tlgLxNhGCDNBqP5
         UIkg+LcU/86uDqCGKlP9WXuutrOMnyAX+6hcsQCzSGuh+pSWkdtIZ4BssujOkY1LuyUS
         klvlKKaRdEBRxNXeK0H+00/c1j2DCwIGMFzw2oaKRTrIJ0OrKyZDSR0D0dyEM3bdbS/J
         xnltyD+BI6NOvQZddOpbu8TBKa6ijuxvwmh7LhxhfVo+HGTfXq7OK9+wIhVP1s9VVCCk
         LM0bwVzupjzvWQoRt2XDEjCRXBcd3kSc6Uy3f4O4yJ4ccO9Ewzb9VNWpEkYxcvJ0KqSU
         5ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2MKW+465dUj+27Cb6VvMzDMIKu9r4slad6XjPlTp7Uw=;
        b=IWiAXIGwsXUnX3KBYyeLaWs3HnA/KmiIG97GHXpOzJE2/c95Z07f4woubRpj/Ny0QE
         +hAUcsTnt/qEfixPdX3UuS1S/pXwuCs8Qu5XRSM71H8vmMQAROyxRVvDSr2qevlz7eML
         vW3gKKB0rkuDQB5XKs6K4QE/jU3m/mOmxnXSVfFoHmgGG1O5anCDMcoO9WXIrhP57NGZ
         IA5BVkOLBlaZy7boPwr1/WTEfDdRvrZFV3WlT09qFx1xStJG703vdrcYLikrKybUD8EM
         dPlzYKvZ14H5qCMPChm5i4qKojFhX0Yy6YqbQEZqH+IpZt2ICbz7zSHB2Tr+cOM9Tvhn
         Dm2g==
X-Gm-Message-State: AOAM533edxHGIcVrLIC+/N1MKA3SSCst1x80q0qSIulFJXlzzTpszU/B
        46AhNK2waYHcnSy+1scbB5w=
X-Google-Smtp-Source: ABdhPJz/0N/H6+t1ATfR+kf3AQizUX5dC541gX+p2d2LLVg9wpuRlYKJ+qk3wbGUUz+9DzfKBbqGaA==
X-Received: by 2002:a50:da48:: with SMTP id a8mr67717908edk.146.1637606054464;
        Mon, 22 Nov 2021 10:34:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd22sm4347474ejc.98.2021.11.22.10.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 10:34:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpE8r-001AKR-El;
        Mon, 22 Nov 2021 19:34:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 0/5] run-command API: get rid of "argv"
Date:   Mon, 22 Nov 2021 19:33:10 +0100
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
        <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
        <YZvY+BJhxaFIOdnJ@coredump.intra.peff.net>
        <xmqq7dd0giwp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq7dd0giwp.fsf@gitster.g>
Message-ID: <211122.86o86cxcnu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> I'm on the fence on how important it is to do these cleanups. IMHO they
>> are half of what really sells the change in the first place (since the
>> other bug can pretty easily be fixed without it).
>
> Yes.  I actually think these have much better value for their
> complexity, compared to the other "half" of the topic ;-)
>
>> But maybe it is piling too much onto what is already a pretty big
>> change. The cleanups could be done individually later.
>
> I am OK with that, too.  But I do agree that the series is too big
> to sit in front of a fix for a bug, for which a much simpler and
> focused approach has already been discussed, to block it.

I'm happy to re-roll this on top of the more narrow fix. FWIW the bug's
there since at least v2.30.0 (just tested that, probably much older), so
in that sense there's no urgency either way.
