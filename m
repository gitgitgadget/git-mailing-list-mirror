Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BFB1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 20:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeHIXQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:16:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34224 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIXQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:16:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so6329483wrt.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/eY+0rJkdFIN/K85QmuNLsECPLdWXd0q9CvZ21uCZjM=;
        b=KzmFkXBKvSvrW6DAF4baFFvSQ0LX3tAjecT+eb60i5lQx/OWds8wNCtZB7KHKM1gAc
         sFtpoo5Mn00rJ2O4aUQ790NiGqo0+1rSiKeQnSBwJagHKqwqXB3C/4Q6nmwI8xvCd1w1
         2Mq9/WnXEd9quBdPbKX8AkuWOy1dYhSUTRMZtinhSMaVaohpghIWwPg7eXGzKLh/exw0
         F6hO2eOKoDxzeFa4j93woB1f9Zu9P8UjThq6MB1Nf4IOel2KModT+n59bMy4Mdlkb04A
         DcSvvXEpiAxO1wSjo1bB59VB/VuGLSiuCY+09kPsuOpkm3Gwx040JezqnH3Uh7nCgAQn
         cv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/eY+0rJkdFIN/K85QmuNLsECPLdWXd0q9CvZ21uCZjM=;
        b=s0n/OgqqMBsg2rerCf0xpuotYIoYD3kstCt6T/AptSEWm14+byjGGy5kST3OKPGrVA
         XHSgypPtJv+MErLUkb+5tfkwOiDK/U6FC6Ju2hPYrFN7itVDfROfx82XZh/zjFcUEFwz
         zgPZhseYN1w4OZ3Xe8Wvr/fxnGeEP40NkMAIz/qE2hBjKzFj/Ku10eOyFYq0HWo8R4MU
         ZBXbEjWlw3QBQ/vaSQNk2luAMfeaXGrAB2fpII2KzkwkctARRbeUuykKQycEwpXdGSMF
         sICtPW7K28OdCvUNXuKnkWq8hnEqGwQ1K1Q8Xvm7isL5piWnFYoN8c2GW+R960KlEwOz
         AKnw==
X-Gm-Message-State: AOUpUlHFdcKzoKOR7ws4o4e9y79U7vKaaeNx24abI4l0tW5rYOV6pVeT
        B1QeTZKkHDgLOqNwQ02786G3KAT0
X-Google-Smtp-Source: AA+uWPwuBrhWQ6IvCVTt857hh9A5Yr7rF9WyRFOPP9J759tStcH0iKoCXmutD9K1TksOdHEpqA8Afw==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr2296321wrf.268.1533847794618;
        Thu, 09 Aug 2018 13:49:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y18-v6sm6648864wrh.85.2018.08.09.13.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 13:49:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
References: <pull.17.git.gitgitgadget@gmail.com>
        <20180809194712.GC32376@sigill.intra.peff.net>
Date:   Thu, 09 Aug 2018 13:49:52 -0700
In-Reply-To: <20180809194712.GC32376@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 9 Aug 2018 15:47:12 -0400")
Message-ID: <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Are you sure that it's not well-defined? We open the path with O_APPEND,
> which means every write() will be atomically positioned at the end of
> file. So we would never lose or overwrite data.
>
> We do our own buffering in a strbuf, writing the result out in a single
> write() call (modulo the OS returning a short write, but that should not
> generally happen when writing short strings to a file). So we should get
> individual trace lines as atomic units.
>
> The order of lines from the two processes is undefined, of course.

Correct.  But I am more worried about the "mixed/overwriting"
breakage, if there is one; it means we may need to be prepared for
systems that lack O_APPEND that works correctly.  I initially just
assumed that it was what Dscho was seeing, but after re-reading his
message, I am not sure anymore.

I think the "do not trace the other side" approach you suggest for
these tests that only care about one side is more appropriate
solution for this particular case.  We then do not have to worry
about overwriting or output from both sides mixed randomly.

> diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
> index 3b60bd44e0..5ad5bece55 100755
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
> @@ -88,7 +101,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
>  	# the next "have" sent will be "c1" (from "c6" skip 4) and not "c4"
>  	# (from "c5side" skip 1).
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c5side c11 c9 c6 c1 &&
>  	have_not_sent c10 c8 c7 c5 c4 c3 c2
>  '
> @@ -114,7 +127,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
>  	# not need to send any ancestors of "c3", but we still need to send "c3"
>  	# itself.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch origin to_fetch &&
> +	trace_fetch client origin to_fetch &&
>  	have_sent c5 c4^ c2side &&
>  	have_not_sent c4 c4^^ c4^^^
>  '
> @@ -144,7 +157,7 @@ test_expect_success 'handle clock skew' '
>  	# and sent, because (due to clock skew) its only parent has already been
>  	# popped off the priority queue.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c2 c1 old4 old2 old1 &&
>  	have_not_sent old3
>  '
> @@ -176,7 +189,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
>  	test_commit -C server commit-on-b1 &&
>  
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" to_fetch &&
> +	trace_fetch client "$(pwd)/server" to_fetch &&
>  	grep "  fetch" trace &&
>  
>  	# fetch-pack sends 2 requests each containing 16 "have" lines before
