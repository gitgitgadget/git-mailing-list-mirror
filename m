Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583DD20988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760037AbcJRRCH (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:02:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61339 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755435AbcJRRCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:02:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CD05473B5;
        Tue, 18 Oct 2016 13:02:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/UarHxsKPM6YVjopLIl/iThAZw4=; b=TDNSGL
        Xo4fn6GFbpFPmpkiWP0tZV7h6JMxGwgLe6K+B/52jX6bkeHYRK8dG4fUMcO0wpLy
        a+ipe/qdN1xyDCghvVeLe1L65XUcz77kzhR3SEKZz6x877bcdmgpf2+ghb7ixw99
        mAyvWfr5mthrfF6mG6xhUxshjpa4OIf4wAAtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hphJFl1QpzSCFdG9TiuqEdLgYFNR5t5e
        LogwptLgffCW6pEpA1Rd+7FO7Uh9r0f41plmHA/yQT5R8gQf5WvZB3SrZ+WYJK3E
        QzHB6h0P4sihza3J14ZvaGmNtcdRRf7kjzJrsBLTyNckVX25SxtXrHnNxpunma+A
        BGlzwfGwiqI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 450C8473B4;
        Tue, 18 Oct 2016 13:02:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6C80473B3;
        Tue, 18 Oct 2016 13:02:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Git log exclude/remotes/branches options not working as expected
References: <CAHd499C+SACpBrOEk-V4QMKoq2egmMfYSwUN1tZBBhFOTWomRw@mail.gmail.com>
Date:   Tue, 18 Oct 2016 10:02:01 -0700
In-Reply-To: <CAHd499C+SACpBrOEk-V4QMKoq2egmMfYSwUN1tZBBhFOTWomRw@mail.gmail.com>
        (Robert Dailey's message of "Tue, 18 Oct 2016 08:33:42 -0500")
Message-ID: <xmqqzim1pp4m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97C88034-9554-11E6-9F5D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> I have 3 remotes registered in my clone:
>
> origin, fork, drive
>
> When I do:
>
> $ git log --oneline --decorate --graph
>
> I only want to see branches under:
>
> refs/heads/*
> refs/remotes/origin/*
>
> I tried the following:
>
> $ git log --oneline --decorate --graph --simplify-by-decoration
> --remote=origin topic1..master

I am guessing that the above is not what you actually typed and
s/remote/remotes/ is what you did.

According to "git log --help":

    --remotes[=<pattern>]
        Pretend as if all the refs in refs/remotes are listed on the
        command line as <commit>. If <pattern> is given, limit
        remote-tracking branches to ones matching given shell glob. If
        pattern lacks ?, *, or [, /* at the end is implied.

So your command line is equivalent to

    $ git log --oneline --decorate --graph --simplify-by-decoration \
      refs/remotes/origin/master refs/remotes/origin/topic ... \
      topic1..master

(replace the second line with all the remote-tracking branches you
have for "origin").

There is nothing that tells "--decorate" which refs to base its
decoration on, so it is reasonable to expect that a commit that
happens to match a tip of remote-tracking branches from other
remotes are decorated as such, and I think that is what you are
seeing.

> What I'm expecting is that I literally see NONE of those excluded refs
> ... How can I achieve my goals?

The decorations are added in log-tree.c::load_ref_decorations() and
it does not get anything that says "I want to see decorations based
on only these refs", so a short answer is that there is no canned
way to do this in today's codebase.

Having said that, I would say it is a reasonable new feature to
have.  Another related wishlist item might say "decorate only based
on tags, not branches or remote-tracking refs".

You can achieve your goals by teaching that codepath to take such
new pieces of information, come up with a new command line option
[*1*] and add a code to parse your command line option to either
builtin/log.c or revisions.c and pass it down the callchain that
leads to load_ref_decorations().


[Footnote]

*1* Unfortunately "--decorate=<option>" is already taken to specify
the decoration levels, so you would need a different one.
