Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F5C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD7C22CA0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 09:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFJMeE66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHEJGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEJGq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 05:06:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9C8C06174A
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 02:06:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c15so22287054edj.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0SL/F5hO/vjkOGfMX7qqITo0NxQybo7g1lPklZO0CDg=;
        b=GFJMeE66pcQikmJVd/YLc6YbZe0HLyaeaUBpDnFDZIosQ7L5cjsA3HUOI9umMSu3j6
         TGkpVRkyQs+95LOZiOnNpFpLcvJg9rUdk/JgOSVhiddu4wm3qI9KmMqxxtuwSvWFvoFl
         qp+w+AZ5qEhJS5u9SfyTEWgM64lAoqSLRqRqxI76VrNew9TNyFeZ2twPCxwnKrE1WY3G
         TAhTc2SY5oxOepFwREI+fc1aaMYK23KjzaJyr3MxLpPRQO4yMIaWyFtAFvEQ3AOlTB3q
         cwD5mD1vR193pv7bCmI9Ze3uRPJTV9421TuQdRnUkE1ZEc4Jqg9etHDGfImpe1t4Mb+6
         fi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0SL/F5hO/vjkOGfMX7qqITo0NxQybo7g1lPklZO0CDg=;
        b=XwRGkd/djtW1e00a1F9qUkYBpJQ+oKVBmlWY8PannsiFdhdZje3ZK/hypznaDc38QY
         bZ2ty2d2rNQb2BrOAnlMOJTnJQosAm8wfiZ3GkIax+UEeHE2Q1sSpePpB1qYNBa6p19m
         fUdJ1xR/73FoVFCP22QMlPrz2RKtB+mMIqH+2yQ9GGp23QTdSRPPXRlTA6E6LSAIkikZ
         gIPPqcgZIFJy5/WzkvJihE8S0545J1f1PHdCJc7q4ksj8O2XW7iFg/0hmS3uUiK6mQZy
         7kQFuPJa46yjg3XQ3ReQQM0feiKSglTZ/I2bPtBUGLFDlSGFZ7NclYFd1kh6GrFqSJ/d
         RXQw==
X-Gm-Message-State: AOAM5319dOfdhm/y8msJn5LgLjiSZpDyW7dB1F6DXkkVV+zg5cmd192J
        rfae2mVa/mrSHrEMPsq7EybW4ObB
X-Google-Smtp-Source: ABdhPJyDBwlKdMzab2odcr4At4+T4nACNcC0NtjH9EbmwUZt0HpmaghdvHfxT6jFaWNl2KBdl471pw==
X-Received: by 2002:aa7:d84d:: with SMTP id f13mr1749767eds.155.1596618404184;
        Wed, 05 Aug 2020 02:06:44 -0700 (PDT)
Received: from szeder.dev (94-21-37-143.pool.digikabel.hu. [94.21.37.143])
        by smtp.gmail.com with ESMTPSA id kt27sm1111059ejb.15.2020.08.05.02.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 02:06:43 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:06:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: racy test failure in tb/upload-pack-filters
Message-ID: <20200805090641.GR2898@szeder.dev>
References: <20200805084240.GA1802257@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805084240.GA1802257@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 04:42:40AM -0400, Jeff King wrote:
> I hit a test failure in the CI job against 'next' tonight, which proved
> to be an interesting puzzle. Skip to the scissors line for the
> explanation and the fix. Read on if you want to guess. :)
> 
> Here's what I saw:
> 
> Running t5616 with --stress works fine:
> 
>   $ ./t5616-partial-clone.sh  --stress
>   ...lots of runs...
>   OK   29.12
>   ...etc...
>   [I get bored and hit ^C]
> 
> If I run it with GETTEXT_POISON, it doesn't fail:
> 
>   $ GIT_TEST_GETTEXT_POISON=1 ./t5616-partial-clone.sh
>   ...
>   ok 17 - upload-pack fails banned object filters
> 
> but if I do both together, it fails almost instantly:
> 
>   $ GIT_TEST_GETTEXT_POISON=1 ./t5616-partial-clone.sh --stress
>   FAIL 19.1
>   FAIL 15.1
>   OK   26.1
>   OK   16.1
>   ...
> 
> But here's the really interesting part. The failure log looks like this:
> 
>   ...
>   + grep filter 'blob:none' not supported err
>   error: last command exited with $?=1
>   not ok 19 - upload-pack fails banned object filters with fallback
>   #	
>   #		test_config -C srv.bare uploadpackfilter.allow false &&
>   #		test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
>   #			"file://$(pwd)/srv.bare" pc3 2>err &&
>   #		grep "filter 'blob:none' not supported" err
>   #	
> 
> OK, so what's in that file?
> 
>   $ cd trash\ directory.t5616-partial-clone.stress-failed/
>   $ cat err
>   # GETTEXT POISON #fatal: # GETTEXT POISON #
>   fatal: filter 'blob:none' not supported
> 
> What, it's there!? Is it somehow confusing grep?
> 
>   $ grep "filter 'blob:none' not supported" err
>   fatal: filter 'blob:none' not supported
>   $ echo $?
>   0
> 
> Nope. So what's going on? Turn to page 17 for the exciting conclusion!
> 
> -- >8 --
> Subject: t5616: use test_i18ngrep for upload-pack errors
> 
> The tests added to t5616 in 6dd3456a8c (upload-pack.c: allow banning
> certain object filter(s), 2020-08-03) can fail racily, but only with
> GETTEXT_POISON enabled.
> 
> The tests in question look something like this:
> 
>   test_must_fail ok=sigpipe git clone --filter=blob:none ... 2>err &&
>   grep "filter blob:none not supported' err
> 
> The remote upload-pack process writes that error message both as an ERR
> packet, but also via a die() message. In theory we should see the
> message twice in the "err" file. The client relays the message from the
> packet to its stderr (with a "remote error:" prefix), and because this
> is a local-system clone, upload-pack's stderr goes to the same place.
> 
> But because clone may be writing to the pipe when upload-pack calls
> die(), it may get SIGPIPE and fail to relay the message. That's why we
> need our "ok=sigpipe" trick. But our grep should still work reliably in
> that case. Either:
> 
>   - we got SIGPIPE on the client, which means upload-pack completed its
>     die(), and we'll see that version of the message.
> 
>   - the client didn't get SIGPIPE, and so it successfully relays the
>     message.
> 
> In theory we'd see both copies of the message in the second case. But
> now always! As soon as the client sees ERR, it exits and we run grep.
> But we have no guarantee that the upload-pack process has exited at this
> point, or even written its die() message. We might only see the client
> version of the message.
> 
> Normally that's OK. We only need to see one or the other to pass the
> test. But now consider GETTEXT_POISON. upload-pack doesn't translate the
> die() message nor the ERR packet. But once the client receives it, it
> calls:
> 
>   die(_("remote error: %s"), buffer + 4);
> 
> That message _is_ marked for translation. Normally we'd just replace the
> "remote error:" portion of it, but in GETTEXT_POISON mode, we replace
> the whole thing with "# GETTEXT POISON #" and don't include the "%s"
> part at all. So the whole text from the ERR packet is dropped, and so we
> may racily see a test failure if upload-pack's die() call wasn't yet
> written.

Oh, this is a good one! :)

> We can fix it by using test_i18ngrep, which just makes this grep a noop
> in the poison mode.

I wonder whether changing that die to

  die("%s: %s", _("remote error"), buffer + 4)

would be better.  

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5616-partial-clone.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 4247102b00..9164ad3e63 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -239,7 +239,7 @@ test_expect_success 'upload-pack fails banned object filters' '
>  	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
>  	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
>  		"file://$(pwd)/srv.bare" pc3 2>err &&
> -	grep "filter '\''blob:none'\'' not supported" err
> +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
>  '
>  
>  test_expect_success 'upload-pack fails banned combine object filters' '
> @@ -249,14 +249,14 @@ test_expect_success 'upload-pack fails banned combine object filters' '
>  	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
>  	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
>  		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
> -	grep "filter '\''blob:none'\'' not supported" err
> +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
>  '
>  
>  test_expect_success 'upload-pack fails banned object filters with fallback' '
>  	test_config -C srv.bare uploadpackfilter.allow false &&
>  	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
>  		"file://$(pwd)/srv.bare" pc3 2>err &&
> -	grep "filter '\''blob:none'\'' not supported" err
> +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
>  '
>  
>  test_expect_success 'upload-pack limits tree depth filters' '
> @@ -265,7 +265,7 @@ test_expect_success 'upload-pack limits tree depth filters' '
>  	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
>  	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
>  		"file://$(pwd)/srv.bare" pc3 2>err &&
> -	grep "tree filter allows max depth 0, but got 1" err
> +	test_i18ngrep "tree filter allows max depth 0, but got 1" err
>  '
>  
>  test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
> -- 
> 2.28.0.506.gf082c28967
