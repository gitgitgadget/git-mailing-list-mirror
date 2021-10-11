Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFC3C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DF860EBB
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhJKQSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:18:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53622 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhJKQSD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:18:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A00BF85F0;
        Mon, 11 Oct 2021 12:16:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JhRm0N4dt8qFivQtRVfj47UxlKvPvGHhkO8Skk
        a8Zbc=; b=GuYYzwu/8o7SiEpP9xxNpz3sNTekfbi3hskpRu9GDdvWfkmAAk9dZo
        PQWEgEdvL+2MmzPb3/E7+xkp5y1eJ/bBDSo/E0Jm5C2YOPJEVtCGkfckZy4z1tK2
        XurCAgRFk4FjXX6vr3wtyw940xMvSLHkGa6n6OQKDKvPxNmOnZFik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30C34F85EF;
        Mon, 11 Oct 2021 12:16:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 967B0F85EE;
        Mon, 11 Oct 2021 12:16:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
        <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
        <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
        <xmqq1r4vl65w.fsf@gitster.g>
        <47d4c810-0b56-45b0-944c-72c4d047f9b6@gmail.com>
        <xmqqlf30edvf.fsf@gitster.g>
        <4a002488-09ba-efed-ac70-c0ec16d7dbe2@github.com>
Date:   Mon, 11 Oct 2021 09:16:00 -0700
In-Reply-To: <4a002488-09ba-efed-ac70-c0ec16d7dbe2@github.com> (Victoria Dye's
        message of "Mon, 11 Oct 2021 11:55:00 -0400")
Message-ID: <xmqqh7dnczb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 876C991A-2AAE-11EC-A0A6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> After some basic performance testing of `git reset [--hard]`, it's not clear
> whether `cache_tree_update` is definitively faster or slower than
> `prime_cache_tree`; more conclusive results would indicate which of the two
> could be skipped. I'd like to defer this to a future patch (tracking it with
> an internal issue so I don't forget) where I can perform a more thorough
> analysis across all of the commands currently using `prime_cache_tree` and
> update its usage accordingly.

Yup.  That sounds sensible.  Concentrating on correctness first is a
good direction to go.
