Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E9C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381277AbhLCOC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352843AbhLCOCx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 09:02:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C8C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:59:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r25so11823696edq.7
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rv7tKCtCt02/G+4C5GB8fkK3HgmFDgJbgCx7jr6mVBc=;
        b=RK5YaHyRtKeW2IhsAvLIuambZk1c0luRnFsHgkzgPzpPL/R92poMoWIw+z4zKgMjxj
         NJ2itjbx509weRI/RZC4Dm+dmb9tjmFQtbXMd3mHf6Vs2Qm3K+RGBlO9W8xQWN5ln8Go
         9bQQFzPRqCVbo3bYtPPCIVC64EeNDRe0VrdJHj2HHZnMzTEf3h5uxGPVaKECoblsBuga
         /jVUv2CQMguL1DAxvXU3iSGjK1Onfsw2fmDKRYY4nPBVV8rPdpUkz7ElPUZti6qgEpEK
         lvjItn8tArg318bpJcljAogPn8aJImEG+P/q8xc5zk7wzgkCLp9GIPxvVFJNn0p5s0Aa
         z+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rv7tKCtCt02/G+4C5GB8fkK3HgmFDgJbgCx7jr6mVBc=;
        b=26E//APKaMzt400ICgKTuao1EwewW6sGHmU9z15WruL2vL7iZ9Cn2M00/2p7ifnUZh
         Ki7L/4Rgc3ILaH8GF4trrq0/QdjAVd4QVqsVJX6qB0Fgz44lqHis0G+gIWPo1VdWGg5i
         pvRY3YCKSJfa51idp87p6lAg6FY6Q/p2bO0/7zEv3bddCZykaFr2Q4B+FuK/SchjXJio
         h4BBUxRujxiH4Ct169fC+lvnU31wW39jlUUnlcu0282vNoU/A0xWtzxWM6F9eyTT6JxU
         /GferizaczYGF6QPRbpwT4FB0UxONLIW9vgpberncyrk0mnqjr2BjWUnjfyb9kaW7Nf9
         FMhA==
X-Gm-Message-State: AOAM531UFPUq2AVvRUxZJIeoUY6LuDycPac8WGjPXac0pAQGeGr9JzSP
        bRDS6Y0BgEsacTNIaisYlB0=
X-Google-Smtp-Source: ABdhPJzGNKOfSaRCEuCnbRylTHL672ksocSeDkpW89Qg+QI0Rt+Qe4GSwgg+m6OLKzKiHc5c7WO//g==
X-Received: by 2002:a17:907:3e9a:: with SMTP id hs26mr23782492ejc.433.1638539965126;
        Fri, 03 Dec 2021 05:59:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ce2sm1999190edb.41.2021.12.03.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:59:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt95w-0009WS-5w;
        Fri, 03 Dec 2021 14:59:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v4 5/5] unpack-objects: unpack_non_delta_entry() read
 data in a stream
Date:   Fri, 03 Dec 2021 14:54:40 +0100
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-6-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203093530.93589-6-chiyutianyi@gmail.com>
Message-ID: <211203.86ilw5ssar.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Han Xin wrote:

> diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
> new file mode 100755
> index 0000000000..01d950d119
> --- /dev/null
> +++ b/t/t5590-unpack-non-delta-objects.sh
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2021 Han Xin
> +#
> +
> +test_description='Test unpack-objects when receive pack'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success "create commit with big blobs (1.5 MB)" '
> +	test-tool genrandom foo 1500000 >big-blob &&
> +	test_commit --append foo big-blob &&
> +	test-tool genrandom bar 1500000 >big-blob &&
> +	test_commit --append bar big-blob &&
> +	(
> +		cd .git &&
> +		find objects/?? -type f | sort

...are thse...

> +	) >expect &&
> +	PACK=$(echo main | git pack-objects --progress --revs test)

Is --progress needed?

> +'
> +
> +test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
> +	GIT_ALLOC_LIMIT=1m &&
> +	export GIT_ALLOC_LIMIT
> +'
> +
> +test_expect_success 'prepare dest repository' '
> +	git init --bare dest.git &&
> +	git -C dest.git config core.bigFileThreshold 2m &&
> +	git -C dest.git config receive.unpacklimit 100

I think it would be better to just (could roll this into a function):

	test_when_finished "rm -rf dest.git" &&
	git init dest.git &&
	git -C dest.git config ...

Then you can use it with e.g. --run=3-4 and not have it error out
because of skipped setup.

A lot of our tests fail like that, but in this case fixing it seems
trivial.



> +'
> +
> +test_expect_success 'fail to unpack-objects: cannot allocate' '
> +	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
> +	test_i18ngrep "fatal: attempting to allocate" err &&

nit: just "grep", not "test_i18ngrep"

> +	(
> +		cd dest.git &&
> +		find objects/?? -type f | sort

..."find" needed over just globbing?:

    obj=$(echo objects/*/*)

?
