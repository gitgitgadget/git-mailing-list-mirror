Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D5AF20285
	for <e@80x24.org>; Tue, 29 Aug 2017 10:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdH2Klv (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 06:41:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37903 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdH2Klu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 06:41:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id t3so2432386pgt.5
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q+oEOHfeuUBNeC8OsCg10nQYoKvo7bdhaqRu3akD0JE=;
        b=eLM79w4IEykBvzzfiXXz+JEKiq9hJvwSowT3kWQBRZYGZW9hzTq2DVs56Ne/RGF/KP
         txOVVyTeQGoSAntQ3SVZ8nou7S3h1+dHVg5m+5Uuh+gZcQoDYku93w0NMwH8gC/n3BYg
         p2kOGOev0ZwGeO1o7iv4A2g5Qf3Busarr8mfEmjxDX8vEgAPbeGuq5bozqjrawIMyokD
         73bwIbXlAbtacX5pd/EADKtD+KR5jzerkEIRNjxFgHV1bORFv8GBKKaEhXDYa0KpysYv
         VR75J+FybtrbeRql1jhapNn3gJY7vjeGZRo2g5uOyOTLyn9Z1i9kgqc6qndkwG4kuyfP
         HvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q+oEOHfeuUBNeC8OsCg10nQYoKvo7bdhaqRu3akD0JE=;
        b=rb+9qM2UOGZk5vpGNPfGjVyizZnMfr2BAeTb2JGuUvAd+ImLAEncSo4D6ADTU1sm9f
         OPLRWLMFqERfUdo3Pl70rpLOHmNZd+cc4HY7Zp+p1Ou0ph5K+0uvQdOixkvefRCV7Idl
         tQfNT57yq2ItmffLbgEv2boPLvAzlbpnlybfPQuDYEZ6aJLCzMRzto+44SNT0hxARfy1
         pADLBnucF9Prsodv+TDZtyKO6QE0Y79tvsXGkNbvgGuxi0IS0LhFPpfe+2D9li0dor7n
         L5IP6fHYHFuE/KUPfTO2CoQKvJbTgWVyirCMFHKUtxW2hXratltd1vEinMfQoOSH0Uu9
         U7ZA==
X-Gm-Message-State: AHYfb5iMnyuSyiPk84gP9uDCpbtwvdIixx9L5luH4ozO/bmVeUeyf9B6
        MIOonfrBBZNFt3CQcGxHKCtxkdPHFcdIeGc=
X-Received: by 10.84.224.7 with SMTP id r7mr535845plj.273.1504003309542; Tue,
 29 Aug 2017 03:41:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 29 Aug 2017 03:41:49 -0700 (PDT)
In-Reply-To: <425e16e7-188e-ecff-3a09-228ef1dcf319@alum.mit.edu>
References: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
 <fe842671061cea7972b0c8695a4b7f82f854453a.1503951733.git.martin.agren@gmail.com>
 <425e16e7-188e-ecff-3a09-228ef1dcf319@alum.mit.edu>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 Aug 2017 12:41:49 +0200
Message-ID: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] refs/files-backend: fix memory leak in lock_ref_for_update
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 August 2017 at 10:39, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/28/2017 10:32 PM, Martin =C3=85gren wrote:
>> After the previous patch, none of the functions we call hold on to
>> `referent.buf`, so we can safely release the string buffer before
>> returning.
>
> This patch looks good to me, but I did notice a pre-existing problem in
> the area...
>
>> ---
>>  refs/files-backend.c | 31 ++++++++++++++++++++-----------
>>  1 file changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index bdb0e22e5..15f34b10e 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> [...]
>> @@ -2305,10 +2305,12 @@ static int lock_ref_for_update(struct files_ref_=
store *refs,
>>                                       strbuf_addf(err, "cannot lock ref =
'%s': "
>>                                                   "error reading referen=
ce",
>>                                                   original_update_refnam=
e(update));
>> -                                     return -1;
>> +                                     ret =3D -1;
>> +                                     goto out;
>
> It is incorrect to return -1 here. First of all, stylistically, the
> return value should be a symbolic constant. But in fact, it should be
> returning `TRANSACTION_GENERIC_ERROR` here, whereas -1 is
> `TRANSACTION_NAME_CONFLICT`. So the code is not just stylistically
> wrong; it is functionally wrong.
>
> I know that this is not your mistake, but would you like to add another
> patch to your series to fix this up? I'd do it myself, but it's a little
> bit awkward because the fix will conflict with your patch.

Sure. I'll send out a v3 later today. I'll fix this in a third patch,
and I'll also address your comments on the first patch.

Thanks a lot.

Martin
