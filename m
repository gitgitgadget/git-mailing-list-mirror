Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C059520437
	for <e@80x24.org>; Sat, 14 Oct 2017 02:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbdJNCI7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 22:08:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63151 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752769AbdJNCI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 22:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79A619DCA5;
        Fri, 13 Oct 2017 22:08:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aGL3hFePlbCoZP/fIVsKHcsWr8E=; b=XzpVEh
        1w1vFs61iAY612/hbHWz5QkhyXf32pbDygh8xdRAv09ac2fWxUV/Ujq8XfvT5Tt8
        KLfr6mmr4i3sn7ZGZ1Ja9k7Hg4R2LwkcGbnhmuhblCAeaMklRDjvKl7Wk6j5Zaa1
        ZtYEX7qodj60mTAt1GvNjOzuVn3c/0XJdH5sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=woxTyy3cGz4LSV6s7tHOw2xSakDLzR6u
        cbJha68eollV6s0VqQxZu/lht03axQvysFcokiRRnb1yL7DX9tjdBHwfY+oXgAcg
        9YtGHI1FiyDR6njQlwZQOWDEKnb9DmMhJZP7YtZxUuxhS3haR2ZUJGnEoG9hL0Sj
        PPGYQst2YKU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71D699DCA4;
        Fri, 13 Oct 2017 22:08:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB27B9DCA3;
        Fri, 13 Oct 2017 22:08:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <cover.1507205895.git.johannes.schindelin@gmx.de>
        <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
        <20171013163923.GA5598@alpha.vpn.ikke.info>
Date:   Sat, 14 Oct 2017 11:08:53 +0900
In-Reply-To: <20171013163923.GA5598@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Fri, 13 Oct 2017 18:39:23 +0200")
Message-ID: <xmqqinfiv5u2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A176D71A-B084-11E7-8F00-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Thu, Oct 05, 2017 at 02:19:15PM +0200, Johannes Schindelin wrote:
>> From: J Wyman <jwyman@microsoft.com>
>> [..] 
>> 
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 39f50bd53eb..22767025850 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -142,8 +142,9 @@ upstream::
>>  	encountered. Append `:track,nobracket` to show tracking
>>  	information without brackets (i.e "ahead N, behind M").
>>  +
>> -Also respects `:remotename` to state the name of the *remote* instead of
>> -the ref.
>> +Also respects `:remotename` to state the name of the *remote* instead
>> +of the ref, and `:remoteref` to state the name of the *reference* as
>> +locally known by the remote.
>
> What does "locally known by the remote" mean in this sentence?

Good question.  I cannot offhand offer a better and concise
phrasing, but I think can explain what it wants to describe ;-).

For a local branch we have (say, 'topic'), there may be different
things outside this repository that regularly interact with it.

We may update 'topic' with work others did, by

	git checkout topic && git pull

without any extra command line argument to "git pull".  We are
pulling from the 'upstream' of the 'topic', which is a branch in a
remote repository, and the (nick)name of the remote is :remotename.
When we do this pull, we would grab one of the branches the remote
has and merge it into our 'topic'.  IOW, when the above command line
is written in longhand, the "git pull" step may look like this [*1*]:

	git pull origin devel

if we were building on top of the 'devel' branch at the 'origin'
remote.  The full refname of that branch, 'refs/heads/devel', is
:remoteref, and that is the reference locally known to the 'origin'
remote.

The "locally known by the remote" is an attempt by the patch authors
to stress the fact that the result is not refs/remotes/origin/devel
(which is where _you_ would keep a local copy of that reference in
this repository).

Two other things outside this repository that interact with 'topic'
are where the result of our work is pushed out to, which is a branch
at the 'push' remote.


[Footnotes]

*1* Modulo the details of other refs fetched that are unrelated to
    the resulting merge and local copies stored as remote-tracking
    branches in this repository.


