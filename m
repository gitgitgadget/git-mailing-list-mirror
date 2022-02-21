Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9059FC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 01:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbiBUBtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 20:49:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbiBUBtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 20:49:02 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDEE517D2
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 17:48:40 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C02BA105F99;
        Sun, 20 Feb 2022 20:48:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Se9udwFhR2vNE2giAwVeZ51MakFmxEpWkQVGQ8
        nWBv8=; b=Ah1ygfbCnGGCb95PCZIQ3hI19X3FHvYjbGno/NL5L+r2dcpQRxVoBY
        38HKV51sf2jJ/7qV7mvc4PBblYbsWvviRkRtF+B5d0S+czmtSnBHXPfKwErD349h
        p6goz77lKrc/CSxnplIRow1kaYnPwF+I9KuSnOOy44BlglafjPfdo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8950105F98;
        Sun, 20 Feb 2022 20:48:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 313BD105F96;
        Sun, 20 Feb 2022 20:48:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
References: <20220218223212.1139366-1-jonathantanmy@google.com>
Date:   Sun, 20 Feb 2022 17:48:38 -0800
In-Reply-To: <20220218223212.1139366-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 18 Feb 2022 14:32:11 -0800")
Message-ID: <xmqq35kdugzt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 641277EC-92B8-11EC-A9A2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +test_expect_success '--stage' '
> +	# In order to test hash abbreviation, write two objects that have the
> +	# same first 4 hexadecimal characters in their (SHA-1) hashes.

What about linux-sha256 jobs?
e.g. https://github.com/git/git/runs/5267681569?check_suite_focus=true

> +	echo brocdnra >submodule/c &&
> +	git -C submodule commit -am "update c" &&
> +	echo brigddsv >submodule/c &&
> +	git -C submodule commit -am "update c again" &&
> +
> +	cat >expect <<-\EOF &&
> +	100644 6da7 0	.gitmodules
> +	100644 7898 0	a
> +	100644 6178 0	b/b
> +	100644 dead9 0	submodule/c
> +	EOF
> +
> +	git ls-files --stage --recurse-submodules --abbrev=4 >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'ls-files correctly outputs files in submodule with -z' '
>  	lf_to_nul >expect <<-\EOF &&
>  	.gitmodules
> @@ -292,7 +311,6 @@ test_incompatible_with_recurse_submodules () {
>  test_incompatible_with_recurse_submodules --deleted
>  test_incompatible_with_recurse_submodules --modified
>  test_incompatible_with_recurse_submodules --others
> -test_incompatible_with_recurse_submodules --stage
>  test_incompatible_with_recurse_submodules --killed
>  test_incompatible_with_recurse_submodules --unmerged
