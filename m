Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF41D2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 16:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbcGHQCV (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 12:02:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33314 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbcGHQCT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2016 12:02:19 -0400
Received: by mail-io0-f196.google.com with SMTP id t74so10431260ioi.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 09:02:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nY+cHjcMyR7TaBMqevx1HNHeHqGmweXqczDweA6yiwg=;
        b=I6zynn/tmcWFjW49OJDX2AwD0FRwQTxY4Fdsf281waFBzZZqUQQHnXKF2HOOF+q/Wy
         3vS7kP2sLI4Z2BMK/BOzYHg70vaNjiF3URl7zdYQs35oHx5ShuCFNNH8RzepSHEHlYTR
         I1UIJGv2SHAiN53Yeeq50hHMx/yUhOclP3FMN+mmwZ3bhaPT+3IN44OpThUlKx1I+8nU
         w5XPQMyPB4uqcB2F+CfGoEq0CSTX4aNRdFdRNSuFruKQ3DhX5CLgvtkbjvvnxfFx2AWE
         18KA5pojd8O22MijF7N2st5nAz++kyBMVEHOiYojX52AJD9D+phlvz6LJfJI9+mpv+ja
         8w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nY+cHjcMyR7TaBMqevx1HNHeHqGmweXqczDweA6yiwg=;
        b=RYqOPfG6OKC3tPznDzL+K1QVo09eYQ4A0tqNcP2IAJARAV1zqkdMvWOrh/69TlzddB
         WmAf1KTXDPu+M6SE3LNsXHMezR6QM9UPrJ44J0XxNBuMuJx4e5zaYzP6fb9EN095RoHP
         7ZKBK1fz2ihtW/gCK10F31KS4Wfez/2ALoyxSGGwGXWAmjuMyfBre5Vt+JWkLz0z1TOi
         aQvmp2lbg3RQvhCHQRyOA5IjDhSI4BkvCA1x7bdQhHUmSW7L9YC1Y5hvRo7794V6Zaz3
         e74io+fzwfR4sFMMaYjLuSKhU0JOUbyxJtFPSkmC4BdfuCcneQEeb0sr+k/9g3mbKG4g
         kzNg==
X-Gm-Message-State: ALyK8tLVexG/OLCK2plPVnol/HGf4eVA9cty8ifKjnwrgVQuxwrgUx6gz4jqmBmUzGZWt1quyUT6EQulLW/e1Q==
X-Received: by 10.107.8.221 with SMTP id h90mr9508154ioi.95.1467993738844;
 Fri, 08 Jul 2016 09:02:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.7.3 with HTTP; Fri, 8 Jul 2016 09:01:47 -0700 (PDT)
In-Reply-To: <xmqqa8husgrj.fsf@gitster.mtv.corp.google.com>
References: <20160702131333.8418-1-pclouds@gmail.com> <xmqqa8husgrj.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 8 Jul 2016 18:01:47 +0200
Message-ID: <CACsJy8DEC1BqC8q0KDa5ZhCu6zFWemgNWoO-vRT0PgcZ616Svg@mail.gmail.com>
Subject: Re: [PATCH] config.c: fix potential number truncation in git_parse_signed()
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 6, 2016 at 9:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> clang -Wabsolute-value on IA-32 architecture complains that "absolute
>> value function 'labs' given an argument of type 'intmax_t' (aka 'long
>> long') but has parameter of type 'long' which may cause truncation of
>> value". Very unlikely for this code though. Nevertheless, add an
>> explicit check for truncation to shut clang up and error out.
>
> Thanks.  It however makes me wonder if it is a better approach to
> avoid downcasting intmax_t to long by using imaxabs()?

I think the tricky part is detect overflow. WIth uval being a
potentially signed number, i'm not sure how to catch it. The (uval >
max || labs(val) > uval) was written with unsigned number in mind, I
think.

>
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  config.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index d7ce34b..880bd4a 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -503,6 +503,7 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>>               intmax_t val;
>>               uintmax_t uval;
>>               uintmax_t factor = 1;
>> +             long int lival;
>>
>>               errno = 0;
>>               val = strtoimax(value, &end, 0);
>> @@ -512,9 +513,14 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>>                       errno = EINVAL;
>>                       return 0;
>>               }
>> -             uval = labs(val);
>> +             lival = (long int)val;
>> +             if (lival != val) {
>> +                     errno = ERANGE;
>> +                     return 0;
>> +             }
>> +             uval = labs(lival);
>>               uval *= factor;
>> -             if (uval > max || labs(val) > uval) {
>> +             if (uval > max || labs(lival) > uval) {
>>                       errno = ERANGE;
>>                       return 0;
>>               }



-- 
Duy
