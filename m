Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F27BC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA4720706
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lN16GvSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLEXEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:04:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56170 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEXEU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 18:04:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B72B9A642;
        Thu,  5 Dec 2019 18:04:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KDZfc3Bt46K73gA2can52vwNEko=; b=lN16Gv
        SmodIQ0YygRTU+bIxrYfKZ3wTBbguGJruR4Xei/N2QG5boXkS4djk6s4ydK95im+
        FTtSoXwbtXpIXCwXzAlWEd+PPLEdHle758BqX6h+Y/ydc5cB89p6jxUUxvoA8lRM
        9o2UjVozQrD+0lO8zAqC1qBgWekfZPP5uDYjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HrUAjW9MOpi2hawORJgEsCA+AtRSWsmx
        huPMHv1nAS7SiwGLn0ae6bfaJDUvHkazk1bjMVC7E7VZBxInDkqY2Enl93H+ktCi
        J/o+phiYEnb71jlT6bFHOdbB2ec/CbvsbGijWqNa6s83Amo5s/BPqFsXbg4F6Tdw
        HaDcjFakUi0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 635E19A641;
        Thu,  5 Dec 2019 18:04:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3BB049A63A;
        Thu,  5 Dec 2019 18:04:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Torok <alext9@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] rebase: add test for rebase --fork-point with short upstream
References: <20191205225322.5529-1-alext9@gmail.com>
        <20191205225322.5529-2-alext9@gmail.com>
Date:   Thu, 05 Dec 2019 15:04:13 -0800
In-Reply-To: <20191205225322.5529-2-alext9@gmail.com> (Alex Torok's message of
        "Thu, 5 Dec 2019 17:53:20 -0500")
Message-ID: <xmqqv9quxtle.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EEB538A-17B3-11EA-9137-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Torok <alext9@gmail.com> writes:

> This proves the bug of "rebase --fork-point upstream branch" not using
> the fork point of upstream and branch if upstream is not the full
> refname of the upstream branch.
>
> Signed-off-by: Alex Torok <alext9@gmail.com>
> ---
>  t/t3431-rebase-fork-point.sh | 1 +
>  1 file changed, 1 insertion(+)

Is this new test expected to fail after applying only 1/3 and then
starts working after applying all 3 patches?

If so, it probably makes a lot mroe sense to reorder the series to
have 2/3 as a single preparatory patch, with 1/3 + 3/3 combined into
a single patch "rebase: find --fork-point with full ref" to fix the
code and protect the fix with the test at the same time.

> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 78851b9a2a..6ecdae918e 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -49,6 +49,7 @@ test_rebase 'G F C D B A' --no-fork-point --onto D
>  test_rebase 'G F C B A' --no-fork-point --keep-base
>  test_rebase 'G F E D B A' --fork-point refs/heads/master
>  test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
> +test_rebase 'G F D B A' --fork-point --onto D master
>  test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
>  test_rebase 'G F C E D B A' refs/heads/master
>  test_rebase 'G F C D B A' --onto D refs/heads/master
