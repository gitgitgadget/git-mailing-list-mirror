Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA6520401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdFNKJf (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:09:35 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34851 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdFNKJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:09:34 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so23041561pgc.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D9J7CHuJ3820NsFncBkYdlzWDeHJENz149YzvLR8mN0=;
        b=qEDd6W0L1rgJvPFbsQjlUQ/j6ngUo4BG6s+157UOC6vdRPFDE7Jnu1KldjEHwx1vqN
         MfuLDHDiLqcVOupA5OQ97FkNytlkPc7eJ7vD0vaXA03ghSsuuKSQWAyQnqrVterdOX8D
         bN66Z3r5GocwKBcwAXj1fjq9iFOG8eB3QIxhg5HqIIjCDj2P+COcaqn/kAwsgiSshpaL
         rtvXBEOfEX/PNJhud48TONk3R2gGlzq0+eu+lJGTfwQOI7B11XjCC7nFHNmQc+xnT+C5
         xM4MAuY/sHMUBMgEl+MknSwBoo111bwIzHoMNy7pze3MYh2JugVTPFeKfQrux01SJdpu
         WWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D9J7CHuJ3820NsFncBkYdlzWDeHJENz149YzvLR8mN0=;
        b=sz/mCh5y5jjQrab3VaLUDeOxpNbH75ONpiPa7JgUh1O/TL7vihokxXDS6fbcmpdBpV
         Yj7cvFOggSOuFUJlNi2tL8aGCIz9SKE5SQWdNRCY0hJnP75Rla9Ugj58FM2DBzZhIoSO
         PGoP04LfGdTNYW9/lomvVmYuFUVllyAMHhRVdX1EbNKVOVdLDF12LUfzaN7LYAiH2kch
         P4x6tNBU81iCayqZgww2LEWiXtBMdoQbultAL0rga6j0phsQ40XB8NYzpE3lmarZcCLO
         EyDFP3SxlPzEEHQDW3BVS1+Fda3lukrjOmLlvCf2/mgeYFNUMmThlsg+iYXVrW4b1Rvf
         cATQ==
X-Gm-Message-State: AKS2vOzkvoK1ZpW7azQRZVXx4i6+RQlNJIZt+yQmdw7h3Pp7q91idm5G
        CVpHBwCUbVAVPg==
X-Received: by 10.101.72.207 with SMTP id o15mr3489702pgs.133.1497434974024;
        Wed, 14 Jun 2017 03:09:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 65sm1215073pgf.14.2017.06.14.03.09.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 03:09:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvind?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix a refname trimming problem in `log --bisect`
References: <5a3f6af6-f936-50e7-5fca-c41b3aeefdce@alum.mit.edu>
        <cover.1497430232.git.mhagger@alum.mit.edu>
Date:   Wed, 14 Jun 2017 03:09:32 -0700
In-Reply-To: <cover.1497430232.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Wed, 14 Jun 2017 11:07:25 +0200")
Message-ID: <xmqqbmpq519f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The code for `git log --bisect` was calling
> `for_each_ref_in_submodule()` with prefix set to "refs/bisect/bad",
> which is the actual name of the reference that it wants. This resulted
> in the refname being trimmed completely away and the empty string
> being passed to the callback. That became impermissible after
>
>     b9c8e7f2fb prefix_ref_iterator: don't trim too much, 2017-05-22
>
> , so the command was failing.
>
> Fix the problem in two orthogonal ways:
>
> 1. Add a new function, `for_each_fullref_in_submodule()`, that doesn't
>    trim the refnames that it passes to callbacks, and us that instead.
>    I *think* that this is a strict improvement, though I don't know
>    the `git log` code well enough to be sure that it won't have bad
>    side-effects.
>
> 2. Relax the "trimming too many characters" check to allow the full
>    length of the refname to be trimmed away (though not more than
>    that).
>
> In an ideal world the second patch shouldn't be necessary, because
> this calling pattern is questionable and it might be better that we
> learn about any other offenders. But if we'd rather be conservative
> and not break any other code that might rely on the old behavior,
> patch 2 is my suggestion for how to do it.

Thanks for a nice summary.  

I agree that 2. is a nice safety to have, especially if the code
before b9c8e7f2 ("prefix_ref_iterator: don't trim too much",
2017-05-22) has been seeing the completely trimmed result (i.e. an
empty string) in the callback function.

And I agree that 1. is also a good interface to have.
