Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9255C1F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 09:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750765AbdKLJ4N (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 04:56:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57745 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750723AbdKLJ4L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 04:56:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C115AAA4D1;
        Sun, 12 Nov 2017 04:56:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=daiw8wTSx/bWMp2PPdNm06EmpZk=; b=pFHQPL
        +nRRT4HMam8uTceIWX40BZB3z2r2uQHg7dh3I7+IS/P2BHkWK3cz9fFWlr7U2JnU
        +u9w4GzzH/qb9OU6qmkvIdYz3u7jmoi6kHesioS2ELhrYRY2SHfL0jtaYI1kSluJ
        KGK6KW2e6QWEuj1NOzDswlHX6OGOxxJe1SrrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=msYiC1adK/By/K1Z7JFW7Ok36VnvrHux
        K8hLLjj/hOG284gJfTmgHvaWZ1j6G3slDH/dHpAM0icz46gYu4/2qRQtYOagET0M
        /sSCMH4yfoROhJ7ioIXnqtZVsvGFK2KDk9jn1PzoR7bfS/Y2Ped2cavmnABgG2by
        dowzYKDHRTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7E05AA4D0;
        Sun, 12 Nov 2017 04:56:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20513AA4CF;
        Sun, 12 Nov 2017 04:56:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: should "git bisect" support "git bisect next?"
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
        <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
        <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
        <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
        <alpine.LFD.2.21.1711120415190.28956@localhost.localdomain>
Date:   Sun, 12 Nov 2017 18:56:08 +0900
In-Reply-To: <alpine.LFD.2.21.1711120415190.28956@localhost.localdomain>
        (Robert P. J. Day's message of "Sun, 12 Nov 2017 04:17:20 -0500
        (EST)")
Message-ID: <xmqq4lpzddmv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5BE6108-C78F-11E7-86FC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>> This reminds me; is there a way to suppress it because I'm about to
>> give a large set of good and bit commits (perhaps because I'm
>                       ^^^^^^^^^^^^^^^^^^^^
>> replaying part of a git biset log, minus one or two lines that are
>> suspected of being bogus thanks to flaky reproduction), and so
>> there's no point having git bisect figure the "next" commit to try
>> until I'm done giving it a list of good/bad commits?
>
>   i'm sure i'll regret asking this, but (assuming "bit" should read
> "bad") is this suggesting one can hand bisect more than one bad
> commit? i thought we just went through that discussion where there
> could be only one bad commit but multiple good commits. clarification?

The documentation you have been futzing with is about the fact that
the initial set of known to be good/bad commits that "git bisect
start <bad> <good>..." take can have one bad and zero or more good.

What is being discussed in this thread is different (and I tried to
clarify the fact by saying "what bad and good commits in what
sequence").  

Ted is talking about replaying the series of "git bisect (good|bad)
$a_single_commit" that are recorded during a bisection session and
can be read via "git bisect log".  When Ted says "good commits"
and/or "bad commits", he is not talking about giving all of them to
a single invocation of "git bisect" command.  The replay session
will take one commit at a time (which is what "git bisect replay"
does) and feed it to either "git bisect good" or "git bisect bad".

Does it make sense?

By the way, I do not think there is anything to regret in asking
what you do not understand.  Showing how much you know (and you
don't) will allow others who communicate with you to calibrate their
expectations, which eases later discussions; it is a good thing.
