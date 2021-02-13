Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34073C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 23:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE9164E3D
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 23:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBMXzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 18:55:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57730 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBMXzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 18:55:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F67DBCA4B;
        Sat, 13 Feb 2021 18:55:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0FY8ix+fXq8DlX7ToAWCidKcNUI=; b=lfu0mI
        HawDRL32YKahuOPqHO2+XLpoI/c7uFwbPbXyMjfls0/wUBwQvCpxNQWeY13sRjlg
        EXIGLR5COJWehX9+Hy4g/MtvUgYvF7MR7SyNb7cyvRpmRiysnIK54glEQ/m+Figy
        ivn8M2a+ZolNxyiP2TPr/BNwDKLpGjsUMEc/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IajqQECQpBsbnhrTFyCyhqlzGZHzFODm
        iFQqtHefMdborPaHnmaslpsNsY0HBgW56Xl7EDYh2bEmpllfzY65SnZycO9mJBtG
        cnRafnpjOeZqOrQ/ZBNFRo+zdyxR/3QASDG+shhbK3+lg7dGUaLDt+Umr+QtLMuf
        CdRn5Ui9f/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FE5BBCA4A;
        Sat, 13 Feb 2021 18:55:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A760BCA48;
        Sat, 13 Feb 2021 18:55:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 3/5] diffcore-rename: complete find_basename_matches()
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <dc26881e4ed3447c6efdcd492463be294f99b8c4.1612970140.git.gitgitgadget@gmail.com>
        <xmqqsg60u49i.fsf@gitster.c.googlers.com>
        <CABPp-BF_cj1GEYT75aj9funUk1mYvtM2OvKiNb1JAZzA6E5mgQ@mail.gmail.com>
Date:   Sat, 13 Feb 2021 15:55:04 -0800
In-Reply-To: <CABPp-BF_cj1GEYT75aj9funUk1mYvtM2OvKiNb1JAZzA6E5mgQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 13 Feb 2021 10:34:50 -0800")
Message-ID: <xmqqft1zttev.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5C22530-6E56-11EB-AE5A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I can change that.  I can also simplify it further to
>
>         if (0 <= (dst_index = (strintmap_get(&dests, base)))) {
>
> since dests uses a default value of -1.  That will decrease the number
> of strmap lookups here from 2 to 1.

Which would be a real win, unlike what I said in the message you are
responding to.

>> It feels incompatible with the spirit of these two steps aim for
>> (i.e. only use this optimization on a pair of src/dst with UNIQUE
>> basenames).  For the purpose of "we only handle unique ones", the
>> paths that already have matched should participate in deciding if
>> the files that survived "exact" phase have unique basename among
>> the original inpu?
>
> Yeah, I should have been more careful with my wording.  Stated a
> different way, what confidence can we associate with an exact rename?

Suppose you start with a/Makefile, b/Makefile and c/Makefile and
then they all disappeared while a1/Makefile, b1/Makefile and
c1/Makefile now are in the tree.  The contents a/Makefile used to
have appears without any difference in a1/Makefile, the same for b
and b1, but c/Makefile and c1/Makefile are different.  The c vs c1
pair may worth investigating, so it goes through the "same basename"
phase.

Now, in a slightly different situation, a vs a1 are still identical,
but b vs b1 have only one blank line removal but without any other
change.  It looks odd that such a change has to pessimize c vs c1
optimization opportunity, but an interesting part of the story is
that we can only say "such a change", not "such a miniscule change",
because we have just finished the "exact" phase, and we do not know
how big a difference b vs b1 pair actually had.

That makes me feel that this whole "we must treat unique one that
remains specially" is being incoherent.  If "because we have only
small number of removed and added Makefiles spread across the trees,
first full-matrix matching among them without anything else with
higher bar may be worth an optimization" were the optimization, then
I would understand and support the design to omit those that have
already been matched in the "exact" phase.

But IIRC, limiting this "same basename" phase to unique add/del pair
was sold as a way to make it less likely for the heuristics to make
mistakes, yet the definition of "unique", as shown above, is not all
that solid.  That I find it rather unsatisfactory.

In other words, it is not "what confidence do we have in exact
phase?"  "exact" matching may have found perfect matching pair.  But
the found pair should be happy just between themselves, and should
not have undue effect on how _other_ pairs are compared.  Stopping
the "exact" pair from participating in the "uniqueness" definition
is placing "exact" phase too much weight to affect how other filepairs
are found.

> By the exact same argument, you
> could take this a step further and say that we should calculate the
> basenames of *all* files in the tree, not just add/delete pairs, and
> only match up the ones via basename that are *truly* unique.  After
> all, break detection exists, so perhaps we don't have full confidence
> that files with an unchanged fullname are actually related.

Sorry, but you are not making sense.  These optimizations are done
only when we are not using copies and breaks, no?  What _other_
changes that kept the paths the same, or modified in place, have any
effect on matching added and deleted pairs?
