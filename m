Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB2C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiITUgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiITUgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:36:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174075A2C8
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:36:06 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 3so2582631qka.5
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8rG23MFG5ygBrULkez/u1NTp1VfmzZVsWovUlR40jX0=;
        b=2jbH2iBZoNPdKBgmDXuG9gVvo3+IvyZNprdVlU5zxY/myEhmKbECLduf0GoptrzSr7
         obNlpqV0sRH0Xd0wqtDLuak5PM/esrUjWGeZuTg8+yD1MTvc9yTAkdVmzVcjuPq80p1n
         yPnPU5v/X5axm79SVc6dvznkUDnPoCm9QIANHBl5nR4pT33ogB3yhLWb41oEtMqGhfUX
         1syG6IB681YCfnH8JwKekSROFjqHkGW34HFwuEd57hU9IBarcY58ON1hgdsOC1j9H0zH
         ejYZqQAVBqzZy3ds5PHMO7GZFwYD0OxlZwvx+EEnHUigbd7qQdVN/390jjJosa0prt1S
         CM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8rG23MFG5ygBrULkez/u1NTp1VfmzZVsWovUlR40jX0=;
        b=nuEHobIAWhHnugnwMf8wMPUxrJfmwcYlk0iLfd1qw6k3tGne6ENIl60uX221/4fZpx
         sfxztc47O7UF6Wa+8AKsYmrIOz8BKzDk8fxbIhDZkRxVLl/fg7LjPbQZoF23GSdrWBPU
         VhZ3k/KNBJahiRVhmongDboMUgQ7WcXJTMn6EBpgMD1d0qMFybedr98EHLeVDbEbrQwA
         AWV0BRlG0yQA52ScLmkWANzyA62UPtCMAS0+90ZXw3nSUu1vs9RM8V2T/R3mJzzAPAE5
         fyY7SO/RfPqk/OeR91XEfcDfnVP+A6sn3bhNjNG6PI5Wlw0kJcjruauv9Bd8cwAFbZ0P
         uWQg==
X-Gm-Message-State: ACrzQf33psVrRyO1x8Qz+Vkftg1zmIBoOvhwdVkJlnH1iEuaIPfSQxED
        8ZUw9e5gIkuda7CwgsQchYtqXw==
X-Google-Smtp-Source: AMsMyM6AF2B6Z/rJZHOIHDSa2XwG9bjqgtZDUhcFFqYdMiBF/CmoP5j6x0z7B2FWP98JecZ9fOeD1Q==
X-Received: by 2002:a05:620a:1595:b0:6cf:3a8e:b64c with SMTP id d21-20020a05620a159500b006cf3a8eb64cmr3249107qkk.41.1663706165168;
        Tue, 20 Sep 2022 13:36:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i3-20020a05622a08c300b0035c11fd1b49sm346518qte.80.2022.09.20.13.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:35:51 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:35:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, derrickstolee@github.com
Subject: Re: [PATCH] midx.c: use `pack-objects --stdin-packs` when repacking
Message-ID: <YyokIf/Sd7SYztKQ@nand.local>
References: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
 <YyoUZb90HeJnOuAV@coredump.intra.peff.net>
 <YyoZM1V5S53dz6U6@nand.local>
 <YyodQg5diyr/UYK1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyodQg5diyr/UYK1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 04:06:26PM -0400, Jeff King wrote:
> On Tue, Sep 20, 2022 at 03:49:07PM -0400, Taylor Blau wrote:
>
> > > Is that true also of "multi-pack-index repack"? I guess it would depend
> > > on how you invoke it. I admit I don't think I've ever used it myself,
> > > since the new "repack --geometric --write-midx" approach matches my
> > > mental model. I'm not sure when you'd actually run the "multi-pack-index
> > > repack" command. But if you did it with --batch-size=0 (the default), I
> > > think we'd end up traversing every object in history.
> >
> > We could probably benefit from it, but only if there is a MIDX bitmap
> > around to begin with. For instance, you could first try and lookup each
> > object you're missing a namehash for and then read its value out of the
> > hashcache extension in the MIDX bitmap (assuming the MIDX bitmap exists,
> > and has a hashcache).
> >
> > But if you don't have a MIDX bitmap, or it has a poor selection of
> > commits, then you're out of luck.
>
> You could also use a pack bitmap if there is one (and it's one of the
> included packs). But yes, if you have neither, it's no help.

Good point. But, yeah, you have to have them to begin with.

> Mostly I'm just concerned that this could have an outsized negative
> performance effect if you have a setup like:
>
>   - you have a gigantic repository, say that takes 15 minutes to do a
>     full "rev-list --objects" on (like linux.git with all its forks)
>
>   - most of that is in one big pack, but you acquire new packs
>     occasionally via pushes, etc
>
>   - doing "git repack --geometric" rolls up the new packs, nicely
>     traversing just the new objects
>
>   - doing "git multi-pack-index repack" before your patch is fast-ish.
>     It stuffs all the objects into a new pack. But after your patch, it
>     does that 15-minute traversal.
>
> But I don't know if that's even realistic, because I'm still wondering
> why somebody would run "git multi-pack-index repack" in the first place.
> And if they'd always do so with --batch-size anyway, which would
> mitigate this (because it gives a geometric-ish approach where we leave
> the huge pack untouched).

Yeah, the `--geometric` path(s) don't have this problem, because the big
pack will already be covered by either a pack or MIDX bitmap, and we can
read out all of the namehash values from there.

But I tend to agree that this is pretty unrealistic, so I'm hopeful that
it isn't a huge deal. If it is, though, we can always just "turn off"
the traversal parts. (Though I have to imagine that a repository large
enough to care about the existence of namehash values probably isn't
using `git multi-pack-index repack` anyway).

> Yeah, sorting the packs by mtime might be sensible. I know in the final
> midx, we use object order to find the "preferred" pack. And you could
> iterate the objects here, passing along their de-duped pack name. But I
> don't think we have the objects here in that useful order; that is
> really the order of the midx's .rev file, IIRC, and this is probably the
> actual sha1 order.

We already need the sorted order in order to compute the rollup for
non-zero `--batch-size` arguments, so using that to construct the pack
is just a matter of dragging the sort out of the function to compute the
rollup itself (and into `midx_repack()` instead).

Patches incoming... ;-)

Thanks,
Taylor
