Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A8C433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbiAEUHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:07:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55429 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiAEUHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:07:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6DAA17AD88;
        Wed,  5 Jan 2022 15:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DpBB1Cykt4Fh+oGZMqhHTqhHKMaakm4ewt2c5a
        MGpdw=; b=XKjkd28hOpGUkT3CBU6yJEdcErDf5bQ4dw8bQB/qJZqiaMnaCNnW8D
        UUs/XN+4OCPhMgJYmRF4C38uqszGQUUeygE3c+TVUCDba2bhPKlb1ZinkEPKBxCz
        +h7bNXcMDHBSYpCjOa3LRNcFmyMYFe3HI4iuSBod0ilROZ65jeDBs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E022D17AD87;
        Wed,  5 Jan 2022 15:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5177A17AD86;
        Wed,  5 Jan 2022 15:07:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
References: <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
        <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
        <7c5fb10d87c4b807567db0ed83f987487532c7c1.1641356439.git.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 12:07:06 -0800
In-Reply-To: <7c5fb10d87c4b807567db0ed83f987487532c7c1.1641356439.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Wed, 05 Jan 2022 04:20:38
        +0000")
Message-ID: <xmqqh7aihrpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F8EA00C-6E63-11EC-B140-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	altogether.
> ++
> +For example:
> ++
> +--
> +	$ cat sample.txt
> +
> +	An abbreviated revision 2ae0a9cb82 will not be substituted.
> +	The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
> +	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +
> +	$ git name-rev --annotate-stdin <sample.txt
> +
> +	An abbreviated revision 2ae0a9cb82 will not be substituted.
> +	The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907 (master),
> +	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +
> +	$ git name-rev --name-only --annotate-stdin <sample.txt
> +
> +	An abbreviated revision 2ae0a9cb82 will not be substituted.
> +	The full name after substitution is master,
> +	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +--

I compared the output from the earlier ones with this one; the way
the displayed sample was shown in the previous rounds looked better,
at least in HTML pages.  The earlier ones used "listingblock" in
which the sample is contained in a <pre>formatted <code> block, but
this one ends up in a series of one-<div>-per-paragraph.

> -	if (transform_stdin) {
> -		char buffer[2048];
> +	if (annotate_stdin) {
> +		struct strbuf sb = STRBUF_INIT;

This will break the compilation at this step.
