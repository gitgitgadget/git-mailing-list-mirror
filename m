Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E0C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 21:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiL3VII (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 16:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3VIH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 16:08:07 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03E1C431
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:08:06 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id u8so11883241ilq.13
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aW3JmpQNHBPZRxbXwAaOqskCCN12wlUFcBJqilBi8co=;
        b=o/K6ZTkiM/26Hjn3ljb8z9mDK7qNIdiCh0JtVJTxnuqL3RgOfaAcmmTnB6G0yav2du
         LMHW8FuLTLfRoY70azgUeEv2CzFnxiSSxZoZafb74JLobs31TMHDDrJNN9Cnauyd71C/
         6ung+ZVxgkwvagNgH2xlgL59qua5Xt1MSZeiuV55yU6ISg6f6pWoIW0DEfTLufhwQfNZ
         bIFY0jtCej/SHmVetWQQmoIiRQ27jXuLH1jW7TPKM/ux9qJRHZ+JpTnQWo+EAJ7kPjyB
         xMdGWs0kYDVSeaoiThMs7Ay4+m+CiZxkNN1Dm0kBsQ3be90r2rTe8aIBx0HMyPOnyKgZ
         88Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW3JmpQNHBPZRxbXwAaOqskCCN12wlUFcBJqilBi8co=;
        b=8GPyKrz394xLHCuXLIMdhn2wk6yVUrT/0H1gsLXM+n89QzlFJorq9bS7uawwG6PJDV
         s/lzMj4fWgnqdYv+JmJWk6KCJyKuAyT0kb5FGh0eqazLSpaIkxRcWametXRyVYrhnEah
         G2KPceToTISJ9DsHzaooXoLnMDOL7/8+xdDkpn9pRQrSjffXQzko4uLe43VENo+lka+U
         6vj51//l6vtmIxkODPMIiZNqz8jmU5jWboAmS7rUc4fppkmAcIObIaLBkObQxsxc+auM
         LXVyf72TK050p6InSd7p9d6L+OZC8pvte4Grlj9oFchrHNNZd/2ylzEwBetC7gJq8u8N
         xtpg==
X-Gm-Message-State: AFqh2kpIJ8w8/zCprWNnm50sG3tofTGr0snREE/2O0mvg4fNqi8c/FBN
        G1Lbw03Hu4qeWmBrC0PmxWJvBQ==
X-Google-Smtp-Source: AMrXdXvc0J/THdeF7ntoSRRlGIvazmkB5NNQoiY13BWEyTqxyIkKmzQDcaTjIFrNLUJLEkgJcb+nXA==
X-Received: by 2002:a92:b745:0:b0:304:c04b:c184 with SMTP id c5-20020a92b745000000b00304c04bc184mr22779196ilm.28.1672434485663;
        Fri, 30 Dec 2022 13:08:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y18-20020a056638229200b0034c12270863sm7188690jas.80.2022.12.30.13.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 13:08:05 -0800 (PST)
Date:   Fri, 30 Dec 2022 16:08:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [BUG] fatal: transport 'file' not allowed during submodule add
Message-ID: <Y69TMzIf/bdsZe6/@nand.local>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com>
 <xmqqilhwp5g4.fsf@gitster.g>
 <011201d91aca$a5db7800$f1926800$@nexbridge.com>
 <Y6y+zkUsPhknTYH/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6y+zkUsPhknTYH/@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, Dec 28, 2022 at 02:10:42PM -0800, Jonathan Nieder wrote:
> Hi Randall,
>
> rsbecker@nexbridge.com wrote:
> > Junio C Hamano wrote:
>
> >> This suspiciously sounds like what a1d4f67c (transport: make `protocol.file.allow`
> >> be "user" by default, 2022-07-29) is doing deliberately.
> >
> > I have tried using 'git config --local protocol.file.allow always' and/or
> > 'git config --local protocol.allow always' to get past this, without
> > success.
>
> Does `git config --global protocol.file.allow always` do the trick?
>
> >>                                                           Taylor, does this look like a
> >> corner case the 2.30.6 updates forgot to consider?
>
> I think it's the intended effect (preventing file:// submodules), but
> I wonder if this hints that we'd want that protection to be more
> targeted.  A file:// submodule (as opposed to a bare path without URL
> scheme) wouldn't trigger the "git clone --local" behavior that that
> commit mentions wanting to protect against, so at first glance it
> would appear to be no more or less dangerous than cloning from a
> remote repository.

Changing the default value of 'protocol.file.allow' isn't solely about whether
or not we use the `file://` scheme and transport or not. Instead, it's
about preventing the user from accidentally cloning local repositories
containing sensitive data into the working copy of a malicious
repository.

One example might be that I convince you to clone my malicious
repository, which has a Dockerfile that uploads everything in the
container filesystem to some data harvesting server. Since 'docker run'
automatically puts everything in '.' into the volume mount, anything in
the working copy of my malicious repository will get exfiltrated.

The worry that I wrote about in a1d4f67c was that if I knew that you
stored, say, your SSH private key material in a repository that is at
`$HOME/.git` (as is sometimes common practice), then I could add a
submodule at /home/jrnieder/.git, and extract any sensitive data
therein.

So I think our new default is sensible here if we are concerned with
preventing such a case.

Thanks,
Taylor
