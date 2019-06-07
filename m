Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2381E1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfFGRD4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 13:03:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64171 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfFGRD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 13:03:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E32A72DF6;
        Fri,  7 Jun 2019 13:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Nqh7nSzaDGR9
        iLxZ/p0B9HZjcbY=; b=ML4boDbOTBcDCKQ2Wz9qi81ui7jJBqJmLmwj4rUs1AFe
        ZYoFXbB2+DUsvsHzhRQEISg0oBaYil9S0uXchQEG8l3YhAeRGdCJAzcZd2aDk3AY
        rd9KNYLXld3d/Rgf8KEi1h2pHPvk6n1+fgVeomvZR7TKXXpA10j4DlXS5hLEYuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=r+rCwv
        t1LTgESiuR2LzSQLe9AHPG3MKKbey/ZGnCpF0jVfHdSMTx0u/tAMWsts402WcPpj
        cAwh6iNTxZCIbB3arr1KFZqfCvM6+tlGfTWYLM+o6RadLUZx9dhSrdvnCefoVE11
        2wSvRlBkYAy6HuK5uIxIhlO0G/XdQHyiMusVM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 967BB72DF5;
        Fri,  7 Jun 2019 13:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC47472DF3;
        Fri,  7 Jun 2019 13:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Osipov\, Michael" <michael.osipov@siemens.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] configure: Detect linking style for HP aCC on HP-UX
References: <6aabf669-a73f-d23d-8d65-8b96eefbae4b@siemens.com>
        <20190516093412.14795-1-avarab@gmail.com>
        <c12ec5ff-87c9-a6d0-e9f6-6d7e1cf343c5@siemens.com>
Date:   Fri, 07 Jun 2019 10:03:45 -0700
In-Reply-To: <c12ec5ff-87c9-a6d0-e9f6-6d7e1cf343c5@siemens.com> (Michael
        Osipov's message of "Fri, 7 Jun 2019 16:51:19 +0200")
Message-ID: <xmqqr285pbta.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3721CE78-8946-11E9-AFBC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Osipov, Michael" <michael.osipov@siemens.com> writes:

> Am 2019-05-16 um 11:34 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> From: Michael Osipov <michael.osipov@siemens.com>
>>
>> HP aCC does not accept any of the previously tested CC_LD_DYNPATH
>> formats, but only its own[1] "-Wl,+b" format. Add it to configure.ac.
>>
>> 1. http://nixdoc.net/man-pages/hp-ux/man1/ld_pa.1.html
>>
>> Signed-off-by: Michael Osipov <michael.osipov@siemens.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>>
>> I took the liberty of slightly amending the commit message.
>>
>>   configure.ac | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index be3b55f1cc..a43b476402 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -475,8 +475,18 @@ else
>>         if test "$git_cv_ld_rpath" =3D "yes"; then
>>            CC_LD_DYNPATH=3D-rpath
>>         else
>> -         CC_LD_DYNPATH=3D
>> -         AC_MSG_WARN([linker does not support runtime path to dynamic=
 libraries])
>> +         AC_CACHE_CHECK([if linker supports -Wl,+b,], git_cv_ld_wl_b,=
 [
>> +            SAVE_LDFLAGS=3D"${LDFLAGS}"
>> +            LDFLAGS=3D"${SAVE_LDFLAGS} -Wl,+b,/"
>> +            AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_wl_b=
=3Dyes], [git_cv_ld_wl_b=3Dno])
>> +            LDFLAGS=3D"${SAVE_LDFLAGS}"
>> +         ])
>> +         if test "$git_cv_ld_wl_b" =3D "yes"; then
>> +            CC_LD_DYNPATH=3D-Wl,+b,
>> +          else
>> +             CC_LD_DYNPATH=3D
>> +             AC_MSG_WARN([linker does not support runtime path to dyn=
amic libraries])
>> +          fi
>>         fi
>>      fi
>>   fi
>>
>
> I can see that this one has not yet been committed nor my PR has been
> pulled.
>
> Any chances to get this into master?
>
> Michael

Sorry, it jsut fell of the cracks.  The way the new test was added
looks very good --- any platform that is happy with the existing
test will continue to function the same way, and a platform that
knows -Wl,+b would use it instead of failing.

Will pick it up.

Thanks.
