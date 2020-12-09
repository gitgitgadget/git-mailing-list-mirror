Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97190C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CA823B23
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgLIGlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:41:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63271 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgLIGlC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:41:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6E1E8206C;
        Wed,  9 Dec 2020 01:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m3Yvzcna9f6+g9LLAscr2tOB0S8=; b=TxUsIQ
        5dseSoXqOxqz3nXWmmvAMsF/bcIsken0VM8+Xujhq7DyRIHTvtX8Bji/0rO5N3hW
        7oKFTTMJ1WHKoKXHoj9RR7vIY2GFnjWDKIz2VBuB1326mBALIJ8b8Jhe+5b5JqtK
        hLZ0Pbv5wUf7OIyvsalL93jfT5HNxAI3+4lVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sGOskl5MRMWJJ3Bg8DM7CF12AonAyNSs
        q95W0pEtltvOy8o9X7ipvieW+czQ+7fhNFJAm5ryxJ3aRhiOZRGOegkPexcH27Nb
        SjRuiyiTVva9M/eJlbdC8tRcDuIEDv+aQqFyYBFUC7bDEte7ONaCIldYXAfSJaL9
        332bf/lNcuA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 937BE8206A;
        Wed,  9 Dec 2020 01:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7815582069;
        Wed,  9 Dec 2020 01:40:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        <xmqqtusv362t.fsf@gitster.c.googlers.com>
Date:   Tue, 08 Dec 2020 22:40:05 -0800
In-Reply-To: <xmqqtusv362t.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 08 Dec 2020 21:24:10 -0800")
Message-ID: <xmqqpn3j32ka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FF72D34-39E9-11EB-B546-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

A clarification and a correction.

> I suspect that the real reason why "-m" does not imply "-p" was
> merely a historical implementation detail...

Now I remember better.  The reason was pure oversight.

In the beginning, there was no patch output for merges.  As most
merges just resolve cleanly, and back then the first-parent chains
were treated as much much less special than we treat them today,
"git log -p" showed only patches for single-parent commits and
everybody was happy.  It could have been a possible alternative
design to show first-parent diff for a merge instead of showing no
patch, but because the traversal went to side branches, the changes
made by the merge to the mainline as a single big patch would have
been redundant---we would be seeing individual patches from the side
branch anyway.

Then later we introduced "-m -p"; since the first-parent chain was
not considered all that special, we treated each parent equally.
Nobody, not even Linus and I, thought it was useful by itself even
back then, but we didn't have anything better.

I think it was Paul Mackerras's "gitk" that invented the concept of
combined merges.  We liked it quite a lot, and added "-c" and "--cc"
soon after that, to the core git and kept polishing, until "gitk"
stopped combining the patches with each parent in tcl/tk script and
instead started telling "git" to show with "--cc".

By the time the change to make "--cc" imply "-p" was introduced, it
was pretty much given that "-m -p" was useful to anybody, unless you
are consuming these individual patches in a script or something like
that.  So simply I didn't even think of making "-m" imply "-p".  It
would be logical to make it so, but it would not add much practical
value, I would have to say.

> If I were to decide now with hindsight, perhaps I'd make "--cc" and
> "-m" imply "-p" only for merge commits, and the user can explicitly
> give "--cc -p" and "-m -p" to ask patches for single-parent commits
> to be shown as well.

After "now with hindsight", I need to add "and without having to
worry about backward compatibility issues" here.  IOW, the above is
not my recommendation.  It would be the other way around: "--cc"
implies "-p" for both merges and non-merges, "-m" implies "-p" for
both merges and non-merges.  It is acceptable to add a new option
"--no-patch-for-non-merge" so that the user can ask to see only the
combined diff for merges and no patches for individual commits.

Both "--no-patch-for-non-merge" option, and making "-m" imply "-p"
are very low priority from my point of view, though, since our users
(including me) lived without the former and have been happily using
"log --cc" for a long time, and we've written off the latter as
pretty much useless combination unless you are a script.
