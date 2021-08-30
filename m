Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71766C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A04760C3F
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhH3PKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:10:36 -0400
Received: from mout.web.de ([212.227.17.12]:53985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhH3PKe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 11:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630336175;
        bh=v+CTuTvLkBumIs2hkBnrCgxN6bwZoMg9SfkfQV6VTnU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hXAxCWbflUZVwvFCIAi+mugP60s0Gp48l/+KSHhKuGOcUqD7YkxR45l4/uGLiP1g3
         yzqwDfjG7ESbWs7Njr1kwQQSWo71mDdYZQ9K6lp+zsJZ0Wjdwe06gZvpsdzNRQ8LwT
         Li+9N0k3sY91zfoACqh/8TYUnBim4vmz7TParEDk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N30dT-1mzSaZ3usH-013LL6; Mon, 30 Aug 2021 17:09:34 +0200
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <60e9baf4-4e76-71a8-e6bb-1af87486994d@web.de>
Date:   Mon, 30 Aug 2021 17:09:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSvsQcGNpCMZwS8o@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rnGTtui18SAqnW9zSY/QkXB+lhuuwALxM8g3RHtIylos2iATGtS
 5oQ8BmANrQKSmJfngvlCK0VACH83XWeMza8WVA5ybQwCdTLDvm1AdahdDUoNOoSrfCKHBii
 hkyF6ioo0Ov1y4LYQwKdj7SqtLQHcftuEB1brJlZEyYON/w6Ic6mxB3O5F9jQx0rT2HcS+Z
 4cnG0xXb1nO+UOUTkEEsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gYrw1frWtrE=:P7msBzKsav/MjCM5p8VTQn
 QdDSQ5b2nI1QBWBkm8QgN9uKotj6SSUp5XGABkdPFQIfLO6E3f1yl+Zdiji475Q66+YcScGJX
 uVG6UsiCs8j0GItcfL6pmgsCb4FzGkMloZRFX8/TtezPg54zQhjrnAlP5rL6UoJzsarEZ9zuH
 IDtwBLi7QRDK057TdtQypX1ukRNkB1FyZzGh1k9S3DbTUQzcsl70f2FjNeGDp8C1LOzNR2PA4
 loYtf0wKzrNmvgZY32CmYowa7by5g2YkCrxviHJ3g+weLC4UumXvK2s9AO45SxpyG+mLFAHaD
 XV/N0ax65E+oLmHg+w/BzZ34UdvKArydHQ3WVgNPEzvepyAmkafFKXHgCUuCuiYC6ATz34I3l
 o0sYV7mw0cGuYtW4bY4IrZcj6sFwSycjTf/GpRrowG2ZlHgYX23zFDq9kETuI6LdfbV2tIDx7
 /mYFEkiYkpZuTRBvysDfxIRGITAZjVA6VRl1iYNY24eAJwJJ1KLhBJiz9fmQBB1MszRJJTicm
 ZhBLIMKzneuiQT+tiJcDxQValOpz5rv649pW9Hl7uP4g/Rqzuah9cpBuXH6AG4NSRUPKwlhvG
 67DSehOoxIlfs0t1HB1FN43aH2XdaDK6BbDq9gW9AoyWJdn1hMCP9bi8NPXSdBBROf4VTgA2G
 9+uNtfEeDa7ZjsIC44zCMUDKSrB77OIAzDfvPidAn0eegR6EvnJLu6XZbXBo7klPrcuopbrSS
 pDcTHhwA4N2NbqR3QFkt6xNHsNTfF53QbeTX9fTeBz5MSVdOPJNO1FNWUIkk44Z6U81zVaGCY
 yVhtMfNqRIf3RsFBtCLtR7QEWcAfatIVBDA4msFHBSrF7Oz2ZqhwF2VDeOFVmFNIjsUOfroHC
 eNeM/txlyCO+vnzEdTIZQmwTW3QYmhVojwSX5Of4+Y4LxgYvkb08v4puovkFvlvm4c4AGh5zj
 lREPTP2tiQ5VRVN+0b9ZYDHIobk54I4x4/WDn3TRiYN/MENJNSVWbEJqw1ZQZC1ft6WwIZIyg
 ZhshzmlkW0ScUcG8dY/hHf9TxvOtJaq1W1l1wDlbQheS1CR08olaqGOLn/7RV+apIHWAPYEZ3
 d9hN4mL8RrN+/V7bpc7pbOr9sBtJ99tm1l+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.08.21 um 22:21 schrieb Taylor Blau:
> Hi Ren=C3=A9,
>
> On Sat, Aug 28, 2021 at 11:30:49PM +0200, Ren=C3=A9 Scharfe wrote:
>> Call fspathcmp() instead of open-coding it.  This shortens the code and
>> makes it less repetitive.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  merge-recursive.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 3355d50e8a..840599fd53 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -55,10 +55,7 @@ static int path_hashmap_cmp(const void *cmp_data,
>>  	a =3D container_of(eptr, const struct path_hashmap_entry, e);
>>  	b =3D container_of(entry_or_key, const struct path_hashmap_entry, e);
>>
>> -	if (ignore_case)
>> -		return strcasecmp(a->path, key ? key : b->path);
>> -	else
>> -		return strcmp(a->path, key ? key : b->path);
>> +	return fspathcmp(a->path, key ? key : b->path);
>>  }
>
> Looks obviously right to me. I found another spot in
> t/helper/test-hashmap.c:test_entry_cmp() that could be cleaned up in the
> same way. But this looks fine with or without the following diff:
>
> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> index 36ff07bd4b..ab34bdfecd 100644
> --- a/t/helper/test-hashmap.c
> +++ b/t/helper/test-hashmap.c
> @@ -28,10 +28,7 @@ static int test_entry_cmp(const void *cmp_data,
>         e1 =3D container_of(eptr, const struct test_entry, ent);
>         e2 =3D container_of(entry_or_key, const struct test_entry, ent);
>
> -       if (ignore_case)
> -               return strcasecmp(e1->key, key ? key : e2->key);
> -       else
> -               return strcmp(e1->key, key ? key : e2->key);
> +       return fspathcmp(e1->key, key ? key : e2->key);
>  }
>
>  static struct test_entry *alloc_test_entry(unsigned int hash,
>

That's a local variable named "ignore_case", not the one declared in
environment.c that fspathcmp() uses, so this would change the behavior.
The helper code does not include cache.h, so this is not even a case of
variable shadowing, just two different variables for similar purposes
in different places having the same name.

Ren=C3=A9
