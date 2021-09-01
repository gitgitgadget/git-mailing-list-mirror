Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A1C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EB360FDC
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhIAUF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:05:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52696 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhIAUF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 16:05:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 942B2149D94;
        Wed,  1 Sep 2021 16:05:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=53S7nV2vXlt0
        dIH+4UNAN/EoRdJYVz88sBojZ7IQ2Zg=; b=fV1onf2iS7466fw6x7X95xyrPeLG
        3F01Hflb+RnO4t4kse/KUg4AlDRVIn4nn5iJU4LfNfid6neIuYFYX53SUYUOfWPL
        EH/B0OpdsWw4odw6B187mWFeTcflcsvF/V4K7+sGbib6OVDw/Evm7Ey+RiBm8Z5T
        G5QeTEhtkdbJHtg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C523149D93;
        Wed,  1 Sep 2021 16:05:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BFE51149D92;
        Wed,  1 Sep 2021 16:04:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: use 'TEST_SHELL_PATH' in
 'test_pause'
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
        <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
        <2f566f330e01ed4249edad54671e98301dbeec5a.1630503102.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 13:04:56 -0700
In-Reply-To: <2f566f330e01ed4249edad54671e98301dbeec5a.1630503102.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Wed, 01 Sep 2021
        13:31:40 +0000")
Message-ID: <xmqqsfyooydz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E1B2BCC4-0B5F-11EC-88A6-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> 3f824e91c8 (t/Makefile: introduce TEST_SHELL_PATH, 2017-12-08)
> made it easy to use a different shell for the tests than 'SHELL_PATH'
> used at compile time. But 'test_pause' still invokes 'SHELL_PATH'.
>
> If TEST_SHELL_PATH is set, invoke that shell in 'test_pause' for
> consistency.
>
> Suggested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index e28411bb75a..1884177e293 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -139,7 +139,7 @@ test_tick () {
>  # Be sure to remove all invocations of this command before submitting.
> =20
>  test_pause () {
> -	"$SHELL_PATH" <&6 >&5 2>&7
> +	"$TEST_SHELL_PATH" <&6 >&5 2>&7
>  }
> =20
>  # Wrap git with a debugger. Adding this to a command can make it easie=
r

Sensible.
