Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDCB1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 15:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeHJS27 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:28:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32854 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeHJS27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:28:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so8759388wrp.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=FUgon6ewfPgAlQPckkrDvIh13fbvA+dJ9pPbPVdTGMk=;
        b=Gk3p5rLmseUHTItpvmXuZTMKnDaIzbgaGZKWwkGOAJTB2b3+d574Q7xNj2oChZDiOM
         Mu4LQFnK7B44ynmw4qcW18U9ucMIEUdgBkmA6L8oJNwgu3rTttnyGRju+hyXM5SajWeT
         IvoZ1dNOOmlqzDJnsuZk6lLdMkoB2fJpBnha1SYjuqoUcSifv241WqMFpKOKncgydtlr
         7vKzlptAy1eYRy7P4ikffwQvRulVztlsCFxEoSU0wg+OSWrDxgEp+OHBVd1MVIYwgquY
         UBsDv1xp/kMxAQZ+BW+jNo+6qweg7fk74WAdPQuYmVhL1yggP92VLzNt0pTAiVIPlYru
         Hxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=FUgon6ewfPgAlQPckkrDvIh13fbvA+dJ9pPbPVdTGMk=;
        b=NZ9ISWTOZTKETQwg+4REBAK1ty2B+AoJzVsjvfmmPNo0Hcq5LzqxiboaSRhDDrxXtA
         4E7IJ2iuFdHG+bqAv/0CbK2+G9eFD4tHJnvuM0VkWNQH1mrfgnAMmsRPKpfiG/EDSKE/
         RMOHpPhuHyrRQPZ4EEYj09AnXVSxkVbb4VzCLzYKi9JLGAy/GzmlVaVkQMxUq5JKerbB
         J6Qo6EBpha6XbXy9J+VqmE9aFUbrVnk1osncK5CDfv8LSYhEJQ5pvZrzXZ8wnygVvq0y
         HJIJIiLK0+N3rSxc0qvs1OB+jk9kHVA6C+2JpxrCDloalfTu/FMtg6VUlgs6G4KzSwEU
         WDBg==
X-Gm-Message-State: AOUpUlEcfrFZMyacCYMCxqPmQknRz8qcWNG4I8QgxLoMG1FHAUs+Q4rY
        vxUILS/lRuHFJlyDxq2b8uE=
X-Google-Smtp-Source: AA+uWPwuLaa8KUqkiFud/NE0kxV33aWurcREyx6KYfWnRS2xw9RoZl2xF3sTWTo/YvWaNoNbeBB+mQ==
X-Received: by 2002:adf:cd82:: with SMTP id q2-v6mr4799903wrj.118.1533916711488;
        Fri, 10 Aug 2018 08:58:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b8-v6sm12658705wrw.22.2018.08.10.08.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 08:58:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
In-Reply-To: <20180810140908.GA23507@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 10 Aug 2018 10:09:08 -0400")
References: <pull.17.git.gitgitgadget@gmail.com>
        <20180809194712.GC32376@sigill.intra.peff.net>
        <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
        <20180810140908.GA23507@sigill.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 10 Aug 2018 08:58:30 -0700
Message-ID: <xmqq1sb69psp.fsf@gitster-ct.c.googlers.com>
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

Will queue.  Thanks.

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
