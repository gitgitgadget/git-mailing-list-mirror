Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910FC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F12D60EFD
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhHDV2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhHDV2n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:28:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EBC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 14:28:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i6so5390297edu.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tgMuTJizcW86BhYRtmXSeoVDnkDezvHsQqu+a/anDug=;
        b=ooshWffGBxwYPfmg/QZ4rZ+iNLKQuznzTPL7/kEekyG+4jmnaRATguY8rpHEbgVpjn
         +NEBZ8hGNOfifV3OlXm4sesdl1S9R22RhpVp97v8MZ1Cgd1Pj0B8/BzAtY5t8MhyOcZ3
         UW9iaykVfOBbJTnriYq5F0/zz7ma2jZKY7muVItniS6QhHvvTFpc/ia2gEvXuXXypYtx
         VCcb8cjTLh8xiyWzgh2n5E9qYEgv+cEeheL/d35u2gKe62C1AjgDarwIL5n9FAlQhImT
         +2iPgQs+MLt+gS+tXDyfr38fD8g2K0quFULeD++DsCTjgDUqPeeXfR875u3Q/d1lc6r8
         mcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tgMuTJizcW86BhYRtmXSeoVDnkDezvHsQqu+a/anDug=;
        b=U9srdTm9Sw1HakxZixspJi+HqB6pzhx+mLiS98QBMQlLlPRaa7ETDtqOuaCINld2rk
         imoXzKuwqXthg4AS/qUOM12o3Kc/vklUFVPYCh3WqzoH6Nkp/KQyKWX+FMfMNhtIj8j6
         7GNj3DRLOMNcddWjSi9jJUOPS9HhjeyHK64Jz+QW6+rGp8R7t8NVHKWrWQbrFpp/dmzp
         hnXmGD+XUyrOYQqj5rsujsk9NBU2Stciu1coYY8t5UVBTCzgZfGi4zqct9paKDX9qFcC
         Fmzq6E8IKu3fNtlXLAEXoVg23Ao6KZ0nBk0uFZ+WpBAHtpBUP+5g7nJ5SiTPKcWtOczo
         YeBw==
X-Gm-Message-State: AOAM530Z/oZCdjJnX+xnTjjDGWnyoUrfW2WEJyB923blReaP/Tsmzt6f
        E3iUVF42Z05JG8NedY2ICNg=
X-Google-Smtp-Source: ABdhPJxycq2Hw/HKZPkIPbOCipuClY8m55uy4GhAb3e/fPGuNaKLofrmTnUAPSZDxMImNc8y7hrlEQ==
X-Received: by 2002:aa7:d8cb:: with SMTP id k11mr2070486eds.320.1628112508599;
        Wed, 04 Aug 2021 14:28:28 -0700 (PDT)
Received: from szeder.dev (78-131-14-24.pool.digikabel.hu. [78.131.14.24])
        by smtp.gmail.com with ESMTPSA id w6sm1388747edd.22.2021.08.04.14.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 14:28:27 -0700 (PDT)
Date:   Wed, 4 Aug 2021 23:28:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Message-ID: <20210804212825.GH23408@szeder.dev>
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <87wnp1mqv2.fsf@evledraar.gmail.com>
 <xmqq4kc5ozi7.fsf@gitster.g>
 <87lf5hm0v7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf5hm0v7.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 04, 2021 at 09:53:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Aug 04 2021, Junio C Hamano wrote:
> 
> > Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >
> >>> * ab/test-columns (2021-08-02) 3 commits
> >>>  - test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
> >>>  - test-lib-functions.sh: add a test_with_columns function
> >>>  - test-lib-functions.sh: rename test_must_fail_acceptable()
> >>
> >> We're going to need this or another solution to the v2.33.0-rc0
> >> regression in c49a177beca (test-lib.sh: set COLUMNS=80 for --verbose
> >> repeatability, 2021-06-29) before the final v2.33.0.
> >
> > Just a question.  Is that true?  Wouldn't a system that needs these
> > on top of c49a177beca already break the tests without c49a177beca?
> >
> > IOW, is c49a177beca truly a "regression", or is it merely "a half
> > solution that solves for most but not all platforms"?
> 
> Yes, because with c49a177beca your tests only break if you use the
> --verbose option, i.e. if your stderr is connected to a terminal. I.e.:
> 
>     ./t0500-progress-display.sh --verbose
> 
> So in practice it mostly affects git developers who run with --verbose,
> but probably nobody doing a build in the wild.
> 
> With c49a177beca they break on e.g.:
> 
>     /bin/bash ./t0500-progress-display.sh
> 
> If your bash is recent enough, so "make test" if you're on a system with
> a recent bash whose /bin/sh is /bin/bash.
> 
> This is because post-c49a177beca we don't "unset" COLUMNS anymore, which
> bash takes as license to update it.
> 
> So we really do need that series in before the release to avoid that
> common annoyance, a revert of c49a177beca is also possible, i.e. it
> would still leave things broken under --verbose, but that breakage is
> rare and existed before v2.33.
> 
> I think given the triviality of the fixes and that the cause is
> well-understood it makes sense to go forward in this case.

On one hand, there is feedback to be addressed:

  https://public-inbox.org/git/20210802171429.GC23408@szeder.dev/

OTOH, setting the checkwinsize is the truly trivial, minimal, reliable
and uncontroversial fix for this issue, and IMO that should go into
the next release.

This fix in this patch series is not trivial: it introduces yet
another GIT_TEST variable and a helper function that developers will
have to remember to use in the future.  Worse, this means that despite
aiming for future proofing I can't consider this approach future
proof, because it's easy to forget about such a rarely used test
helper function, and if anyone introduces yet another test setting
COLUMNS, then that will be prone to similar failures when run with
Bash.

I don't think that in this case we should aim for future proofing when
the cost is the additional cognitive load of yet another helper
function.  I would instead prefer to go with the really trivial fix
for now and wait whether this issue pops up again with other shell or
terminal, hoping that this issue is a "one-hit-wonder" [1] and it
won't happen ever again.


[1] "one-hit-wonder" as in:
    https://en.wikipedia.org/wiki/Bloom_filter#Cache_filtering

