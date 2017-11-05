Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C11202A0
	for <e@80x24.org>; Sun,  5 Nov 2017 06:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750800AbdKEGRo (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 01:17:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63651 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750733AbdKEGRn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 01:17:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99389A3A02;
        Sun,  5 Nov 2017 01:17:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8DfUZ7YoiraA
        oGtdsgg3wx18woc=; b=etDlBpcO/CzoTvZQPQBht11sneH9/bgR3HNcsYy7+DIg
        SrUoGKQr9jE2Nkof5OKMMfDvW4IvV2B6F5LMPP3ZIW4EMGm8YDb0xiAj9fy2cP13
        onc483/i/8uJWm3HHNjkpMq93TWX6E+STGxb11tQaBXwM45mMh5HCFBRreEif3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nWXMs7
        IARGtP0pqiMyaZvQfawiz6jhq9EaEnRFNqluI0wEzx6wfGD+6v2RUoxbssdgY8ez
        ZlouRN9ksjIHt8o5Lq+Pqrhd37iz8plkwVj4jykHexLKTJIvwr/UMjjsIAnav3eX
        2LJRQfR81wYWio7npi0IiKplJFjE59ibwc8qM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FE01A3A01;
        Sun,  5 Nov 2017 01:17:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F125BA3A00;
        Sun,  5 Nov 2017 01:17:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org
Cc:     me@ikke.info, hjemli@gmail.com, mhagger@alum.mit.edu,
        pclouds@gmail.com, ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-3-rafa.almas@gmail.com>
        <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
        <b0e3856b-e627-0d22-90da-3da1781f98b3@gmail.com>
        <xmqq1sldmqms.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 05 Nov 2017 15:17:40 +0900
In-Reply-To: <xmqq1sldmqms.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 05 Nov 2017 11:00:11 +0900")
Message-ID: <xmqqshdtl057.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07D3E480-C1F1-11E7-BED7-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:
> ...
>> Because changing the default behavior of that function has
>> implications on multiple commands which I think shouldn't change. But
>> at the same time, would be nice to have the logic that deals with
>> glob-ref patterns all in one place.
>>
>> What's the sane way to do this?
>
> Learn to type "--decorate-refs=3D"refs/heads/[m]aster", and not twewak
> the code at all, perhaps.  The users of existing "with no globbing,
> /* is appended" interface are already used to that way and they do
> not have to learn a new and inconsistent interface.
>
> After all, "I only want to see 'git log' output with 'master'
> decorated" (i.e. not specifying "this class of refs I can glob by
> using the naming convention I am using" and instead enumerating the
> ones you care about) does not sound like a sensible thing people
> often want to do, so making it follow the other codepath so that
> people can say "refs/tags" to get "refs/tags/*", while still allowing
> such a rare but specific and exact one possible, may not sound too
> bad to me.

Having said all that, I can imagine another way out might be to
change the behaviour of this "normalize" thing to add two patterns,
the original pattern in addition to the original pattern plus "/*",
when it sees a pattern without any glob.  Many users who relied on
the current behaviour fed "refs/tags" knowing that it will match
everything under "refs/tags" i.e. "refs/tags/*", and they cannot
have a ref that is exactly "refs/tags", so adding the original
pattern without an extra trailing "/*" would not hurt them.  And
this will allow you to say "refs/heads/master" when you know you
want that exact ref, and in such a repository where that original
pattern without trailing "/*" would be useful, because you cannot
have "refs/heads/master/one" at the same time, having an extra
pattern that is the original plus "/*" would not hurt you, either.

This however needs a bit of thought to see if there are corner cases
that may result in unexpected and unwanted fallout, and something I
am reluctant to declare unilaterally that it is a better way to go.

Thoughts?
