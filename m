Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C886C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbiAEVEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:04:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63501 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiAEVEA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 16:04:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C3FFFDD9C;
        Wed,  5 Jan 2022 16:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=80MizonuAlTww58meo476VEI7ZWbjnSZxt/ZFJ
        uW0a4=; b=auoGFs+SOKoIyQsEUExS1fWInSQ7YlAzmZK7GijlztxBsnNFn7ZsCF
        somZ6imNTAMvdWVo1Wou8xCLMZftFLjDuulYQNl9KmWjXGF6dGXOcnlGgcFMsyL/
        FalOi7yrcPNWpn1vvKKQ+wP1FXERbZd8z78Y4MzX3OEhdh5X0PKbM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82A9BFDD99;
        Wed,  5 Jan 2022 16:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF5F9FDD94;
        Wed,  5 Jan 2022 16:03:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v2 2/2] update-index: refresh should rewrite index in
 case of racy timestamps
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
        <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
        <dfeabf6af15dfab06bde1ec7dcc2d0576497be9b.1641388523.git.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 13:03:57 -0800
In-Reply-To: <dfeabf6af15dfab06bde1ec7dcc2d0576497be9b.1641388523.git.gitgitgadget@gmail.com>
        (Marc Strapetz via GitGitGadget's message of "Wed, 05 Jan 2022
        13:15:23 +0000")
Message-ID: <xmqq7dbdhp36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 006C65AC-6E6B-11EC-84B5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success '--refresh has no racy timestamps to fix' '
> +	reset_files &&
> +	test-tool chmtime =1234567891 .git/index &&

Don't some people use Git on VFAT where the time resolution is 2
seconds?  1234567890 and 1234567891 differ only by one second, so
chmtime may not be able to store one of them exactly, so I am not
sure if this guarantees "no racy timestamps to fix".

