Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B0FC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9007D206D5
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pLv/qyjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgGOOuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:50:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56850 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGOOuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 10:50:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE5A3DE13B;
        Wed, 15 Jul 2020 10:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A+BIlXzUuvqRRXywyu56LzvpoFE=; b=pLv/qy
        jYoPHrJe39JhQIKt0FD+nwcBnr1bzluy4/1CfL0X7Lw7l8kC2i2KOYeky69vTG/T
        roKHN/z4XtRw2NiCdzWN9MkvSNOeO3ueO69XDqCI5quJ12SZMLyMy60Vygktu6gh
        S55MMH+h+8deUOysUuvXrtNjs/RCCJXzpMxn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qvLYXEtFi+v55MPIcMpqfYsvObHGHDs+
        7T6wmB2K96jodnWmxTUpH7HeC2hg2hKG7nO8jRxaPElsmjMll3V4dxixqA+JYchd
        SZXRi6Q5sdglk59SE2KJ6+cWDwAlecAoAVu0kCmeOoX5KrTaBUfi/F49qT05mX/d
        pG/s0rt1KW8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D59AADE13A;
        Wed, 15 Jul 2020 10:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1859BDE139;
        Wed, 15 Jul 2020 10:50:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/4] deterministic commit timestamps in tests
References: <20200709203336.GA2748777@coredump.intra.peff.net>
        <xmqqa707rpuu.fsf@gitster.c.googlers.com>
        <20200714123142.GA2587001@coredump.intra.peff.net>
        <20200714123334.GB2587001@coredump.intra.peff.net>
        <20200714214728.GA21660@dcvr>
        <20200715074250.GB3249056@coredump.intra.peff.net>
Date:   Wed, 15 Jul 2020 07:50:25 -0700
In-Reply-To: <20200715074250.GB3249056@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 15 Jul 2020 03:42:50 -0400")
Message-ID: <xmqqa700ltn2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 854990A2-C6AA-11EA-AACD-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's a revised patch (I see Junio already picked up the other fix; if
> that ends up being merged instead, that's not the end of the world).
>
> (compared to the earlier version, you can skip everything in the commit
> message before "One fix would be...").

Heh, it already is in 'next' and I do not think it is worth
rewinding and rebuilding to cause downstream folks an additional
trouble.  I however think this updated solution is nicer and do not
mind building on top i.e. "while an earlier change did unbreak the
svn tests, relying on the current timestamps is not nice and here is
an update".

Having said that, I think it is more urgent to address the "ouch, we
made it clera that repos with extensions.worktreeconfig set without
marking them as repoformat v1 are broken and without giving users
enough hints to recover" issue discussed elsewhere before -rc1 (and
for that reason I do not think I can tag -rc1 today), so I'd
backburner it.  This topic won't merge down from 'next' until final
anyway.

Thanks.


> -- >8 --
> Subject: [PATCH] t9100: stop depending on commit timestamps
>
> The early part of t9100 creates an unusual "doubled" history in the
> "git-svn" ref. When we get to t9100.17, it looks like this:
>
>   $ git log --oneline --graph git-svn
>   [...]
>   *   efd0303 detect node change from file to directory #2
>   |\
>   * | 3e727c0 detect node change from file to directory #2
>   |/
>   *   3b00468 try a deep --rmdir with a commit
>   |\
>   * | b4832d8 try a deep --rmdir with a commit
>   |/
>   * f0d7bd5 import for git svn
>
> Each commit we make with "git commit" is paired with one from "git svn
> set-tree", with the latter as a merge of the first and its grandparent.
>
> Later, t9100.17 wants to check that "git svn fetch" gets the same trees.
> And it does, but just one copy of each. So it uses rev-list to get the
> tree of each commit and pipes it to "uniq" to drop the duplicates. Our
> input isn't sorted, but it will find adjacent duplicates. This works
> reliably because the order of commits from rev-list always shows the
> duplicates next to each other. For any one of those merges, we could
> choose to show its duplicate or the grandparent first. But barring
> clocks running backwards, the duplicate will always have a time equal to
> or greater than the grandparent. Even if equal, we break ties by showing
> the first-parent first, so the duplicates remain adjacent.
>
> But this would break if the timestamps stopped moving in chronological
> order. Normally we would rely on test_tick for this, but we have _two_
> sources of time here:
>
>   - "git commit" creates one commit based on GIT_COMMITTER_DATE (which
>     respects test_tick)
>
>   - the "svn set-tree" one is based on subversion, which does not have
>     an easy way to specify a timestamp
>
> So using test_tick actually breaks the test, because now the duplicates
> are far in the past, and we'll show the grandparent before the
> duplicate. And likewise, a proposed change to set GIT_COMMITTER_DATE in
> all scripts will break it.
>
> One fix would be to sort the list of trees before removing duplicates,
> but that loses information:
>
>   - we do care that the fetched history is in the same order
>
>   - there's a tree which appears twice in the history, and we'd want to
>     make sure that it's there both times
>
> So instead, let's de-duplicate using a hash (preserving the order), and
> drop only lines with identical trees and subjects (preserving the tree
> which appears twice, since it has different subjects each time).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t9100-git-svn-basic.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 9f2d19ecc4..3055943a22 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -200,8 +200,9 @@ GIT_SVN_ID=alt
>  export GIT_SVN_ID
>  test_expect_success "$name" \
>      'git svn init "$svnrepo" && git svn fetch &&
> -     git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
> -     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
> +     git log --format="tree %T %s" remotes/git-svn |
> +	awk "!seen[\$0]++ { print \$1, \$2 }" >a &&
> +     git log --format="tree %T" alt >b &&
>       test_cmp a b'
>  
>  name='check imported tree checksums expected tree checksums'
