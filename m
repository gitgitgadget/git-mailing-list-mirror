Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FD8C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98BF206E3
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KPQziBx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgJBUDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:03:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56943 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJBUDk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 16:03:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D20EA0422;
        Fri,  2 Oct 2020 16:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lGVTHOXAbmMn0aTsEYYOtsPPq74=; b=KPQziB
        x5BjflV58jF68lNSO6m8xll0eZxQcVggAoC6h+QC6Yt+/QsAn0+sz0z5Gk9te/XA
        1MYO1dU3nKX8stgRMYKFLnSOiavQcR+3prn1CXjgdlTkKi11ymde/6OprzthdK46
        1LxrBeRFuIQ1PWI/GsvLUy8feobOpIQCpU2yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r7kIskiREDGVGSZ76KCD7DtlSR00uND8
        KaBQcYm5f6JBS8dQfl+OjYGsAAj5IlX0wLrOeJvFfpf/KXfJsrOGMT0mIVxHTPpy
        dVEGcgAEsituB1coCCENq1g0DwRqFR+eZSfydU2uzrNYWqtYSJnHTqY01BZ1M1bw
        wyk5WbnRxIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53833A0421;
        Fri,  2 Oct 2020 16:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD169A0420;
        Fri,  2 Oct 2020 16:03:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-reach: fix in_merge_bases_many bug
References: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
        <xmqqv9fs8nre.fsf@gitster.c.googlers.com>
        <c6b163dd-d5f4-73a8-43ac-22460d1079ec@gmail.com>
Date:   Fri, 02 Oct 2020 13:03:37 -0700
In-Reply-To: <c6b163dd-d5f4-73a8-43ac-22460d1079ec@gmail.com> (Derrick
        Stolee's message of "Fri, 2 Oct 2020 15:47:28 -0400")
Message-ID: <xmqqr1qg8kfa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C0A1A9E-04EA-11EB-A70E-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Thanks for double-checking. I also think that dropping the
> "hide the error" patch is prudent.

Thanks again for a quick and straight-forward fix.  As I mentioned
elsewhere in the thread, it appears that we invented duplicate API
with parallel implementation in get_reachable_subset(), which seems
to be a strict superset of in_merge_bases_many(), and that may be
what led to an initial and incorrect "get_reachable_subset() is not
broken the same way as in_merge_bases_many() so use it instead"
response.  I haven't paid attention to the quality of implementation
of get_reachable_subset() as much as in_merge_bases_many() (e.g. I
know of an obvious way to optimize the latter) so far, but it would
be wonderful if we can eventually rewrite in_merge_bases_many() as a
very thin wrapper() around get_reachable_subset() without any
downside.

