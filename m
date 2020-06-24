Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC89AC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 22:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEAD2076E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 22:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b1SLPQig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbgFXWiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:38:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57693 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbgFXWiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 18:38:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8E8F671D2;
        Wed, 24 Jun 2020 18:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VPATZM+Aa6lVFhdl0K84Zjied+w=; b=b1SLPQ
        igee46g0uyNzC/xCTNkPIJzE03FQsHVfFGu6xyfak2LvWy6rkQ336OiRZ+MsYaN9
        KwsqMPJsP7B1YEmMqWqK/YYjL1SvL2V3jZZzMOfAswjKzmjIKhn+etrdc96Xr7F8
        f4cdkDj6ixqPdF8VWZwDWyR4XSNsViNDDhugM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EyLUjPb3QemdcDNYAQlpHnR5PtCWQlKD
        lSQTs4gVzoZoY+lythPQMeISWew2BYdgtm1sEe3p6W2dQDxBSs90xmZi6tJK0b88
        HO+YJ6Nx5obGe8nxGbku6o4LwR+MPTgI8clLVo5SUp/1/GOfwi3w+MhDw2Or2FRY
        clloIbUBVtA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFC53671D1;
        Wed, 24 Jun 2020 18:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C295671D0;
        Wed, 24 Jun 2020 18:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
        <871rm6x86y.fsf@osv.gnss.ru>
        <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
        <xmqqk0zxbe6f.fsf@gitster.c.googlers.com> <87k0zw1gu9.fsf@osv.gnss.ru>
Date:   Wed, 24 Jun 2020 15:38:46 -0700
In-Reply-To: <87k0zw1gu9.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        24 Jun 2020 21:03:42 +0300")
Message-ID: <xmqqk0zw5bt5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 779BB72C-B66B-11EA-8F77-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> To clarify, could you please tell if plain
>
>    git merge -s ours
>
> is a "partial merge" from your point of view?

It is not even "partial".

The merge strategy "-s ours" is a way to cauterize a side branch as
dead-end, declaring that everything that has ever been done on that
side branch up to the point of the merge is not interesting and we'd
never want to look at anything that builds on it.

It has its uses, though.  After doing so, "git log --all ^mainline"
or "git branch --not-merged release" would not show such a
cauterized branch; it is a good way to "hide" the branch that you
deem a dead-end when you cannot remove it.  But of course you do not
want to ever build on such a side branch after doing so.

> If you think it is not, then what about:
>
>   git merge -X ours

It is not even a sensible merge.  It takes their changes where we
didn't touch, but it takes our change without even looking at what
they did when the changes overlap.  It's like saying

	let's take as much automerge results as possible to salvage
	their changes where our work does not overlap with what they
	did on their side branch, but in places that textually
	conflict, I would not bother trying to understand what they
	wanted to do well enough to be able to reimplement it for
	them within the context of the current code we updated to.

It is better than letting monkeys type randomly and claim that they
resolved conflicts, but not by a large margin ;-)

See also https://lore.kernel.org/git/7vr69r8sqk.fsf@gitster.siamese.dyndns.org/
that is more than 10 years old.

Imagine you have two (for simplicity) areas of interest, each is
worked by a different team, A and B, whose work are in directories
dir-A and dir-B of the project.  The teams work on their own topic
branches and from time to time merge to the "development" branch for
integration testing.  Time flows from left to right.


    ---A---A---A---A---A	team A
                \       \
      ---X---X---X---X---X	integration testing
            /       /
    ---B---B---B---B		team B

After a while, team A may be tempted to say "we are done, so let's
merge our work to the release branch", but the work product of team
B may be far from ready.

If teams have been keeping good branch hygiene, such a merge to
release branch may be done by merging the rightmost commit on A
branch directly to the release branch and there is no need for a
"partial merge that merges only dir-A while ignoring dir-B".  But if
we start supporting such a feature, it becomes tempting to use such
a "(mis)feature" to merge the rightmost commit on the integration
branch X to the release branch.  Some may find it even necessary
because A's branch may contain backmerges from the integration
testing branch, hence contaminated by unfinished work by team B.

The resulting tree of such a partial merge from integration testing
branch may be the same as a proper "merge of topic branch A into
release" for this "first" merge by team A, but the consequence it
leaves for team B would be nasty.  After building a bit more on what
they had on the branch B, it may become ready to release their part,
but because of the partial merge that declared that team B's effort
on dir-B before the point of the first merge is worthless, the
release branch, even though it would already have the four commits
labelled as B in the picture contained, has none of the actual
changes reflected in its tree.  The result would be like cherry
picking only recent work on team B's branch, not the whole thing.

And that is why such a "pathspec limited" merge is a way to
disaster that encourages a bad workflow.

Thanks.
