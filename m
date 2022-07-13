Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C777C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiGMVIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiGMVIO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 17:08:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4C32EDB
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 14:08:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCE4A13CD61;
        Wed, 13 Jul 2022 17:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GRTTlTDH95U2QVFVan2GpARMF/yOHE+Odr70sO
        SDl+Q=; b=Q1Nc5pmXhH5U9JXiNEkJ5QRs4OYX/E45oYnIgWE4zZ0U0cp4i95rUZ
        h5rdcMFbt6Eoo9Ug9OAvF1BdO/fIjBp0/bPBMpcNGYdQ7qRO1mMML91LqyNnu8Hr
        dhuROM9RvOp+y2/tWvdfJLbkZJ3R/8WgGdQQrLwfo56qm7HjsVyR0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4BD313CD60;
        Wed, 13 Jul 2022 17:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47B8F13CD5F;
        Wed, 13 Jul 2022 17:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 14:08:11 -0700
In-Reply-To: <pull.1287.git.1657726969774.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 13 Jul 2022 15:42:49
        +0000")
Message-ID: <xmqq7d4gbu10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7863BF2-02EF-11ED-A18C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  	if $base_present
>  	then
> ...
> +	base_present=1

I think s/1/true/ or something is in order, perhaps?

> +	LOCAL='lo cal'
> +	BASE='ba se'
> +	REMOTE="' '"
> +	MERGED='mer ged'
> +	merge_tool_path=record_parameters
> +
> +	merge_cmd vimdiff || at_least_one_ko=true
> +
> +	cat >expect <<-\EOF
> +	-f
> +	-c
> +	echo | split | vertical split | 1b | wincmd l | vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
> +	-c
> +	tabfirst
> +	lo cal
> +	' '
> +	mer ged
> +	EOF
> +
> +	diff -u expect actual || at_least_one_ko=true
> +
>  	if test "$at_least_one_ko" = "true"
>  	then
>  		return 255
>
> base-commit: 980145f7470e20826ca22d7343494712eda9c81d
