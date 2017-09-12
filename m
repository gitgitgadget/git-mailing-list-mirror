Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F777209B8
	for <e@80x24.org>; Tue, 12 Sep 2017 03:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdILD4g (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 23:56:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58570 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751022AbdILD4f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 23:56:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 964ED8ED93;
        Mon, 11 Sep 2017 23:56:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k6iU2pIpyNIf/TxV+HKO4JxtyJo=; b=txZKko
        /Q08VhufpDDeOkaDpNXIM7fK09BmmGJiSpzLikI6zqx+sS5uHI/60ta7AbFFBCH+
        lFmnmghS08gMWFo9NcM5VSyWMZZ7bUG44jbziSUhOZIPSNFXoqPoS2+BFczjm8X8
        HRocmorhxDji1fG1hp/vBPC5+7unSqflx5tP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q12Tmoyu6zSYYbq4whf/X5pkXurGbcVx
        Y3Jy0Yxs4IGzUH0Zcl96845ACdx5DUtFraah1Emd8XANil0ukf4QWWAs4bROk9VL
        uJ8hO6wPI0+ZZcX89Hdt4/TxHDGNJtBITbolzwImX0nzRxj7EEMhxuwNR0/d0+GA
        aiDUA/a3w0g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D9918ED92;
        Mon, 11 Sep 2017 23:56:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E14668ED90;
        Mon, 11 Sep 2017 23:56:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kevin Willford <kewillf@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
Date:   Tue, 12 Sep 2017 12:56:32 +0900
In-Reply-To: <alpine.DEB.2.21.1.1709111259430.4132@virtualbox> (Johannes
        Schindelin's message of "Mon, 11 Sep 2017 13:15:36 +0200 (CEST)")
Message-ID: <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E1F5566-976E-11E7-984A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Stepping back a bit, I am not sure if it is sane or even valid for the
>> end-user to modify paths outside sparse-checkout area, but that is
>> probably a separate tangent.
>
> That is not at all the scenario that Kevin fixed.

I know, but in this tangent I was reacting to this part of Kevin's
message

>>	create $path
>>	git add $path
>>	git commit
>>	git checkout // where $path is not in the sparse-checkout
>>	git reset HEAD~1

to which I was responding to.

> ...
> Yet without Kevin's fix, `git status` would report that the user *deleted
> files outside the sparse checkout*.
> ...
> That is such an obvious bug, and Kevin's fix is such an obvious
> improvement over the current upstream Git version, that I would think the
> only thing worth discussing is whether the patch goes about it in a way of
> which you approve.

When reviewing any topic, I'd ask three (or four) questions to
myself:

 * Are we solving a right problem?  Is the problem addressed valid?
 * Are we solving it with a right approach?
 * Does the patch implement the approach correctly?

(the fourth is s/correct/efficient/ of the third, which is optional).

and any "no" to an earlier question will make it a moot point to ask
further questions.

Let's imagine a path P that is outside the sparse checkout area.
And we check out a commit that has P.  P would still be recorded in
the index but it would not materialize in the working tree.  "git
status" and friends are asked not to treat this as "locally removed",
to prevent "commit -a" from recording a removal, of course.

Now, let's further imagine that you have a checkout of the same
project but at a commit that does not have P.  Then you reset to
another commit that does have P.  My understanding of what Kevin's
first test wants to demonstrate is that the index is populated with
P (because you did reset to a commit with that path) but it does not
materialize in the working tree (perhaps because that is outside the
sparse checkout area?), yet there is something missing compared to
the earlier case where "git status" and friends are asked not to
treat P as "locally removed".  They instead show P as locally removed,
and "commit -a" would record a removal---that is indeed a problem.

Am I reading the problem description correctly so far?  If so, then
my answer to my first question (are we solving a right problem?) is
yes.

My response to an earlier version of the patch was written while
assuming (read: without thinking deeply but trusting that the
contributor thought things through) that the first two answers were
"yes".  If the right approach were to check out what is in the index
to silence "git status" and friends by matching the index and the
working tree, then the implementation in the patch (i.e. setting up
some cache entry and calling checkout_entry() to make it materialize
in the working tree) looked correct, and that is what I meant by
"Other than that, the patch looks quite cleanly done and well
explained."

But this time, I am trying to see if the approach is good.  I am not
so sure if the approach taken by this patch is so obviously good as
you seem to think.  A logical consequence of the approach "git
status thinks that P appears in the index and missing in the working
tree is a local removal, so let's squelch it by creating the file in
the working tree" is that we will end up fully populating the
working tree with paths that are clearly outside the area the user
designated as the sparse checkout area---surely that may squelch
"status", but to me, it looks like it is breaking what the user
wanted to achieve with "sparse checkout" in the first place.

When we make a sparse checkout that places P outside the checked-out
area, with P in the index and not in the working tree, what asks
"git status" and friends not to treat P as "locally removed"?
Shouldn't "reset HEAD~1" that resurrected P that was missing in the
commit in the state before you did the "reset" be doing the same
(e.g. flipping the bit in the index for path P that says "not having
this in the working tree is not a removal---it is deliberately not
checked out")?  If that is the right approach to solve the issue
(which we established is a right problem to solve already), and the
approach that the patch wants to take is quite the opposite of it,
then my answer to the second question (are we solving the problem
with the right approach?) is no.  And at that point, it is moot to
ask if the code correctly and/or efficiently implements that wrong
solution, isn't it?
