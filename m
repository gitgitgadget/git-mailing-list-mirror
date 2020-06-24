Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48FEC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9020E2078A
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O2vjV6ZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbgFXBKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:10:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61460 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgFXBKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 21:10:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 386866A772;
        Tue, 23 Jun 2020 21:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2cENNAhbWtg6tFmDscfUNis82zc=; b=O2vjV6
        ZL0d0qXsFvFWxIRtBb4trYUyQxsYFQFQk6X78+IH4W3nXO1e2bNCXF1P5A/qMfbv
        B1iBpT6tZz5KOlKnQUelOJhyrdei5g7IPLdKf3ZrN6HZaGzvbJh0vvjerehy3hKl
        4o7u3S1XvdZ94Q18dmPTSE6xfAguDmARi8Kuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U42OK6LbpTExPuBgJn6dtst/si5eM1Y/
        1Bec+1NmDadLTBzZT56RbxVMTBiOhXn2rpWrQJtL5D4n0Keti3MztwcZ9+mKlF5f
        7eyHt5EOplZSdKqXxaQOmJ6/BwKIPX2HkbN7wUH9xnSXsob7pWGdHXIU8/BOQdIz
        tBQNcx3M3zg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2ECAD6A771;
        Tue, 23 Jun 2020 21:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABC856A770;
        Tue, 23 Jun 2020 21:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 7/8] remote: use the configured default branch name when appropriate
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <00a1b281e5ae4cf14435a6745cc55fc248f378a5.1592951611.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 18:10:30 -0700
In-Reply-To: <00a1b281e5ae4cf14435a6745cc55fc248f378a5.1592951611.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 23 Jun 2020
        22:33:29 +0000")
Message-ID: <xmqqbll99sl5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F48206E-B5B7-11EA-823B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/remote.c b/remote.c
> index 534c6426f1..965129adc3 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -276,7 +276,7 @@ static void read_branches_file(struct remote *remote)
>  
>  	/*
>  	 * The branches file would have URL and optionally
> -	 * #branch specified.  The "master" (or specified) branch is
> +	 * #branch specified.  The main (or specified) branch is
>  	 * fetched and stored in the local branch matching the
>  	 * remote name.
>  	 */

Isn't this a bit premature here?

