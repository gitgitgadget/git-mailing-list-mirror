Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97CC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiCaPYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiCaPY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 11:24:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8C220FF9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:22:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b15so28591270edn.4
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NOJTJiUYwyxC+y9dcxRXzXXfH/MPyw+odGZ6VCiV0L4=;
        b=fwZbSpnlg7GatRSiKKNyKNgmSbd7e7Mp6Nfm8Ju12ItSg2EqNFO+DX0kEzIQPbrg2U
         Om4+zFlzIx2wHJFU1SFLrekIIGpC9Tq95rRlj9+AGwtkJX+biVi/1KAJbjoz0l2PVB8P
         t/gxMxcHQ5a1FweG4/v89jAQrSWRInPCJGL+BFOe51CH+csTF0Pj5B8iCy6QiFs2wEwZ
         8FuGN1KlW8Cg6c9Q9r5VZaK9criRaFDHqz+RMnQY/9HMClEPNyeyLZzrBmZNujNm+ZZF
         JpVjZks3+Y+iaci2JUDtsXxg3ZrERrVylaUbXWeFMoMrNwq/q9+i8jafNuVIa3wClUl5
         +wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NOJTJiUYwyxC+y9dcxRXzXXfH/MPyw+odGZ6VCiV0L4=;
        b=T9Q1aFgvtDzzVuMIikb76yM4xX4A8MjUTs/yqWYfLOVpTjZMVO7nlI5PdPpzYkO45D
         EWqdm6qIxz2LnHGV+mrPPsXu9rj1IDE6/5YMO3p0sBip0I60X1BM8Cz9yORfXuZAJIQn
         WxjQxBDxCnT25VqyyR3F7PlxElvRaRfmrZ/ti54XoN8f4Un//MlmAp3s8MSXBAUHFWCU
         tPGjlWiJnis3XoggDrKDyn3L+CGvCKMjG4Jw2kjBo8ZfyHLUBRfcWpKnrJkanRU8clo7
         eJkw2xe+uTJF6S2r2LSeaD0v/GkGNn6/s68L6zY0KVCyG7QTLSYTXJBLI2bXsYZEgXn6
         DveQ==
X-Gm-Message-State: AOAM532GfDd8ndIyvm0+IO+M0RnK1w9D9wW5xggimD+5uP9CBZzzmnKG
        QrYHuzMaNgxW9v9lbT+Ync4fRr2FVcOVdw==
X-Google-Smtp-Source: ABdhPJzM+CKiHrVpwD6rIZDwmpMXqUzxYf9k7mhSuXgbtOXF5I/hTpb/XBNxEzlI+M1vA8PBXaEVYg==
X-Received: by 2002:a05:6402:3489:b0:419:88f0:4bcd with SMTP id v9-20020a056402348900b0041988f04bcdmr16969210edc.401.1648740160341;
        Thu, 31 Mar 2022 08:22:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm11528525edb.47.2022.03.31.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:22:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZwdD-000VsK-Aj;
        Thu, 31 Mar 2022 17:22:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v4 5/7] t5615-partial-clone: add test for fetch --refetch
Date:   Thu, 31 Mar 2022 17:20:45 +0200
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
 <6c17167ac1edbeea5f6d375a989aa49f5748d099.1648476132.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6c17167ac1edbeea5f6d375a989aa49f5748d099.1648476132.git.gitgitgadget@gmail.com>
Message-ID: <220331.86fsmyp2o0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Robert Coup via GitGitGadget wrote:

> From: Robert Coup <robert@coup.net.nz>
>
> Add a test for doing a refetch to apply a changed partial clone filter
> under protocol v0 and v2.
>
> Signed-off-by: Robert Coup <robert@coup.net.nz>
> ---
>  t/t5616-partial-clone.sh | 52 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 34469b6ac10..87ebf4b0b1c 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -166,6 +166,56 @@ test_expect_success 'manual prefetch of missing objects' '
>  	test_line_count = 0 observed.oids
>  '
>  
> +# create new commits in "src" repo to establish a history on file.4.txt
> +# and push to "srv.bare".
> +test_expect_success 'push new commits to server for file.4.txt' '
> +	for x in a b c d e f
> +	do
> +		echo "Mod file.4.txt $x" >src/file.4.txt &&
> +		if list_contains "a,b" "$x"; then
> +			printf "%10000s" X >>src/file.4.txt
> +		fi &&
> +		if list_contains "c,d" "$x"; then
> +			printf "%20000s" X >>src/file.4.txt
> +		fi &&
> +		git -C src add file.4.txt &&
> +		git -C src commit -m "mod $x" || return 1
> +	done &&
> +	git -C src push -u srv main
> +'
> +
> +# Do partial fetch to fetch smaller files; then verify that without --refetch
> +# applying a new filter does not refetch missing large objects. Then use
> +# --refetch to apply the new filter on existing commits. Test it under both
> +# protocol v2 & v0.
> +test_expect_success 'apply a different filter using --refetch' '
> +	git -C pc1 fetch --filter=blob:limit=999 origin &&
> +	git -C pc1 rev-list --quiet --objects --missing=print \
> +		main..origin/main >observed &&
> +	test_line_count = 4 observed &&
> +
> +	git -C pc1 fetch --filter=blob:limit=19999 --refetch origin &&

Is 19999 just "arbitrary big number" here?

> +	git -C pc1 rev-list --quiet --objects --missing=print \
> +		main..origin/main >observed &&
> +	test_line_count = 2 observed &&
> +
> +	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
> +		--refetch origin &&
> +	git -C pc1 rev-list --quiet --objects --missing=print \
> +		main..origin/main >observed &&
> +	test_line_count = 0 observed

Does this test_line_count *really* want to be = 0, or does this mean
test_must_be_empty?

I.e. are we expecting content here, just not ending in a \n, or nothing
at all?

> +'
> +
> +test_expect_success 'fetch --refetch works with a shallow clone' '
> +	git clone --no-checkout --depth=1 --filter=blob:none "file://$(pwd)/srv.bare" pc1s &&
> +	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
> +	test_line_count = 6 observed &&
> +
> +	GIT_TRACE=1 git -C pc1s fetch --filter=blob:limit=999 --refetch origin &&

Why the GIT_TRACE=1? Seems to not be used.
