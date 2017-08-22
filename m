Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7691F667
	for <e@80x24.org>; Tue, 22 Aug 2017 18:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbdHVSM3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 14:12:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62417 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752483AbdHVSM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 14:12:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48428A667E;
        Tue, 22 Aug 2017 14:12:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xzoTZfpfX5B0
        RnxaQ4DnDYXfApE=; b=hF2X2QER0eJFW1MUzwT1MCgr5+bWuHbZdC721+VxHgez
        HJoEziCE7ahU2QLSVq+z6kvE+7Ih1VYH3KVHXM4b9VgllZVzjeXBpkyrMhpYQpR/
        XlYhRSKYAS3zvbW/LzO4eZ01/1XjouyWw2AqND7A86kFtZVJQKlWubtntNqICq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nsB0g2
        8SGESoVGN3KhRv8QYB1U/yUOTvXsmhc+KOQ+RJzLFEBki/VvmXWLxMZYkShG9dg0
        ZhKm92JspYOKa/F8/CtlF7dvgZ7os8QvoKZ15H1yPUuQ/5iTePjxN+BrFNTPzOwp
        6pEk2R6zUuIs+OpexcvzNcVSFuumeJA5hxzJ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 417ADA667D;
        Tue, 22 Aug 2017 14:12:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F530A667C;
        Tue, 22 Aug 2017 14:12:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] repository: fix a sparse 'using integer a NULL pointer' warning
References: <91150cfc-3271-16b0-33d3-9a4e149dc9fe@ramsayjones.plus.com>
        <9e45674c-bdc2-003e-daa4-79a3903dde8f@web.de>
Date:   Tue, 22 Aug 2017 11:12:25 -0700
In-Reply-To: <9e45674c-bdc2-003e-daa4-79a3903dde8f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 22 Aug 2017 19:35:58 +0200")
Message-ID: <xmqqwp5v320m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 740EE076-8765-11E7-81EA-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> diff --git a/repository.c b/repository.c
>> index 01af20dee..ceef73614 100644
>> --- a/repository.c
>> +++ b/repository.c
>> @@ -5,7 +5,7 @@
>>  =20
>>   /* The main repository */
>>   static struct repository the_repo =3D {
>> -	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0,=
 0
>> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NU=
LL, 0, 0
>
> This line yells out "designated initializer" to me:
>
> +	.index =3D &the_index
>
>>   };
>>   struct repository *the_repository =3D &the_repo;
>>  =20
>>=20

Yes, but let's hold it off for a while, until at least what is
already in the tip of 'master' graduates to a released version at
the end of the current cycle.  We picked reasonably quiecent parts
of the codebase and implanted uses of a few C99 features to ensure
that we get complaints and requests for revert from people on exotic
platforms, so that we can back them out easily.

cbc0f81d ("strbuf: use designated initializers in STRBUF_INIT",
2017-07-10) does the designated initializer for struct members.

512f41cf ("clean.c: use designated initializer", 2017-07-14) does
the same for array elements.

In addition, e1327023 ("grep: refactor the concept of "grep source"
into an object", 2012-02-02) inadvertently introduced the use of
trailing comma in enum definition about 5 years ago, so we know that
one is safe to use.
