Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1568C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiCAChU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCAChS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:37:18 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA85926ADC
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:36:38 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 861841969A4;
        Mon, 28 Feb 2022 21:36:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j4BBXQXVdn4XAGufbKy7f01WLajI/EkvLGYINc
        g2q94=; b=g9mJXeS54TYCH2H5N0zTzQZ472ZNuevj6YxyMHuCTTfCH+huOnickV
        yzOptYCYYR0+Y0hojecW4He3IlPiUP8fmQUahe9BL8dG6cU8HQMmzNupK0mOIN3b
        mTLlhd2DOMY5WuBZkXY2rQSB3vlv5BvE9HNktOs2WAdzAjBay9dac=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E4E71969A3;
        Mon, 28 Feb 2022 21:36:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 018171969A0;
        Mon, 28 Feb 2022 21:36:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] name-rev: use generation numbers if available
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
        <20220228215025.325904-3-jacob.e.keller@intel.com>
Date:   Mon, 28 Feb 2022 18:36:35 -0800
In-Reply-To: <20220228215025.325904-3-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Mon, 28 Feb 2022 13:50:25 -0800")
Message-ID: <xmqqpmn6wg98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A15686A-9908-11EC-AEF0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> +test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
> +	test_config -C non-monotonic core.commitGraph false &&
> +	(
> +		cd non-monotonic &&
> +
> +		rm -rf .git/info/commit-graph* &&
> +
> +		echo "main~3 undefined" >expect &&
> +		git name-rev --tags main~3 >actual &&
> +
> +		test_cmp expect actual
> +	)
> +'

I doubt it is wise to "test" that a program does _not_ produce a
correct output, or even worse, it produces a particular wrong
output.  This test, for example, casts in stone that any future
optimization that does not depend on the commit-graph is forever
prohibited.

Just dropping the test would be fine, I would think.
