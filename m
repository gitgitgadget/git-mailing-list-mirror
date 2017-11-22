Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873792036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdKVBUz (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:20:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64362 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751344AbdKVBUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:20:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11FE8AF21A;
        Tue, 21 Nov 2017 20:20:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6j1eLVoDhlP6rGf2bddTdF9Eya4=; b=lsDsBE
        iTGr8rg78D2Ez58FwLQYLpImqSXdKXu8g/b46FmpNle1xCr9aNDtexK7NmISBg49
        ukfxrsDcG888xtIX11C4EVUY9aWFeBJAzfMflJMh9P+H2Zixy1pAgdk7RgiPV0GX
        NBLvqARyeh3mRW6ZrcgS1wAn6MiJg9K6KVG9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GVZuv9N/O5Od8Q7S9tm+xKWzNJj2BejH
        qGrX1nBEm0FmB9eyTy9TcB/sv31pgMZNzSlJ+285aqssELurm+ZW9q28oqDZaxdO
        oEEq9Ww1tWSkzzprSlKfcWOcZD8iA4CyMbNvj0IbE+xbfIMid3rqWQLkFCj382S6
        vYRcnb8yzaE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A908AF219;
        Tue, 21 Nov 2017 20:20:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 763BAAF218;
        Tue, 21 Nov 2017 20:20:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/3] worktree: make add <path> dwim
References: <20171118181103.28354-1-t.gummerer@gmail.com>
        <20171118224706.13810-1-t.gummerer@gmail.com>
        <20171118224706.13810-4-t.gummerer@gmail.com>
        <CAPig+cQqbvuZg0Y8ZMObZc7mYXzohooVBFj0-o+CGGXrgGLp5w@mail.gmail.com>
        <CAPig+cTmqHt5s+C1vTFA7S4ZBwjqnzkn-2wA6i3jVeLw7i1_Lg@mail.gmail.com>
        <20171121221339.GA4047@hank>
Date:   Wed, 22 Nov 2017 10:20:52 +0900
In-Reply-To: <20171121221339.GA4047@hank> (Thomas Gummerer's message of "Tue,
        21 Nov 2017 22:13:39 +0000")
Message-ID: <xmqqh8tnyuq3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 621D4F8C-CF23-11E7-B1B9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I didn't consider that, I think you are right, and the flag should
> apply in that case as well.  I think at that point we may as well pass
> this flag through to the 'git branch' call, and let users set up
> tracking if they want to, the same way it works in 'git branch'.

OK, so tracking is set up by default in the current implementation
of "git worktree" (even without your proposed update), but we will
stop doing so, and instead take an explicit "--track" option (or
"--no-track" to countermand an earlier "--track" on the command line
and/or a default configured with branch.autosetupmerge) just like
"git branch" does?

I think that it is very sensible thing to make sure that "branch",
"checkout -b" and "worktree", i.e. the three ways to create a branch
to work on (the latter two being short-hands), behave consistently.

Thanks.
