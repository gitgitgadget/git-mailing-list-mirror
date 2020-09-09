Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8800C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655332080C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZNcWFq01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIUDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:03:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51954 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 16:03:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA2EC6C955;
        Wed,  9 Sep 2020 16:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oyaOnvzHmaZV
        q9Ytw0gxQiiW4XU=; b=ZNcWFq01KmPtcjtyYhNDBxDm0412wgToAslTJRrsPlTX
        m8XRW7lNp9w26xmT/7b+ljXwq5IKt5+/onGUG94jCPsuNziBm49bIRUuNN+uiVC3
        v2vd/V/uuFZV7e2f2WHuRqoG6MNqDuIArefVzjFJeaVgSgb1OvjuwQWj95jE7MI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GL0dHc
        5GPELLpwjq8u7hjEprrLke9lHFERXczsOQeLuzHuW2ddEE2Q5J7xkH0lEpsWBz9v
        jq0EOfPJPbPAQVOQ5ahcjqYUh8fAMDhlcr8kg38ODnNjImaelu4ipYsboTHvSzUY
        EXtmX6pP5yyeqzrMBd1Jgbf7yKQl/TbZcop0Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA1CC6C954;
        Wed,  9 Sep 2020 16:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8A856C952;
        Wed,  9 Sep 2020 16:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
References: <20200907171639.766547-1-eantoranz@gmail.com>
        <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
        <20200909091149.GB2496536@coredump.intra.peff.net>
        <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
        <20200909191345.GA2511547@coredump.intra.peff.net>
        <20200909191746.GA2514794@coredump.intra.peff.net>
        <0773b560-b456-fc88-42d7-f214246ddd1b@web.de>
Date:   Wed, 09 Sep 2020 13:03:06 -0700
In-Reply-To: <0773b560-b456-fc88-42d7-f214246ddd1b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 9 Sep 2020 21:54:55 +0200")
Message-ID: <xmqqa6xyvhtx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A9B7752-F2D7-11EA-AB0F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> diff -u -p a/packfile.c b/packfile.c
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -735,7 +735,7 @@ struct packed_git *add_packed_git(const
>>  	p->mtime =3D st.st_mtime;
>>  	if (path_len < the_hash_algo->hexsz ||
>>  	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
>> -		hashclr(p->hash);
>> +		oidclr(p);
>>  	return p;
>>  }
>>
>>
>> Maybe it's worth being looser in our cocci patch definitions. I'm havi=
ng
>> trouble thinking of a downside...
>
> For transformations that change the type as in the example above we
> should insist on getting the right one, otherwise we might introduce
> bugs -- like in the example above.  p points to a struct packed_git and
> not to a struct object_id, so this introduces a type mismatch.

;-)  A good counter-example.

> We better make sure our semantic patches are safe, otherwise we have to
> check all conversions very carefully, and then we might be better off
> doing them manually..

Yes, that is a sensible suggestion.

