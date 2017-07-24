Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72DF5203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756082AbdGXUxw (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:53:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55441 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753359AbdGXUxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:53:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEBB89AFE6;
        Mon, 24 Jul 2017 16:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xuBSI24A3SoI0yu+17hn3F0fSOI=; b=TT4wvw
        SVHk7HxuoWu4y7tcsJjvAjWh4sQ1KhOEum9U71OFKyoWMsHyR4jN6xujd1PRdwt3
        v6XWIJj8WBmD6K0go3R0X+nP2XkzawJBy+06n2/0mPX7kdM8xVY3374RqmpxYvs0
        XifdG15K6Eqq+JkgmTfjAOSbGL3Lz71gIUKAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T7z3crO8zpGGy2sHAom3thaEPVVpgInw
        Iw341uUuXy6qLPJWh3Y4S7gq0Lj5lneOLmf0cDKrZnQY/c66Ybur7xffM4YhphlF
        B5TuEjhxkcfRGi/UmzCs3jn+WVsBUtGhD/SmYMLNLPW6OTURpnv2RKWR3XLLwVYi
        ohEFKfmTyaI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B48B59AFE5;
        Mon, 24 Jul 2017 16:53:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23CF09AFE4;
        Mon, 24 Jul 2017 16:53:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        William Duclot <william.duclot@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] rebase: make resolve message clearer for inexperienced users
References: <20170709202520.21739-1-william.duclot@gmail.com>
        <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com>
        <20170710183101.GA13122@Haydn>
        <xmqq4luh1gzw.fsf@gitster.mtv.corp.google.com>
        <7E67FF115BB146A49D486E77404882F2@PhilipOakley>
        <fd665e9d-e46a-c9f1-f4ec-3407dd18ab36@talktalk.net>
Date:   Mon, 24 Jul 2017 13:53:38 -0700
In-Reply-To: <fd665e9d-e46a-c9f1-f4ec-3407dd18ab36@talktalk.net> (Phillip
        Wood's message of "Mon, 24 Jul 2017 10:51:57 +0100")
Message-ID: <xmqqmv7td0a5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BEDA918-70B2-11E7-B991-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> git rebase --continue requiring one to git add first confuses/annoys me
> too. I started a patch to autostage unstaged changes if they don't
> contain conflict markers a couple of weeks ago, I'll clean it up and
> post it later this week.

As long as "git rebase" will keep refusing to start in a working
tree with dirty files and/or index, this could be a good change.

But people _may_ be annoyed because they expect "--continue" to
remind them that some conflicts are not concluded with an explicit
"git add", and they would even feel that you made the command unsafe
if "--continue" just goes ahead by auto-adding their change that is
still work-in-progress.  Lack of conflict markers is not a sign that
a file is fully resolved (which they are used to signal by "git
add", and they do so per set of paths).

> I also find it confusing that it asks me to edit the commit message for
> picks, fixups and non-final squashes after conflicts. I can see that
> perhaps one might want to amend the message to reflect any changes that
> were made while resolving the conflicts but I've never had too. I'd
> rather be able to pass --edit to rebase --continue if I needed to edit
> the message in those cases. Looking through the code I think it would
> require saving some extra state when rebase bails out on conflicts so
> rebase --continue could tell if it should be asking the user to amend
> the message.

This is disruptive if done without a careful transition plan and
you'll annoy existing users who expect to be able to edit by
default.  Especially since "rebase" keeps going and potentially
rebuild many commits on top, by the time they realize the mistake of
not passing "--edit", it is too late and they will hate you for
forcing them rebase many commits again.

If these suggestions above were given while "rebase -i" was
developed, it might have made the end-user experience a better one
than what it currently is, but transitioning after the current
behaviour has long been established makes it much harder.


