Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2AFC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiCJAeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiCJAeG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:34:06 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91232075
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:33:06 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F20010EA6A;
        Wed,  9 Mar 2022 19:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JUFgVEOd1MTLksOi3w5i38bmtkekKaAKnArAop
        oZt+M=; b=flTWUF/jIVj95aejla6OqzsRfbXEGvEJ28szWICyb6y2Erbs9vRuEY
        Yz4fMsGGEcZLvujaaliLRhiLb6ilKnkfuRe+bMMmLYmv0Cz/ZTILcdgo6hN5pLN1
        2JqYx9gyAJ85Lp+g6mOdv6akUdcDAGGGXAMVeAOtj/duDokfwu7zU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B01C10EA69;
        Wed,  9 Mar 2022 19:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA52610EA68;
        Wed,  9 Mar 2022 19:33:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] name-rev: use generation numbers if available
References: <20220310000550.2368737-1-jacob.e.keller@intel.com>
Date:   Wed, 09 Mar 2022 16:33:02 -0800
In-Reply-To: <20220310000550.2368737-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Wed, 9 Mar 2022 16:05:50 -0800")
Message-ID: <xmqqilsmir41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5C4B516-A009-11EC-8CA4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> +# A-B-C-D-E-main
> +#
> +# Where C has a non-monotonically increasing commit timestamp w.r.t. other
> +# commits
> +test_expect_success 'non-monotonic commit dates setup' '
> +	UNIX_EPOCH_ZERO="@0 +0000" &&
> +	git init non-monotonic &&
> +	test_commit -C non-monotonic A &&
> +	test_commit -C non-monotonic --no-tag B &&
> +	test_commit -C non-monotonic --no-tag --date "$UNIX_EPOCH_ZERO" C &&
> +	test_commit -C non-monotonic D &&
> +	test_commit -C non-monotonic E
> +'
> +
> +test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
> +	test_config -C non-monotonic core.commitGraph false &&

Don't you mean "true" here?

> +	(
> +		cd non-monotonic &&
> +
> +		echo "main~3 tags/D~2" >expect &&
> +		git name-rev --tags main~3 >actual &&
> +
> +		test_cmp expect actual
> +	)
> +'

Other than that there wasn't anything unexpected in this iteration.

Thanks.

