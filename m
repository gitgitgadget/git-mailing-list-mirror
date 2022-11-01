Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F27C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKAUur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAUuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 16:50:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25B18B34
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 13:50:43 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o13so8457239ilc.7
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg7E4sPeWXS3RWyOWkLIG9rOBDGpmL0aV5t0Cw8hNKo=;
        b=Gk2CxPkZmpa7/vnyXUFHmtif3AhWQNp5ibNGtcXW0ATLfx5YKBM/XFWuu/Sz6PYILm
         uYEUMGBj7IBeXiwA22WZfVwucSgD7CEZwbZsXNdSDrBSTXWF60kAHpYMRL2i21vgClDd
         OVyXX0MnslS/8oAD2i8O+AMa3inUBZMYGoJLxTzCpNofk29m6d6G34pvjRVwAeuHOnFh
         cPogmTjStle19uYPVxX050bLXspTCSHXMpIvhhS1lOZAutgDda3N2zl1OtpTky9gPbtU
         qLajB1OQP6Ql624r6/qeCwVKUUsc9VLHwED77XNXa9/us2spgZpHubXd/vpCAQshLYWL
         7Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg7E4sPeWXS3RWyOWkLIG9rOBDGpmL0aV5t0Cw8hNKo=;
        b=qd0ERXW1ezXZio938IXUwhm/ZknkR10djWyumVP4+hvWEj2N6miTuJKktZ0Pa4DG3E
         9yPL8Sk8fQcieFmqCBYvxmEq70xntQzqb1zGcIMQlFxwEskuNeH1lx94P0oFQ5TkEBBJ
         lJ+z8PK3wN0kwpvc0RAp3eglPgCQflmRFs91TPwSHRkKjxDxiRzQvwrpxKA+wo+1sXht
         QsUdA6zoLRUFoslYoKmPUVPJvz2qfezd6zZoi+BAh58w2ODOONTa1Udr4nH0aRhrpirP
         Rd6DqKCVQsUu40Ul6FFF5NqhcyUlKOiLMWQdFm0x/fJarjcOHGpErHpU/2wPmKF84QHP
         BcXA==
X-Gm-Message-State: ACrzQf022IB0bRfHSCExu4EGBny02aBDy5MzL0vucsh/hJajpXb0rn2X
        fAn8uMgNv/5c/E7/6BrCicN4GIoEt+FmHPdr44E=
X-Google-Smtp-Source: AMsMyM5/3fCq5MZurIJoUTpBORhBdCYZT/glR7eWg1iqz8QWMnCbXFj+7uj3GSkARRtMyeOc5q42WA==
X-Received: by 2002:a92:dd83:0:b0:300:bc4c:6e42 with SMTP id g3-20020a92dd83000000b00300bc4c6e42mr5788174iln.85.1667335843132;
        Tue, 01 Nov 2022 13:50:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z18-20020a05660229d200b006bccaa66ee4sm4239792ioq.40.2022.11.01.13.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:50:42 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:50:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Message-ID: <Y2GGofvR0ii2pI1x@nand.local>
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
 <xmqq5yfze0lc.fsf@gitster.g>
 <Y2DOA7uYfkFveAU9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2DOA7uYfkFveAU9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 03:42:59AM -0400, Jeff King wrote:
> On Mon, Oct 31, 2022 at 09:54:23PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > It is unclear as to _why_, but under certain circumstances the warning
> > > about credentials being passed as part of the URL seems to be swallowed
> > > by the `git remote-https` helper in the Windows jobs of Git's CI builds.
> > >
> > > Since it is not actually important how many times Git prints the
> > > warning/error message, as long as it prints it at least once, ...
> >
> > Sorry, but I do not quite see the value of keeping the test to
> > expect success in a weakend form.  If we think we are emitting three
> > warnings, whether we do so by mistake or by design, and some of them
> > are lost and not shown for an unknown reason, is there a guarantee
> > that at least one would survive?  And when all three are lost, even
> > the test in the weakened form would fail and stop the CI builds, no?
>
> Without understanding the cause of the loss, I agree that things are a
> little hand-wavy. But the assumption _does_ seem to hold that we
> consistently produce at least one (presumably from the parent
> clone/fetch/push process). And if we can rely on that, there's value in
> the tests asserting that the message was shown to the user at least
> once.

Part of me wonders whether the local DNS-resolution issue you fixed in
the first patch would be sufficient to get us to produce the wrong
number of warnings consistently.

I.e., if I queue just the first patch and drop Johannes's, would that be
sufficient to get CI working consistently again?

I don't know. It's frustrating to rely so much on an external
environment that our feedback loop can only be as short as "push out
some combination of these patches and wait for CI". That's
disappointing, and TBH I would rather spend time focusing on other
patches than play games with CI.

The pair of patches look good to me. Perhaps we could avoid the weakened
assumption, but I do not mind too much in the meantime. Especially since
we already have a series[1] in the works that resolves the issue for
good.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com/
