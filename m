Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7C82021E
	for <e@80x24.org>; Tue, 15 Nov 2016 18:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbcKOSvY (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 13:51:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60818 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751081AbcKOSvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 13:51:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62CC34F5D7;
        Tue, 15 Nov 2016 13:51:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dPQmP4gl4rdl+e41YiMTu3ZdCl8=; b=olr0gb
        GcakbxtebDuTdwfYYBX9aZSpjedRaPAkFXzVi6uFM9BzJyn+PeiagUYXf51M/tYE
        9V14vrQNhQsr1yDl18hNJgL69t0ANZGune0quMbs179rahWOX0q4vBFqJjKT50pC
        l8yWnxEse+h/blYe0jXZDAmhKY2x2EimmQKt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sCkKd+MeWLPTwvADS0jUF4m1fiWmBqgc
        KdB959gpGg5CkiPR0R73kWa2VrNsh3FtMhNtMqtHCd1+rWCkGez0PVpAEqSFk5X4
        ajOXwEwV9vls4s7IqjMluOsRV5Xy4OSs2rCoqmGtWpFDYDfE/PIQDPvfIafIwzsL
        g5MxrXcDgeE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B0584F5D6;
        Tue, 15 Nov 2016 13:51:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD2004F5D5;
        Tue, 15 Nov 2016 13:51:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Rood <mr.john.rood@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ignore blank line removals
References: <CALj-rGcSrbAiyxPOYD1KCacK_gqi3T5_R=e0H_UfBTqLb5VRmg@mail.gmail.com>
        <CALj-rGdRDa0EU6AeMHWYketr5QBOnV7-3RKraiuPCk=Aepz=pQ@mail.gmail.com>
Date:   Tue, 15 Nov 2016 10:51:20 -0800
In-Reply-To: <CALj-rGdRDa0EU6AeMHWYketr5QBOnV7-3RKraiuPCk=Aepz=pQ@mail.gmail.com>
        (John Rood's message of "Tue, 15 Nov 2016 11:56:58 -0600")
Message-ID: <xmqqr36ctw47.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 804673F0-AB64-11E6-A417-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Rood <mr.john.rood@gmail.com> writes:

> On Thu, Nov 3, 2016 at 10:57 AM, John Rood <mr.john.rood@gmail.com> wrote:
>> If the contents of a file initially are:
>>   one
>>
>>   three
>> and on branch A there is a commit, removing the blank line:
>>   one
>>   three
>> and on branch B there is a commit, adding 'two':
>>   one
>>   two
>>   three
>> Normally, if you try to merge A into B (or B into A), git recognizes a
>> decision needs to be made between removing the second line or add
>> "two" to the second line. It would be convenient to have a merge
>> strategy that defaults to the latter in cases where the removed line
>> was a blank line (or a line containing only whitespace) ...something
>> like -Xignore-blank-line-removals.
>
> Is there any push-back on this, or is there a backlog that we can add
> this feature to?

If you mean by "push-back" objections that say "this feature is evil
and should not be added to Git, ever", I do not think we saw any on
the list.  The lack of response is most likely that everybody
thought "Meh." aka "It is not useful/interesting/valuable enough
feature to bother discussing."

One thing I wondered was what you would want if the contents were
one/three without blank, A added blank between the two and B
replaced blank with two.  As your example shows, in the filetype you
are dealing with, a blank line has no significant meaning (otherwise
you won't be ignoring the change A made to remove the blank in your
original example).  The outcome desired by you may be one/two/three
without any blank in that case because of that.  Which would lead to
the suspicion that ignore-blank-line-removals is not a good general
feature (i.e. in this other example, you want to ignore blank line
addition).  Which further leads to the suspicion that the desire you
expressed in the original post is not well thought through to be a
useful specifification to build anything out of (yet), but is merely
a potentially interesting discussion starter.  And nobody so far
found it interesting enough to spend time discussing it further to
make the wish detailed enough to be called a "design" of a new
feature.

Having said all that.

I suspect that you may not have to make any change to Git to do what
you want; can't you just use the 'merge' attribute with a custom
3-way merge driver that removes an empty line?

