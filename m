Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8C1EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 16:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjFVQj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFVQj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 12:39:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C141FEA
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 09:39:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3112f256941so5311316f8f.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687451987; x=1690043987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2dUEAsPrZ9nr0nUWuDHsRJ+XE/2jrDaVxStsgavzIrQ=;
        b=qkyQe37cXc85gGhA/Ekh99V2vkicjXHZ1UCzBS7KrEp4JEEXmAd0YVFl+gdo4gD663
         xfgAwoRx7U+hDOWK90DuN8jMzl+kl6Q2ukXQ7v7co7BmHfykWRlipVBWV3dGi1XW4Hue
         v3IuoBP+Rg9dFWmvZBaKeU/oNa7om3xLayGVYaMe5rXO7OJaSRPGsBAQo15JYIcU5Ie7
         Q2NgzYLdKiSB6JU+sb2EpzIlRqHkoFHrakNtBYbBWtnV6Cjif4H1vANDYnaZXRQyuWMr
         /k6+XNpcwTAii89xJPD8IlCwsWFI9AdsEgTc+hUpTKlVbUQdLYJ1QRo/kFMChomQAyyc
         nQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687451987; x=1690043987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dUEAsPrZ9nr0nUWuDHsRJ+XE/2jrDaVxStsgavzIrQ=;
        b=DrqmyLV/hhrFcLuNIw5Is8wyAmLaFIByhCe69pX83DTGWE82TLTnGgCgxRIq1dDFcq
         F4LXs0QYPq0vaul5+XdF1rs++y0K3wFINF2eMVzMakAA4E0UDe3xW8j6wdmSsDS6QkmX
         xv8lfWHcxJoPJV/R2cdMSbB1Ro8f6kfNA1zPnbfIlCy9Zf4ayPs7AZI2FuiQWhK1VcK3
         fLxJXGg8kbTMp7bzPU9u/0+SXQ8HUNAYf6qRFMpSiWrAsXZAQ614PYItvOzxqjqZXIZq
         KpT8rgIm7UCDIDTbcw7dF/IC2IbHhCcJN1TUQHjzZrm4ok1TdUiBn9EllMHUaRLTjtpV
         Xm3g==
X-Gm-Message-State: AC+VfDwl/lP6G1LY4kxAH8XkckUXRCxVbKDqQoEcfCvGC4kPTeHqTKIP
        296CtHQvAi88tz1PQTlvtYm4ckWLTw==
X-Google-Smtp-Source: ACHHUZ42DYFRQ/eC9VRDQctxT4mhPnhcbypgiR9M/338fbYI9HfbTgVW2GS/hakUZ4qCznmQXEsKXQ==
X-Received: by 2002:adf:cf09:0:b0:307:9db3:432a with SMTP id o9-20020adfcf09000000b003079db3432amr11572835wrj.42.1687451986881;
        Thu, 22 Jun 2023 09:39:46 -0700 (PDT)
Received: from pweza (i59F50ED2.versanet.de. [89.245.14.210])
        by smtp.gmail.com with ESMTPSA id p7-20020a056000018700b003095bd71159sm7479427wrx.7.2023.06.22.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:39:46 -0700 (PDT)
Date:   Thu, 22 Jun 2023 18:39:36 +0200
From:   Sergei Golubchik <vuvova@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: bug: submodule update fails to fetch
Message-ID: <ZJR5SPDj4Wt_gmRO@pweza>
References: <ZJQr0_aC-NlLXDgj@pweza>
 <ZJRHlJvE4BMue1/Z@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRHlJvE4BMue1/Z@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Taylor,

On Jun 22, Taylor Blau wrote:
> On Thu, Jun 22, 2023 at 01:09:07PM +0200, Sergei Golubchik wrote:
> > Hi,
> >
> > Sometimes (my local repository has lots of branches) after switching
> > branches
> >
> >   git submodule update --init --recursive
> >
> > fails with something like
> >
> >   fatal: transport 'file' not allowed
> >   fatal: Fetched in submodule path 'wsrep-lib', but it did not contain e238c0d240c2557229b0523a4a032f3cf8b41639. Direct fetching of that commit failed.
> >
> > the submodule transport is not 'file' (it's https) and the direct
> > fetching of the commit actually works:
> >
> >   cd wsrep-lib
> >   git fetch origin e238c0d240c2557229b0523a4a032f3cf8b41639
> >   git checkout e238c0d240c2557229b0523a4a032f3cf8b41639
> >   cd ..
> >
> > after that
> >
> >   git submodule update --init --recursive
> >
> > succeeds.
> 
> It makes sense that after manually fetching the desired tip that the
> submodule update goes through OK, because there is nothing to do (the
> checked-out state matches what's in .gitmodules), so we don't have to
> use any transport mechanism.

Right. I just used it to show that git thinks the submodule was updated
correctly and doesn't try to do anything after that.

> I recently changed the submodule update rules to disallow file-based
> submodules when not directly executed by the user. See a1d4f67c12
> (transport: make `protocol.file.allow` be "user" by default, 2022-07-29)
> for more of the details there.

Yes, I've seen it. That submodule shouldn't be affected:

  $ git remote -v
  origin  https://github.com/codership/wsrep-lib.git (fetch)
  origin  https://github.com/codership/wsrep-lib.git (push)

so I wouldn't want to circumvent your fix and allow the file transport
that we aren't using.

> But in the short-term, I am curious why we are complaining about needing
> to use the file transport when you claim that the submodule actually
> needs the HTTPS transport.
> 
> Are you able to share a copy of your repository, and/or its .gitmodules
> file, and your repository-local .gitconfig, as well? Do you have some
> `url.<base>.insteadOf` value configured elsewhere that would be
> rewriting those paths for you?

No insteadOf. Let me try to...
Okay, here's the bug. In submodule--helper.c, fetch_in_submodule()
function, there're lines:
---------------------------
2211         if (oid) {
2212                 char *hex = oid_to_hex(oid);
2213                 char *remote = get_default_remote();
2214
2215                 strvec_pushl(&cp.args, remote, hex, NULL);
2216                 free(remote);
2217         }
---------------------------

this get_default_remote() appears to be getting the default remote name
for the main repository and then uses it to fetch from the submodule.

It happens that my default remote isn't "origin" (long story), it's
"github", but in the submodule it's of course "origin", there's no
"github" remote there. As a result, `git submodule update` runs the
command

  git fetch github ${commit_hash}

in the submodule, and that's interpreted as 'file' transport.

To repeat this you need a repository where the default remote isn't
"origin" and a submodule where the commit cannot be fetched by simply
`git fetch` and needs a direct fetch.

Hope this helps.

Regards,
Sergei
