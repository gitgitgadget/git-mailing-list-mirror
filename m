Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0129BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8B760243
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhH3SXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:23:32 -0400
Received: from mout.web.de ([212.227.17.11]:41477 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhH3SXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630347746;
        bh=IcCJnkef4y9wjkKDONb/40VbpAml+3g3WZUeEEjQoRo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OONsz393YKdWzAsJQwrh7qoCvzBPipbPYuL5+QqpUfab+taRM4S5Fi/oqejIj8TWg
         nM5ljQso+N5W0kunOxQztl31p8kXt6ULw5sRift7WwqV795zlsU8UYqYnM7A3e42fn
         3a3R00084lHbGHFCrfDFMxfYEVPVqMI5EeK7etJQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lx7Ab-1n4tEB1sfx-016d27; Mon, 30 Aug 2021 20:22:26 +0200
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local> <xmqqeeaa6fey.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de>
Date:   Mon, 30 Aug 2021 20:22:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqeeaa6fey.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EimsZEit2ryqLeuGDLi5pHRT4LXg0HWuFO78gsRcxuMsb7O56S1
 joGgWCE3OOmI3SGwDxpVLcioRxQL58jSCfLWK+hiPKgJNncm6snUhboamHkG43YWPwDYP39
 Ix9vXFDqMbAIgTHedM6AkAu8dqmnTbFuelMuLkw2jIbq7BLcbS0+B1i99inkDXYOJa83uhw
 8VjfzsqTKnbsvxPGvboGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2xfFS7IVzuU=:/uzrEIKPQZDlEFKyToq0yU
 IRP/nIBmi9BepD4YnC6sKTnVjuk5vjuM5Y+n6jKcj7J1JMfzFcdDzj0IUwgcksS46m4jAmM3M
 UHEE0LJhCsC9HExFbGfqPm1t+QopMAhmprsDHCktE0jrpn6yMeDouqEwuFsT7JooEP5gxWbFk
 sVI4Tej3mKv4WomNUIc5WJQR4bNiz//16FV8JVzWvueyjHZ8Fw7w3v+5MjXui9rHBKmIjDhcD
 0tO3btb/gSTQX8hkwBHsUE2EwVeGUo1+8hX8TPO5S7iywB8t/YeJgiy/oPgN/gLI6tsh5a321
 F97ZgAdBCofgxxC9lZT1S7j3QV7wSlOmLbjs5sAYaOWSpnshaJ7Vo4PgF1PnMm5fReD4TssYQ
 F4bLTyqV4KLifs7TDOO9Tez4zCvK6i1Q5wuswmRJ2lgNvS6sczMBFg1noXAFy3ypzrkIOieJd
 cDuaf1efMuLOALOWoXHwWKvrDgPHJXcqd9K9jCxULweiMm/RwngFeRgs6ovZnMLhvh+cOPsCQ
 znV2AD2t79+YZ66wbcL+MPl5++F3HH7XLXqZCMSAjUcK7mMMnMe6JLAjYjfKQYEjtlvntHvLH
 1tKHAOTlDAleWofo3bMxZyJX2dQKKejSM34VmX+LDhBGdMFIcXQN1uG2EhoaFoktyWCrf+o8m
 jjTkHTcBCH9AmTfd8A8Oj4AVnpjTkGv8kYvfs1Fvpnyd5nQ43lXiDGazqTp3e45HEqBKEXu+P
 fnGPovDZ0EB8BmrdAowsRGQujN4wTOSfPsqOsI8taoAmmVhxlkhvF0xbMw4qm+Nw0w07rXS8A
 6IYoSFrys4tcnLDqENksqnblSA+qZgOeaGEZTzZx5SJ1qe5mEDihfL8vqUSnXofCCrbvb5ZRe
 n0mlhMCp3MUmxK+kuFp5Xto1IrPgptttkpryNxE2TudEZwxZ19XEVqT/7U45Y1VGtjLXMroy9
 GVAJyKUff1YOffVRwlHXLqUixaZm9W1/EAljA4BwjM0erlpVT0AWpdWa2B/gQ8QvSI6DgMlE1
 2WfLaSFSwkfiZdkmSfVgPODCQCLVIXNYFmsMDiIS7OwBtp8pYocInZOc1Lg34v1rjtN6TuHtN
 mzha3w/F4muNDt1EPIQD1KCy3RPLhLq7WkF
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.08.21 um 18:55 schrieb Junio C Hamano:
> Taylor Blau <me@ttaylorr.com> writes:
>
>> Looks obviously right to me. I found another spot in
>> t/helper/test-hashmap.c:test_entry_cmp() that could be cleaned up in th=
e
>> same way. But this looks fine with or without the following diff:
>
>> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
>> index 36ff07bd4b..ab34bdfecd 100644
>> --- a/t/helper/test-hashmap.c
>> +++ b/t/helper/test-hashmap.c
>> @@ -28,10 +28,7 @@ static int test_entry_cmp(const void *cmp_data,
>>         e1 =3D container_of(eptr, const struct test_entry, ent);
>>         e2 =3D container_of(entry_or_key, const struct test_entry, ent)=
;
>>
>> -       if (ignore_case)
>> -               return strcasecmp(e1->key, key ? key : e2->key);
>> -       else
>> -               return strcmp(e1->key, key ? key : e2->key);
>> +       return fspathcmp(e1->key, key ? key : e2->key);
>
> Sorry but I think this patch is wrong.  Before the precontext of the
> patch, there is a local variable decl for ignore_case---the existing
> code looks at ignore_case that is different from the global
> ignore_case fspathcmp() looks at.
>
> Admittedly, it was probably not an excellent idea to give a name so
> bland and unremarkable, 'ignore_case', to a global that affects so
> many code paths in the system.  But the variable is already very
> established that renaming it would not contribute to improving the
> code at all.
>
> It however may not be a bad idea to catch these code paths where a
> local variable masks 'ignore_case' (and possibly other globals) and
> rename these local ones to avoid a mistake like this.

The name itself is OK, I think, but using it at global scope is
confusing.  -Wshadow can help find such cases, but not this one, as
test-hashmap.c doesn't include the global declaration.  Moving the
global into a struct to provide a poor man's namespace would fix this
for all namesakes, assisted by the compiler.  We'd then access it as
the_config.ignore_case or even the_config.core.ignore_case.

Moving all config-related variables would be quite noisy, I guess,
and probably conflict with lots of in-flight patches, but might be
worth it.

Ren=C3=A9
