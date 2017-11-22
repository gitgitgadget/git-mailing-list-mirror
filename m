Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8972036D
	for <e@80x24.org>; Wed, 22 Nov 2017 00:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdKVAyT (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 19:54:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57135 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751408AbdKVAyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 19:54:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EB95B96E4;
        Tue, 21 Nov 2017 19:54:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+FsCs6kK6+BMYewmyH+FPrckVEw=; b=hdH8zA
        7+TnQV16eJaTK3CHJrOB4x+Dy8QjQp05SC0DLjSCDHRXdmSKUVWkmgB+YQKAlhRw
        WOyzYHP4PqXmejEQR9zuL3FP1AOh1Lw/EMmQtvJwD5A/6mIOYgNlE0jBt8TK0bI2
        Q111uyKC9wyDGTXanIJCtACZN+tK0sZ2WBhmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlISQzAbFLgcj2mcLKZtToyQ11RXBTID
        TrUDCczsBEXQouMOj5sFk2BYFQZm4AFJAjh+5LVxbJcMg6FW4Bba2G/yz6sCv5JR
        oD81+YWjbwO7JrT/2p1Fl3Q2iFQGGfwlKFMwIp77ENEsWb3jeLJu8kA9nyEBMS//
        DIa6qg+NKT4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25B79B96E3;
        Tue, 21 Nov 2017 19:54:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9512EB96E2;
        Tue, 21 Nov 2017 19:54:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
References: <20170724173601.19921-1-sbeller@google.com>
        <20170724180312.GE13924@aiede.mtv.corp.google.com>
        <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com>
        <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
        <20171121223449.GI3429@aiede.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 09:54:13 +0900
In-Reply-To: <20171121223449.GI3429@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 21 Nov 2017 14:34:49 -0800")
Message-ID: <xmqqr2sryvyi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A91CB732-CF1F-11E7-BB98-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The thread I am replying to appears to be where the patch comes from
> but I have some memories of more recent discussion that I'm not
> finding.
>
> More context:
> https://public-inbox.org/git/xmqqshd8i3ze.fsf@gitster.mtv.corp.google.com/
> says
>
>  * sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
>   - Documentation/checkout: clarify submodule HEADs to be detached
>   - recursive submodules: detach HEAD from new state
>
>   "git checkout --recursive" may overwrite and rewind the history of
>   the branch that happens to be checked out in submodule
>   repositories, which might not be desirable.  Detach the HEAD but
>   still allow the recursive checkout to succeed in such a case.
>
>   Expecting a reroll.

Sorry, I should have done my usual "cf. <message-id>" to help me
recalling the discussion that lead to the marking there.

We kicked it back to 'pu' after the discussion that had
<xmqq375ppqma.fsf@gitster.mtv.corp.google.com>, and the "send out a
plan" sort-of happened with <20171109001007.11894-1-sbeller@google.com>
which seemed to have converged to a conclusion in the subthread with
<CAGZ79kZAvMKQUjbqWZkhy39sE5e9k1DmkiA42ywiw2NgY1+Xig@mail.gmail.com>
where a preferred way would be to detach and opportunistically reattach
to keep the illusion of submodule being on a branch as much as possible
(correct me if I am misunderstanding the consensus).  

I had a suspicion that such a random re-attachment may lead to an
unpredictable behaviour from end-user's point of view that is
confusing, but there wasn't a concrete patch to do so, so that was
why I was waiting for a reroll so that people can take a look at it
and see how well it fares.

The responses in this thread seems to indicate that now we are
punting on that re-attachment plan and want to give this "always
detach" to the end users, which I think is a lot more predictable
thing to do.  After such a recursive checkout from the top-level,
any work done in the submodule from that state and is referenced
from the top-level (recorded presumably with a recursive commit) is
not referenced by anything other than the reflog of HEAD in the
submodule repository, and I suspect many users are not used to and
are comfortable with working on a detached HEAD for extended period
of time, so this new behaviour might deserve a stronger warning to
help them, but I am OK with the stance "We'll learn as we go---let's
merge it as-is and see what happens".

Thanks for prodding.  One less topic that is stale but has to be
carried around in 'pu' is always a good thing ;-)



