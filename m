Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98DC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 18:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJQSza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJQSz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 14:55:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5F1AD94
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:55:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q9so27166551ejd.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRtOugKTmeGwyvbVzhMuRkCRkc/6nwMWw2S+cfB+Snc=;
        b=jzXua4gic3zWktJBw+mWaQ7uxv/MpxFw7OvJNG2oIN2TOMndToT+23ReGn4/GCHYSz
         5WZS4JGeSELQl3x/Wlrmchwsr6sECHTZe0gCZLGoM6xyv5Fnj6SjLmgdxcm1pjqh2rvj
         0GyQS77MHjsSPIjzdwwECiVcAHWBjU8R0jMZ4NbqHM4swNuMNsXANKZKSY61aITr5bih
         Ohrrhn6eAxvPoZijFWSzhab0WRcEXrj0NqJbA0urKgCMrF9/oGWXlhIZ3yZv9wllrMCg
         9lLU3nbhmnyghig+pK1lW8HvKU8wVbGGm36a6ADdBUmUF3ij7mwiQR1n9uqXEf2zHx7P
         0RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRtOugKTmeGwyvbVzhMuRkCRkc/6nwMWw2S+cfB+Snc=;
        b=XzijrlJkP/gBqRSbVXAN9UMwOMtb9Gv+uZqFKYiv7q0fHJ82EUXjQoWsQsI5ITvOqB
         vWUnMXNvtP1ENecDcRDY8qoeuYLJovDy8d+9wHYOHNlDTfs3emixDuNNUXThRoVtEA6Y
         fZYA6j8XrCNLHxil2euSzlegIDZfqEhFk7s2aVpKpdAGj7uwl6L3LmwdIzpZcAKFlsKN
         0JsEuw/lC8gi0xBlF/MxWU/tZ2oDGqUfXMtUGniwQJzJJNKLaGhufEcbH7q0ooz425el
         W6PD+dZQhQr31nbdc7ZTRCkgfPudFZdjQhCckiG5OdftVkmXY3CDgiftNI35UPsJ3d5N
         p5Og==
X-Gm-Message-State: ACrzQf3Hj7JW6lZMoXKle+KFFdnh6mZpzT/u+6i1MJjG7XUvUMWhuAQR
        tqNRyHhXE9J/ORpOD8rogZ4=
X-Google-Smtp-Source: AMsMyM7DVVnTSENnWotgxD0RAUqLadWH369m6gzQtavAwe0tHqQCRt1a6puKwFaiVbcOCinKxcfVEA==
X-Received: by 2002:a17:907:980e:b0:78d:b6ea:25b3 with SMTP id ji14-20020a170907980e00b0078db6ea25b3mr9772733ejc.98.1666032925181;
        Mon, 17 Oct 2022 11:55:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id md9-20020a170906ae8900b0078defb88b0dsm6402407ejb.73.2022.10.17.11.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:55:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okVGm-005bmi-0G;
        Mon, 17 Oct 2022 20:55:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, vdye@github.com, gitster@pobox.com
Subject: Re: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
Date:   Mon, 17 Oct 2022 20:50:07 +0200
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
 <Y02YzYS172skpbAb@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y02YzYS172skpbAb@coredump.intra.peff.net>
Message-ID: <221017.868rlejn4z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 17 2022, Jeff King wrote:

> On Wed, Oct 12, 2022 at 03:05:33PM -0400, Taylor Blau wrote:
> [...]
>> [...]
>> +	for_each_string_list_item(item, include) {
>> +		strbuf_addstr(&path, item->string);
>> +		strbuf_strip_suffix(&path, ".idx");
>> +		strbuf_addstr(&path, ".bitmap");
>> +
>> +		if (unlink(path.buf) && errno != ENOENT)
>> +			die_errno(_("could not remove stale bitmap: %s"),
>> +				  path.buf);
>
> We could downgrade this to a warning, since there is no downside to
> retaining those files (aside from wasted space). In
> remove_redundant_pack(), we call into unlink_pack_path(), which just
> ignores unlink errors (though arguably it should at least warn).

An ENOENT would indicate a race with a concurrent process.

That in itself seems like a wart of our lock management. I.e. we invoked
"multi-pack-index" earlier and took a lock to create the midx.

I don't know how exactly that interact with the pack bitmaps, but should
we ideally have taken locks on the relevant associated files instead
during the larger operation?

But anyway, that's a much larger topic, so we could sweep it under the
rug here.

But at that point should we be ignoring other unlink() errors?  Maybe we
should additionally be ignoring EBUSY.

But the rest all seem from a quick scan of unlink(2) to be things we'd
like to just die on, e.g. EIO.
