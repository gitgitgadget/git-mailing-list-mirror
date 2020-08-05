Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20508C433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DD52250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GAZCkCVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgHETsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgHEQ50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:57:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A6C0086BD
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:08:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e5so19860372qth.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+K4HQ8uGdhlYL7lJDGekFTM+CdywondHaWeOIEM6MQ4=;
        b=GAZCkCVdgEfYWwC0JkHT4A34uY2Xtt+iJHwpbytrNdRdc9fa2CzVDzvG6OFdFlbXZ8
         iJIE2F9m94XQDknyxsSbPtgeRN8EUeBpY9i8LMWDATPwfzhj7hNAYJQ7w6wCVFJJzKFQ
         q3H7S39PmlZAtIq+/G6O7yNXEYw2t57VbTZkhlxPzcSE3xOPoGXkH1HOlGzYb8o3uwXi
         pCFi3i/186MHOjs0hQx1b20NtcEjyVncIdoTM4q3Qt0xKzVQMXvoANarKr/JLtEWQUP6
         knZntwXAQxRBYsLsKulZy9JVLLETcwo0GqPStu/u2vcoWYly6sHK4u7tpEzDMDg3nKPY
         mG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+K4HQ8uGdhlYL7lJDGekFTM+CdywondHaWeOIEM6MQ4=;
        b=NhCX7W3ENlGBhxTaqJ/WMurep3mnfWh0+on8av67Lz9RTC+l7FQDont5XRpPtPVhvK
         bBskowLShp7Wm+HpBGAcH5isDavEcoKVCO57ltaXJVZ25eMkugUweu0W/gV8G02xweOX
         I/6BsD565tPo/0dECedikdBG5vFVUCnqFggRNixyeQvEeCX6VbUqJ51lasrYma4g7QOL
         mtcb/M4qD1Y+6KvYT/lhf3GUzsHwsQaqOuHTxp2KY+Uy55jh8kcBBmzsZhILyHFFlcWv
         7QKDVQqcgzmCNtbtmq7WnX2iDz3SHSNWnaLg3MaPeUSTFN2/N+SSlsiCbWd2QeUYimiW
         KdIg==
X-Gm-Message-State: AOAM530L0LecpY0ogF1q6aHc0Gblizw1wvG7Vwk/kZCzotNBlDakyb4v
        j2t/0seyb0g9i8FzDdH4++SYDw==
X-Google-Smtp-Source: ABdhPJwZY3m9dreDvcc1PeBRWDWkCwnpD7xvEds24Kg42mthYpIoK+1oS2B7uiWP6KutR4aMx1BZMA==
X-Received: by 2002:ac8:454b:: with SMTP id z11mr3946562qtn.350.1596640132630;
        Wed, 05 Aug 2020 08:08:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id x67sm1664182qke.136.2020.08.05.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 08:08:51 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:08:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: racy test failure in tb/upload-pack-filters
Message-ID: <20200805150850.GA9546@syl.lan>
References: <20200805084240.GA1802257@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805084240.GA1802257@coredump.intra.peff.net>
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

Yikes. I knew I should have thought more about switching from
'test_i18ngrep' back to normal 'grep', but I wouldn't have expected
something like this ;).

I agree with your find and fix, and thanks for the enjoyable read in the
meantime.

  Acked-by: Taylor Blau <me@ttaylorr.com>

> We can fix it by using test_i18ngrep, which just makes this grep a noop
> in the poison mode.
>
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
Thanks,
Taylor
