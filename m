Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91444C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 13:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiF3NXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiF3NXe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 09:23:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDB030F67
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:23:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fi2so38938705ejb.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=V7dRmGfbKzJBpdc51rFOphDy/hUraxQYheHvHsX6ku0=;
        b=qPD6agW14eaEtXVf1p4aerkip03NGF1LuOG5ql6gynxv+viCBTdG28KlsboG/yskcv
         As8EB2a0jjzfoiwDGlcDFj0hBWXRBoAFX2mafl8DEynKzrQUMWkwBgYcq7aOKWn2I0Qc
         etkfwaNtXz9PFqClWVjUmvT3rjhAycbvTlCRGrZVYRzRVrQGO/jrBCaT0d+odNr/YphF
         JHpRuJrgHWnI6gdo5PtnXZiYx7Z6BY4rqIdcCxtJn7JpAXPCMVOrMI1Sv1z44LPRDvsS
         WYr7QhIlSEGEDnFJWZbwYxoq3pgFMZh0WhOHeSXrX1dBq4bvWg5Kpz/mX9qhGYw4wmoH
         V2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=V7dRmGfbKzJBpdc51rFOphDy/hUraxQYheHvHsX6ku0=;
        b=OJuHmPI6gz1nkZZ7vxLypPeoUQs1OVPUySsrSoJWSZwcGJ8+sI5dm4vnn/vCYHQhSV
         rUPRgPzXLWZtsw9XWWdAECd/QBvBiF3we+olT/RBjrPvGJBa3XQD3rLNE3Impk9oqpkg
         VQ46AptlKHhdk4mg9OrIY6Su0eDQsLC/LtjT9C5G41NOPN2ffQRFNPv1n1GKCA+LnolQ
         xzJj6xYm1R3BvQKYup9xi1tMBoyybF8S5gRxp6UbKUI54oTw756T7kk7hI09/UasS53f
         C8s8gPY2HXWoedWEIM+j944Xc3GH/AmEJt14SUpuae2yixW2aq4lTOEn5H8kp17xam+0
         VCCg==
X-Gm-Message-State: AJIora9M8rNHpBitqAXdUo3EKXQfLusZntHTaATViyfBfs5vykmlN3Ni
        +sSxFs7vUEMsP3JcpgTJAAc=
X-Google-Smtp-Source: AGRyM1vYU9MLAmESChMTy+P6v0VS8q4YHC69h8A3EakMLW6jMZaYfJ7OjpZ9zdf29OgEsM/661w2pg==
X-Received: by 2002:a17:907:8a05:b0:726:e8f2:d539 with SMTP id sc5-20020a1709078a0500b00726e8f2d539mr8884471ejc.429.1656595411571;
        Thu, 30 Jun 2022 06:23:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b00722e1635531sm9100883ejb.193.2022.06.30.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:23:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6u8n-002Kk1-R1;
        Thu, 30 Jun 2022 15:23:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v5 5/5] setup.c: create `discovery.bare`
Date:   Thu, 30 Jun 2022 15:20:01 +0200
References: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
 <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <14411512783fd4e2cdcc8513690377b29262f6b8.1656354994.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <14411512783fd4e2cdcc8513690377b29262f6b8.1656354994.git.gitgitgadget@gmail.com>
Message-ID: <220630.864k02e14e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>

> diff --git a/t/t0035-discovery-bare.sh b/t/t0035-discovery-bare.sh
> new file mode 100755
> index 00000000000..0b345d361e6
> --- /dev/null
> +++ b/t/t0035-discovery-bare.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +
> +test_description='verify discovery.bare checks'
> +

You're missing a:

	TEST_PASSES_SANITIZE_LEAK=true

Above this line:

> +. ./test-lib.sh

Which tells us that this new test doesn't leak (yay!)

> +expect_accepted () {
> +	git "$@" rev-parse --git-dir
> +}

I think we can do away with this helper, we use the argument support
once, and for the rest we can inline the trivial command...

> +
> +expect_rejected () {
> +	test_must_fail git "$@" rev-parse --git-dir 2>err &&
> +	grep "discovery.bare" err

grep -F ?

This helper is less trivial, but more obvious would be a "run command
and assirt xyz about the output" helper, see
e.g. test_stdout_line_count.


> +test_expect_success 'discovery.bare unset' '
> +	(
> +		cd outer-repo/bare-repo &&
> +		expect_accepted
> +	)

Also: Odd to use a sub-shell when the helper takes -C...

> +'
> +
> +test_expect_success 'discovery.bare=always' '
> +	git config --global discovery.bare always &&
> +	(
> +		cd outer-repo/bare-repo &&
> +		expect_accepted
> +	)
> +'
> +
> +test_expect_success 'discovery.bare=never' '
> +	git config --global discovery.bare never &&
> +	(
> +		cd outer-repo/bare-repo &&
> +		expect_rejected
> +	)

...ditto...


> +'
> +
> +test_expect_success 'discovery.bare in the repository' '
> +	(
> +		cd outer-repo/bare-repo &&
> +		# Temporarily set discovery.bare=always, otherwise git
> +		# config fails with "fatal: not in a git directory"
> +		# (like safe.directory)
> +		git config --global discovery.bare always &&
> +		git config discovery.bare always &&
> +		git config --global discovery.bare never &&
> +		expect_rejected
> +	)

Drop the sub-shell and use test_config?

> +'
> +
> +test_expect_success 'discovery.bare on the command line' '
> +	git config --global discovery.bare never &&
> +	(
> +		cd outer-repo/bare-repo &&
> +		expect_accepted -c discovery.bare=always &&
> +		expect_rejected -c discovery.bare=
> +	)
> +'
> +
> +test_done

