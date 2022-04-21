Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AB0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391674AbiDUS57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391636AbiDUS54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:57:56 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF544C42D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:54:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i196so6317960ioa.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=edL1cnqM0xI7ZRNz3M7fhtuKCmz5g0cSubpTbrnsV9U=;
        b=GNrKtlxaGQ075BnhfrWvWa7PTbGdQexM+YgHAXDv425vqZqbyXF4/vX/Fl0cvRf3/H
         TX2HY5IeMHbFw5rjUvjTuav8BO+iHv/n0UIU89yGRQ8uog/I3yCla/FO4rr5g5WW8X4r
         7ErgvHFUUh4RK+Hoe5g6KcGyOFqJp6OqqbB83wOoWp2U2r747VAggE6tlPo9GWvmXKo2
         sG9PtYMVTpgStPORbqxaNPs3erNv7WYf96xAYxm2lGfwgrHI9gWG1DgrIuFzF780M5/L
         +8t4DmOXFzX7h5ncHRXXsECP7NE8Z8aE4r5TPYc2i63+gHz1od6TsPEYSQqHydCHYHtt
         nGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=edL1cnqM0xI7ZRNz3M7fhtuKCmz5g0cSubpTbrnsV9U=;
        b=SKnjQqKfV/nYlPu2BQBKDeu4U6S0ICOVqkzTovbs6tRMd5l1z76yBDybLFBnG5Pfe6
         u7rrSQ4nPeMv8UNQd9i/YhpdS2yCvpTlTEY6TT9bg3zcYmZFVyrKF0M93YT2v19WMhZj
         qE85ovF3ol038ReQf5Fk+Wxvp3eLQV2RoG/efK3OGFIMtN5Gs2cRRiQqWrJ7akjIL7/3
         ADzIQUL+SbWSoUfhkpWvl6Z/bLpwaJsJ4Jqr4XOqgGlPxtJHsDnnspyG0WXyrHgK6BNV
         7tvfATRWJvRvg3IXfpD9QEhjP5NBHlRtB65rZFQ+5uFgKpkdyiAu0i7Np8pI1TBlDwWX
         vszA==
X-Gm-Message-State: AOAM532vOSgI8TZ7D1qrSFkTR9s5QjmhUo+7KuVtI8gpk8qZy2SI/vd4
        wpNzyktZxCoOhY13OR2Yi4bFZ4Ka/hYeOA3R
X-Google-Smtp-Source: ABdhPJxR4WXWG4L1L6K0JvoZR7ZQCErofBOcKJEbJP4oti+kXkj8ooj+cceD24mbw6mdd+pYy+I92Q==
X-Received: by 2002:a05:6638:2389:b0:323:abaf:a8fb with SMTP id q9-20020a056638238900b00323abafa8fbmr521840jat.205.1650567284445;
        Thu, 21 Apr 2022 11:54:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5-20020a0566022bc500b0065490deaf19sm9046221iov.31.2022.04.21.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:54:44 -0700 (PDT)
Date:   Thu, 21 Apr 2022 14:54:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Git List <git@vger.kernel.org>, justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <YmGoc8gwB3W/cfHM@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local>
 <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
 <CAJoAoZkf6VuAOwX9j8Zc0x4HqJRJ5zQgqfmu+8Zs1kVx88dGpg@mail.gmail.com>
 <xmqq4k2mi88p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4k2mi88p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 11:47:34AM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > Ah, another thing I forgot to mention. There has been a little
> > discussion in the past about isolating "safe" parts of config (and
> > gitdir) from "unsafe" parts, e.g. "which configs and embedded scripts
> > are executables", to help better protect from zipfile-type attacks,
> > which are very similar to this kind of attack. I wonder if it makes
> > sense to consider that sort of thing as a needswork for this bugfix?
> > e.g. "/* NEEDSWORK: Only ignore unsafe configs and hooks instead of
> > ignoring the entire embedded config and hooks in the future */"?
>
> There have been such discussions in the past and they all went
> nowhere because such safe-listing fundamentally does not work.  What
> you consider "safe" today may turn out to be "unsafe" and in a later
> version of Git will stop honoring it, and for those who depended on
> it being listed as "safe", such a security fix will be a regression.
>
> Disabling the whole thing if the file can be tainted is the only
> sensible way forward without promising users that they will be hurt
> by such changes/regressions in the future, I would think.

I assume when Junio says "safe-listing" he is talking about your "which
configs and embedded scripts are executables". I have tossed that idea
around in my own head for a little while, and in addition to the points
that Junio refers to, I think that this could be confusing for users.

I worry about forcing the user to consider which parts of their
config and hooks are being read/ignored, and then re-interpret their
meaning in light of that.

That seems like it would be an unnecessarily tricky position to put
users in, and I think we could get around it by either reading the
config/hooks, or ignoring them entirely.

(It also seems error-prone to me: just trying to list which parts of our
config could lead to command-execution is challenging for me at least.
In addition to the ongoing maintenance cost, a clever attacker would
almost certainly be able to spot some obscure piece of config that we
didn't consider and then use it in their attack.)

Thanks,
Taylor
