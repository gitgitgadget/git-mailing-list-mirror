Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C0C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380188AbiAaQRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380241AbiAaQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 11:16:59 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097EC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 08:16:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z199so17533316iof.10
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VV1UqWwXEwt9LKDnBMEe/kvAf4+7fm5mm0d25/RdYb8=;
        b=AxQbymfThGfYMdRTu2wmMYn6QgWP3HBhQjyIE2B8pXFE29T9iI5+E55BDgRungcyx3
         5inXNAC6S+OYrCJePgpMdeSmm4+4wCqwn+8McpyJijUEwCwOOhP1fTQUCMQsBR0GXRyC
         JR3emIJggWA2Oi8fZ+z4jrgLyy+BeDGlNc9tjiQb5ccNBVnGnLiT/oaLnfL/yjZhGjE/
         hLtnFrNSXKGULwlH7FSF8tXsMf1R8dUSoX2gUpoSx5lP9FcWAZ8Mzael19f0nb0BpiuF
         vouCx9CdvAU3zY1Pj9a3FaySHzV4rCOxnrIFXXz+eApkSaEjsozomI6B7MsDsJgLxgHJ
         HXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VV1UqWwXEwt9LKDnBMEe/kvAf4+7fm5mm0d25/RdYb8=;
        b=4UxX4F9Wht2MU7g7vvhLkn+BxCuUioJE5O1pcCGfLAKd7uN8FNR1rY9Lpfc07uaGC/
         bWmuGT/lap5hD+9cjuNSunsB7vJJ8NlnkCH8R7RmBEI6mz2UojqJTS/gM2z3QfyCLUPv
         hi5r1tZkBY6mGHcIBKlIu+ZHz22EffE9fTVoJ9VBtg4+WoT4Qnd0CvdFGGYO9KI0/ve2
         tymY2yasrrjfT+mpJbReNCyc5y233MCJ37LtV/ZX0s/YAUPXgQ1Dspkw+P0UD1tFZa2D
         5iq94mnlv/ybKPjHWj7zKtsVXMmzyeN/tB7+Bd19Ez/Z8ml4MT8DjANEFhgvuE+JBNgn
         mYZA==
X-Gm-Message-State: AOAM532Ga1z5lznd6BFxg2O2BkaFleLxMhl8T/WfwqJwhiwp7IEqwpMq
        IWFJxsDFRM7jCNJA5NbTSp7aSQ==
X-Google-Smtp-Source: ABdhPJwZnLlWAPQ/TRODejBnFRQP2T31hp/K6NIa06cCMN1x+vK0cqAdOY6EqdU1F8L6rkc/pLdaOw==
X-Received: by 2002:a05:6638:a17:: with SMTP id 23mr11781062jan.253.1643645818419;
        Mon, 31 Jan 2022 08:16:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l2sm2498080ilk.61.2022.01.31.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:16:58 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:16:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: BUG: Various "advice.*" config doesn't work
Message-ID: <YfgLeVw0rrk7Q5/+@nand.local>
References: <220128.867dakcgj0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220128.867dakcgj0.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 10:33:29AM +0100, Ævar Arnfjörð Bjarmason wrote:
> $subject, which I started looking at because in 4f3e57ef13d
> (submodule--helper: advise on fatal alternate error, 2019-12-02) the
> scaffolding was set up to read config, but nothing actually did so. So
> "advice.submoduleAlternateErrorStrategyDie=false" has never worked. That
> can be tested with:
>
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index a3892f494b6..8918be9ef5c 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -193,7 +193,7 @@ test_expect_success 'missing nested submodule alternate fails clone and submodul
>  		cd supersuper-clone &&
>  		check_that_two_of_three_alternates_are_used &&
>  		# update of the submodule fails
> -		test_must_fail git submodule update --init --recursive
> +		git -c advice.submoduleAlternateErrorStrategyDie=false submodule update --init --recursive
>  	)
>  '
>
> More generally, the advice API should be made to panic in
> advice_if_enabled() if nothing has read the advice config, which would
> turns up a lot of other such issues. I can't think of an easy way to
> check for that. We could add a BUG() on:
>
>     if (!the_repository->config && !the_repository->config->hash_initialized)

I haven't spent much time looking in this area, but isn't the only thing
that reads advice.* config the `git_default_advice_config()` callback?

If so, we could check whether or not it has been called (being careful
to handle the case where we called git_config(), but had an empty
configuration, so the callback itself was never run). If it hasn't, then
we could BUG(), though I'd probably err on the side of just reading it
right before calling advise().

In general, I wonder if making advise() public is a good idea. I think
there are good uses of it, like in builtin/branch.c, where we want to
print advice to the terminal unconditionally.

But having something like (in builtin/add.c:add_files()):

    if (advice_enabled(ADVICE_ADD_IGNORED_FILES))
        advise(_("..."));

feels like it opens the door to call advise() by default if we happened
to forget to read the configuration. I think that is a good candidate to
be replaced with advice_if_enabled().

I'm not sure if that is true in general, though. Take a look at this
example (from branch.c:create_branch()):

    if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
        error(_(upstream_missing), start_name);
        advise(_(upstream_advice));
        exit(1);
    }
    die(_(upstream_missing), start_name);

This also makes it possible to call advise() when we shouldn't have. But
how should we rewrite this code? Wanting to either error() (and then
call exit(1)) or die() based on whether or not we're going to print the
advice makes it tricky.

You could imagine something like this:

    if (advice(ADVICE_SET_UPSTREAM_FAILURE, _(upstream_advice))) {
      error(_(upstream_missing), start_name);
      exit(1);
    } else {
      die(_(upstream_missing), start_name);
    }

(where this advice() takes the place of advice_if_enabled(), and has the
dynamic read-advice.*-if-we-haven't-already behavior). But that switches
the order of the output, which may or may not be desirable. I haven't
looked further to see if there are more tricky cases like this.

> Probably the inverse would be a good approach, adding a
> advice.default=false to turn them all off by default, and then BUG() if
> we ever end up emitting advice anywhere (except if other specific config
> told us to enable it).

Maybe, though I still think BUG() is a bit extreme, and we could
accomplish the same by having the advice API just read the config if it
hasn't done so already before emitting advice.

Thanks,
Taylor
