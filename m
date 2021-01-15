Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4DEC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0CD2399A
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 17:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbhAORXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 12:23:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55783 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbhAORXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 12:23:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7906FB6516;
        Fri, 15 Jan 2021 12:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m65U/35ijaWZox9g0RuLYIS9hmo=; b=yQO60j
        2j+aZiRIEUUO2qSKu/MmLTCKQ9AES9XwIrYXNv9bndt+5XjSUU5w8dHa3fGq9+9O
        3CfzG86GIUeKNy1EhwmglmEzaPbKgOvbA4MG9EnXE/VI9mNy/y9BaQr5el7dBcgV
        rH70N/Bx/iqsOFoMAHcGkbizDirfgPSS6GpaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xNE55YPZJjzMtabHLIanvxdH9dNUJucx
        It3SPR1Z1V7XWOaxEQ8LbQDHvwicAppZ8/ir6TF5VOddz1UQkPYHaHMNZKAhk2Eb
        2S75OtAPyBcmwHUKtvi/v9k8rYEO93Lhvb+QNih8u0nv51DKKcjhHMfSTxLJgCGQ
        hy8XKII09fg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F16EB6515;
        Fri, 15 Jan 2021 12:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA53BB6514;
        Fri, 15 Jan 2021 12:22:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 1/9] rebase -i: only write fixup-message when it's
 needed
References: <20210108092345.2178-1-charvi077@gmail.com>
        <20210108092345.2178-2-charvi077@gmail.com>
        <X/8/WassxF7ujqjX@nand.local>
        <CAPSFM5ew583ZPZO9XUWxskQPsdSv520gKCM30GH2huhdTDxb2A@mail.gmail.com>
        <ac1691d6-e13e-2c04-b105-73a0645f4883@gmail.com>
        <CAPSFM5eBCVD9sx-AkA6Zr-PAq3JgTftcf2UhZBcBmK_00ff1+Q@mail.gmail.com>
Date:   Fri, 15 Jan 2021 09:22:37 -0800
In-Reply-To: <CAPSFM5eBCVD9sx-AkA6Zr-PAq3JgTftcf2UhZBcBmK_00ff1+Q@mail.gmail.com>
        (Charvi Mendiratta's message of "Fri, 15 Jan 2021 14:08:37 +0530")
Message-ID: <xmqqbldqt8rm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43B6AA16-5756-11EB-A7F3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Okay, I looked into the write_message(...) and agree that it does not return
> a positive value and only returns non-zero for error case and zero for
> success. So, for this patch maybe we can ignore checking '< 0' here and
> later add another patch to make this function follow the convention of
> "negative is error".

Please don't.  There is a higher cognitive cost to readers when you write

	if (write_message(...)) {

The reader is forced to look at its implementation to see if it
returns positive in a non-error situation.

If you write it like so from the beginning

	if (write_message(...) < 0) {

the reader can trust that the code follows "negative is an error"
convention.  One fewer thing readers have to worry about.
