Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB4CC38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931312080D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="h5Q8uAZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgBXTCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:02:08 -0500
Received: from mout.web.de ([212.227.15.4]:34147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgBXTCI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 14:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582570921;
        bh=nkDSMqWyTQUKSj2m8rckPutl0XbWMSbwHi112R9oE80=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h5Q8uAZ+leyI61nvAkynSGP/olJ5JHA3+YRibMQy+vjB+UrF7RSz+ictoErYe6+Bj
         lUwJpl8DSs/+04l8Mtls9tphwYKdMffdjNBHPiAIa4n5H5H6R6H04uHbKeGPR5LzDc
         uU+tkyKvtk7T8q+gK3bewi7nCv1V1GFbN1Odw2a0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0QlZ-1jPTGe3Rd7-00ua20; Mon, 24
 Feb 2020 20:02:01 +0100
Subject: Re: [PATCH] use strpbrk(3) to search for characters from a given set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
References: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
 <xmqqy2srrjx1.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <21e6eaac-318b-3cb3-bb63-4f65abfae670@web.de>
Date:   Mon, 24 Feb 2020 20:01:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2srrjx1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3EE4JE8IxukwETblBvg6ngOscJfyjYELY2I2JcOgcV+e6gULGtc
 rmScrIpeJfE9tKclseSYnkkg4eFhHI29Rm/+OiNBI+5tbf7Q244ltyuOqBi8x0c1390juXX
 WXFEt22RnAAvI8u6/SP+5EFlpVS/4Zy8RRLBVFRzmfPU5Pn9oUm8B/n0s7eHOz9ZIURzag6
 T58izAkL3Os0iWDNrESDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a024BvCSUyk=:OXS942ZPQS82j8gjKAZHXt
 aTkm66vOHoVoA6j9RWoXCYctDpezW258XaC51b7ju2Ubd4T4QmEM0anMjCTxVCOhoq1gxqZZu
 DiA/0QlSAU9BMvsu54z08rjPA5YbbAKQ+hNBnpKsmAodj+MyaOKm4hnlabFUbg/A71liLbEL1
 EUbKsPBXIEhlQdD6b2CltxTa+8Z0+c86pNkvYyjnLDReSk1acK5YvgJGI8pXCL96dP5Qu2QJ/
 9Spe3p6QDcuTvcLZStADUYIwJbIaHRxU1a9ICPlkhTBJdJEjlksXRxXSfEJH820ocovfrQvoo
 UYtqoo50kN7WkjaXNjvYDXo5m8CtaxQIUOjGdnvEx4Wxf0elTStrJ+Q1WQmJiUwIUTrGC/8px
 UkyW/B3WAT8xENckiPRXdLR4K3dqcI/mIHQuzTdEqZHW+CHuQToDK8oQnRU5GZr2lfHIUrln9
 F6bSZQb83cxwpwfTC/nKeqVM/ZQQLZygc9bpA/kZaabuKCTcNr85lgbrP//rWUiwmYNZECsaa
 9TX2yZX36RRAUAzjpdxWLpxr5kDOgIauaVJ5jIdCE7mJUGQbO3y9liSnsOenou3bf4GXxJJCV
 aKggJZNvoh7g+1S3uOhiHeVlLQ3GYQXPSHYFMymm1kLXYVXdEPyAju6rVm1js13CjHLbBpJLk
 +tQ7DkcefdBhtyTlnyAlF08qi4DMR2r6vZ0EqAmmGKBsCcmceEFAyotkYWXyYdP360xBNJ2b1
 sZMWRy+5kKa6yiUnwQFAPpDVVcyMVoAH4DKu+ZcqXmYKedUDt0PuSCKKcydsf3/4vIQwewhml
 YKXHkKpEO6Xx81YO8bEhzmHs35afrxgrcgK5SPIJourpBDxLKAj3frJUmsY9mlDmrM89ZCEel
 CWAgsdDgBdf/SmO5++hp2vXpspc0v9Ae8quo0N0D2iPMtc14o/di2obKgPrckTkWua03K6rPT
 NeN+afH9QNY3om5fbO7vn0xPwSBcf1qokjeG4/gB5pIQCOAwa/GlvnWhvzD25slO4XbukTi5Q
 RESVe3XIgiyu6Van/RwQQB+Cat9Bjq+3cOTR6e57nThjdP6nKjFadOvTHpPdIsBMB3v47K9Wm
 /X1htaJCALVd7gtNioq2aGiSuPmQniGOmgcbUm5lcsRy2dPyaBAfVlBqJ3bjOrWTFinB6xhWg
 gsazn0W60QpGlJz/JIzMTITU9dXuR7ngTT+gcUmOlHWVgq5C2kCfXJWO3FjYYwd2LVt3k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.20 um 18:10 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> We can check if certain characters are present in a string by calling
>> strchr(3) on each of them, or we can pass them all to a single
>> strpbrk(3) call.  The latter is shorter, less repetitive and slightly
>> more efficient, so let's do that instead.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/show-branch.c              | 2 +-
>>  compat/mingw.c                     | 2 +-
>>  mailinfo.c                         | 3 +--
>>  t/helper/test-windows-named-pipe.c | 2 +-
>>  4 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
>> index 35d7f51c23..8c90cbb18f 100644
>> --- a/builtin/show-branch.c
>> +++ b/builtin/show-branch.c
>> @@ -536,7 +536,7 @@ static void append_one_rev(const char *av)
>>  		append_ref(av, &revkey, 0);
>>  		return;
>>  	}
>> -	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
>> +	if (strpbrk(av, "*?[")) {
>
>
> The changes in the patch obviously look all correct.
>
> I wonder how we can exploit Coccinelle to do this kind of
> transformations, though.  Would it be possible to say
>
>  * if we see "strchr(S, C1) || strchr(S, C2)", transform it to
>    "strpbrk(S, concat(stringify(C1),stringify(C2)))"; and
>  * if we see "strpbrk(S, N) || strchr(S, C)", transform it to
>    "strpbrk(S, concat(N, stringify(C))";
>
> and let the tool apply these two rules repeatedly, to catch the
> pattern to find any number of needle character in the same haystack?

That would be nice.  I briefly considered it, but I only can think of a
silly way to convert char literals to strings (by using one rule for
each possible character value), I don't know how to concatenate strings
in Coccinelle (simply putting them next to each other as in C doesn't
seem to work), and I don't know how to apply a rule recursively to allow
transforming an arbitrarily long chain of strchr() calls. :-/

Ren=C3=A9
