Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43EAD2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 02:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdKVCJN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:09:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63177 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751443AbdKVCJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:09:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98BFFAFCB2;
        Tue, 21 Nov 2017 21:09:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hthnow84zAyl
        wKMyezg5EpJYcYY=; b=tLSMsCGaudsejH5Y23H/8hAhSB5HVU5Q0Xa5xYfV73bp
        bDMJh4q4Rr4LDuVqU7rUH5SY4VptC7LekXeLacQCXszJH/o37q8DKj7yTzgqyqXI
        6rd47wqVsl3HTJ/kfZAKTaEAEZG7o81ZpouB8ZdcjNHcy9idhf/kDHonlWQo9n8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nIxLmG
        SbiCzYdw5VnKoO+rKmdLNZ9/KWE98ze+tPPlOZJZY3zVWjesBfSjliW9VWYUoJoB
        sRXQGTFFKtgwhzxY6+cq4C85S/MEAPuy1DSKq4J11OX0fq5L1sJdyIer3e6eWp9z
        MDzb6tOAftK+d/ci8bqBjx1HYn1vlPh622BDc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9017BAFCB1;
        Tue, 21 Nov 2017 21:09:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03053AFCB0;
        Tue, 21 Nov 2017 21:09:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] builtin/branch: strip refs/heads/ using skip_prefix
References: <20171121141852.551-1-kaartic.sivaraam@gmail.com>
        <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com>
        <60caf5c8-4dc3-481a-80d6-37a697e31b52@gmail.com>
        <CAPig+cRK8+pzf3EWuoG+36CRNaaGv6CQk27d4CrzTv=8beoQGg@mail.gmail.com>
Date:   Wed, 22 Nov 2017 11:09:09 +0900
In-Reply-To: <CAPig+cRK8+pzf3EWuoG+36CRNaaGv6CQk27d4CrzTv=8beoQGg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 21 Nov 2017 14:22:12 -0500")
Message-ID: <xmqqeforxdx6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 212D928C-CF2A-11E7-B331-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Nov 21, 2017 at 2:12 PM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> On Wednesday 22 November 2017 12:08 AM, Eric Sunshine wrote:
>>> The original code unconditionally uses "+ 11", which says that the
>>> prefix is _always_ present. This commit message muddies the waters [.=
..]
>>
>> That muddiness of that statement is a consequence of my recent encount=
er[1]
>> in which the assumption (that the prefix(refs/heads/ always exists) of=
 that
>> code failed. I had a little suspicion, when I wrote that commit messag=
e,
>> that there might be other cases in which assumption might fail. The is=
sue
>> has been resolved only in 3/4 of jc/branch-name-sanity but that was on=
ly
>> after I wrote the commit message initially.  So, it does make sense to
>> remove that muddiness now. Thanks for noting that.
>>
>> [1]: Note the 'warning: ' message in the following mail. That ugly '|=EF=
=BF=BD?' was
>> a consequence of the assumption that the 'prefix' always existed!
>> https://public-inbox.org/git/1509209933.2256.4.camel@gmail.com/
>
> Thanks for the explanation and history reference.

I have a suspicion that it wasn't the case.  The ugly uninitialized
byte sequence came from an error codepath of a function that is asked
to fill a strbuf with "refs/heads/$something" returning early when it
found an error in the input, without realizing that the caller still
looks at the strbuf even when it got an error.  That caller-callee pair
was updated.

It is just a bug and +11 is always correct; passing the data that
does not begin with "refs/heads/" there, including the case where an
uninitialized buffer is passed, is simply a bug.

In other words, skip_prefix() is a good change, but if we are to use
it, we should also check the result and error out if we do not see
"refs/heads/" there--you already bothered to spend extra cycles for
that.
