Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178EC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiA0S3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:29:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61441 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiA0S3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:29:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C15BE17F72D;
        Thu, 27 Jan 2022 13:29:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hZqR2HpHhcvS
        E7Uz1bEX+qhhCMX0iR6/h9U91BOYK6E=; b=YOKCfgvGGvTjnXV4bKy/T292prON
        A58Od39TwRMuviWYLOjc00M7z26gAG4QLMyzrQjBI44ZS9uYIvtQXPwSC4XHaWCR
        g6qBnGuXGq1dGIq9/uwVM5s2B1SnYSdhsYxv/4NercuPG8FKsLmEdnw/vA5y89vH
        Rs+FJ3npg6/F81w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A467017F72C;
        Thu, 27 Jan 2022 13:29:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0BE8D17F72B;
        Thu, 27 Jan 2022 13:29:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        me@ttaylorr.com, jeffhost@microsoft.com
Subject: Re: [PATCH v2] test-lib: unset trace2 parent envvars
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
        <2b5e573c22f226cbdb07d931d470a37bca7ffe2b.1643234866.git.steadmon@google.com>
        <220127.86r18tdeve.gmgdl@evledraar.gmail.com>
Date:   Thu, 27 Jan 2022 10:29:38 -0800
In-Reply-To: <220127.86r18tdeve.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 27 Jan 2022 04:23:10 +0100")
Message-ID: <xmqqlez12fsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 16CBEC88-7F9F-11EC-BD12-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 0f7a137c7d..faf25ba1b2 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -432,7 +432,7 @@ EDITOR=3D:
>>  unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
>>  	my @env =3D keys %ENV;
>>  	my $ok =3D join("|", qw(
>> -		TRACE
>> +		TRACE	# Allow tracing in general, but see unsets below.
>
> I think it would be good to turn that -e into a -we, which would tell
> you why this doesn't work the way you think:
>
>     Possible attempt to put comments in qw() list at -e line 14.
>     Possible attempt to separate words with commas at -e line 14.
>
> I.e. you added one string "#" to the array, and a string "Allow" etc.

Having an expert who can spot these things at first glance is handy
;-).  Very much appreciated.

In any case, the previous iteration has been in 'next' long enough
without causing trouble for those who use a variant based on 'next'
at $DAYJOB, I presume, so my recommendation is to just let it
graduate first, and pursue your suggestion to do more things in this
scriptlet (below, omitted) as a "further improvement" on top.

Thanks.
