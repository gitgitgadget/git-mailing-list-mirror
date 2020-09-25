Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E81C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F332075F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SHzEJnmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgIYSAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:00:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56290 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYSAx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:00:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03F8DF2FD5;
        Fri, 25 Sep 2020 14:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7igkJhA0NapALN6vcsAtJe0JZhw=; b=SHzEJn
        mAee+vynfxN8tX41E5n2mTlsCn8QB8KWLmxaMvlY+R3yNTFab2QMi/mHm6HZep1Y
        CDKwUuiPR0f582sI07QesBkU/HaCHqVy78j8lDGIpaQJ0byYNb0JMytB7Y4+mXmE
        l1znuUByx/aq2icnvpXSofOUJaeJ2VLgAY0OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F07T5Tx3i5uO0KNFYySEi0kE8/nBK3gF
        juOqK+kgDEng37qjSfeYGf3J2HUvtPNVKGtYf0NhI8ftDj0Z3g/IFQnsnDnkNnv3
        BLtfgV15YqZwKha/MlTOBx9OZ8ezd+K1ESAOh3+yenEppz9KlGZMhSUxEAaAridN
        olWg/D0oZho=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF203F2FD4;
        Fri, 25 Sep 2020 14:00:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 78C5EF2FD1;
        Fri, 25 Sep 2020 14:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/8] maintenance: create auto condition for
 loose-objects
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
        <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
        <931fff4883a3da26a296af69a9c5ccc3a5037d71.1601037218.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 11:00:44 -0700
In-Reply-To: <931fff4883a3da26a296af69a9c5ccc3a5037d71.1601037218.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 25 Sep 2020
        12:33:33 +0000")
Message-ID: <xmqqh7rllos3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09857C64-FF59-11EA-8DE4-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index b3fc7c8670..27565c55a2 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -127,4 +127,26 @@ test_expect_success 'loose-objects task' '
>  	test_cmp packs-between packs-after
>  '
>  
> +test_expect_success 'maintenance.loose-objects.auto' '
> +	git repack -adk &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
> +		git -c maintenance.loose-objects.auto=1 maintenance \
> +		run --auto --task=loose-objects 2>/dev/null &&
> +	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
> +	printf data-A | git hash-object -t blob --stdin -w &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace-loA" \
> +		git -c maintenance.loose-objects.auto=2 \
> +		maintenance run --auto --task=loose-objects 2>/dev/null &&
> +	test_subcommand ! git prune-packed --quiet <trace-loA &&
> +	printf data-B | git hash-object -t blob --stdin -w &&

Is it essential for the purpose of the test somehow that the data
used for the test are all incomplete files that lack the end-of-line
at the end of the file?  Use of 'printf' sends such a signal to
confuse readers.

Use of test_write_lines to write a single line may feel overkill,
but it may be less cryptic, as newer parts of testsuite are
encouraged to use it over 'echo' and raw 'printf'.

> +	GIT_TRACE2_EVENT="$(pwd)/trace-loB" \
> +		git -c maintenance.loose-objects.auto=2 \
> +		maintenance run --auto --task=loose-objects 2>/dev/null &&
> +	test_subcommand git prune-packed --quiet <trace-loB &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace-loC" \
> +		git -c maintenance.loose-objects.auto=2 \
> +		maintenance run --auto --task=loose-objects 2>/dev/null &&
> +	test_subcommand git prune-packed --quiet <trace-loC
> +'

