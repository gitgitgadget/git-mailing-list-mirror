Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F221F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 03:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeKZN4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 08:56:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59461 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeKZNz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 08:55:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DBDE10D399;
        Sun, 25 Nov 2018 22:03:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iO9a6Bpmtp440emRKABA/8Q6Lag=; b=c+bPIm
        psJ7om4XZjcTfGlbgzmx3MgUIE2FPDG85SjBndgzpox+8wL38C4PeVe8XekOPNla
        8Lx7pQRYk/IubjUX8iWr8l48XDnWrP9qWRZwWEvlBlNAa0dncBK/G3Ti66V8orXL
        m3/dpGJef4j7qO/5P6QSucOHRlNKlsonOSP40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eu7ZoGHyeB2NRvJKL7rOvIh4GsGi6a0s
        x8gmcKh56Dy0yD8WLw8Q98TtChwQsjgUc4/A6Rx3kH7AfCn8Rz5nQG+3FHIVjaGl
        TEosd/fsYRNPC3/x0HbT85Dm0/HibRTjFcYE1nLcSaMw45QnUHf0huLr7SuDP+Io
        cTUpKJ+SMv8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4581010D397;
        Sun, 25 Nov 2018 22:03:17 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B017D10D394;
        Sun, 25 Nov 2018 22:03:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] Introduce two new commands, switch-branch and restore-paths
References: <20181110133525.17538-1-pclouds@gmail.com>
        <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
        <8736rx1ah9.fsf@evledraar.gmail.com>
        <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
        <20181120174554.GA29910@duynguyen.home>
        <20181125222021.GL4883@hank.intra.tgummerer.com>
Date:   Mon, 26 Nov 2018 12:03:15 +0900
In-Reply-To: <20181125222021.GL4883@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sun, 25 Nov 2018 22:20:21 +0000")
Message-ID: <xmqq1s781qx8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2329012-F127-11E8-B1FF-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I like the idea of splitting those commands up, in fact it is
> something I've been considering working on myself.  I do think we
> should consider if we want to change the behaviour of those new
> commands in any way compared to 'git checkout', since we're starting
> with a clean slate.
>
> One thing in particular that I have in mind is something I'm currently
> working on, namely adding a --index flag to 'git checkout', which
> would make 'git checkout' work in non-overlay mode (for more
> discussion on that see also [*1*].

Ah, thanks for reminding me of that.  That explains why I felt
uneasy to see "restore" in the proposed command name.  In short, I
think "checkout --index <tree> <pathspec>", i.e. if the <pathspec>
matches a directory in <tree> and the current index and/or the
working tree has tracked paths in that directory that do not exist
in <tree>, the operation _removes_ these paths so that the result
matches <tree>, should become the default of "I want to check out
these paths from the named tree-ish".  The current one is not
exactly "checking out the paths" in that it ignores and does not
check out the absense of paths in <tree>.  That operation sounds
more like "restoring paths out of a given tree".  If the tree does
not have some paths, these paths won't be "restored" from that tree,
so "restore" matches the current "overlay what's taken out of the
given tree on top of what is already in the index and the working
tree, without checking out the absense of paths" better from that
point of view.


