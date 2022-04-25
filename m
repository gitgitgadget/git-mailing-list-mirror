Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98021C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243975AbiDYR3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbiDYR2j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:28:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDB1FCDC
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:25:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC41F11A84C;
        Mon, 25 Apr 2022 13:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WCfH62/HN8nz+qPrie4GhV8mkAWzx2Zc/VnJph
        4y5H4=; b=bE9PGDQrzP74gHCi6KQ+GAEvnAMjasboGo+rDLqruGeH/lICM1foex
        SyYgf4QazcZX2Vn2EGOYE+Kk4LStaURuATbLoOHxpq54/1RfHj32CHJUbMhlk9we
        nqov4tEhNIZM1rruwaIaH1fou1nY5Tut9Q561V4KsnilmA2uSx8DM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D207F11A84B;
        Mon, 25 Apr 2022 13:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3343811A84A;
        Mon, 25 Apr 2022 13:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     FanJun Kong <bh1scw@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: help for git format-patch lost diffstat
References: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
        <CAPig+cQsGZ5Uw13vr5r_SZ9APZwovtxSW5N4QGpieHRx1_6zRg@mail.gmail.com>
Date:   Mon, 25 Apr 2022 10:25:22 -0700
In-Reply-To: <CAPig+cQsGZ5Uw13vr5r_SZ9APZwovtxSW5N4QGpieHRx1_6zRg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 25 Apr 2022 04:09:00 -0400")
Message-ID: <xmqqo80pvzwd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B04B657A-C4BC-11EC-AF9D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The problem is that when you format both patches of a two-commit
> repository, `origin` is NULL because there is no commit preceding the
> initial commit; the initial commit is the root of the history. Thus,
> there is nothing prior to the first patch against which to create a
> diffstat.
>
> I have not investigated, but it may be possible to teach
> show_diffstat() how to generate a diffstat against the "emptiness"
> preceding the initial commit, but nobody has done so yet. Perhaps this
> would be a good project for someone interested in contributing to the
> project (or perhaps not -- as mentioned, I haven't investigated how
> hard this would be).

Yeah, it is like the "--root" option to allow us stop treating a
root commit as any special and instead consider it is adding
everything it has relative to the empty tree, which sounds like a
quite sensible thing to do.

Thanks.
