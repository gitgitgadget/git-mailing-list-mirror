Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FFF20960
	for <e@80x24.org>; Wed, 12 Apr 2017 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdDLIlv (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 04:41:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50312 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753391AbdDLIlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 04:41:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7E46714A1;
        Wed, 12 Apr 2017 04:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5LrepYEksqJjTliNuom80yc3fPo=; b=YiJkEb
        F4JqO/D+jdTJeRvGkL2A0aIFGrtMOPWxo+fw6n3K5VjHy6vwX2t7Q8K5IgOzOQeG
        LT4I8k8HaDOYZnxzNxzD2y/DomvuiS7fEDF6vQV2rMRs8yHSuE/lunpnvZYV5SIC
        6vYK4VDweeWDivwrSY8MQOwrSdI7n9WqeSwGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cMu5BjeBPpIl8gVMjWlqtgrDRw+itjww
        SK+dzzPHDaGBsYXUQs26n/3iewU48s8hAkkycu9CaihRfCoZvxKSqxNsy3ORSFP4
        OFY/vsMtQZl9TMNQNLzGE6reQ8zNTCzJS9+nVExEM8nc/icSvagryXK7x04Yt7GC
        qZ8ubq2L9ds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C07D0714A0;
        Wed, 12 Apr 2017 04:41:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 122417149E;
        Wed, 12 Apr 2017 04:41:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
References: <20170409022128.21337-1-danny@dannysauer.com>
        <alpine.DEB.2.20.1704091238560.4268@virtualbox>
        <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
        <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
        <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net>
        <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
Date:   Wed, 12 Apr 2017 01:41:43 -0700
In-Reply-To: <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 12 Apr 2017 13:30:31 +0700")
Message-ID: <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBF62518-1F5B-11E7-859A-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> I think this is much more than just .mailmap, though. For instance, I
>> have noticed a similar problem with .gitattributes:
>
> Urgh. assuming that we should not read .gitattributes if there's no
> worktree to read from (similar to the "defaults to .git" situation),
> how about
>
>  - if mailmap stuff is requested, setup worktree, or die trying
>  - if worktree is detected, but setup code does not jump to it, do it
>  - if no worktree is detected, tell git-log to stop reading .gitattributes

My gut reaction is that we are doing something wrong once we start
saying "if mailmap stuff is requested".  This is not about .mailmap
but is about how sanely the paths relative to the root of the
working tree (which includes a path in the index, or comparing
$commit:$path with $path in the working tree) can be named by any
subcommand of Git.

Can't we model this after how setup_git_directory_gently() gives the
subcommands a choice?  While the majority of subcommands do not call
the _gently() variant and die when we are not in a repository, the
rest do use it and continue after learning that they are outside a
repository.  

Perhaps we want a new bit GOTO_WORK_TREE_ROOT that is orthogonal to
NEED_WORK_TREE to tell the codepath that calls cmd_foo() to always
move to the root of the working tree (if there is one), regaredless
of the behaviour f3bb8b4b84 documents.  I have a strong suspicion
that we didn't _care_ about a silly use case where GIT_WORK_TREE is
specified and the command is started from somewhere completely
unrelated to that location, and the users with such a silly use case
didn't care either what Git does to the files in the working tree,
i.e. what you quoted in your previous message

    "11. When user's cwd is outside worktree, cwd remains unchanged,
        prefix is NULL."

    This behavior probably started long before my topic though, mine was
    more of documentation, making worktree detection more consistent. It's

was not describing the design, but just describing whatever random
thing the code happened to be doing.
