Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D01C433E3
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C089E2078D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fBpQyAQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgHNTZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:25:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50994 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNTZw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 15:25:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4662E66C4;
        Fri, 14 Aug 2020 15:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KVw+emywvw1JkiV/TvW3rz/T3rk=; b=fBpQyA
        QEZt33mVTcRwvU3xFA8ahb8+yB5+Z6r2qXox2tNwJTgm0rsMG1P59SQUkPeOdNpJ
        STHo4GLNpgTESU1KJGW2Zopdp53Aw3zQl/GPJMovN9p31YSuCTu6oLs/AKkTUTlq
        iWTLa7+NzyD+H6kYbIIf1Am1VDjxOPHnrIXLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E3tG9oFiRlmt5mLow0IFQAUFUNUvmCH2
        DEYScCXTd57vLBc2xEVNOiNDqS/hoyK6JRqT1Y9f2f7qSU4mENhFzUZGH0VQM947
        p2I9jfi7GG9UmerXVCB0kYgK0a/AZgGh18iCozaOmVyYtox1sue8cWaGDY9AaCK7
        G380Bb3/nss=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDDE6E66C3;
        Fri, 14 Aug 2020 15:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10136E66BF;
        Fri, 14 Aug 2020 15:25:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] SHA-256: Update commit-graph and multi-pack-index formats
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 12:25:47 -0700
In-Reply-To: <pull.703.git.1597428440.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Fri, 14 Aug 2020 18:07:17 +0000")
Message-ID: <xmqqeeo9vxl0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F58A336E-DE63-11EA-B9C7-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As discussed [1], there is some concern around binary file formats requiring
> the context of the repository config in order to infer hash lengths. Two
> formats that were designed with the hash transition in mind (commit-graph
> and multi-pack-index) have bytes available to indicate the hash algorithm
> used. Let's actually update these formats to be more self-contained with the
> two hash algorithms being available.
> ...
> If this is the way we want to go with the formats, then I'll assist
> coordinating these textual and semantic merge conflicts.

I agree that the files should be self-identifying, but have these
changes tested without sha256 hash?
