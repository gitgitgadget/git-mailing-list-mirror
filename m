Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3B3C433E0
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD90208E4
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t07LBr10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgGTS20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:28:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52038 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTS20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 14:28:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D36DF632FE;
        Mon, 20 Jul 2020 14:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uuWupe6edQ+WdQrzDal28lbcki8=; b=t07LBr
        10J42Fwbc8YdiKJNLWBFRwLayBPNRjk7ijaFpeskk7M8AXv4S0YDDU0Y9zukqhiA
        4+aOxgC5etJtM7Rf4yytlgN9kwVcK6O8dE1LP/K6pPRDCW1PkTd4CckzE0neOk8m
        nwJwCyzZ1X3Jx951jyuIVTz1cntd12JGFSaho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FrJVRCb+kA/b2VL0VhaooR0giVCf9Efy
        +iQ0HyLWthieukr2O5LIGwThRPJ/UI5HM6tNYV/xD7L2VxUE0n4OhM+3xZIksxvl
        mF6WWAtMCr5qvs1a5t2NJ7AmniMpbWw4cVi5pcsVgyPf/uqE/AyNDPTWdVCglKvJ
        71M+POve2BI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA8C0632FC;
        Mon, 20 Jul 2020 14:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F735632FA;
        Mon, 20 Jul 2020 14:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2] git-mv: improve error message for conflicted file
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
        <pull.678.v2.git.1595225873014.gitgitgadget@gmail.com>
Date:   Mon, 20 Jul 2020 11:28:20 -0700
In-Reply-To: <pull.678.v2.git.1595225873014.gitgitgadget@gmail.com> (Chris
        Torek via GitGitGadget's message of "Mon, 20 Jul 2020 06:17:52 +0000")
Message-ID: <xmqqh7u29h2z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA3345D6-CAB6-11EA-AFD7-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     I put in the shortened "conflicted" here but did not shorten the
>     existing "not under version control" message (to minimize the visible
>     and translations-required changes).

It does not matter all that much but the message in your original
for the new case looked better and worse at the same time ;-)

"not under version control" is a statement of fact that does not
hint what the user may want to do with that information.  Your
original for the new case gave that hint (i.e. "must resolve first")
but the new "the path is unmerged" (I think 'unmerged' is a more
proper term for this than 'conflicted'; see gitglossary[7]) stops at
stating fact without giving further hint,and in that sense the
messages are consistent with each other.

We could shoot for consistency in the opposite direction, by making
"not under version control" could instead say "must add first".  But
that leads to a fruitless comparison between "'git add' then 'git
mv'" and "plain 'mv' then 'git add'".  For "git mv", "must resolve
first" may be the only sane option right now, so it probably is OK.

So, after having thought the above through, I tend to (slightly)
prefer to stop at stating fact, perhaps "the path is unmerged" or
something to match "not under version control".

>     I like the idea of renaming all stages and keeping them at their current
>     stages, but that's too much for this patch.

I totally agree, and I am not 100% convinced that the "rename all at
their current stage" gives a better end-user experience.  For one
thing, I suspect that it would still have to fail depending on how
the destination path and paths that conflict with it are populated
in the index, and that may make even harder-to-explain error case.

>     I'll be traveling next week and not sure if I will get to any followups
>     for a while.

That is perfectly fine.  We are in pre-release freeze and this patch
won't go anywhere until the end of the month.

Thanks for contributing, and safe travels.
