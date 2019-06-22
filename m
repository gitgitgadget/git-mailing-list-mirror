Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0561F461
	for <e@80x24.org>; Sat, 22 Jun 2019 10:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfFVKDe (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 06:03:34 -0400
Received: from mout.web.de ([212.227.17.11]:57057 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKDe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 06:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561197807;
        bh=lVWNZ9A7g3cQI3+LGKwoaHFspSaIyow5IbDTz2+tvMo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WIEv5XEl4A9wvYrdn1egJJEEgQQBBd9iwN7pyFmdazUiIc+oV+E6Ssm4pa13X+kaz
         aEA6DkfcqSaLCNpviXHTD+xH6umUcIHLVFIGQo1/4ySo0Keef/ZqGSlEXeSEM/qtHu
         LG7urLugxERZ3HB3E73PJ3MrBeJIt9x5qDS7dscc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYWA-1i8kdF39pG-00WZFH; Sat, 22
 Jun 2019 12:03:27 +0200
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.265.git.gitgitgadget@gmail.com>
 <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
 <03a68560-8058-7436-6edb-38e276a37190@web.de>
 <f22599d4-148f-212c-282c-790f5bde1706@web.de>
 <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
 <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
 <ebe4176d-1b51-fc82-7bce-713d098dbcf3@web.de>
 <nycvar.QRO.7.76.6.1906212024010.44@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0dd77efa-a8f5-9f3c-6057-d6fddfc23563@web.de>
Date:   Sat, 22 Jun 2019 12:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906212024010.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WzFQXZdrNm8sHZYtPxHsmjhvA7xTW9Sz3SIXWO4t7U/jk/eOvyS
 ypSy6OUHBqwlOSrN60hZQSCkIfBNZfz8mPD8cCoDM9R/2FC0GyDUNfZogaa60e/ocYS18/+
 xP1iIySXP7FD34i1MaF1TdgV6FA4DlBd2ftETMDIywEBBSSxvypY5njTevTWJ9BCy0Fqxca
 JvUxTbvb4Nve6XWy6evQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X/hOeOQjSp0=:fhkNTZAcosTTtxQNlybkxA
 A3+a4RdDvOOuovbkk3P+QsusOn80RyQCupb1cdh5X9UU4JhkAHLsYgzhSIWiM8LtjvwYaKbcQ
 gNYKlQ1NXWvfImn+ynioVzvlqkaMaeU17LZnhwXl7kABAvNUBD8Fb31eGMU0xR5wtKFuYLXKe
 f1z4cVUE7wphee3l4PevfskcLboea1OZny83ya8/9emqA8g8qp4puC55xhkUiidTT3fsqUSNN
 z81N+bd4nl6wKZG1tJ2wKic4CBiq3C2Hfvf30hJj17jZDnVkch+p9tBtqWnudQ4/j5urSZ+DT
 6lheM/pk2NhdzFrF75s8BZ4uebimVImrd1EvdL9u3FpRJ5hkQ7BB66wwYZsC8JT1JQ03hi3aA
 OmxTPT7noYVXnsgY0C1dNtm9n9g0zNJqtl27FrUgLPyKZiV8N1chjadfI5JtD1N/vO5iwEE/H
 3O8J1NyH8lLBtRwBS5nXkhKflM1FGmNv/rrkkt5p+PiFzb0KQ08A++siLJfKPiiP7biP8BzrK
 Ybo04ONe29dbpHZZepw9U3qEOoLJLM6e2eNRKnest13y/Cte8mjRCSflH13+y+Li5+zfkCFj+
 OrGwrhzS6r4L29wDn293ARobGa2z1/iNHPCBD0gaexF+DKf9jA11zKFbZZieVqBZM0bMHgCrY
 H0Kj/hbTnSARBlKBsxO8Fzu1LRTYKiqlI5kmzdyf5VLJ8LZ5RXE9+C8kHPwU6XHMuT72hSKJF
 a3tD+cBMxHTEcPaqezusn9BtTAegq3JIEkfsJy4Np/L+p+93feEcOSFjzf8pduJJqIEq28KPO
 1KCqzZHATs9WNDQceKRCDwwpbiM2lOCDBhP1jLisiPAPtBYK4yo66V1Vq0M5RbRCOZf9FV+vY
 rwrBIxUap8b7q/G+7FX5sHfDgwsxeoIrgBYhQQyF4hza6Epv+ancKSp/r1pHOHx7O4/grLmha
 gQ6UAjXUtGmU5gpSrl8VHN5T/ifRYZQM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.06.19 um 20:35 schrieb Johannes Schindelin:
> Hi Ren=C3=A9,
>
> On Thu, 20 Jun 2019, Ren=C3=A9 Scharfe wrote:
>
>> Subject: [PATCH] config: simplify unit suffix handling
>>
>> parse_unit_factor() checks if a K, M or G is present after a number and
>> multiplies it by 2^10, 2^20 or 2^30, respectively.  One of its callers
>> checks if the result is smaller than the number alone to detect
>> overflows.  The other one passes 1 as the number and does multiplicatio=
n
>> and overflow check itself in a similar manner.
>>
>> This works, but is inconsistent, and it would break if we added support
>> for a bigger unit factor.  E.g. 16777217T expands to 2^64 + 2^40, which
>> is too big for a 64-bit number.  Modulo 2^64 we get 2^40 =3D=3D 1TB, wh=
ich
>> is bigger than the raw number 16777217 =3D=3D 2^24 + 1, so the overflow
>> would go undetected by that method.
>>
>> Move the multiplication out of parse_unit_factor() and rename it to
>> get_unit_factor() to signify its reduced functionality.  This partially
>
> I do not necessarily think that the name `get_unit_factor()` is better,
> given that we still parse the unit factor. I'd vote for keeping the
> original name.

get_unit_factor() is the original name from before c8deb5a146.

> However, what _does_ make sense is to change that function to _really_
> only parse the unit factor. That is, I would keep the exact signature, I
> just would not multiply `*val` by the unit factor, I would overwrite it =
by
> the unit factor instead.

So the patch is too big.  Its narrative of "let's restore the original
code, but keep the good features added since" is not carrying the
weight of its many changes.

> At least that is what I would have expected, reading the name
> `parse_unit_factor()`.

Hence the renaming. :)

When I read parse_unit_factor() without any context then I expect it to
work in the middle of a string, telling the caller how many characters
were recognized.  It would then be usable with different units, e.g.
for "17KB" just as well as for "100Mbps".

We don't need such a generic function here, of course.

>> reverts c8deb5a146 ("Improve error messages when int/long cannot be
>> parsed from config", 2007-12-25), but keeps the improved error messages=
.
>> Use a return value of 0 to signal an invalid suffix.
>
> This comment should probably become a code comment above the function.

You mean just the last sentence, right?  For an exported function I'd
agree, but for this short helper I'm not so sure and would rather not
bother the reader with easily inferable facts.

>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>
> What, no accent?

I prefer a recognizable simplified version to a butchered one.  Perhaps
the world is ready for Unicode now?  I still get weirdly transformed
characters on letters and parcels, so I'm cautious.  Testing the waters
with the sender name setting in my MUA for some time now..

>> diff --git a/config.c b/config.c
>> index 01c6e9df23..61a8bbb5cd 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -834,51 +834,46 @@ static int git_parse_source(config_fn_t fn, void =
*data,
>>  	return error_return;
>>  }
>>
>> -static int parse_unit_factor(const char *end, uintmax_t *val)
>> +static uintmax_t get_unit_factor(const char *end)
>
> It has been a historical wart that the parameter was called `end`. Maybe
> that could be fixed, "while at it"?

I was tempted to do that, and am a bit proud of having resisted that
one.  I try to avoid "what at it" these days -- if it's worth doing
that other thing then it can live in its own patch.

But the name "end" is arguably good, as it signifies that the function
only works with unit factors at the end of strings.

>>
>>  		errno =3D 0;
>>  		val =3D strtoumax(value, &end, 0);
>>  		if (errno =3D=3D ERANGE)
>>  			return 0;
>> -		oldval =3D val;
>> -		if (!parse_unit_factor(end, &val)) {
>> +		factor =3D get_unit_factor(end);
>> +		if (!factor) {
>
> Again, here I would strongly suggest the less intrusive change (with a
> more intuitive outcome):
>
> -		oldval =3D val;
> -		if (!parse_unit_factor(end, &val)) {
> +		if (!parse_unit_factor(end, &factor)) {
>
>>  			errno =3D EINVAL;
>>  			return 0;
>>  		}
>> -		if (val > max || oldval > val) {
>> +		if (unsigned_mult_overflows(factor, val) ||
>> +		    factor * val > max) {

I'll split that out, then we can discuss it separately.

Ren=C3=A9
