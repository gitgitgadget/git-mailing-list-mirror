Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3E9C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhLVAAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:00:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61008 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhLVAAK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:00:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A859106D11;
        Tue, 21 Dec 2021 19:00:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TGXzqQgG4E4U6Clp46ViG1d+ZFPOvmfwKEFRLg
        id0fI=; b=hGZ0wgTegEIM1a31aL/o7INA6xiaYYXZNnaMxoC8Q6V35BPkRlnCt1
        zMPhe1+dueTkOmmgIRiyNRRs99HyULU6ld8mywfZw0csZXaD1bC/AOsz4bd2EAW7
        6r5vHBqpO3EXmuSTJhMhHtcN9FC2dAuHNO194prrUcTnic/JtT2ms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17EF7106D0B;
        Tue, 21 Dec 2021 19:00:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBADF106CF8;
        Tue, 21 Dec 2021 19:00:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 3/9] merge-ort: capture and print ll-merge warnings in
 our preferred fashion
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <f36395fdee044a077a640bd3031a7a8da8a39657.1640109948.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 16:00:00 -0800
In-Reply-To: <f36395fdee044a077a640bd3031a7a8da8a39657.1640109948.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 21 Dec 2021
        18:05:42 +0000")
Message-ID: <xmqq5yrho6f3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CEC182E-62BA-11EC-BA53-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Instead of immediately printing ll-merge warnings to stderr, we save
> them in our output strbuf.  Besides allowing us to move these warnings
> to a special file for --remerge-diff, this has two other benefits for
> regular merges done by merge-ort:
>
>   * The deferral of messages ensures we can print all messages about
>     any given path together (merge-recursive was known to sometimes
>     intersperse messages about other paths, particularly when renames
>     were involved).

I would imagine that with something like this, we can show such a
warning message differently when it happens during an inner
"synthesizing a virtual common ancestor" merge (the most likely
value for "show differently" would be to "squelch"), which may be a
good thing.

>  	if (merge_status == LL_MERGE_BINARY_CONFLICT)
> -		warning("Cannot merge binary files: %s (%s vs. %s)",
> -			path, name1, name2);
> +		path_msg(opt, path, 0,
> +			 "warning: Cannot merge binary files: %s (%s vs. %s)",
> +			 path, name1, name2);
>  

Nice.
