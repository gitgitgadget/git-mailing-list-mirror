Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540511F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 16:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755107AbcJNQlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 12:41:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65091 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754822AbcJNQlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 12:41:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A40F44BF6;
        Fri, 14 Oct 2016 12:41:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0WlF903oNIn0n+G9MnuYJOyfa3g=; b=HZk/ZB
        Ucsa0s2Gnx+hAr50uLo3vYm00FkIJs6h5gX1ZlrJRAmxfoYfltKnaXE94eGzGf9U
        fDtbuDKNs9/3zP/rVs/1m0NcF1l0cBR5R5VaKBDlBx7QKEFFMq0255jjNKZR2e1j
        R/gCzM3jq5AEa4J/6TnpDyqLlCU64vUTloHc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iobns7KdBCKdXyU9U1nEAReyC3DWStbM
        L4rbNQDAG9E/bXP7VaE8SXYCOFw6ClDZ3d4SZWs1V4ONGsUQfVdEJrjjyGO7GyMH
        /eUDZzIOlrWKcrAA1QLC0fhDFzebz1/xyNBbFKWmOOC22jRrlLmI5InmuaOFnCF1
        x2JB9XHedOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFD0944BF4;
        Fri, 14 Oct 2016 12:41:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B55344BF3;
        Fri, 14 Oct 2016 12:41:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 13/25] sequencer: prepare for rebase -i's commit functionality
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <9b2782e64f678ab2d261042b63fafc3e4a519295.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqwphe8zl2.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610121356510.3492@virtualbox>
        <xmqq60ox5wxb.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610131242100.197091@virtualbox>
Date:   Fri, 14 Oct 2016 09:41:06 -0700
In-Reply-To: <alpine.DEB.2.20.1610131242100.197091@virtualbox> (Johannes
        Schindelin's message of "Thu, 13 Oct 2016 12:50:16 +0200 (CEST)")
Message-ID: <xmqqvawuzxwd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01E7812A-922D-11E6-82ED-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think my puzzlement comes from here.  What makes it OK for "am" to
>> expect the contents of author-script file to be quoted but it is not
>> OK to expect the same here?  What makes it not quoted for _this_
>> reader, in other words?
>
> The `git am` command is inherently *not* interactive, while the
> interactive rebase, well, is.
>
> As such, we must assume that enterprisey users did come up with scripts
> that edit, or create, author-script files, and exploited the fact that the
> interactive rebase previously sourced them.

It's like saying "While the program is waiting for user interaction,
the user can attach a debugger to tweak the contents of this string
variable.  Hence we must not assume that the string is always NUL
terminated to protect ourselves."

A correct response to such a user is to tell them not to do that,
and do so at two levels.  

The first level may be "it may be physically possible to tweak the
string via debugger but don't do that in such a way that breaks the
invariants our program relies on, or you are on your own", but more
important is the response at the second level.  Why is the user
futzing with that string in the first place with the debugger?  In
the context of author-script, the question is "Why is the user
futzing with the author-script file"?  To attribute the resulting
commit to a different author, of course.  But we need to step back
and think why the user needs to resort to editing that file to
achieve that.

If that is a common thing users would want to do, then we should
offer an official way to do so, and it should not be "you can futz
with author-script file with your editor".  Something like "have
'exec git commit --amend' in the todo file" may be more appropriate
and if it is important enough, the sequencer command language may
want to learn an extra verb to update the author.

Besides, the opportunity easiest for the user to futz with the
contents of author-script file (or "attach the debugger while we
wait for user interaction") arises when "rebase -i" or "am" stops
waiting for conflict resolution.  Even when you run "am" without its
"-i" option, it is equally susceptible to the "user futzing with the
file", which means your "am is not interactive but 'rebase -i' is"
is irrelevant to the issue.  Oh, also, did I say "am" has "-i"
option, which is a short-hand for "--interactive"?

What disturbs me the most is that I know you know the system well
enough to realize how bogus your argument to claim that "rebase -i"
and "am" are different was and to come up with what I wrote above
yourself.  Which means that I need to conclude that you have some
other reasons why you want to keep this parser different, but I
still do not know what they are.

I guess it entirely is possible that one of the reasons is because
some later patches in the larger "rebase-i to sequencer" series
writes author-script file in a syntax that cannot be read by the
recently refactored code "am" uses to read the author-script file,
and reusing the existing code may end up breaking the endgame
"rebase -i" you have.

As I do not feel like arguing with you on this any longer, and as I
certainly do not want to be blamed for breaking your "rebase -i", I
do not insist the code to be refactored to share with the existing
codepath.  But still I do not see the need to keep them separate (as
I already said in the previous message, I am OK if the one used in
"am" is updated to match).





