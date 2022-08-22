Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E5C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 20:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiHVUWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHVUWi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 16:22:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E24BD14
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 13:22:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C201A1BCDD7;
        Mon, 22 Aug 2022 16:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qRjI4TWGW0wr8jktSrrIHgEiwtSNKQDrUtFgVP
        na0lk=; b=UzB8ywtjmyy80DoBiyYo7IkGbNMJSSdsMUeprzn+PuP0pvcjpkXtpS
        2rYMJ5Wx8+PWPpkShmXYhWQys21Ubw7bg4J2MhFptJh5oHiHG2VwN8IyAf+alw/Z
        c9SOAB2r7SzTJbBo8BigK+x6ISrFtPcmhtJV2mzW0S66A/gwYPVHI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B99C01BCDD5;
        Mon, 22 Aug 2022 16:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 666A81BCDD2;
        Mon, 22 Aug 2022 16:22:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] t: detect and signal failure within loop
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
        <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 13:22:30 -0700
In-Reply-To: <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
        (Eric Sunshine via GitGitGadget's message of "Mon, 22 Aug 2022
        18:26:42 +0000")
Message-ID: <xmqqwnb0av09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 265B937C-2258-11ED-A7AC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
> index 8968f7a08d8..6049e2c1d78 100755
> --- a/t/t5329-pack-objects-cruft.sh
> +++ b/t/t5329-pack-objects-cruft.sh
> @@ -29,7 +29,7 @@ basic_cruft_pack_tests () {
>  				while read oid
>  				do
>  					path="$objdir/$(test_oid_to_path "$oid")" &&
> -					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")"
> +					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" || exit 1
>  				done |
>  				sort -k1
>  			) >expect &&

With the loop being on the upstream of a pipe, does the added "exit
1" have any effect?

Everything else in these three patches looked very sensible, but
this one I found questionable.

Thanks.
