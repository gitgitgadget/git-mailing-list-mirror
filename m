Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B8BC4332D
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F7423B16
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbhAVTxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:53:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63468 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbhAVTXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:23:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D2C2A7720;
        Fri, 22 Jan 2021 14:23:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yf85kMS/Rv/W6tJgw50G3h+WILg=; b=AXkdyU
        CjCAdAL7i0XB4PO+faIT4rKlksa1KvNF5On9+DMJHjDXDv7QkOK9+jF2O7tR1LHE
        whWcxraDsGkju0AZBieU+w9mND4DsVXv3z5zcwrdB9CrEIoliZNF7aVm2AhmUOHX
        Fle2UcB9jsq/ML+Nah1SzonEfG3bV7Saznqcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U6Nu4yVuDROy2J7XCvflC/19u5Mq4y5C
        Mkjv9hibvNmXM8J/jpPe0qzG+KmJUMcmia6YaCwMsUmr52piurgD62gqToCO7w6P
        r8A84R0NPAdHTudXf6YCPqCGTk3cfBK/m5/53/bXmG/ygc5q2mRfiLf3++2ObGeB
        0t0QwS63Dro=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AB1AA771F;
        Fri, 22 Jan 2021 14:23:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58E7FA771D;
        Fri, 22 Jan 2021 14:23:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/8] repository: add repo reference to index_state
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <a0d89d7a9731adeee4e2a432843b2f4a9c232dc4.1611320639.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 11:23:07 -0800
In-Reply-To: <a0d89d7a9731adeee4e2a432843b2f4a9c232dc4.1611320639.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 22 Jan 2021
        13:03:55 +0000")
Message-ID: <xmqqczxw93ok.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42674C38-5CE7-11EB-9C34-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> It will be helpful to add behavior to index operations that might
> trigger an object lookup. Since each index belongs to a specific
> repository, add a 'repo' pointer to struct index_state that allows
> access to this repository.
>
> This will prevent future changes from needing to pass an additional
> 'struct repository *repo' parameter and instead rely only on the 'struct
> index_state *istate' parameter.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

I think this makes sense, but shouldn't we insist on these
bidirectional links to point at each other?  Otherwise we cannot
simplify the function signatures safely later.  That is ...

> +	/* Complete the double-reference */
> +	if (!repo->index->repo)
> +		repo->index->repo = repo;
> +

	else if (repo->index->repo != repo)
		BUG("the repo->index instance does not belong to the repo???");

... a check like this?

>  	return read_index_from(repo->index, repo->index_file, repo->gitdir);
>  }
