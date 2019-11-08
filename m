Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1B41F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 12:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfKHMtM (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 07:49:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63732 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfKHMtM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 07:49:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70ED69EC1E;
        Fri,  8 Nov 2019 07:49:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=st4PYdLahRYyP5dM90i3LXyLfjU=; b=mBLB6g
        6ppyXz6YzPValEo2qtV9SanX/tHTDfsax1IwGHj298Lfu7TGj8SoicHsdDpY9w63
        3UdAWXGogwlDznpbUqq44innGUR0Pe+JpBNC+hbgXnAdYyeHoqnkrCBHmeDMKwMn
        rNHlWKNayUDP7TiObvKEJ82DW9WGwQylm83Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tYbVg7khKSQzHiMN4MBqq+Vd4RuGfTlt
        muMSSStlLIBRNtqZCJ4Almw6JXjnc/c5JrhDWDV4Dm1oTqvD7PFBBiYHGJ2HJFP3
        yAhH48oNAbWAxIqpngNYOkU3bvoPCJRNsqkWX0Uj66ImFMmNwGGviOFKBIkoZnd+
        3bcjNKUNEqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D3A49EC1D;
        Fri,  8 Nov 2019 07:49:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A4D59EC1C;
        Fri,  8 Nov 2019 07:49:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 01/14] t: teach test_cmp_rev to accept ! for not-equals
References: <cover.1571739459.git.liu.denton@gmail.com>
        <cover.1573152598.git.liu.denton@gmail.com>
        <0d0696f310a6f8e13ed480b1a1e91cdc2debaa20.1573152599.git.liu.denton@gmail.com>
        <xmqqpni3nj8j.fsf@gitster-ct.c.googlers.com>
        <20191108082310.GA2497@generichostname>
Date:   Fri, 08 Nov 2019 21:49:02 +0900
In-Reply-To: <20191108082310.GA2497@generichostname> (Denton Liu's message of
        "Fri, 8 Nov 2019 00:23:10 -0800")
Message-ID: <xmqqa796mt35.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 253FA5FA-0226-11EA-95E7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> >  		local r1 r2
>> >  		r1=$(git rev-parse --verify "$1") &&
>> >  		r2=$(git rev-parse --verify "$2") &&
>> 
>> If either of the calls fail, the assignment itself would fail, and
>> the &&-cascade would stop without executing the if statment below.
>> 
>> I see the "!" feature, but where is the promised "fix" for
>> segfaulting rev-parse?
>> 
>> Puzzled.
>
> I suppose your puzzlement comes from my badly worded commit message
> above. I meant to say that in the _hypothetical_ case that 
> `git rev-parse` segfaults, it wouldn't be caught because we're
> blanket-ignoring failures if we do `! test_cmp_rev`.
>
> But I suppose I focused too much on segfaults. I guess I didn't realise
> that the problem is more general than that; any failure of 
> `git rev-parse` should be reported.

But if that is the case, shouldn't the part that runs two rev-parse
read more like this?

	r1=$(git rev-parse --verify "$1") ||
		error "'$1' does not name a valid object"
	r2=$(git rev-parse --verify "$2") ||
		error "'$2' does not name a valid object"
	if ! test "$r1" $op "$r2"
	then
		... they do not compare the same ...
	fi

Offhand I do not know if the current callers depend on being able to
pass a string that is not an object name in either $1 or $2 and a
valid object name in the other one, and relying on the helper
function to say "$1 and $2 are different!"  If such callers exist, a
defensive change like the above that requires the caller to always
pass valid object names would need to be accompanied with changes to
these callers, too.  Overall, I think that would give us a better
end result, but it might be a bit more work.

Thanks.
