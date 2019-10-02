Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60E11F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 06:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJBGdp (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 02:33:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52724 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBGdo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 02:33:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A87F735FA6;
        Wed,  2 Oct 2019 02:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oh28qTos9a7OKKQ5nnJs2WbiWyM=; b=oipcWf
        xdRI6gduaJu50sCHUILotU0+ZfS+o7EArLvFSKe+XQhwjdXX9C+v+8XOBYPgnWWp
        jeSlkhsCjClwHtiKd4iexRwzbzNCLktKxuzRz9K/QxOE5hVj9XEFtMMIvugaEk76
        xcc/ETURHWdFetkgLVw9yrVtiznt3TWLbAl3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HVIi2R+GhnV50wXu/8bkcWIcJ0B+Ioin
        16bZ8UY3ecCaBp8xuCgW8BATWpg4dqBnNxklLNGnAroc6FE10GY8snkAUD3rzmNo
        45sQIP/eU6lvEvPHxmun8y6ai2KlX6CWcau1EgVh0vJS6XqsA3HxYISCCWhod0i5
        c33CjoRp5UQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0F4135FA4;
        Wed,  2 Oct 2019 02:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A79435FA3;
        Wed,  2 Oct 2019 02:33:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: git-grep in sparse checkout
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
        <CAKPyHN3G-j6p8YZmk+07Sb3tL9vua_R-hJ=W81O7vCYr07AkxA@mail.gmail.com>
        <CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com>
Date:   Wed, 02 Oct 2019 15:33:37 +0900
In-Reply-To: <CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 1 Oct 2019 09:12:26 -0700")
Message-ID: <xmqqy2y3ejwe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91BFD4EE-E4DE-11E9-A5B6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> * other commands (archive, bisect, clean?, gitk, shortlog, blame,
> fsck?, etc.) likely need to pay attention to sparsity patterns as
> well, but there are some special cases:

"git archive" falls into the same class as fast-(im|ex)port; it
should ignore the sparse cone by default.  I suspect you threw
"fsck" as a joke, but I do not think it should pay attention to the
sparse cone, either (besides, most of the time in fsck the objects
subject to checking do not know all the paths that reach them).

> * merge, cherry-pick, and rebase (anything touching the merge
> machinery) will need to expand the size of the non-sparse worktree if
> there are files outside the sparsity patterns with conflicts.  (Though
> merge should do a better job of not expanding the non-sparse worktree
> when files can cleanly be resolved.)

I think the important point is what is done to the result of
operation.  Result of these operations that create new commits are
meant to be consumed by other people, who may not share your
definition of sparse cone.  And such a command (i.e. those whose
results are consumed by others who may have different sparse cone)
must be full-tree by default.

> * fast-export and format-patch are not about viewing history but about
> exporting it, and limiting to sparsity patterns would result in the
> creation of an incompatible history.

I agree with the conclusion; see above.

> * New worktrees, by default, should copy the sparsity-patterns of the
> worktree they were created from (much like a new shell inherits the
> current working directory of it's parent process)

Sorry, but I do not share this view at all.

In my mental model, "worktree new" is to attach a brand-new worktree
to a bare repository that underlies the existing worktree I happen
to be in, and that existing worktree that I happen to type "worktree
new" in is no more or no less special than other worktrees.

The above isn't to say that I'd veto your "a new worktree inherits
traits from an existing worktree that 'git worktree add' was invoked
in" idea.  I am just saying that I have a problem with that mode of
operation and mental model being the default.


