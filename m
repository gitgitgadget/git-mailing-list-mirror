Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B5920899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbdHQVa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:30:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55228 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752632AbdHQVa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:30:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 882C1ADE9D;
        Thu, 17 Aug 2017 17:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mEiwF4eMODz2pq+nV6ze9Ni70r0=; b=iNpHTj
        2Omx7XFjHqgQVUpl3dlOCKFuB2asJk8ndvl8iyzU8ophUOibd2ShHb58BbwQagkz
        CayfqXxharDD7JYp1iOOY69dZ4bt3/NkUaXteoFBolU2H8WHHLQ0SPdYbH19ZsyT
        9x/tCPigH6G9F4ZZ1OLq2gdhiHiE39wQcQ8/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mwR/IPSCPz1yPYUk21VlZaMvfWYeLGuy
        XQyWNUbkoI+Nr9WL8H1IIh73GfWJmpMu6389MsgQTO6/HBuQ4kgi/zXheH+Z8+e7
        6QFBYkwEf39UuJfiY2Wg5klLFG5+CheGMENHKdVsjjIvu6hQnE+r9gUR9i6t96Tw
        mGVkMZpw1ic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80B51ADE9C;
        Thu, 17 Aug 2017 17:30:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCB34ADE99;
        Thu, 17 Aug 2017 17:30:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 14:30:53 -0700
In-Reply-To: <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 06:22:17 -0400")
Message-ID: <xmqqy3qhevaq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59D33282-8393-11E7-832F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 17, 2017 at 10:27:09AM -0700, Jonathan Nieder wrote:
>
>> > --- a/t/t1402-check-ref-format.sh
>> > +++ b/t/t1402-check-ref-format.sh
>> > @@ -161,6 +161,10 @@ test_expect_success 'check-ref-format --branch from subdir' '
>> >  	test "$refname" = "$sha1"
>> >  '
>> >  
>> > +test_expect_success 'check-ref-format --branch from non-repo' '
>> > +	test_must_fail nongit git check-ref-format --branch @{-1}
>> > +'
>> > +
>> >  valid_ref_normalized() {
>> >  	prereq=
>> >  	case $1 in
>> 
>> I don't think it's right.  Today I can do
>> 
>> 	$ cd /tmp
>> 	$ git check-ref-format --branch master
>> 	master
>> 
>> You might wonder why I'd ever do such a thing.  But that's what "git
>> check-ref-format --branch" is for --- it is for taking a <branch>
>> argument and turning it into a branch name.  For example, if you have
>> a script with an $opt_branch variable that defaults to "master", it
>> may do
>> 
>> 	resolved_branch=$(git check-ref-format --branch "$opt_branch")
>> 
>> even though it is in a mode that not going to have to use
>> $resolved_branch and it is not running from a repository.
>
> I'm not sure I buy that. What does "turning it into a branch name" even
> mean when you are not in a repository? Clearly @{-1} must fail. And
> everything else is just going to output the exact input you provided.

This "just going to output the exact input" is not entirely correct;
there is just one use case for it.

"git check-ref-format --branch a..b" would fail with a helpful error
message, while the command run with "a.b" would tell you the name is
safe.

Use of 'check-ref-format --branch "@{-1}"' *IS* a nonsense, whether
it is inside or outside a repository; it is OK to fail it outside a
repository and I would say it is even OK to fail it inside a
repository.  After all "check-ref-format" is about checking if the
string is a sensible name to use.

I think calling interpret_branch_name() in the codepath is a mistake
and we should instead report if "refs/heads/@{-1}" literally is a
valid refname we could create instead.
