Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D2F20899
	for <e@80x24.org>; Thu,  3 Aug 2017 02:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdHCCga (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 22:36:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751188AbdHCCg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 22:36:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9D08A4470;
        Wed,  2 Aug 2017 22:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ah2l72DxQOdu93yGjDf6E9vuR8U=; b=ja6EWo
        4WkiVyQfwFEmHAnr/Gp6t+mTeDsPvXaspWgJ34SUylFmAttLgwkQIMnwFOST4O9t
        KLAtp/INoaL+Egl/GRnD9V+1xqs1HROwHEgVXUZ9i4Ub6Thhhes7Orxbhui6n27D
        0tfUDU/qW/+eHfOxugtGwQCG/NUUzDV173B3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uVIullYVjjQij5B6IyRprfX4LydEvUIw
        6WcAJ/qGAi/I8x5f6nXuMnI0TCPMHtH4KBiO3AA4RhGO9g/Gb3qlWmFk2RekrnQw
        SFhmjuy2pqhnr6ptrzw52hbxT3+w2bkrYs4CG6Lobm0Snx0/eYOKSMxYC/MrU17x
        dy9JIOxYdEI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2111A446F;
        Wed,  2 Aug 2017 22:36:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3585A446E;
        Wed,  2 Aug 2017 22:36:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Subject: Re: reftable [v4]: new ref storage format
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
        <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com>
        <xmqqd18dqv0y.fsf@gitster.mtv.corp.google.com>
        <CAJo=hJuWc-hLyTgtdO_AYjUhvRWFSY70bBPEgNtygs5ojJcKyQ@mail.gmail.com>
Date:   Wed, 02 Aug 2017 19:36:26 -0700
In-Reply-To: <CAJo=hJuWc-hLyTgtdO_AYjUhvRWFSY70bBPEgNtygs5ojJcKyQ@mail.gmail.com>
        (Shawn Pearce's message of "Wed, 2 Aug 2017 19:21:11 -0700")
Message-ID: <xmqq8tj1qswl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D0B2B5A-77F4-11E7-8ECB-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> On Wed, Aug 2, 2017 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>    Would it benefit us if we define the sort order of bytes slightly
>>    different from the ASCII order, so that a slash '/' sorts between
>>    NUL '\000' and SOH '\001', which is the order we should have used
>>    when storing the entries in the index?
>
> I'm not really with that. It complicates the compare routine, and
> makes the data in reftable sorted differently than we announce in the
> wire protocol.

Fair enough.  It was not like I had some operations in mind that
would benefit from such a sort order (i.e. walking two of these
things in parallel and merging them, which would have been the case
for the index when we walk it together with one or more trees); if
there is no such operation that benefit, there is no reason to try
to be clever here.

>>  * Even though readers can continue accessing, starting from the
>>    $GIT_DIR/refs, without locking and get consistent views, any
>>    transaction that groups one or more ref updates would need to
>>    take a global lock on $GIT_DIR/refs file.
>>
>>    Would it become a problem in a busy repository?
> ...
>
> I'm not really sure how one could safely do the same thing with
> git-core. Its certainly not going to be portable or safe on NFS if we
> tried to do anything fancy with flock(2), fcntl(F_SETLKW), or
> semop(2).

Yes.

And for public record, another thing we privately discussed was that
we currently do not know if we would want to make this design mesh
well with the use of multiple worktrees (IIUC, HEAD and things
outside refs/, and refs/bisect/, need to be per- worktree, while
others are to be common), and if so how.
