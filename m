Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CCC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiCVSph (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbiCVSpf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:45:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD93192D
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:44:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so38188131ejd.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cjB/Vq0ZyDF3HNNsmbloipZ7ciYhlSUp3HBPAMQEWf4=;
        b=SAtX6FMMScVxFQeDqXVzm1z6dCmSIAQGG0bhoHz1mx4DkQ9qVgeJY4MCRDUn1rg1v7
         FJHxfEcLBU2LkbUiU03q1wQMSUQwxhuTTz+p7oGKQR/0A7qxP8wHzIRZWSns5z51ipXV
         vmeQkKc73CQ9n023xYAXywCNA1/SfwNzFe50djG+zKJ/nhxIslOMBkd/M6KvrCJQQfMp
         VSIcXiTHvezUteS95nyYUoYezesAtUTUu8G5LGCNbCMNrySMNLPnNKPLGGYjVV6AKKeY
         oxltJk6KGJYqKl6hJaunn/Y7sGFLsg+cyONojBJDAhR/Lrnk6XETWUJCKAEzmTT7V6VA
         9PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cjB/Vq0ZyDF3HNNsmbloipZ7ciYhlSUp3HBPAMQEWf4=;
        b=SiJMBPN3Ry3OTgeaEREFzhNf4f/tv68DHZoVv70CgCzHpvPFrYTRnewWL1gYZxMoS8
         dr3kLMTLUgPhRT0i2zeTBH2pjUDF1HtHRoqy0gQPBGkvbujZ/Z0pVyFZHMtLWzZMbgo7
         mWeK1gzGzswvqhdza8LiRl53Emu+kbJC9VWfxMToFIwYak8V2dBdOcSVbbIju7aLSDn7
         l8f+Sq3xLKAPkpsN3b0Yz9oNosPg7FtIEdPrNhF3pRWmSSin6xWubsd8Z+Eqr4igcxlJ
         DOdgMwsQqG8a6nkHfbwZJ+VCljM7Jb31HDrkjL0Hp7jZirVdaGrm+nxWqTBq8DumtStG
         vtIg==
X-Gm-Message-State: AOAM531dUAQ0UO144yC6rdux2qoRHIv6IVhY8tdlvkTvFSAY/zUlOP1g
        4IiINyUxdb7XsF/kbKRgQADEePJaePrPlA==
X-Google-Smtp-Source: ABdhPJxWhg+xphuqvfUszeqvlDZTTVqRUyIzwBLuZaDYFgTWqoFi2ZI9qVk4cf1nVg3MsoT+qJ8yPw==
X-Received: by 2002:a17:907:9910:b0:6d5:acd6:8d02 with SMTP id ka16-20020a170907991000b006d5acd68d02mr28051333ejc.173.1647974646138;
        Tue, 22 Mar 2022 11:44:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n19-20020a1709067b5300b006ce36e2f6fdsm8790795ejo.159.2022.03.22.11.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:44:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWjUD-000CUu-0c;
        Tue, 22 Mar 2022 19:44:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 24/29] t/perf/p7519: speed up test on Windows
Date:   Tue, 22 Mar 2022 19:43:04 +0100
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <803a540cc0022e893a75eae8815b3275a7fac3af.1647972011.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <803a540cc0022e893a75eae8815b3275a7fac3af.1647972011.git.gitgitgadget@gmail.com>
Message-ID: <220322.865yo5q13f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Change p7519 to use `test_seq` and `xargs` rather than a `for` loop
> to touch thousands of files.  This takes minutes off of test runs
> on Windows because of process creation overhead.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index c8be58f3c76..0611e533951 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -72,7 +72,7 @@ then
>  	fi
>  fi
>  
> -trace_start() {
> +trace_start () {
>  	if test -n "$GIT_PERF_7519_TRACE"
>  	then
>  		name="$1"
> @@ -91,13 +91,20 @@ trace_start() {
>  	fi
>  }
>  
> -trace_stop() {
> +trace_stop () {
>  	if test -n "$GIT_PERF_7519_TRACE"
>  	then
>  		unset GIT_TRACE2_PERF
>  	fi
>  }

(I think I noted in a previous version): Would be nice to have an
optimization change not do unrelated refactoring....

> +touch_files () {
> +	n=$1
> +	d="$n"_files
> +
> +	(cd $d ; test_seq 1 $n | xargs touch )


...and here we don't &&-chain.

> +}
> +
>  test_expect_success "one time repo setup" '
>  	# set untrackedCache depending on the environment
>  	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
> @@ -119,10 +126,11 @@ test_expect_success "one time repo setup" '
>  	fi &&
>  
>  	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
> -	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
> -	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
> -	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
> -	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
> +	: 1_file directory should be left empty &&
> +	touch_files 10 &&
> +	touch_files 100 &&
> +	touch_files 1000 &&
> +	touch_files 10000 &&
>  	git add 1_file 10_files 100_files 1000_files 10000_files &&
>  	git commit -qm "Add files" &&
>  
> @@ -133,7 +141,7 @@ test_expect_success "one time repo setup" '
>  	fi
>  '
>  
> -setup_for_fsmonitor() {
> +setup_for_fsmonitor () {
>  	# set INTEGRATION_SCRIPT depending on the environment
>  	if test -n "$INTEGRATION_PATH"
>  	then
> @@ -173,7 +181,7 @@ test_perf_w_drop_caches () {
>  	test_perf "$@"
>  }
>  
> -test_fsmonitor_suite() {
> +test_fsmonitor_suite () {

ditto refactoring..
