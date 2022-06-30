Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622C9C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 03:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiF3DTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 23:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiF3DTM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 23:19:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9036178
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 20:19:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f14so13639042qkm.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 20:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iqqPjj8cCRAbli2dNfCKODY5G/iWyxy1YtxPKngWN/I=;
        b=YOIMzINRGhnOWPQZyoMTAG8COe0F4TthvLIoH3/o5lxRHaBGQdd6zFwt/GSxJzpEMo
         z/EMqEOMzwjOcOGpn10DMVWyWaF4unVZJXMatFTg+0KYJW2ZBxEG26xWobstvh8UzaT6
         0V2DLECDbPcEge+mcaMxvWTpAEKvNzqSz7xBv+5KytUeWbTLudpc/nKjXdes9+igwJ65
         MjbS79vNllxXxFNQaE3nDKvEfkz1S5NeY89bzkYYAF6+u5EDZvNpLeMH4BnW77q4xQBV
         44j/iMMxShbuHTyTi9XvVwk5vtrDr0xla0OqUDMeK7YGR0xl6+1rJMTFEixkE2RqXJqx
         LLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iqqPjj8cCRAbli2dNfCKODY5G/iWyxy1YtxPKngWN/I=;
        b=daYlXMQwzUK7glyxvsUIDeq/lVASQjdx6XJiqA5lNPNCjzQ8KGLWesaEgDAYX+L048
         x4y9zxgNt2jag+x6ogK557qF77xrGBI6ci4rheHuZT27zt5HKXlXM+7Ki7qk1BkOyoEc
         eyERWn1Ap/Nd1bVmRHnh+xBux74ZLFrxNFtoWJ/5ws0a/C8Mi8BQP2ELGOc8vrR21pX9
         AT/S6oNwBCSxu5sE+dfnVN++bVVRNnTHaJJut3GzouBzjIaQiqFWVvPxXYwA5adhIL8e
         CNn0zup8L/EjPdBreAbRs8IksWoUvykhXo5PrAolYAZ+DopGkuVXf+BvQhvdK1CCtIks
         wgIA==
X-Gm-Message-State: AJIora+K86dbIOjmbbnNgqZjNVs5tTGo/sGH04fml03cMc9iF/OBny5g
        4SmGUdzU4sCjEXzcp1AB4g+WQA==
X-Google-Smtp-Source: AGRyM1uFWZ8U6plbSM5UF80wPSLbWlDyfdZy59+Gq1gpXwHsIOo7t4vPWPHSlIbvY1bI5osrWiJrgw==
X-Received: by 2002:a05:620a:2590:b0:6ab:91fd:438 with SMTP id x16-20020a05620a259000b006ab91fd0438mr4681521qko.312.1656559150627;
        Wed, 29 Jun 2022 20:19:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dz8-20020a05620a2b8800b006b141dd9746sm2677464qkb.110.2022.06.29.20.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 20:19:10 -0700 (PDT)
Date:   Wed, 29 Jun 2022 23:19:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: Race condition between repack and loose-objects maintenance task
Message-ID: <Yr0WLebMfBXZ1K7D@nand.local>
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
 <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local>
 <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 05:44:25PM -0700, Gregory Szorc wrote:
> Revising my initial post, not running `loose-objects` is insufficient:
> we also need to prevent `incremental-repack` from running while a `git
> gc` / `git repack` is in progress. If an `incremental-repack` runs
> concurrently with `git repack`, `repack` can error after bitmap
> generation but before the temp packfile is renamed with "could not
> find 'pack-*.pack'." I suspect this has to do with
> `incremental-repack` deleting packs that were initially in place when
> `git repack` started running. But I haven't looked into where exactly
> repack is failing.

Yeah, you would need to prevent other writers from removing packs while
writing a cruft pack.

I think the canonical way to do this would be to let `git
maintenance` use its own locking to ensure that it wasn't trying to
remove packs while simultaneously generating a cruft pack.

But assuming that the cruft pack generation is running independently and
concurrently with the maintenance incremental-repack task (which will
delete packs in the background), then there is definitely a TOCTOU race
there.

The race is that `repack` will signal to `pack-objects` which packs will
stay and which packs will be deleted during the repack. To generate a
cruft pack, the packs that stay are formed by doing a reachability
traversal and writing a pack that contains all reachable objects. That
way anything that is in `all-packs \ reachable` (which form the contents
of the cruft pack) are going to be just the unreachable objects.

But if a pack that was going to be deleted by repack *after* generating
the cruft pack disappears while `repack` is running (particularly after
it starts, but before it generates the cruft pack), then the cruft pack
generation can't proceed, since it has no idea what objects it needs to
add.

Namely, if it is told that pack P is going to be deleted, any objects in
P which don't appear in a pack that *isn't* going to be deleted need to
be saved. If we don't have a copy of P anymore, then there is no way to
come up with what that set of objects is, meaning that it's impossible
to generate the cruft pack.

I should mention, BTW, that this isn't a problem unique to cruft packs.
Geometric repacking, which uses `pack-objects --stdin-packs` has a
similar issue where if a pack being combined is removed from underneath
while `repack` is running, `pack-objects` cannot successfully generate
the pack.

> However, I think there is yet another bug at play: running
> `incremental-repack` appears to be able to repack the cruft packfile.
> In doing so, it deletes its .mtimes file and the metadata inside.

That sounds like a bug to me. I'll take a look into it and see what I
can find.

Thanks,
Taylor
