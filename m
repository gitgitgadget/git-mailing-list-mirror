Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D0C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 21:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJJVnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJVnN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 17:43:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B57D7B9
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 14:43:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 925FE15E95C;
        Mon, 10 Oct 2022 17:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bKKbMYwI2/6KEivV2N3z2f6XXt4MO+SSsvtsyI
        F4UsA=; b=iKsDRRIW5/Pa7MOrvJEEDYqqkkrPhMVwYZUiSKW4i+G2Ry4O8LHzvU
        FQsF+UmbvGvCEalriynfPDknEldO1B//Kp7C/m8dk2tS767GSHqrRBdHOsCEsSES
        Di6yk0iXpkpoIf+s451mT4zWhLL+nb+EBdLYA7ItFLsXyHQlM896E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A0F515E95B;
        Mon, 10 Oct 2022 17:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E71AA15E95A;
        Mon, 10 Oct 2022 17:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH 2/2] ci(main): linux32 uses actions/checkout@v2
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
        <4ee163b9a2c4c657e649159ae6c83b13613028f3.1665388136.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 14:43:06 -0700
In-Reply-To: <4ee163b9a2c4c657e649159ae6c83b13613028f3.1665388136.git.gitgitgadget@gmail.com>
        (Oscar Dominguez via GitGitGadget's message of "Mon, 10 Oct 2022
        07:48:56 +0000")
Message-ID: <xmqq7d171hjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87652DB0-48E4-11ED-8B0B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Oscar Dominguez <dominguez.celada@gmail.com>
>
> to prevent issue tracked in https://github.com/actions/checkout/issues/560
>
> Signed-off-by: Oscar Dominguez <dominguez.celada@gmail.com>
> ---
>  .github/workflows/main.yml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 8dc9d938159..4eb5042f0d6 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -281,17 +281,20 @@ jobs:
> ...
>      steps:
> -    - uses: actions/checkout@v3
> +    - uses: actions/checkout@${{matrix.vector.checkout_version}}
>      - run: ci/install-docker-dependencies.sh
>      - run: ci/run-build-and-tests.sh
>      - name: print test failures

I think the breakage we see in

    https://github.com/git/git/actions/runs/3222517697

is due to this change.
