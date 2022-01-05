Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFAC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiAEUKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:10:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59424 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbiAEUKg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:10:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14DCAFD801;
        Wed,  5 Jan 2022 15:10:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=00Df1ro718UxzQQ5NPspiWJPZoUg6S6dyA0G9/
        aKmks=; b=sSidXBcaIfoa80I5zXaUWjLrG7KZh9gPr+wGpmMyJOuSxGpW8K4C//
        NYtkE/kbOqmeYF2YwDCcGmKmvlcJcE3Ts92IfrhGXiHpmpu4g31YB+uuktgYqiDa
        OGczHly8iKo1i6HqiCq86C+1H9sfWOD3wfmbIdTD/XS7sA3s45ypg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CE8EFD800;
        Wed,  5 Jan 2022 15:10:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49703FD7FD;
        Wed,  5 Jan 2022 15:10:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4] receive-pack.c: consolidate find header logic
References: <pull.1125.v3.git.git.1640931460758.gitgitgadget@gmail.com>
        <pull.1125.v4.git.git.1641396098056.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 12:10:34 -0800
In-Reply-To: <pull.1125.v4.git.git.1641396098056.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Wed, 05 Jan 2022 15:21:37 +0000")
Message-ID: <xmqqczl6hrk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AEBA1BE-6E63-11EC-A496-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes since v4:
>     
>      * added NEEDSWORK block detailing what needs to be done to clean up
>        find_header_mem
> ...
>       -	while (line) {
>      ++	/*
>      ++	 * NEEDSWORK: Between line[0] and msg[len], there may not be a LF nor NUL
>      ++	 * at all, and strchrnul() will scan beyond the range we were given
>      ++	 * Make this operation safer and abide by the contract to only read up to len.
>      ++	 */

This sounds unnecessarily alarming.  Can't we also explain that the
current callers are safe?
