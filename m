Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C925FC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA73C60FDA
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhF1IBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1IBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 04:01:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446FC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:59:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bu12so28511613ejb.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eqsOb8UbI5yO7thJMEOswFRuMLHaQg8dVET21+Ib9m0=;
        b=HmQBMUCVngsRw/8gMorXeylPBSuiMeorY0IbHjHBEnPwoSpBCp5WtVYuyq/QkA4YRk
         YIW1GH7bLSC6CYDjesZJ3UqpIMdhkzkBK3l+b90sT+F+htzNhqx7KUTwRNusS98Re07T
         EB3LXpr9AtzFyTXnHEj8lIimPtmuc0nbc3TuPV6IUCJO1rDgq+uiR6Npg9OYBQ5nhGbm
         mrAKVMaCOQLySxGmC/trGhftdKmWbd4PZfyKmoAEez+MsaZy4pPuMgOPQwL/7ihRHmZ8
         4LaQvqBCYXX+kRUCXQ2dfyiZPoMoMa2PN8YEZKKvALQ2W8m5FAaosACdzlrfwLUPxtrr
         n1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eqsOb8UbI5yO7thJMEOswFRuMLHaQg8dVET21+Ib9m0=;
        b=fbt/jqRtr9j75+fCcbM2fS9pzJsfkBgPgnuHsevIjye17ES7w0v1Q5Ua6DJ4r+fSpD
         0+TBum+/I+x5Yg/QSxauelCLV6r8bnI/fm58BH8IDnNRYlOboF2VEetSskdOZx8UUQqd
         88Q1FT+n2vUbGsJmdfalCKKcswiMv5FV5L3WJSKzRcEhNVnznGPI5F7QblRC9NfYj90f
         uor5NaPgcWoOBPcZd4KR54yMs8ucTBt322hTVF7EV4eOzKFmfyAQhhFwMbsjdbFwMdzk
         t6MWmlzuBDABlsSWpp2+O3xCVZt0Bw/NcLY9i9NJhKdkwe7t+AiXdJHt5btULtaObRWI
         jgWA==
X-Gm-Message-State: AOAM530cVug6BO5qgKiHnoQLAIRhvxAN2qwUcSSYmnTcrZwRFxwofArF
        FGaBDeqCmYQeB6IiKe3Psk7jO5OApis=
X-Google-Smtp-Source: ABdhPJylif4lfkkRfQ/OgdC9t8yxMZeFhxkJW6ltc2/D83g9T1K5xlI1m6iuNC+wU6mEAZjUy6U1KA==
X-Received: by 2002:a17:906:cedd:: with SMTP id si29mr13510875ejb.81.1624867155610;
        Mon, 28 Jun 2021 00:59:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r17sm9039092edt.33.2021.06.28.00.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:59:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] p5400: add perf tests for git-receive-pack(1)
Date:   Mon, 28 Jun 2021 09:49:54 +0200
References: <cover.1624858240.git.ps@pks.im>
 <2f6c4e3d102e71104d7d00c78631b149b880609a.1624858240.git.ps@pks.im>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <2f6c4e3d102e71104d7d00c78631b149b880609a.1624858240.git.ps@pks.im>
Message-ID: <871r8mxvvx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> We'll the connectivity check logic for git-receive-pack(1) in the
> following commits to make it perform better. As a preparatory step, add
> some benchmarks such that we can measure these changes.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/perf/p5400-receive-pack.sh | 97 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100755 t/perf/p5400-receive-pack.sh
>
> diff --git a/t/perf/p5400-receive-pack.sh b/t/perf/p5400-receive-pack.sh
> new file mode 100755
> index 0000000000..a945e014a3
> --- /dev/null
> +++ b/t/perf/p5400-receive-pack.sh
> @@ -0,0 +1,97 @@
> +#!/bin/sh
> +
> +test_description="Tests performance of receive-pack"
> +
> +. ./perf-lib.sh
> +
> +test_perf_large_repo

From the runtime I think this just needs test_perf_default_repo, no?
I.e. we should only have *_large_* for cases where git.git is too small
to produce meaningful results.

Part of th problem is that git.git has become larger over time...

> +test_expect_success 'setup' '
> +	# Create a main branch such that we do not have to rely on any specific
> +	# branch to exist in the perf repository.
> +	git switch --force-create main &&
> +
> +	# Set up a pre-receive hook such that no refs will ever be changed.
> +	# This easily allows multiple perf runs, but still exercises
> +	# server-side reference negotiation and checking for consistency.
> +	mkdir hooks &&
> +	write_script hooks/pre-receive <<-EOF &&
> +		#!/bin/sh

You don't need the #!/bin/sh here, and it won't be used. write_script()
adds it (or the wanted shell path).

> +		echo "failed in pre-receive hook"
> +		exit 1
> +	EOF
> +	cat >config <<-EOF &&
> +		[core]
> +			hooksPath=$(pwd)/hooks
> +	EOF

Easier understood IMO as:

    git config -f config core.hooksPath ...

> +	GIT_CONFIG_GLOBAL="$(pwd)/config" &&
> +	export GIT_CONFIG_GLOBAL &&
> +
> +	git switch --create updated &&
> +	test_commit --no-tag updated
> +'
> +
> +setup_empty() {
> +	git init --bare "$2"
> +}

I searched ahead for setup_empty, looked unused, but...

> +setup_clone() {
> +	git clone --bare --no-local --branch main "$1" "$2"
> +}
> +
> +setup_clone_bitmap() {
> +	git clone --bare --no-local --branch main "$1" "$2" &&
> +	git -C "$2" repack -Adb
> +}
> +
> +# Create a reference for each commit in the target repository with extra-refs.
> +# While this may be an atypical setup, biggish repositories easily end up with
> +# hundreds of thousands of refs, and this is a good enough approximation.
> +setup_extrarefs() {
> +	git clone --bare --no-local --branch main "$1" "$2" &&
> +	git -C "$2" log --all --format="tformat:create refs/commit/%h %H" |
> +		git -C "$2" update-ref --stdin
> +}
> +
> +# Create a reference for each commit in the target repository with extra-refs.
> +# While this may be an atypical setup, biggish repositories easily end up with
> +# hundreds of thousands of refs, and this is a good enough approximation.
> +setup_extrarefs_bitmap() {
> +	git clone --bare --no-local --branch main "$1" "$2" &&
> +	git -C "$2" log --all --format="tformat:create refs/commit/%h %H" |
> +		git -C "$2" update-ref --stdin &&
> +	git -C "$2" repack -Adb
> +}
> +
> +for repo in empty clone clone_bitmap extrarefs extrarefs_bitmap
> +do
> +	test_expect_success "$repo setup" '

> +		rm -rf target.git &&
> +		setup_$repo "$(pwd)" target.git

...here we use it via interpolation.

I'd find this whole pattern much easier to understand if the setups were
just a bunch of test_expect_success that created a repo_empty.git,
repo_extrarefs.git etc. Then this loop would be:

    for repo in repo*.git ...

I'd think that would also give you more meaningful perf data, as now the
OS will churn between the clone & the subsequent push tests, better to
do all the setup, then all the different perf tests.

Perhaps there's also a way to re-use this setup across different runs, I
don't know/can't remember if t/perf has a less transient thing than the
normal trash directory to use for that.
