Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2DC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 00:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiGPABY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPABW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 20:01:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D583095B3B
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 17:01:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E94F01AB568;
        Fri, 15 Jul 2022 20:01:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7fJFfl1sAq2IGcAjBxHREaERrsu1JHreYaopzG
        7XYeY=; b=BH39JC4J2VV7yof7DylDLNBsmixhITLRZwzhydgYy/2Gr8GJcIFrzQ
        9MA+BRjKNWWp++cb6zNVFKdqR5pykChMdHiY6UNxZnXKaqOh5SPRS4PTyECvoGPY
        LwaIK213NcqcvrC77Iwa6vwr4+rkGhlxnGv2cLaxm3z8ioQgUOJ5U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E18C61AB567;
        Fri, 15 Jul 2022 20:01:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F7E61AB566;
        Fri, 15 Jul 2022 20:01:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        peff@peff.net, ps@pks.im, wfc@wfchandler.org
Subject: Re: [PATCH 1/3] t5318: demonstrate commit-graph generation v2
 corruption
References: <cover.1657667404.git.me@ttaylorr.com>
        <0a49c86037bac200bb23e1abf9f67363e99c4b7c.1657667404.git.me@ttaylorr.com>
        <10d12d6f-6d86-743f-518b-eb45871509a7@github.com>
        <YtHkmb4Qwvo9n00A@nand.local>
Date:   Fri, 15 Jul 2022 17:01:16 -0700
In-Reply-To: <YtHkmb4Qwvo9n00A@nand.local> (Taylor Blau's message of "Fri, 15
        Jul 2022 18:05:13 -0400")
Message-ID: <xmqqo7xqx6wj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A776242-049A-11ED-958C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jul 14, 2022 at 11:15:42PM -0400, Derrick Stolee wrote:
>> > +		# This commit will have a date at two seconds past the Epoch,
>> > +		# and a (v1) generation number of 1, since it is a root commit.
>> > +		#
>> > +		# The offset will then be computed as 2-1, which will underflow
>>
>> I have verified that your test works, but this explanation is confusing me.
>> "2 - 1" is 1, which does not underflow. There must be something else going
>> on.
>>
>> Looking ahead, you describe the situation correctly in Patch 3 to show that
>> we take "generation - date", so you really just need s/2-1/1-2/ here.
>
> Yes, absolutely. Thanks for catching it.
>
> Junio: you may want to s/2-1/1-2 in this patch's message, or I can send
> you a replacement or reroll, whatever is easier.

I've already done "rebase -i" to do so.

But for future reference, the easiest for me is if the author said,
after saying "Thanks for catching it", "Will reroll after waiting
for a bit to see if there are other comments".  That way, I only
have to edit the latest draft of "What's cooking" report to mark the
topic to be expecting a reroll (which will prevent me from merging
the topic down to 'next' prematurely by mistake) and forget about
it, until I actually see the updated set of patches.  It would be
even easier if the updated set of patches said which topic it is
meant to replace.  That way, I can trust other reviewers about the
details of the change between iterations and play a patch monkey,
when I am short of time.

It is more work to (1) look at the message you are responding to and
understand what "2 minus 1" vs "1 minus 2" being discussed is about,
and (2) go one level up in the thread to find the line in the patch
that was being discussed, and (3) run "rebase -i" and change "pick"
to "edit" and (4) find the line in the file that was affected by the
hunk in question and edit it.  The worst part of it is I'd either
have to do it right away before I forget, or mark the message unread
so that I can revisit it when I have enough time.

Either way is fine, but a straight resend with two notices (one that
says "will reroll", the other that says "this replaces topic X") is
the easiest to handle for me.

Thanks.

