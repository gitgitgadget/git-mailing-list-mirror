Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC264C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJTPfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJTPfr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 11:35:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A26188AA2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 08:35:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F07001B4C24;
        Thu, 20 Oct 2022 11:35:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6et6jIW2HGPKs+VDPLJvh2jDRRmlef7LmMM/1a
        bC5iA=; b=bFgrADrEXuo9JR7+8gb9YK3jEvVK5fUjn027IDkWZT7JiSlegquWmH
        sxi39OxjsG61AAbAmXRoZrJMQJs07F157OMoxDnWopdEIJNwlTksXxTh37F3yJvL
        jQyYhW52st8VjzMdirWZqXvF3fNDXrskFtnAI3BCb0j6w8c+Q3gKc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E83101B4C23;
        Thu, 20 Oct 2022 11:35:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20F691B4C22;
        Thu, 20 Oct 2022 11:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
References: <xmqq4jvznups.fsf@gitster.g>
        <e70b19de-d990-9844-6a0c-994ceabd9102@iee.email>
Date:   Thu, 20 Oct 2022 08:35:38 -0700
In-Reply-To: <e70b19de-d990-9844-6a0c-994ceabd9102@iee.email> (Philip Oakley's
        message of "Thu, 20 Oct 2022 12:57:45 +0100")
Message-ID: <xmqqr0z2mrsl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D96818AC-508C-11ED-939F-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 20/10/2022 02:34, Junio C Hamano wrote:
>> * po/glossary-around-traversal (2022-07-09) 3 commits
>>  - glossary: add reachability bitmap description
>>  - glossary: add commit graph description
>>  - glossary: add Object DataBase (ODB) abbreviation
>>
>>  The glossary entries for "commit-graph file" and "reachability
>>  bitmap" have been added.
>>
>>  Expecting a reroll.
>>  cf. <dfe0c1ab-33f8-f13e-71ce-1829bb0d2d7f@iee.email>
>>  source: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
>>
> Hi Junio
>
> I'm close to re-submitting.
> Would you want the V2 to be rebased onto v2.38.1, or stay where it was
> dc8c8deaa6 (Prepare for 2.36.2, 2022-06-07).
> It's a clean merge so far.

Thanks.  

I usually would prefer to see the topic not rebased, especially if a
rerolled topic still merges cleanly, and especially when the
original base chosen was an older maintenance track, not a commit
near the then-current tip of 'master'.  Being queued on top of
then-current 'maint' (or older) is an indication that the topic can
be taken as "fixes" to the older maintenance release(s).  I'd hate
to see something that used to be merge-able down to fix issues in
older maintenance tracks suddenly become limited only to future
releases [*].  It also makes it simpler to run "range-diff @{1}..."
and "diff @{1}" (it is essential for the latter to have the same
base) for sanity-checking the result of accepting a new round.

When the original base was not any of the maintenance tracks but was
near the tip of then-current 'master', I still prefer to see the
base kept unless there is a compelling reason to rebase.  There is
one exception to this, though.  When the original is so old, its
base can now be a descendant of some maintenance track, even if it
was near the tip of then-current 'master' when the topic was queued.
Such a topic is unlikely to be a "fix" and the value to keep it
merge-able to older maintenance tracks is much lower.  So for such a
topic, I think a clean reroll on top of the last stable release
would be OK, and may even be preferable.


[Footnote]

 * It is a different matter if I actually merge them down to future
   maintenance releases, but for some distros that care to support
   older maintenance tracks, being able to merge those topics that
   are marked as "(merge X later to maint)" in the RelNotes would
   make their life easier than having to cherry-pick them.
