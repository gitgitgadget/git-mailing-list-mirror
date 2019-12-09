Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A2FC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E022071E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="akICXMRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLIWwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:52:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55529 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLIWwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:52:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEF28184CF;
        Mon,  9 Dec 2019 17:52:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S+L+bSi7E3+5GSNxM5PyU8vrrdU=; b=akICXM
        Rzsl2heZO2NL5riCtwu/MWO7FSktkt8zxgsR0eoqAv4M6Rz1hs3LQvaa18PDrqDf
        lZUYFitj/KfCJpQYizR6BxL4v+PT3aPel3AeukUiFHpfgo59ZinGrBYGn5GwwmXb
        jECoH7Z3GGX4EJ2mhhSMniYigsVmxwYpyaaLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ciokb2hT9s55IgrYHvwHO20WymYYUQ+t
        gCJZpnZVzHIIkwRw9BiC0/hS/OUgrVnn8qTk75ky9QdnKGzRBriK3gKCJSGcoTep
        R8HKgSZRTW9Qbie9cBMqc+QfcIc8hv9lUx3Mi4DYdm4LGQ2PILh0TrNxYDfJdBrs
        TY18JXamiPo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4CD1184CE;
        Mon,  9 Dec 2019 17:52:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0920184CD;
        Mon,  9 Dec 2019 17:52:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 8/8] test-lib: clear watchman watches at test completion
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
        <e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:52:00 -0800
In-Reply-To: <e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 09 Dec 2019
        16:10:04 +0000")
Message-ID: <xmqqwob5ru27.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 838513CA-1AD6-11EA-BEE3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_clear_watchman () {
> +	if test -n "$GIT_TEST_FSMONITOR"
> +	then
> +		watchman watch-list |
> +			grep "$TRASH_DIRECTORY" |
> +			sed "s/\",//g" |
> +			sed "s/\"//g" >repo-list

Whoa, this is scary.  "$TRASH_DIRECTORY" comes from $(pwd) and the
leading part of it can have arbitrary garbage like "[a-z]*" that may
match paths "watchman watch-list" may emit that does not have
anything to do with the temporary directory used by this test.

What are these stripping of ", and " about?  Could you tell readers
how a typical output from the program we are reading from looks like
perhaps in the log message or in-code comment around here?

Thanks.
