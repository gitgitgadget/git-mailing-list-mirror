Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD0C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2FB2075B
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbhAQXhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:37:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58598 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbhAQXhr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:37:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4597611618F;
        Sun, 17 Jan 2021 18:37:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nAEJexLw7pZB
        eVFh/QirQnyp0jM=; b=jzH5KHitVPlbRVbK3PAnDC+pDHy9IDw7mT7eY7BFLRwO
        KtpvyULI8Fi6K0TxFxlomvxxjiPtLCg4zYgEQ9Jo6l5m0S4EPwXvuOXEIVcDU6I9
        DXEgwoVyEfOSNtnrIcR0R4UWP2A5O2lCIDtJe+YUu4298ED+YzaVvwXH/GiUoCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MSZ58a
        70Y+KuxtVG7Z/lrgR8dHs7+rDHcl5+h52S3NA7AcWg+NXbty74xYiCB2Kj0mtiYu
        xAp3Dk9MwGN1Q0eoNkE/F6VcOpGAn54EHRX5/Zez0kdPOCQG+ESwZItSY/2SZE6D
        avOq673nE/fdDvhaAKXoURcDjy3Y4sYoqCVwI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E44411618E;
        Sun, 17 Jan 2021 18:37:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86DCE11618D;
        Sun, 17 Jan 2021 18:37:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/11] cache-tree tests: use a sub-shell with less
 indirection
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-3-avarab@gmail.com>
        <YARsCsgXuiXr4uFX@coredump.intra.peff.net>
Date:   Sun, 17 Jan 2021 15:37:00 -0800
In-Reply-To: <YARsCsgXuiXr4uFX@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 17 Jan 2021 11:55:38 -0500")
Message-ID: <xmqq7dobkueb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E67A2E0E-591C-11EB-B428-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jan 16, 2021 at 04:35:45PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
>> index 354b7f15f7..2e3efeb80e 100755
>> --- a/t/t0090-cache-tree.sh
>> +++ b/t/t0090-cache-tree.sh
>> @@ -27,20 +27,15 @@ generate_expected_cache_tree_rec () {
>>  	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_c=
ount" &&
>>  	for subtree in $subtrees
>>  	do
>> -		cd "$subtree"
>> -		generate_expected_cache_tree_rec "$dir$subtree" || return 1
>> -		cd ..
>> +		(
>> +			cd "$subtree"
>> +			generate_expected_cache_tree_rec "$dir$subtree" || return 1
>> +		)
>>  	done
>
> We don't check that "cd" worked either before or after your patch.
> Should we?
>
> After your patch, we "return" from inside a subshell. Is that portable?
> ISTR issues around that before, but it just have been when we are not i=
n
> a function at all. Still, I wonder if:
>
>   for ...
>   do
> 	(
> 		cd "$subtree" &&
> 		generate_expected_cache_tree_rec "$dir$subtree"
> 	) || return 1
>   done

Thanks, I missed that bogus/confusing return.

>
> might be more obvious.
>
>> -generate_expected_cache_tree () {
>> -	(
>> -		generate_expected_cache_tree_rec
>> -	)
>> -}
>
> I wondered what the "rec" was for, but I guess it is "recurse". Not a
> problem to keep it, but I wonder if it could be dropped in the name of
> shortness/simplicity (not worth a re-roll for sure, but maybe worth
> doing so if you re-roll for the above issues).
>
> -Peff
