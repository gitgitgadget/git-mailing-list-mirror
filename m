Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C01320179
	for <e@80x24.org>; Sun, 26 Jun 2016 18:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbcFZSP7 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 14:15:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751763AbcFZSP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 14:15:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 898D12780B;
	Sun, 26 Jun 2016 14:15:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CZkVRxy9Z4ahTElzLqH/jjbDs84=; b=nMtJQG
	1vURLVJ7vXx5An+NwCE9g3ldb7dzoEw5d1FG0fi1dcVj5Ib4pqB+NE/ixRDt2Kds
	inDBtCTrv3lFQyRdV6qnVeyaETG6AGxYfimSV1nSspcDsMsrHZVCjSvuXqPEzd5U
	jCD8E9d+Apt5PStjJ0n33ZDeFsjqQ5IDv/sXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGS6SqIdfPNcn43TGOhyBEg/jW0NAfS0
	PkL6ypIZWgSdqFkvvP11cbrjyzFn2KQbhBwlqNnMmR7u/PTIwOROEk7+xXLiUAYj
	yii8kg0lUdE8Vek0lpBlKzhwY5m82CCrNztZoNR1oBNgLIoBJLEmWZzRA09uMWX4
	mClJm27HCQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 806A927809;
	Sun, 26 Jun 2016 14:15:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0182D27808;
	Sun, 26 Jun 2016 14:15:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Barret Rennie <barret@brennie.ca>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
References: <20160625051548.95564-1-barret@brennie.ca>
	<576E2FA9.7070008@kdbg.org>
	<1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca>
	<xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 26 Jun 2016 11:15:54 -0700
In-Reply-To: <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 25 Jun 2016 12:45:10 -0700")
Message-ID: <xmqqshvzddet.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 068E3886-3BCA-11E6-ADB6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Now, if you do the worktree, you may still want the relative
> structure between these two, i.e. if you want to work on two
> different branch combinations of the whole thing, you would want to
> do this:
>
>     $HOME/xyzzy-1/frotz       - borrow from $HOME/xyzzy/frotz
>     $HOME/xyzzy-1/libs/nitfol - likewise for nitfol
>
>     $HOME/xyzzy-2/frotz       - borrow from $HOME/xyzzy/frotz
>     $HOME/xyzzy-2/libs/nitfol - likewise for nitfol
>
> where xyzzy-$n may be for topic-$n branch both in frotz and nitfol.
>
> And explained that way, it becomes clearer that you would want to
> name $HOME/xyzzy-1/frotz worktree after "topic-1", not the default
> name you would get "frotz" (because the default gives you the leaf
> level name of the newly created worktree).
>
> After the discussion above (which may or may not match what you
> raised this topic for), I think a feature to let you override the
> default name makes sense.
>
> It just needs to be explained better to help the users when the
> feature eventually becomes part of Git.  Also, others (especially
> Duy) may have even better ideas (e.g. instead of having to always
> use --name to give custom name for all worktrees, set a "hint" just
> once to help the logic that comes up with the default name give a
> better name), so while the feature may be desirable, your exact
> implementation may or may not be what we eventually want to adopt.

For example, the "frotz" and "nitfol" repositories (i.e. where their
worktrees borrow their refs and object stores from) could have a
single configuration variable each, i.e.

	(in $HOME/xyzzy/frotz/.git/config)
        [worktree] location = "~/*/frotz"

	(in $HOME/xyzzy/libs/nitfol/.git/config)
        [worktree] location = "~/*/libs/nitfol"

and then the user could do in each of these two repositories

	$ git -C ~/xyzzy/frotz worktree add --by-name xyzzy-1 topic-1
	$ git -C ~/xyzzy/lib/nitfol worktree add --by-name xyzzy-1 topic-1

to get the desired layout instead.

The traditional way may be "create one HERE", and your patch tries
to tweak it to "create one at HERE with this NAME".  The above
attempts to remove the need for specifying the exact location every
time a new worktree is created, and instead let you specify the
systematic way in which you lay out your worktrees based on their
names.

