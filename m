Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F3420969
	for <e@80x24.org>; Thu, 30 Mar 2017 06:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbdC3GZY (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:25:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54283 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755189AbdC3GZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 02:25:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13EC5889EA;
        Thu, 30 Mar 2017 02:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qJBjeCijGs63UNUWc2101LnO+xA=; b=mrpkGd
        NjSDG36vMnzJ9gQNc/3V5hC8HgSwXYlyFMDe8FwDChXe7lh+XrH3yyDBD1qIBi3T
        q6MlIz0ZMzeSF5BLkmzeXnwqXOgC8o1UufT7AopYlYS9sThax5nKcU6umLi0EqVY
        Z94WzEb2xxTvXut2kZZo3fPjfIdcbpT+Wnzrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cp4HASMuCQHW/RrdH0hPgyatzLpisUbj
        nE+X2FB48+bzndzBHT2AcVIXtiKFTe/E6pWvRoJGxwKxyheF10e0r+qLMkmKqysn
        RXELhH7VDXBbVp0El5VLsDwE1SkRbYUAf8CIPJacr071t6lw+SPlhzTo26fvbBMF
        PMJuC+l33Fk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C026889E8;
        Thu, 30 Mar 2017 02:25:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BC89889E7;
        Thu, 30 Mar 2017 02:25:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pickfire <pickfire@riseup.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add build-in pattern for shell
References: <20170329165331.17742-1-pickfire@riseup.net>
        <xmqqzig49e4j.fsf@gitster.mtv.corp.google.com>
        <20170330022822.YGyP5YgSE%pickfire@riseup.net>
Date:   Wed, 29 Mar 2017 23:25:15 -0700
In-Reply-To: <20170330022822.YGyP5YgSE%pickfire@riseup.net>
        (pickfire@riseup.net's message of "Thu, 30 Mar 2017 10:28:22 +0800")
Message-ID: <xmqqefxf7038.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3C88086-1511-11E7-9341-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pickfire <pickfire@riseup.net> writes:

>> > +- `sh` suitable for source code in POSIX-compatible shells.
>> 
>> The new test you added seems to show that this is not limited to
>> POSIX shells but also understands bashisms like ${x//x/x}.  Perhaps
>> drop "POSIX-compatible" from here
>
> Those shells are still POSIX-compatible so I think it is true to put
> that or otherwise, something like fish shell will break since it is
> as well a shell but the syntax is totally different.

Scripts with bash-isms are not necessarily usable by POSIX
compatible shells (think "dash") and this highlighter recognises
bash specific enhancements (which by the way is a plus), so if you
absolutely want to say "POSIX something" in order to clarify that
csh and friends do not apply, say "POSIX-like".

>> 	...[ \t]*\\(\\)[\t]*....
>
> Ah, I think I forgot to escape the quoting of ( and ). I will send in another
> patch for that.

OK.  Note that we usually avoid applying a patch whose brokenness
was noticed while review (which then necessitates a follow up patch
"oops, the previous was botched; here is a fix-up").  The "another
patch" needs to be a v2, i.e. pretending as if the version of the
patch we are discussing never happened, not an incremental on top of
the patch we are discussing..

>> > +	 /* -- */
>> > +	 "(\\$|--?)?([a-zA-Z_][a-zA-Z0-9._]*|[0-9]+|#)|--" /* command/param */
>> 
>> TBH, I have no idea what this line-noise is doing.
>
> That breaks word into "a", "$a" and "-a" as well as "$1" and "$#". I tried
> supporting $? by adding +|#|\\?)--" but it doesn't seemed like it is working.

This ...

>> $foobar, $4, --foobar, foobar, 123 and -- can be seen easily out of
>> these patterns.  I am not sure what --# would be (perhaps you meant
>> to only catch $# and --# is included by accident, in which case it
>> is understandable).  It feels a bit strange to see that $# is
>> supported but not $?; --foo but not --foo=bar; foobar but not "foo
>> bar" inside a dq-pair.
>
> Yes, getting --# will be very rare in shell. I think it is better to seperate
> the --foo=bar into --foo and bar. I don't get what you man by the dq-pair.

These design decisions (e.g. what you decided are the tokens to be
taken as a word---taking "--foo" and "bar" as separate things when
given "--foo=bar" is a good example but with this regexp you are
making many other design decisions) need to be explained in the log
message.  A string inside a double-quote pair is taken as a single
parameter to the shell, e.g.

    cmd "arg that is quoted inside double-quote pair" $#

It is unclear what your regexp is doing to such an argument.

>> > +	 "|\\$[({]|[)}]|[-+*/=!]=?|[\\]&%#/|]{1,2}|[<>]{1,3}|[ \t]#.*"),
>> 
>> And this one is even more dense.

FYI, this is also pointing out the need to explain what kind of
things you wanted to recognise as words; explaining in a reply
message is a good first step, as the questioner may find the
explanation in your response still inadequate, in which case you
have a chance to refine it, but the ultimate goal is to put the
polished explanation that would help people who later want to
understand what you added to the codebase by describing what you
wanted to do with the change in either in-code comment or commit log
message when you send an updated patch.

Thanks.
