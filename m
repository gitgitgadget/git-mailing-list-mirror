Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A998C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AC261433
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhEKXmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:42:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53542 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhEKXmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 19:42:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D8CC4E96;
        Tue, 11 May 2021 19:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DBmclSUl3Q9boN96hRWYq+jM2Po14vQ2TTsb4u
        4dFmE=; b=U+bO+A5GPhiSWM2gAdDh/yJCUzmdRCcjAvRFcSzqhiJUVY7AFD/nIl
        tL716XYU+OR5hC86zg72DjmgaGyLP5SJQPZnTJxNM13WI6LnGkgkyqKY3t/CTweV
        gHBYqZsVcaUbnwHCu9JK7IDwFLtdy2jEuLAhrlrb5Zu07PWKmKArA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B936C4E95;
        Tue, 11 May 2021 19:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8722C4E94;
        Tue, 11 May 2021 19:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
        <xmqqtun9knmy.fsf@gitster.g> <87h7j9ne7j.fsf@osv.gnss.ru>
Date:   Wed, 12 May 2021 08:40:57 +0900
In-Reply-To: <87h7j9ne7j.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        12 May 2021 00:38:24 +0300")
Message-ID: <xmqqcztwj0ty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55D7731C-B2B2-11EB-9538-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> But I do think that it is an utterly misleading option to show
>> merges in general.  When "log" is used with the "--first-parent"
>> traversal, "compare with the first parent to show everything the
>> side branch did" is an acceptable alternative, but even there, it is
>> far less suitable than the "remerge" or "cc", I would think, as the
>> default format.
>
> What I still fail to see is why somebody wants to mix traversal rules
> with representation of merge commits, sorry.

It is not about "mixing".

What I meant was that diff between the pre-merge state and the merge
result as two-tree comparison may be an acceptable view of "what did
this _merge_ contribute to the history" and that is in line is what
the first-parent traversal is trying to show the reader of the
history, which is "this merge contributed to the history, and then
this other merge contributed to the history, ...".  It also may make
sense when one is inspecting a merge in isolation, i.e. "git show M".

When one is viewing individual commits without omitting commits on
the side branch, however, showing "what did the side branch as a
whole contributed to the history at this merge" makes little sense
and is misleading.  Such a patch given for a merge mostly overlaps
with what the reader sees immediately after seeing the merge
(i.e. the commits on the side branch, with their own patches, each
of which has already been shown in the first-parent comparison of
the merge).  In other words, "git log --no-first-parent" is about
contribution of each single commit (whether it is a merge or a
non-merge) makes, and the --diff-merges=1 presentation is not in
line with that worldview, in which the contribution to the history
the merge alone makes is what --cc or remerge tries to show,
i.e. "what did the merge do, on top of what the commits on the side
branch contributed to the history?"

So, it is not like two unrelated things are mixed together.  It is
more like showing the result of a merge as a diff relative to its
first-parent is tied to and consistent with the viewpoint of history
as single strand of pearls that is a series of merges into the
first-parent chain, but not with non-first-parent presentation of
the history.
