Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD25C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 18:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbiBQSmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 13:42:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244496AbiBQSmT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 13:42:19 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A9DFBE
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 10:42:04 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C68210F623;
        Thu, 17 Feb 2022 13:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDLBR/y2oTQbHcm/dHXcdjHLBC4M6ZOh/9/VAG
        cYRPM=; b=do8FCL7azn0trn4g2Y25fvBvh0ecWOj80eTlrlJ+nrU2zz1WZtZ9JJ
        OSJZ38ZL2dInX+0ZoCsCN/eBnNEL+UbVgeb3RenSU1WMw1KOhOcygK7/G+pnmoOM
        r3kdQjDwFoQ9lYpxyfIc8wAp8aeGO57EAgk8Zic/VWNLXUJjNYtIM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2125C10F622;
        Thu, 17 Feb 2022 13:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3057410F61D;
        Thu, 17 Feb 2022 13:42:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Erlend Aasland <Erlend-A@innova.no>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
        <xmqqbkz6vjkj.fsf@gitster.g>
        <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
        <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
        <CAPig+cR0Ks2bnTRqs3uF4M+3q+n9X6pApBQ9HQTUq=zK5TpuXQ@mail.gmail.com>
Date:   Thu, 17 Feb 2022 10:41:59 -0800
In-Reply-To: <CAPig+cR0Ks2bnTRqs3uF4M+3q+n9X6pApBQ9HQTUq=zK5TpuXQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 17 Feb 2022 12:13:10 -0500")
Message-ID: <xmqqiltd9vyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BD96922-9021-11EC-9FB6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Perhaps. Perhaps not. I may be misreading Junio's responses in this
> thread, but it didn't seem like he was necessarily opposed to the
> change.

I do not care too much about this issue to expend my political
capital on enforcing my preference ;-)

FWIW, my preference in an ideal world would be to limit "-" as a
short-hand to go back to previous (i.e. "checkout -"), which can be
justified with similarity to "cd -", but do not add any more use.
If we could, I would even deprecate "merge -", "rebase -", etc. that
can not be justified with similarity to "cd -", but I think we came
too far for that.

"-" cannot be used as a universal "the branch we last 'git checkout'
out of" notation because some commands and people expect "-" to be
something else, like "read from the standard input".  The only two
reasons this pops up from time to time is because "checkout -"
exists and because "@{-N}" notation, which is accepted everywhere
uniformly and does not have problems "-" has, is not very well
known.

> A documentation update as in [1] would be a good idea, though,
> if resubmitted.

Yeah, [1] talked about both "@{-1}" and "-", but limiting it to the
former may make sense.  It feels a bit odd that we single out "git
branch" and describe "@{-1}" there, when the notation is universally
available, though.

    $ git grep -l '@{-' -- Documentation/ :\!Documentation/\*/\*

shows hits only in check-ref-format, checkout, switch, and worktree,
but the mention in "revisions.txt" is included in all commands in
the "log" family of commands.  If we add one to "branch", we should
at least teach "@{-1}" to the documentation of merge, rebase, and
revert.  The hits we see here

    $ git grep -l -B1 '"@{-' \*.c
    builtin/checkout.c
    builtin/merge.c
    builtin/rebase.c
    builtin/revert.c
    builtin/worktree.c

all are about replacing "-" the user typed with "@{-1}".

Continuing the "thinking aloud" a bit, I _think_ this tells us these
things:

 * @{-1} has way too many letters to type to be liked by users, who
   won't learn or remember what they do not appreciate (and do not
   blame them---it is a bad notation).

 * @{-<n>} may have been a generalized way that satisfied geeky mind
   while being implemented, but the users only need the "last one"
   and no such generalization.

If it is too late for a more easy-to-type-and-pleasant-to-eyes
notation, perhaps "@-", that does not have downsides of "-" or
"@{-1}", I have to wonder.

Thanks.

