Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3702BC433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187CC61506
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhKHWJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 17:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbhKHWJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 17:09:34 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B5C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 14:06:49 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id m9so5622423iop.0
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 14:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7C1MWr0XdfxsnY0cmfkKtT0CXW8/P2LQFgAIRyg4Xmo=;
        b=fyzb3AYB6rD7YOldupr9eyAkhDSI+l5u/QXwNKKaxA/3OboQeat6LKkAGUP9xctkiA
         dtpYH1M3DKfXszPqL991mWCGnYQgwBg1xM4OGXO6u7k7RNwhafOf5+GcJyRLtdCOoca8
         BvYw0QN/mBPIHbZITMzuI/eq96GjfRoI/R6vT7Netr1CzMoewdg9w6urYI1WIW5MIM2t
         5jjVQhog5dMeZdaR3ZVPysirq+/087YGDjFpyKnref1C6hq7WUfzdqnSvzj8n+GiXPPc
         t6WQ0U3YpRp2/eEqbhDhFzXvQ91hQptOOVd+iQ5roHj7l5bqw4OL09usoAYOxqyHE0cL
         dCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7C1MWr0XdfxsnY0cmfkKtT0CXW8/P2LQFgAIRyg4Xmo=;
        b=rbKZbjSSS/yXELn6tu+uH/uAn7abvfJtnbljKh2PdYCEt3u//hR3IF8YXNkac/Ern5
         Dsun3mBtzC9wS0DqUvjYX8F3Ctt+CnR522yesovtTiV1NhpzV32UTrT/rBw4BZyRLIvm
         5xPpqLRqza3oY8cxZWgdfmdSkbbqZg/o+/5vvmYPtlctRiYtT+oTGdiVjXou4bcpuETj
         HhNbgXMxQj2+yT5Hly9FCVHhynyEzjV+k7SZpAqiowXzpVZrFr51uguiM10mGUULKLu2
         WNoD4wg41COOKxcxC4Bzyy/Mnk48UAz03zfrGDsY6U0f1k95mPS7i4f6Avv2VXBSQwO+
         kEGA==
X-Gm-Message-State: AOAM530OuPIMS8KDFFmWPREtocZT7ymWR+PoB0TYt4dxqzNqa1uIqk0G
        mprTnxvNe3TKC9j9TU0r+hdfDxDqEXYGK1gM
X-Google-Smtp-Source: ABdhPJw0rnJAniVz2xBISbUB2rExz6S/qgY1yTYG//ACNwdJemrjS3pOcPbTQBjG9gHLFX2IYkhrFA==
X-Received: by 2002:a5d:9da2:: with SMTP id ay34mr1588962iob.26.1636409208591;
        Mon, 08 Nov 2021 14:06:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7sm1817967iob.28.2021.11.08.14.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 14:06:48 -0800 (PST)
Date:   Mon, 8 Nov 2021 17:06:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: move some test-tools to 'unstable plumbing' built-ins
Message-ID: <YYmfdze1N7tL+2FE@nand.local>
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
 <xmqq35oaxwnz.fsf@gitster.g>
 <YYWBz6rjF+I+JkO3@nand.local>
 <211106.86fss9hq3f.gmgdl@evledraar.gmail.com>
 <YYgHhaOAsv7pVAMi@nand.local>
 <xmqq7ddiv4oi.fsf@gitster.g>
 <211108.86zgqee6rm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211108.86zgqee6rm.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 08, 2021 at 09:19:10PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Nov 08 2021, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> In my experience I *rarely* rely on test-helpers when debugging wedged
> >> repositories, and much more often end up either in gdb, or in an
> >> anonymized copy of the repository on a different server. I would imagine
> >> that others have similar experiences.
> >>
> >> So unless we had a much more compelling reason to have the test helpers
> >> more readily available, I do not think that the risk our users will
> >> begin to depend on these unstable tools is worth taking.
> >
> > OK.  It sounds like a sensible argument against such a change.
>
> It's an argument against not flipping "make installing them be optional"
> flag on by default, but we could otherwise move some of t/helper to
> builtin/, which would help by encouraging us to write at least
> boilerplate docs for them.
>
> Git developers & similar parties could then set them to be installed for
> ad-hoc debugging.

I was talking about users not heeding our warning, but I'm still not
really that compelled by making the test-helpers an optional component
in our build.

I am pretty sure I have only reached for the test-helpers less than half
a dozen times over the years, and *much* more often find myself in a
debugger. If I'm in the minority (and there really are a lot of
administrators who find it useful to have the test-tools on hand), then
that is a different story, but my guiding assumption is that that isn't
the case.

> I really don't buy the argument that there's no amount of warnings in
> our documentation that we can include which would give us future license
> to willy-nilly change certain things.

My point was only that we cannot guarantee that users read or care about
our documentation.

Thanks,
Taylor
