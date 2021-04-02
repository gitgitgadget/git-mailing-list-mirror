Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAFCC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362FE6100C
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBVBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:01:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53975 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBVBY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:01:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4ED35133C77;
        Fri,  2 Apr 2021 17:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QdL66Ky7u7qP7wFFHmQ6w/dsubc=; b=XRmJSn
        pmpmoVyLfpQn9JpP8bz+CypZShIvPfjQrHZw55UwEy2m9OVJice47E/NnNoCOswL
        cn75DtdPl5jZGHzuFaOwJCnyJydKWDjke78Mz1hplT/hjUb7SSMDEmeIhtwwwzj6
        josi1xEYzIAD2zDGKAsRYzK5+u03YuxF0Htmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MhnhxLNO4fPLRDu8a0Pn69lIBIQ8kiR/
        pJ08SoX5NS0YT56qvFJ0alsCyuO1EQBuN738kGlO57c/LPSnpdH1Q7+o2d3gfbPr
        OveGH3K0v7HaLg/r6DL+xGZTuVvAv4x275kUFth/zxu/4vZqhHLGGVR0wExP6qM7
        XCDZUASM2t8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 480E8133C76;
        Fri,  2 Apr 2021 17:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 639ED133C73;
        Fri,  2 Apr 2021 17:01:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
        <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
        <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet>
        <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com>
Date:   Fri, 02 Apr 2021 14:01:17 -0700
In-Reply-To: <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com> (Phillip Wood's
        message of "Fri, 2 Apr 2021 12:28:43 +0100")
Message-ID: <xmqqa6qg4d0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92831FEE-93F6-11EB-A3B2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think we would save a lot by only syncing the state to disk when we
> stop or run an exec command (the state needs to be synced so exec 
> commands can alter the todo list). In those cases we need to write the
> index and possibly run an external process so writing a couple of
> files is probably insignificant.

The optimization opportunity of this may be a lot smaller than you
would think---you must cater to not just exec but hook scripts that
are run while a new commit is made, which means every step you'd
need to write anyway.

> Where I think we can usefully consolidate is the one-line files which
> store the options rather than state - these are read an written much 
> less frequently so I don't think they have much of a performance hit
> but it would be much nicer to just serialize the options to a single
> file.

Would that break external scripts, hooks, etc.?  I am not sure if we
even have any rough consensus for allowing other people to peek into
the .git/rebase-*/ directories, but I am inclined to say that it
sounds more like a solution looking for a problem than a good idea
to solve some concrete problem.




