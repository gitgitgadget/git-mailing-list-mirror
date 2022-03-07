Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFF3C4332F
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiCGLa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiCGLaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:30:09 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607F5C872
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:14:15 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qt6so31072455ejb.11
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hKMq3DagDl11rK5QgnY0lI7AJA2Uzsi29tZsM+Ws1CA=;
        b=NK7xXWuCZJyRcVQjGLwALibVNIDHolnhffspwsI1+aqmVjxJDjn7QfYDTqHj/e/1Mn
         1OGSCCbtCmW8VinyKWEt55V1A854vOVa73PIeLWlhV7iQ4X3K1hKZU0t4vhAGM0fZhzi
         YBFBJarLWXLxWY0jNYD/sHI6ipmv5gnlPNaBQ9S3a4gNdNTpc6DxE2W9QxI8XiAwNKk1
         I9amoi2M+VLmrPozO4nWtMTLWyJHg/wT8zfzgzg/oBLeAt+UIRa7PbfV74/s7nJmY20n
         lPho89ID35UD7EHc0uplPTQm4Pb0fIucWBjU1dzI2YrKPy2vq6BVLFVqIRDpD9HPjsxI
         g/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hKMq3DagDl11rK5QgnY0lI7AJA2Uzsi29tZsM+Ws1CA=;
        b=FvASCjh/atJjI7jOa3x9XJPjfoYRx050nNBl/D22gAvUBAU7kKu9+hThrj3yWeX0CP
         35QdjBHdYhuyxTJOLQhMWY6jPKb0MsBLCKtgR6LDY8pPewNoBMffWAfmmQVdldEAEBp/
         aY4oHspGr3wDPDoEzA9IKOB6xqsJgqz96YHfLEcuXkEyPJx99lqJiWDsjsnKJ0yZQ2za
         VpJVmqhfbzOdV4i0TtrJLdseQ9nQIHSTh9IAeZICqyeOhga/JXz16geHdAL2EJcwZlyx
         yr62p9kSlX7H6Oo9IbGeqYnhQ6Pt1Mo5UCQJGYZ/LMLvasNv+KctVMtb+J7jzgXHKCfb
         JWYA==
X-Gm-Message-State: AOAM531cRzAeuD4ZDl2iM3tl119DfA0lEcvJOuDAyJ+s2AMv+7gJpL7T
        IoGeOGwOWKn7wdQoDv64Vrltg4yDyUs=
X-Google-Smtp-Source: ABdhPJwBMSa2BUg2moRVrwhUePAi0xrYXOmvUWgWPz9owfoQYgjYeWZHN2CFMVNKdu6mhI4M6wT5qQ==
X-Received: by 2002:a17:906:4c83:b0:6b7:b321:5d54 with SMTP id q3-20020a1709064c8300b006b7b3215d54mr8689520eju.676.1646651653972;
        Mon, 07 Mar 2022 03:14:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lj2-20020a170906f9c200b006da6f29bc01sm4616856ejb.158.2022.03.07.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:14:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRBJc-001RFt-Rq;
        Mon, 07 Mar 2022 12:14:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 25/30] t/perf/p7519: add fsmonitor--daemon test cases
Date:   Mon, 07 Mar 2022 12:12:20 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <b0c9c9c7a4005e2aa2a587fe5bc5588bf5a32d65.1646160212.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b0c9c9c7a4005e2aa2a587fe5bc5588bf5a32d65.1646160212.git.gitgitgadget@gmail.com>
Message-ID: <220307.86v8wq10cb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
> the "Simple IPC" interface.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index aed7b1146b0..a1c552129cc 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -182,7 +182,10 @@ test_perf_w_drop_caches () {
>  }
>  
>  test_fsmonitor_suite () {
> -	if test -n "$INTEGRATION_SCRIPT"; then
> +	if test -n "$USE_FSMONITOR_DAEMON"
> +	then

...another candidate for "shell script style change" re my comment on
25/30.

> +		DESC="builtin fsmonitor--daemon"
> +	elif test -n "$INTEGRATION_SCRIPT"; then


...but it's especially odd in this case, becuse here the added code
*doesn't* follow our usual style... :)

Since this hunk-wise would conflict with the meaningful change I don't
mind if we "fix it while we're at it", but it really should use the
preferred style for new code then.

>  		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
>  	else
>  		DESC="fsmonitor=disabled"
> @@ -293,4 +296,28 @@ test_expect_success "setup without fsmonitor" '
>  test_fsmonitor_suite
>  trace_stop
>  
> +#
> +# Run a full set of perf tests using the built-in fsmonitor--daemon.
> +# It does not use the Hook API, so it has a different setup.
> +# Explicitly start the daemon here and before we start client commands
> +# so that we can later add custom tracing.
> +#
> +if test_have_prereq FSMONITOR_DAEMON
> +then
> +	USE_FSMONITOR_DAEMON=t
> +
> +	trace_start fsmonitor--daemon--server
> +	git fsmonitor--daemon start
> +
> +	trace_start fsmonitor--daemon--client
> +
> +	git config core.fsmonitor true
> +	git update-index --fsmonitor
> +
> +	test_fsmonitor_suite
> +
> +	git fsmonitor--daemon stop
> +	trace_stop
> +fi

Urm, shouldn't this be in a test_perf or test_expect_success?

>  test_done

