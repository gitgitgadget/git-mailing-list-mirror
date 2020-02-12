Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D3C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 18:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1557F20848
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 18:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJ9YlP04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgBLSTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:19:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59334 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSTR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 13:19:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBB0C4B6D0;
        Wed, 12 Feb 2020 13:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BzWiGANS31jr
        PG6wy12ytmwAG7g=; b=dJ9YlP04qP+DctyhVXaPUBMFndsluDfp5atZNV+e2G23
        EgKsp9dr9vEE8nCPhFRdKJLFGgNXCvZLOlU6F0jrNAbBv24YlU8SsgHzoVyFIKf8
        kxUZwhHod2GCtRQ4I7XobAPYKWmGeMV1tYuKpmikXp9xcgKYZeHfCoMOytTVPqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=t+Xkaw
        YdXaAUKApKyezunf5nfmQ6UdKSPuElM4DVt866mljutahL0ULniMg0e29plHw00r
        JYD+qZ493kMG4p80ZE0AxVHJKXxwniDKQvllqeZoxs4uZ27H2p9T90O816cn0CEI
        QO47MMfHKKq58TrTsHVOcmniHKq1/+fSba9RM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E10EC4B6CF;
        Wed, 12 Feb 2020 13:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49FB54B6CD;
        Wed, 12 Feb 2020 13:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>, Garima Singh <garimasigit@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        martin.agren@gmail.com
Subject: Re: [PATCH v3 0/3] builtin/commit-graph.c: new split/merge options
References: <cover.1580430057.git.me@ttaylorr.com>
        <cover.1581486293.git.me@ttaylorr.com>
Date:   Wed, 12 Feb 2020 10:19:14 -0800
In-Reply-To: <cover.1581486293.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 11 Feb 2020 21:47:50 -0800")
Message-ID: <xmqqy2t7u0rh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2DA909B8-4DC4-11EA-937C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Attached is what I anticipate/hope to be the final reroll of my series
> to add new arguments to the 'git commit-graph write --split' flag to
> allow callers to force or prohibit the commit-graph machinery to merge
> multiple commit-graph layers.
>
> I was keeping an eye out for more discussion about whether or not these
> flags were acceptable by reviewers. Martin =C3=85gren and Derrick Stole=
e have
> both chimed in that they seem OK.
>
> Since there hasn't been much more discussion in this thread, I replayed
> this series on top of 'tb/commit-graph-use-odb' (which was itself
> rebased on 'master'). I picked up a couple of ASCIIDoc changes along th=
e
> way, and a range-diff is included below.

I haven't had a chance to form an opinion on this topic, and will
let others comment on it first.

This topic and the "changed paths bloom filter" topic obviously and
inevitably have trivial textual conflicts.  When today's integration
result is pushed out in 6 hours or so, please see if the resolution
is reasonable in 'pu'.

Thanks.
