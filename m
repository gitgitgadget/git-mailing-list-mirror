Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEAC4332E
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1205B229C5
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgLUTKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:10:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60010 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUTKl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:10:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4D1298C96;
        Mon, 21 Dec 2020 14:09:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W51ajVngLKWg
        j6nLjvoyJ2OPeiM=; b=qUAtez3+ypfuc3APTZXybiPgN/RGp9yo2D+qlHTx6QM9
        IMBXD72BNB/uHXukAADfwpUUWJHklVAr2mWX7yz8Pkr5+Q9p6ek2zVRXCdNbfcP/
        hKZXutlrNHYygUzOX2+OaqlvBSP1U+l188+RKWbYeAGYiLQ53g1MQ4dAJ8HiTz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WX+8IV
        i1+e4q8oDirZ4wgBSSK9GtKtK40Y1xdzWp/M4KTGvpDqdqzv8hod08RpWF+jWSTm
        LG1dLhj0Qmn5NCUXz1HpaGK07M16uxy7yD95D+Ps50m8EOoO0dQvKGpzi1z2M5Ir
        m6yz/6iqRDr40cRGMuF27w7BaGinlucNohGNE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC52398C95;
        Mon, 21 Dec 2020 14:09:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50F0998C94;
        Mon, 21 Dec 2020 14:09:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     =?utf-8?Q?=C3=89rico?= Rolim <erico.erc@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] In git-log, --name-status flag overrides the --patch flag
References: <CAFDeuWOit1vKUT38Uvbj2wAsb5CBo59p2h=SE6FGNb6XGOGG-w@mail.gmail.com>
        <X+CgJCj7/tadldUg@danh.dev>
Date:   Mon, 21 Dec 2020 11:09:58 -0800
In-Reply-To: <X+CgJCj7/tadldUg@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Mon, 21 Dec 2020 20:16:20 +0700")
Message-ID: <xmqq5z4vm0vt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1EBDACEA-43C0-11EB-A017-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-12-20 01:23:05-0300, =C3=89rico Rolim <erico.erc@gmail.com> wro=
te:
>> Hi!
>>=20
>> When using the command
>>=20
>>   git log --patch --name-status
>>=20
>> It seems the name-status flag somehow overrides the patch flag, by whi=
ch I mean
>> that I get the same output as simply running
>>=20
>>   git log --name-status
>>=20
>> It would be nice for the combination of these two flags to work, as it=
 would
>> allow one to view both a summary of changed files as well as the chang=
es
>> themselves, at the same time.
>
> I'm not arguing if this your expectation is make sense or not,
> however, the Documentation says something about "Show only"...

Perhaps the documentation would need to be clarified?  I suspect
this is not very useful combination [*1*] and if this were years
ago, I would suggest making the command line error out, instead of
silently ignore one and keep the other one in effect.


[Footnote]

*1* "--patch --stat --summmary" was designed as the standard "both a
    summary as well as the changes".
