Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D82C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 20:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiBZUak (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 15:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZUaj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 15:30:39 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F294C23EC5B
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 12:30:04 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h16so10522212iol.11
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 12:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KT6c3zS6HpbQI2OIDSXzVHqodMNrB8XuJnJBQ8aNx0g=;
        b=jDy3TrPa3oBtX8/UEkk2efwGe1ncRtuQ40M6g2koDBQHNBHvKbvZ/2jRpBLANyj204
         viZmAoxWCetgG9t566GbkzgvfvozLX5H5Xbv0VKFj1QselZKZ/5gDh1V2JNZ78AONC8B
         1l+ZdEFP78KATvM+lNDujZoSzDLkHMyZWOiiR/hs1khGpuGg2NpbV7wvFDIPC4E1HCV5
         0wgJFCEO+7JV0AwbFaYm7OKqvMgfDAgkltggjo/zBPPyzIHJkpm6p6+BCoK64TWYECxO
         qJc9VsmGNpGyCuNp2Ml+pJ8gRtuZSRJ/Q7aet0Be9/sQ2XASCPf18+d3Byg2r6ucwdTL
         fgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KT6c3zS6HpbQI2OIDSXzVHqodMNrB8XuJnJBQ8aNx0g=;
        b=St4bOAWF6y9x5JXkKdjrlOYB0IHfqQs4BrO4fspDW1XTzW+JZeJtp43t0TgYBETq2W
         z3qzgfTAYwnaB4rRS+Yp3HcaU6zR6AJOETzgLoXZfLG/m67e/JPM3WqZGQWwFp/IuiG3
         ipRc5jeBZEHlQoe7PEH/CjDKlYA3ee9KxhgHoxyaZHvs8r0DVbXMacJ60XlF2+yaM/GI
         YVZTIyIjuzmTLCcZmpFNWaKtUeVyROCJtT//kmSTSBxvvJ82YBQR1psbdGHtNn9ocNph
         er6iVuq+vVXBfcmtxcCDFSPZ31vq9FaacweeLFVX102ethW9HlDsDyM6b4FEYJS5D8PF
         vrNQ==
X-Gm-Message-State: AOAM530n0adVK7/Io67aMIMcjBGYEnyiMHQLtxuWSbAyt7h8zlVIiJgi
        WG4HO/ywaLDw4SIsumgMMkBAug==
X-Google-Smtp-Source: ABdhPJzR1n8Zh99rmMwptTO/1pW658mTW7zpZ2AwDv6dW7iKtJIEsrBW8Z9NsZ2XzJwUioyDsce3xA==
X-Received: by 2002:a6b:6b19:0:b0:640:a354:69ef with SMTP id g25-20020a6b6b19000000b00640a35469efmr9980133ioc.186.1645907404357;
        Sat, 26 Feb 2022 12:30:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x14-20020a927c0e000000b002c244d8dcc8sm3498931ilc.42.2022.02.26.12.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 12:30:04 -0800 (PST)
Date:   Sat, 26 Feb 2022 15:30:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhqNy+t5SARNivQ5@nand.local>
References: <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
 <xmqqv8x5v0qc.fsf@gitster.g>
 <36CA51FE-8B7F-4D08-A91D-95D8F76606C9@gmail.com>
 <YhpjbQeFaMNVnyP9@nand.local>
 <47AC2D8D-ADB2-4280-86F0-6B1E239C1EBE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47AC2D8D-ADB2-4280-86F0-6B1E239C1EBE@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 26, 2022 at 03:19:11PM -0500, John Cai wrote:
> Thanks for bringing this up again. I meant to write back regarding what you raised
> in the other part of this thread. I think this is a valid concern. To attain the
> goal of offloading certain blobs onto another server(B) and saving space on a git
> server(A), then there will essentially be two steps. One to upload objects to (B),
> and one to remove objects from (A). As you said, these two need to be the inverse of each
> other or else you might end up with missing objects.

Do you mean that you want to offload objects both from a local clone of
some repository, _and_ the original remote it was cloned from?

I don't understand what the role of "another server" is here. If this
proposal was about making it easy to remove objects from a local copy of
a repository based on a filter provided that there was a Git server
elsewhere that could act as a promisor remote, than that makes sense to
me.

But I think I'm not quite understanding the rest of what you're
suggesting.

> > My other concern was around what guarantees we currently provide for a
> > promisor remote. My understanding is that we expect an object which was
> > received from the promisor remote to always be fetch-able later on. If
> > that's the case, then I don't mind the idea of refiltering a repository,
> > provided that you only need to specify a filter once.
>
> Could you clarify what you mean by re-filtering a repository? By that I assumed
> it meant specifying a filter eg: 100mb, and then narrowing it by specifying a
> 50mb filter.

I meant: applying a filter to a local clone (either where there wasn't a
filter before, or a filter which matched more objects) and then removing
objects that don't match the filter.

But your response makes me think of another potential issue. What
happens if I do the following:

    $ git repack -ad --filter=blob:limit=100k
    $ git repack -ad --filter=blob:limit=200k

What should the second invocation do? I would expect that it needs to do
a fetch from the promisor remote to recover any blobs between (100, 200]
KB in size, since they would be gone after the first repack.

This is a problem not just with two consecutive `git repack --filter`s,
I think, since you could cook up the same situation with:

    $ git clone --filter=blob:limit=100k git@github.com:git
    $ git -C git repack -ad --filter=blob:limit=200k

I don't think the existing patches handle this situation, so I'm curious
whether it's something you have considered or not before.

(Unrelated to the above, but please feel free to trim any quoted parts
of emails when responding if they get overly long.)

Thanks,
Taylor
