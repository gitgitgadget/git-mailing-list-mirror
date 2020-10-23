Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE7AC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08C720882
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ww4ot7ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750713AbgJWUAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750685AbgJWUAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 16:00:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A4C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 13:00:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q199so2384648qke.10
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SOuxSrO3G7sQz1zOSFNwo//DoPAF4GTbv2OUsrejXyY=;
        b=ww4ot7ce2Rp9mSlbjCc64iUSZ35FcVy5YnZ6l93+8kSgsVxFkc6tDpK2YqJWCBpT9K
         f0paOy90KL7EwN0E+yD272dLaGO62HyeLjcfbzgRcTeWM0OjSPAp+oQtp5fObEL1U9Hf
         d4ELFORajB4x/4tbajpXRfkWsGP3ESMkZ5vj8ZoK8Y8/gEFeF8nnvGzzhrcwHKfU+QlM
         BJ1UwXnhUgauJZtIFikCDURrRz8vt7G9BatRhmq6XLw02+wSvJkbIqlOrgkt3BW6yNBT
         jiecfNNAt9tPG1y/RZLVrNzTuVnnoASJ6BYoA2HsvzQtOmM2YZ5zuDoE0lEka7MnGXx1
         Hnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SOuxSrO3G7sQz1zOSFNwo//DoPAF4GTbv2OUsrejXyY=;
        b=RyfBR6YSwdo5hUpZrGwwgEW1gMZIEaFmGOt+H0Z6OOgotDdNxDkXsuaUeI7CYTMHh6
         nGBzGi1qOh+grsh08P2hs+jgCfLW1mJzelYs17l0+7EVaJGKtw1hVW/ov/uAR/ncGuUR
         eV12DUE29xSZfxZxZ3wg7LfNU9wabE67eJDiKJsNO1vcZ2Pj2r5UHo26BC7Z8gUObWyT
         VdiuU9KxCYbEfBVZFPkQK3r3RwbGqu4ZbxOb8Qa44HXtlJlmdlvIEXPIbFOkDQLOqx37
         hAJ5m+irmRx+lj2AoziScCnWYPsey6k2EISV9N9BE0mKYuMrNk6Wh7xT4/AHVOMYz3O9
         q0Bg==
X-Gm-Message-State: AOAM533sVQd3BJBIP8rqMBB9mwtA/tMgEDgglNGZPX6XqiY0lnfTvz06
        4QbTR8OlCYv49uHbLv9+Bux9Zg==
X-Google-Smtp-Source: ABdhPJy7VZnWbOb7urF3DjboeMzORa3buYL3Kw2I4zKt48pQMF3sVFS/T1d7Mbynb+TjmEB2XRf3Uw==
X-Received: by 2002:a37:dcc3:: with SMTP id v186mr4014711qki.218.1603483236147;
        Fri, 23 Oct 2020 13:00:36 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:eda0:8d26:51d2:6e87])
        by smtp.gmail.com with ESMTPSA id o4sm1521748qko.120.2020.10.23.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 13:00:35 -0700 (PDT)
Date:   Fri, 23 Oct 2020 16:00:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <X5M2Yd7cxVRN1nlA@nand.local>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
 <20201023010315.GA1542721@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023010315.GA1542721@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 09:03:15PM -0400, Jeff King wrote:
> We are expecting to see $ZERO_OID in that slot, even though the current
> value of the ref is "PRE" due to our reset above.
>
> Should this be $PRE_OID (we don't have that variable, but it would be
> the result of "git rev-parse PRE")?

I also skimmed past it, but we do already have $PRE_OID, which is
convenient.

> I could alternatively see an argument that <old-value> is the old-value
> that the caller asked for. So seeing $ZERO_OID is saying that the caller
> wants to move from _anything_ to $POST_OID, and we're not willing to
> tell the hook what the current value actually is.
>
> We could actually fill in the current value for zero cost. The reason we
> found this is that we have a custom patch at GitHub that fills in these
> values when we open the ref after locking.

Yup, modulo being easy for symrefs (which I talk about in [1]), but it
shouldn't be impossible.

[1]: https://lore.kernel.org/git/X5M1oe4lfkUy9lAh@nand.local

> In real usage, I'm not sure how much the distinction would matter,
> because any careful caller would provide a non-zero "old" value. And if
> that doesn't match the current value, we'd reject the transaction before
> we even hit the hook, I think. It's only the fact that the update-ref
> calls are sloppy and do not provide an expected old value that it even
> matters.
>
> So I wonder if:
>
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index f6e741c6c0..8155522a1a 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -9,6 +9,7 @@ test_expect_success setup '
>  	test_commit PRE &&
>  	PRE_OID=$(git rev-parse PRE) &&
>  	test_commit POST &&
> +	PRE_OID=$(git rev-parse PRE) &&
>  	POST_OID=$(git rev-parse POST)
>  '
>
> @@ -52,10 +53,10 @@ test_expect_success 'hook gets all queued updates in prepared state' '
>  		fi
>  	EOF
>  	cat >expect <<-EOF &&
> -		$ZERO_OID $POST_OID HEAD
> -		$ZERO_OID $POST_OID refs/heads/master
> +		$PRE_OID $POST_OID HEAD
> +		$PRE_OID $POST_OID refs/heads/master
>  	EOF
> -	git update-ref HEAD POST <<-EOF &&
> +	git update-ref HEAD POST POST <<-EOF &&

This should be "git update-ref HEAD POST PRE", since PRE is the before
state.

> would be a step forward. This isn't changing the actual behavior,
> obviously. It's just tweaking the test so that it tests the more likely
> real-world case.  But we'd possibly want to actually change the behavior
> to always send the actual ref value to the hook.

I have to look at the issue in [1] a little bit more to determine
whether or not it requires major surgery. If it does, then I'd be fine
going forward with just your patch to the tests. If it doesn't, then
updating the refs machinery to invoke the hook with the before OIDs
correctly even for symrefs seems sensible to me.

> -Peff

Thanks,
Taylor
