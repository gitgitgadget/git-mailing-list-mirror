Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401841FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbdJJI6H (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 04:58:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53254 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751826AbdJJI6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 04:58:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FC9692901;
        Tue, 10 Oct 2017 04:58:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H9e80Bml+XAqIfaHGDNoow9ss8U=; b=vk1ba3
        hUpJqfKmEh1yEVneYCLLjxuHEg6SKnn8FWgRDBmvEHV+TJspPZu+ZOr1cKH9Np/l
        V0+VfiDtF2bwvCKe/o6/KyDp7oa2+iC6CuzhpTz65SYbGtyUjYf3Nek5Jf4VXH9R
        sQBxrxfWFgqrjo0v22qzEnVL4Ll+mizMuB8CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IOzJFwYCBmkPAnfOgv0jmPqqPyR3KMwO
        U7W7uxpHvHaSFcWgDMvpJLEQtxHRoincboj27rHxlFDKVvP/Eu6g1PO0AHTA4MnH
        q4FWlntxnlrCCuRCW7qPKmQSbiulAQdBX+quimmG0n+w2LvIIMKytUixcImFonn5
        V+qQfCoPQtk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26C9592900;
        Tue, 10 Oct 2017 04:58:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99AE1928FD;
        Tue, 10 Oct 2017 04:58:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Jeff King <peff@peff.net>, Theodore Ts'o <tytso@mit.edu>,
        Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
References: <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
        <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
        <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
        <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
        <1507412674.8322.4.camel@mad-scientist.net>
        <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
        <1507473160.8322.12.camel@mad-scientist.net>
        <20171008184046.uj7gcutddli54ic3@thunk.org>
        <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
        <20171008204227.f6wgaobosa6yn62g@thunk.org>
        <20171009175225.qn6a3j2th3dxjjn2@sigill.intra.peff.net>
        <alpine.LFD.2.21.1710100432220.16182@localhost.localdomain>
Date:   Tue, 10 Oct 2017 17:58:04 +0900
In-Reply-To: <alpine.LFD.2.21.1710100432220.16182@localhost.localdomain>
        (Robert P. J. Day's message of "Tue, 10 Oct 2017 04:36:53 -0400
        (EDT)")
Message-ID: <xmqqpo9vpeg3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 212F24EC-AD99-11E7-B44F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> underlying weirdness. but it still doesn't explain the different
> behaviour between:
>
>   $ git rm -n 'Makefile*'
>   $ git rm -n '*Makefile'
>
> in the linux kernel source tree, the first form matches only the
> single, top-level Makefile, while the second form gets *all* of them
> recursively, even though those globs should be equivalent in terms of
> matching all files named "Makefile".
>
>   am i misunderstanding something?

We are matching what Git cares/knows about aka "the paths in the
index" to pathspec patterns.

What are these paths in the index?  In Linux kernel sources, there
are quite a many but here are examples that are enough to explain
the above:

	Makefile
        COPYING
	fs/Makefile
	fs/ext4/Makefile

Which one of these four match patterh "Makefile*", which is "the
first letter is 'M', the second letter is 'a', ....,, the eighth
letter is 'e', and anything else can follow to the end"?  Yes, only
the first one.

Which one of these four match pattern "*Makefile", then?  "Anything
can appear as leading substring, but then 'M', 'a', 'k', ..., and
finally 'e' must appear at the end"?

Note that these "start from the paths in the index that match the
pathspec patterns" have nothing to do with "recursive".  It happens
way before we decide to go recursive (or not).

We are not going down recursively from the paths in the index that
are matched by pathspec patterns with the above two "git rm"
requests (because there is no "-r" there), but even if we were,
because these three Makefile files are not directories, there is
nothing to remove recursively underneath them.
