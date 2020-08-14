Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C1C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C596720708
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YhMcfZKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgHNR02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:26:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56569 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHNR01 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 13:26:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 928C17F176;
        Fri, 14 Aug 2020 13:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k+DxhZTq6+iv
        lOCcLbX6PSlTw9U=; b=YhMcfZKj9724eQhH0Wz0tUwez6WNlia0cbhcW8q6BBM0
        oQguL202J1wrTc79Ab4X5427guidPHcp/TsJVEGimyCn8ZtITjH4sEq+nkXVvY+T
        dnHuGwmjsJmtPdnBCg9/8POrPqNyxWRkx+412vLvXApIfqFGgNftta2hchptxFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mQOijG
        qO4y3jJu7mZ9/vu/heBfrYBGYqcCfT3RKKLzlJspApCbj+r4PILmgOACGdGDG76K
        SZAVEMGe00+1czf8U6n3n6XzUydkzUVnGFvoPS34qLfJKnDSlm801AC+izh5lB/r
        gx47exsuKaeIshAQT1QYltC5tPFF1Aykt4KmQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 899E47F175;
        Fri, 14 Aug 2020 13:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1063A7F174;
        Fri, 14 Aug 2020 13:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexander Ost <ost@ieee.org>, Git List <git@vger.kernel.org>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
        <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
        <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
        <20200814150214.GC9518@danh.dev>
Date:   Fri, 14 Aug 2020 10:26:24 -0700
In-Reply-To: <20200814150214.GC9518@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Fri, 14 Aug 2020 22:02:14 +0700")
Message-ID: <xmqqo8ndxhof.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4776E818-DE53-11EA-BF38-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> Thanks.  Perhaps something along this line (which is totally
>> untested), as the top-level Makefile already exports
>> NO_INSTALL_HARDLINKS to submakes?
>>=20
>>=20
>>=20
>>  Makefile | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index f10caedaa7..1cdbf8e504 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -44,6 +44,11 @@ endif
>>  ifndef INSTALL
>>  	INSTALL =3D install
>>  endif
>> +ifdef NO_INSTALL_HARDLINKS
>> +	LN =3D cp
>
> Since both git-citool and git-gui will be installed into same
> directory "$(libexecdir)", I think it would make more sense to use:
>
> 	LN =3D ln -s
>
> here instead?

In the top-level Makefile, INSTALL_SYMLINKS make macro does exist,
but it is not exported to submakes.  If it were, something like

    ifdef INSTALL_SYMLINKS
	LN =3D ln -s
    else
    ifdef NO_INSTALL_HARDLINKS
	LN =3D cp
    else
	LN =3D ln
    endif
    endif

might become possible, but you'd need to audit what is fed to $(LN)
at the locations the macro is used and make necessary adjustment
accordingly.  "cp A ../B" or "ln A ../B" will make a usable copy of
file A appear inside ../B directory, but "ln -s A ../B" will not,
and I didn't see if all uses of $(LN) was to give synonyms to what
is already installed, or some of them were truly installing from the
build location when I gave the "something along this line" example.



