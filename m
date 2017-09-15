Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B560120A21
	for <e@80x24.org>; Fri, 15 Sep 2017 05:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdIOFAW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 01:00:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54956 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750797AbdIOFAU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 01:00:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1B9EB4907;
        Fri, 15 Sep 2017 01:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cf9p9mIR7cA4+GOfH14Bl87/haI=; b=PU8lWMq3A6PvHyIABEsI
        KcOSsQ42BS/rKiKzAoOiNSMm0869NNjtuWvwTW9T65S+pXgbsYIRdQIyM/W/gi9E
        P/Z6CtRZ2RjRGDRCBHmJ/mbIDiOQrUfhYzPmiy3rCImT3DWpYm/PXlNvU+iqlZ7N
        +nTWL4hILmuvmWnX1wlbhGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=JMx4+4J9WmEPyHy5UeMOUtc5EuRlLJTeYRC0rGDTMCqO6C
        kmwX3vjaYQyYWHX9gHLwJXneTgMxR+Ss/0acnK9fzzkGORwOJdZA23ZpEnlXPJ1z
        V28Dvtbuehn4q3EcoEEi/LtzhgUJg13YoKYZ22rYL3/1gEUMmVEx/pWxPsn1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7789B4906;
        Fri, 15 Sep 2017 01:00:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 003C1B4905;
        Fri, 15 Sep 2017 01:00:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
        <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com>
        <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
        <xmqqy3piz1j4.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014031012AEC69CED27FADFB76F0@SN1PR21MB0014.namprd21.prod.outlook.com>
Date:   Fri, 15 Sep 2017 14:00:17 +0900
Message-ID: <xmqqh8w4y2se.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C552E430-99D2-11E7-A1BD-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> 1. Does this statement, "I only care about the files in this
> sparse checkout, and do not concern me with anything else", mean
> that git should not change files outside the sparse-checkout whether
> that be in the working directory or in the index?  Or does that only
> apply to the working directory and the index version of files can
> change to whatever git the git command would do without using
> sparse?  For example if I am doing a 'git reset HEAD~1'  should the
> version in the index of files outside the sparse not be changed or
> change to the HEAD~1 version with the skip-worktree bit on?

My understanding of the purpose of "sparse checkout" thing is that
the user still wants to create correct whole-tree commit even the
user does not have the whole-tree checkout.  The object names for
blobs recorded in the index that are meant to be included in the
next commit MUST be the same as those that would be in the index
when the "sparse" feature is not in use.  "reset HEAD~1" should
match the index entries to the tree entries in HEAD~1.  So, the
latter, I would think, among your two alternatives.

IOW, after "git reset HEAD~", if you drop the skip-worktree bit from
all index entries, "git diff --cached HEAD" must say "there is no
changes".

The only difference between the "sparse" and normal would be that,
because the "sparse" user does not intend to change anything outside
the "sparse" area, these paths outside her "sparse" area would not
materialize on the filesystem.  For the next "write-tree" out of the
index to still write the correct tree out, the entries outside her
"sparse" area in the index MUST match the tree of the commit she
started working from.

> 2. How will this work with other git commands like merge, rebase,
> cherry-pick, etc.?  
> 3. What about when there is a merge conflict with a file that is outside
> the sparse checkout?

I would say, rather than forbidding such a merge, it should let her
see and deal with the conflict by dropping the "this is outside the
sparse area, so do not bother materializing it to the filesystem"
bit, but tell her loudly what it did ("I checked out a half-merged
file outside your sparse-checkout area because you'd need it while
resolving the conflict").  By doing things that way, the user can
decide if she wants to go ahead and complete the merge, even if the
conflict is outside the area she is currently interested in, or
postpone the merge and continue working on what she has been working
on inside the narrowed-down area first.

I do not have a strong opinion whether the sparse-checkout
configuration file should be adjusted to match when the command must
tentatively bust the sparse checkout area; I'd imagine it can be
argued either way.

Note that "sparse" is not my itch, and I would not be surprised if
those who designed it may want it to work differently from my
knee-jerk reaction in the previous two paragraphs, and I may even
find such an alternative solution preferable.  

But it is highly unlikely for any sensible solution would violate
the basic premise, i.e. "the indexed contents will stay the same as
the case without any 'sparse', so the next write-tree will do the
right thing".
