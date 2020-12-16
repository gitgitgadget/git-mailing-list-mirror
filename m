Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0EEC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 01:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34FE207E8
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 01:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgLPBQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 20:16:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51230 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPBQz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 20:16:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF0799F2CB;
        Tue, 15 Dec 2020 20:16:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sAL1VY0NHl0l2R45sndQSsP/g28=; b=sr2jX/
        e0UL+P85n5bUs+2v5Kqajje2T4zwhTnJyxrJm03WiAQwl/aT+AoGf2O593BN4fb5
        TJ0DFNg7Ap/t8EwnN6JjbJMWJtkNQTxc8Sze7OLfot5T7emaGm2yzsdrK5S9zJ6e
        mDwVLL9OgDlu5E3jW4JKUsxdPtGZFpLO8IL0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ie84aCNpCAuQRvWLzeWjp4v5fQJEQPJA
        W6FAaxt4UZaCE/7CVVviZNujia1QKWKOO9KxQNXF+EwFUMpqzNnHpSkaTBAZEV4i
        nTRR7Hp3MGMuBGD5DgyoJLqFDQ9GzOpYJL5Db0cRXqWbIKLS/O2hLXPq1+a118Ww
        fEBNuu/JaAs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D44CA9F2CA;
        Tue, 15 Dec 2020 20:16:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 637C89F2C9;
        Tue, 15 Dec 2020 20:16:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
        <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 17:16:11 -0800
In-Reply-To: <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 15 Dec 2020
        17:53:25 +0000")
Message-ID: <xmqqh7om5z50.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 493C923E-3F3C-11EB-95F0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In a subsequent commit, we will implement the traditional recursiveness
> that gave merge-recursive its name, namely merging non-unique
> merge-bases to come up with a single virtual merge base.  Copy a few
> helper functions from merge-recursive.c that we will use in the
> implementation.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ...
> @@ -1462,5 +1492,7 @@ void merge_incore_recursive(struct merge_options *opt,
>  			    struct commit *side2,
>  			    struct merge_result *result)
>  {
> +	(void)reverse_commit_list;
> +	(void)make_virtual_commit;

To keep these symbols referenced?  Cute ;-)

>  	die("Not yet implemented");
>  }
