Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6050EC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbiEYVNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiEYVNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:13:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F668FBF
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:13:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d21so909810qtj.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qvu6q1mEjraehGVQ6g6tYlKDmTn0tySdA0uiE7nYCzg=;
        b=IQZIBxYSBy+AxsEoB0UEyzEc3x5omLvNScgLSZ59Zt6hnLTW6VSSDqO1ZHY+DPQS80
         a8LOVss2Cf5RheegBgaJ85sxx767DW/rDNrEdwEdzxKNy+LwJkrfZPH/4hgaoi+eIsYJ
         mPnN1ERRIETZekZsjgzH2jx9QMa43rUtxsGymAzdPmE029MnutMthoPtBedwoeyWEzvA
         /GEnI+mLozCsPp4q2ssHFN5Jzz+Dwj0Jap+q/QmrRsb+ilFBbEXsmLVPuDAJwzrQiM3Q
         +sCV4PlmwI04gmFBweKK42TxKnHlAWb66Ilv9essIl8Vog5heujDYwNEp4zEUO8G2eco
         z0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qvu6q1mEjraehGVQ6g6tYlKDmTn0tySdA0uiE7nYCzg=;
        b=1S12BUNgg117Z5svnA1XTzAoKj+Fc4Z6NfmlK/IpwbQtVmg/EidVTsXcrGc1V8aejc
         TNfzpS2lfkXeLZzfXgHwIPNPOeAf3Uuua5d0+A5xsWizoVuS88p1VGgPrWmJ9B7U5zOU
         oHC8omkZwUUVIiM22bO9ZiI5X1DzS/9b04oqctlw1uv2Zfs2VB8askY8BqeET09UVYwE
         vHk+STmptgZslIuXVkdSduzmTrcbpoElBHxgl9xT0ZzdLDRRk1qvKPFWeCJWZ42664LL
         QYyvvAKUndqwhY1K/98J5+NAa7CGddJmRySbnezwDloYgQMaSYGKuv41VboipOmPbo7F
         xFdw==
X-Gm-Message-State: AOAM532fFCw+5mxI0CbiLU0RbqoaVnMWrFB4pU0mcGZuRWaROShQbV6i
        ceOinbI19WcXkOa2I7BA5sMsb6+OIZFpwQ==
X-Google-Smtp-Source: ABdhPJwIWLfHThj4Vu+6VYbNxlheQrbyRZvv4SOdAJiGuFhMymzIbVlMg5INDtImCbFANmFyj7UmJg==
X-Received: by 2002:ac8:7f0a:0:b0:2f3:ec89:ee23 with SMTP id f10-20020ac87f0a000000b002f3ec89ee23mr26458312qtk.448.1653513214007;
        Wed, 25 May 2022 14:13:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b17-20020ae9eb11000000b006a34a22bc60sm29496qkg.9.2022.05.25.14.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:13:33 -0700 (PDT)
Date:   Wed, 25 May 2022 17:13:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        rsbecker@nexbridge.com, 'Jonathan Nieder' <jrnieder@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: adding new 32-bit on-disk (unsigned) timestamp formats (was:
 [PATCH v5 02/17] pack-mtimes: support reading .mtimes files)
Message-ID: <Yo6b+8sixGAqMm/x@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
 <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
 <Yo1bUbys+Fz7g+6h@nand.local>
 <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com>
 <Yo1zW7ntTuNakpOD@nand.local>
 <220525.86o7zmt0l0.gmgdl@evledraar.gmail.com>
 <32db3720-e9c8-e192-6278-c55855ce1d3e@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32db3720-e9c8-e192-6278-c55855ce1d3e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2022 at 09:30:55AM -0400, Derrick Stolee wrote:
> On 5/25/2022 5:11 AM, Ævar Arnfjörð Bjarmason wrote:
> > I must say that I really don't like this part of the format. Is it
> > really necessary to optimize the storage space here in a way that leaves
> > open questions about future time_t compatibility, and having to
> > introduce the first use of unsigned 32 bit timestamps to git's codebase?
>
> The commit-graph file format uses unsigned 34-bit timestamps (packed
> with 30-bit topological levels in the CDAT chunk), so this "not-64-bit
> signed timestamps" thing is something we've done before.
>
> > Yes, this is its own self-contained format, so we don't *need* time_t
> > here, but it's also really handy if we can eventually consistently use
> > 64 time_t everywhere and not worry about any compatibility issues, or
> > unsigned v.s. signed, or to create our own little ext4-like signed 32
> > bit timestamp format.
>
> We can also use a new file format version when it is necessary. We
> have a lot of time to add that detail without overly complicating the
> format right now.
>
> > If we really are trying to micro-optimize storage space here I'm willing
> > to bet that this is still a bad/premature optimization. There's much
> > better ways to store this sort of data in a compact way if that's the
> > concern. E.g. you'd store a 64 bit "base" timestamp in the header for
> > the first entry, and have smaller (signed) "delta" timestamps storing
> > offsets from that "base" timestamp.
>
> This is a good idea for a v2 format when that is necessary.

I agree here.

I'm not opposed to such a change (or even being the one to work on it!),
but I would encourage us to pursue that change outside of this series,
since it can easily be done on top.

Of course, if we ever did decide to implement 64-bit mtimes, we would
have to maintain support for reading both the 32-bit and 64-bit values.
But I think the code is well-equipped to do that, and it could be done
on top without significant additional complexity.

Thanks,
Taylor
