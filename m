Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F4C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFCD2311B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAFUvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 15:51:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51537 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbhAFUvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 15:51:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64F06B391C;
        Wed,  6 Jan 2021 15:50:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fm++/Uj556hnQnwTG2Jt3Q0g488=; b=DSNNhZ
        /dBrB34wJGer/icbomyAmuYn5JdNmtWp7OwvVOJLe6ehpK9u7Rxjwac3oqrr4ZXI
        tx5ufmGVM4GP7SqHIQaqe8m/nj8cyzFh/IgHu+1t7HGfr6lQbW0xm0SL39W2uMZd
        g2gdi0nui+7sHdQiYsIn2gS7m9HCTKuLpT8B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VvdfOy8DR20MJNbIoQnTxnp90J/hHMYz
        UnYabDrhOdLTqgGwDuw0dRVbFlDSRntgTTbXSQGuntijASXhK98z5vqAJ4JdhVxH
        iS/yBmqcS3O4nSekzS5FCMgwQuNj6bIlmol4+5jiyIohjKwBoxU3PpyUfThr7FRS
        3qzexSg8eQA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59623B391B;
        Wed,  6 Jan 2021 15:50:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF4A2B391A;
        Wed,  6 Jan 2021 15:50:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
        <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
        <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
        <CAPig+cRGWzz5n_PZ=_OiHy2hkmeru3=fo2zX3_hnsEhnPq+giQ@mail.gmail.com>
Date:   Wed, 06 Jan 2021 12:50:29 -0800
In-Reply-To: <CAPig+cRGWzz5n_PZ=_OiHy2hkmeru3=fo2zX3_hnsEhnPq+giQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 5 Jan 2021 23:20:14 -0500")
Message-ID: <xmqqturtrdre.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFC872F2-5060-11EB-944E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Is the behavior implemented by this patch desirable? That is, if the
> user mistypes the name of the configuration variable, would it be
> better to let the user know about the problem by returning an error
> code rather than succeeding silently? Or do you foresee people
> intentionally running the command against an empty config variable?
> That might be legitimate in automation situations. If legitimate to
> have an empty config, then would it be helpful to somehow distinguish
> between an empty config variable and a non-existent one (assuming we
> can even do that)?

I am guessing, without reading the mind of those who designed the
feature, that the envisioned use pattern is that a configuration
variable is designated, "git for-each-ref --config=<var> <cmd>" is
carved into stone in a script that is run periodically with the
hardcoded variable name in it, but the value of the variable may
change from time to time.  If it is expected that the variable can
sometimes be empty, then erroring out or even issuing a warning
would be counter-productive.

> Is the API of this command ideal? It feels odd to force the user to
> specify required input via a command-line option rather than just as a
> positional argument. In other words, since the config variable name is
> mandatory, an alternative invocation format would be:
>
>     git for-each-repo <config-var> <cmd>

Or not to use any configuration variable (or not to have the
for-each-repo subcommand at all) and let the users write
something along the lines of...

	git config --get-all <config-var> |
	while read repo
	do
		( cd "$repo" && <cmd> )
	done

which is not all that bad and much more flexible.

> Or do you foresee future enhancements expanding the ways in which the
> repo list can be specified (such as from a file or stdin or directly
> via the command-line), in which case the `--config` option makes
> sense.

