Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A234FC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD4961078
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 21:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhHJV1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:27:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhHJV1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 17:27:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F26CE151E7A;
        Tue, 10 Aug 2021 17:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JZ0nVnwUwiHV74yyWdEfbNZi5ktuQHXXzbJNYC
        7avmE=; b=XgEcvQiQOVrFREYkchGiYOqdAR++OoRYJL4ckX2Yf2+tCm0QYEhFt/
        hRE477O7HOWH5Bb3YabGfDG3X4KtTb8Kn7v988RmapTYn5fCTAvprxn2dDCcvTsv
        i+KjxomM9EldotnfzxHO/KNfSxjHo5Eumco5W26qj3uo0LwRBkLRM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB4A9151E79;
        Tue, 10 Aug 2021 17:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2835F151E78;
        Tue, 10 Aug 2021 17:27:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, avarab@gmail.com,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v4 4/8] dir: libify and export helper functions
 from clone.c
References: <20210806120147.73349-1-raykar.ath@gmail.com>
        <20210807071613.99610-1-raykar.ath@gmail.com>
        <20210807071613.99610-5-raykar.ath@gmail.com>
        <1b731c17-7284-746d-331b-d0edd5823318@gmail.com>
        <m21r73avvx.fsf@gmail.com>
        <68bb457b-9575-c2a1-6d51-fc7cd85a50b7@gmail.com>
Date:   Tue, 10 Aug 2021 14:27:04 -0700
In-Reply-To: <68bb457b-9575-c2a1-6d51-fc7cd85a50b7@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 10 Aug 2021 23:23:13 +0530")
Message-ID: <xmqqpmulc7o7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6277C24-FA21-11EB-836A-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> I wonder what real-world URL has a syntax like 'host.xz:foo/.git' for which
> 'foo' would be an appropriate basename to return. Does a real-world URL of
> this form exist? Or is this just cooked up to demonstrate the basename that
> would be returned for a hypothetical URL like this?

It is not really a URL, but historically we've called them
"scp-style URL".  scp of course copied the syntax from "rcp" where
<hostname> and <pathname> are separated by a colon ':' named a file
or a directory at the named path on the named host.
