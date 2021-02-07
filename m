Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B79C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 03:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D2564E7D
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 03:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBGDd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 22:33:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50757 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGDd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 22:33:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 300F194C4D;
        Sat,  6 Feb 2021 22:33:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tUH2N9yd4gHTaC75lSZNrXV9zHQ=; b=EQz3HC
        OCnnpAQWI/m4hjySEsdL77uqv/BthrHiRz7Mi787pO20mctorn6G04yQhz06Ac2N
        khBBno1fCShzAfKqukWeev3Z9wLiErE8rNBSV5f+NlG7zCVwz7UL4cz+vTG4BX9p
        d5v9v8scK0bHFUDxMkfxTqmzyJC0BIGoKyy1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=brYvPPtjxxrfw+ngHJ/hwdOWIkvuRr54
        GMrvxsHqB3TB32b/OgZ4wi0DAuyOPhT4+icxyiTzDyHnQ1Hnn7a9h7UaGiW323b9
        VKqPga7BvBE4pqPPw4vWnqr67/nNy4WQ2VjXhRFC4PiS8uBFtRgqFOvhS/k/83bG
        bF+5xVEJKoI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2754A94C4C;
        Sat,  6 Feb 2021 22:33:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA5F294C4B;
        Sat,  6 Feb 2021 22:33:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/3] Unify trailers formatting logic for pretty.c and
 ref-filter.c
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 19:33:14 -0800
In-Reply-To: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com> (Hariom Verma
        via GitGitGadget's message of "Sat, 06 Feb 2021 09:15:41 +0000")
Message-ID: <xmqqim74a6x1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36983EA2-68F5-11EB-B52E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
>       +	option="$2"
>       +	expect="$3"
>       +	test_expect_success "$title" '
>      -+		echo $expect >expect &&
>      ++		printf "$expect\n" >expect &&

Are we sure that "$expect" would not ever have any '%' in it, to
confuse printf?  To be future-proof and safe, it would be prudent to
instead use

	printf "%s\n" "$expect"

to make sure that whatever is passed in $3 gets output LITERALLY.

The callers need to adopt the change I gave you in the review of the
previous round so that they do not assume backslash-en will by
changed to LF by somebody---instead if they mean LF, they just say
LF.

Thanks.





	
