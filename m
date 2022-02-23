Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ACC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 20:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiBWUHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiBWUHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 15:07:49 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3B4C423
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:07:21 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4169E102758;
        Wed, 23 Feb 2022 15:07:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/lOXSuxYXkvrtwW2QL2mnhXFoJldbT9kVKcgAi
        bZ17o=; b=TshNpvTD8SYWmTkYOTZXurQcdZD2qtj3E/8G+5zgDHrgzF3QeA2Cuv
        DKjwRqFr+2zdMu4J4nVSo0uYsyWRSHbVGOvN5vL5iTvK1GD6zrfeyazZRNAevip4
        wfkyWS/CysqWdOAYHsiu5wId3nT3c2uB+AuD4VH2Cr3cc+DRxqQCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 360E5102757;
        Wed, 23 Feb 2022 15:07:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99B54102756;
        Wed, 23 Feb 2022 15:07:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
        <xmqqy22tx8t1.fsf@gitster.g>
        <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
        <xmqqh79hvsgn.fsf@gitster.g>
        <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
        <xmqqee3wt5g3.fsf@gitster.g>
        <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
Date:   Wed, 23 Feb 2022 12:07:18 -0800
In-Reply-To: <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 22 Feb 2022 08:26:41 -0800")
Message-ID: <xmqqczjduz2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34899C8E-94E4-11EC-A6ED-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The objection you are arguing against is not my position.  In fact,
> I'm not even objecting to having a single-step cherry-pick, I'm
> objecting to providing it _now_, which I thought would have been clear
> from the portion of my email you snipped ("...I'm happy to add [a
> single step cherry-pick primitive] along with the tool I submit
> later...").

The entry point into the in-core merge machinery of ort already
knows how to accept externally defined merge-base(s) to bypass the
"caller didn't give us the merge base, so let's figure them out by
using the two heads being merged" logic, so it just felt backwards
*not* to have a vanilla three-way merge that can take three trees
and be used for merge, cherry-pick or revert as the single primitive
in the very beginning before we talk about multi-step operations.

So, I guess I am still not getting where the "I'm happy to _add_"
part comes from.  If we start with a primitive (internally callable
from C) "here are three trees O A B, do the three-way merge", then
there is nothing to "add" at all to expose a single-step
cherry-pick.  In fact, to the users of merge-tree, the result does
not have to have any fixed meaning.  If they pass common ancestors
as the merge bases as Os and the current HEAD and the other branch
as A and B, they get a merge.  If they pass the commit to be picked
as B, current HEAD as A and B's parent as O, they get a cherry-pick.

Perhaps starting from "You are allowed to give me two commits A B,
and I do not let you specify the commit O to use as a common
'ancestor'" is the root cause of making this thing feel backwards.
I agree with the goal of having an all-incore machinery that can do
a merge.  I just do not see the reason why you have to build it in a
way that cannot be reused for other two directions of merge-y
operations.

