Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C2C1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 15:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeHJS2z (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:28:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38389 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeHJS2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:28:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so8733225wro.5
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lVDEhfnNK4YyIThh6/XR0baQRX1rBZJEs6E9k33XXIw=;
        b=Rt+XYdL3nYuf9UxWin4X7Jw2JGtNcjObaogawFxV3Dlty8D3AGPAT5raEYYhW2w2vz
         2o35WIs7S81Wm1uN7EbW0k2APFy5EAuYbA8lxY7X077Ygk54ig/RY4J5L1mdF0rxAHoL
         c3ZhR3oZFgewGp7oScz/cOQFeKlagefRfgIq7MVoejUjeFkhVKy59gRfg4Y2eA6S+MKT
         UTrfROm6Qz//8rZRtBAxfZARuTs4le/2c53x49VBUVjPNLDKZLmZ02wD+ekcSJRiSBLV
         qdg9Bs2TqvlbN3h4DeCOMOIxXdWODSExYz0mv/dAkX2k72jGnEt+fjANBatOCKe2SHrL
         koaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lVDEhfnNK4YyIThh6/XR0baQRX1rBZJEs6E9k33XXIw=;
        b=r+5hySZ098Po9gZ24mRrhNsd15OnC7iStQvH05vIyLR9+VpTkJipfR7dpsRn0WAEAA
         5aY9skY120x0yDVRDpPpBAn1Nh6lpmvuqLgOqGJB5LkdprkIo31DTswi22pqavRyxN6G
         NwyTJpYRQiHQ5LkATVf9UrAJ5FFvKmxL9dNrlFa01KcnyaS6V7Frl9N5sa0P+UZlAb0l
         Seo+tc0TEgy63xN5mhsu7nX9yS7hibIWmkNl+WE+xv/UrTn4I33dIZIvevxEa4Vy+a+8
         IBnnsfOkrQ1mnWB2LsV4l2Ylt/xB6Ht9/Z54aJf3GdtQcRZ2SlIMose8+KGH97yGCbu3
         DMoQ==
X-Gm-Message-State: AOUpUlFVxxBV1vr7GYAwRvTTPSv3y0CzuAdwmcQ6HBrCduFjingsCC6n
        PzIkftfh9jJNlzu3H6Hdb19CGuJg
X-Google-Smtp-Source: AA+uWPy88o1l+FBqVepoNNvLOGsnwHVBULxrGqcT9vsyZmQT/p8AJQKBg+wq9vQ/BA3mRN0PLDkfNA==
X-Received: by 2002:adf:d842:: with SMTP id k2-v6mr4538548wrl.26.1533916707396;
        Fri, 10 Aug 2018 08:58:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 66-v6sm3262825wmw.34.2018.08.10.08.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 08:58:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
References: <pull.17.git.gitgitgadget@gmail.com>
        <20180809194712.GC32376@sigill.intra.peff.net>
        <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
        <20180810140908.GA23507@sigill.intra.peff.net>
Date:   Fri, 10 Aug 2018 08:58:25 -0700
In-Reply-To: <20180810140908.GA23507@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 10 Aug 2018 10:09:08 -0400")
Message-ID: <xmqq36vm9psu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here it is as a patch on top of jt/fetch-negotiator-skipping, which lets
> us pursue any fix for interleaved trace output on Windows without the
> pressure of an impending flaky test.
>
> My gut says that looking into making O_APPEND work there is going to be
> the nicest solution, but my gut is not very well versed in Windows
> subtleties. ;)

As we know these tests are only interested in "fetch" lines and not
record of communication in the other direction, I think this is a
nice clean-up that is worth doing.

For only two grep's it may not look worth doing, but it would be
also a good clean-up to give an got_acked helper that sits next to
have_sent and have_not_sent helpers for readability.  That is of
course outside the scope of this change.

Will queue.  Thansk.

> -- >8 --
> Subject: [PATCH] t5552: suppress upload-pack trace output
>
> The t5552 test script uses GIT_TRACE_PACKET to monitor what
> git-fetch sends and receives. However, because we're
> accessing a local repository, the child upload-pack also
> sends trace output to the same file.
>
> On Linux, this works out OK. We open the trace file with
> O_APPEND, so all writes are atomically positioned at the end
> of the file. No data can be overwritten or omitted. And
> since we prepare our small writes in a strbuf and write them
> with a single write(), we should see each line as an atomic
> unit. The order of lines between the two processes is
> undefined, but the test script greps only for "fetch>" or
> "fetch<" lines. So under Linux, the test results are
> deterministic.
>
> The test fails intermittently on Windows, however,
> reportedly even overwriting bits of the output file (i.e.,
> O_APPEND does not seem to give us an atomic position+write).
>
> Since the test only cares about the trace output from fetch,
> we can just disable the output from upload-pack. That
> doesn't solve the greater question of O_APPEND/trace issues
> under Windows, but it easily fixes the flakiness from this
> test.
>
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm assuming that this really isn't triggerable on Linux. I tried and
> couldn't manage to get it to fail, and the reasoning above explains why.
> But I wasn't 100% clear that Dscho hadn't seen it fail on non-Windows.
>
>  t/t5552-skipping-fetch-negotiator.sh | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
> index 0a8e0e42ed..0ad50dd839 100755
> --- a/t/t5552-skipping-fetch-negotiator.sh
> +++ b/t/t5552-skipping-fetch-negotiator.sh
> @@ -28,6 +28,19 @@ have_not_sent () {
>  	done
>  }
>  
> +# trace_fetch <client_dir> <server_dir> [args]
> +#
> +# Trace the packet output of fetch, but make sure we disable the variable
> +# in the child upload-pack, so we don't combine the results in the same file.
> +trace_fetch () {
> +	client=$1; shift
> +	server=$1; shift
> +	GIT_TRACE_PACKET="$(pwd)/trace" \
> +	git -C "$client" fetch \
> +	  --upload-pack 'unset GIT_TRACE_PACKET; git-upload-pack' \
> +	  "$server" "$@"
> +}
> +
>  test_expect_success 'commits with no parents are sent regardless of skip distance' '
>  	git init server &&
>  	test_commit -C server to_fetch &&
> @@ -42,7 +55,7 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
>  	# "c1" has no parent, it is still sent as "have" even though it would
>  	# normally be skipped.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c7 c5 c2 c1 &&
>  	have_not_sent c6 c4 c3
>  '
> @@ -65,7 +78,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
>  	# the next "have" sent will be "c1" (from "c6" skip 4) and not "c4"
>  	# (from "c5side" skip 1).
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c5side c11 c9 c6 c1 &&
>  	have_not_sent c10 c8 c7 c5 c4 c3 c2
>  '
> @@ -91,7 +104,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
>  	# not need to send any ancestors of "c3", but we still need to send "c3"
>  	# itself.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch origin to_fetch &&
> +	trace_fetch client origin to_fetch &&
>  	have_sent c5 c4^ c2side &&
>  	have_not_sent c4 c4^^ c4^^^
>  '
> @@ -121,7 +134,7 @@ test_expect_success 'handle clock skew' '
>  	# and sent, because (due to clock skew) its only parent has already been
>  	# popped off the priority queue.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c2 c1 old4 old2 old1 &&
>  	have_not_sent old3
>  '
> @@ -153,7 +166,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
>  	test_commit -C server commit-on-b1 &&
>  
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" to_fetch &&
> +	trace_fetch client "$(pwd)/server" to_fetch &&
>  	grep "  fetch" trace &&
>  
>  	# fetch-pack sends 2 requests each containing 16 "have" lines before
