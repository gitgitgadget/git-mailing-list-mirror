Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602321F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 02:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeKSMhU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 07:37:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57017 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeKSMhU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 07:37:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08B9912228D;
        Sun, 18 Nov 2018 21:15:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UouTboBgWUxWO/zYp2UwbGzCwf4=; b=qd8I2i
        rS/O7OtpTwyliuAJnyY4WqnUT9LqWIyWN0MJ4x8KfSHTKtfDDxtwiyfOg2kFsJDh
        FsUpRx/MMwLkv9XdqFyyr28N/AP+jdHgFqX4Q9C/PJBnZLFROPHwAA3FmM6fjfh5
        yGHEWckx3YdkfJQS5U5U6h4GxEwcSaSGQWPkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UmVYW7m7m0tcYLAi6jBdzPJ/jla+E9RP
        XELUdUSuvUpALQuU5YklCAIS3jJ4gMCNgdZN+AbGEfErFPSwKRVc6C2D8j1GKecX
        Q2ikSG7tehggesQcqShd9zpFKdHs9SeF1v5fUTSi7+nDAmLciQNM5cOE1R8wkBAQ
        aVsKTdlGAf0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F262D12228B;
        Sun, 18 Nov 2018 21:15:11 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E6E1122289;
        Sun, 18 Nov 2018 21:15:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
References: <20181115005546.212538-1-sxenos@google.com>
        <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
        <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
Date:   Mon, 19 Nov 2018 11:15:10 +0900
In-Reply-To: <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
        (Stefan Xenos's message of "Sun, 18 Nov 2018 16:36:43 -0800")
Message-ID: <xmqqftvxertd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F18D2D82-EBA0-11E8-8FBD-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

>> And the other half is that while I consider the "origin" thing is
>> unnecessary for the above reasons, having it means we need to not
>> just transfer the history reading to aa7ce555 and d664309ee (which
>> are necessary anyway while we have histories to transplant from
>> d664309ee to aa7ce555) but also have to pull in the history leading
>> to 7e1bbcd and we cannot discard it.
>
> I'll assume that by "history" you're referring to the change graph
> (the metacommits) and not the branches (the commits), which would have
> no origin edges or connection between replacements.

I meant the project's history, not the meta-graph thing.

By having a "this was cherry-picked from that commit" in a commit
that is not GC'ed, the original commit that has no longer have any
relevance (because the newer one that is the result of the
cherry-pick is the surviving version people will be building on) is
kept reachable.  It is very much delierate that "cherry-pick -x"
does not make the "origin" reachable and merely notes it in the
human readable form that is ignored by the reachablity machinery.

> If the user has kept a change around in their metas namespace, it's an
> indication that they (or their collaborators) are still working on it
> and want its history to be retained.

This is where we differ.  If commit X was rewritten (perhaps with
help from change cherry-picked from commit Z, or without any) to
produce Y, I do agree that it would be logical to keep X around
until every dependent commit on it are migrated to be on top of Y.
But we do not need Z to transplant what used to be on X on top of Y,
do we?  So I do agree that in such a situation they want the
relevant parts of the history retained, but I do not agree that
"origin" is among them.

	Side note.  As long as we have commits yet to be migrated to
	be on Y that still is on X, ew do not need the meta-commit
	to be protecting from getting GC'ed, as X is reachable from
	these "need to be updated" branch tips anyway.  What we gain
	from extra reachability brought in by the meta commits is
	that by fetching the "change", we get Y (and its anestors),
	even if we are not following any branch that contains it, so
	that we can migrate those that are still based on X to it.



	
