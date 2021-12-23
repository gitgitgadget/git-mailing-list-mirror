Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9CC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 09:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347576AbhLWJtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 04:49:47 -0500
Received: from mout.web.de ([217.72.192.78]:52017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347545AbhLWJtq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 04:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640252969;
        bh=gFlLrmTd3MSVsIONx1bONGw7Kkwm5fudYnkVdvtWFxU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jfdRQNrIp2Hy1irHkP4p3uqMHcm4SzN1ui/WnpNYu13PgXVlFCyOYj+kSgRPhHSDY
         i6TIFtyvxDrgB6mcL12SQvfkrFAKBX8fx56DS7vpP3Lf4GtQUJn8J6GvDroPUK7h8A
         pfZvuZ7Dto22QeBa7yWxKp23Pd0klGbl8vjMEdw8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjIE-1nAGsG3zLw-00COh3; Thu, 23
 Dec 2021 10:49:29 +0100
Message-ID: <af378ac5-a24c-5110-04a7-3257a909815b@web.de>
Date:   Thu, 23 Dec 2021 10:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length memcpy
 calls
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
 <xmqq1r24gsph.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1r24gsph.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wyd8Au3CeRRpJuECKXstdp6SuLWm+ZTrEkTw7c3qEDzwu4VemkK
 Xqsw7P2YENXPjNyjc1RDFEpHp0pbiGVscxr+MHotizBn0KiVwdWI0CVZIJBPgJXql7yqOWv
 7qpTvXLfyeZVUEeHXwCG3ur6yif8UiAzeHzOO+eTBNZXzzhGFYKeArYgTnHQe1qQuASDaYe
 cxlu/7hNX1GacMVVr/0CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RkxmrXvUtrQ=:7qsWG8s273BExzv2VUPh+z
 vE5Zew+RYHPwuVgjMaOqt/pnuNSHXDinmZ6L92JfoH5Qu4PUq4JpZoxv7kTaj5o7uZX8hOOuh
 cRZAsXmLNrrnU6741omr4+l0TsimlgZBUCOzUD0eaq2lOHgdo0mDc6f7iGpVYBt3TdDdIHn5N
 DvKSPW5mHVazhQ6FfbsX2+Cs4lclub9G/jG4FH8G1E+Ou2fQOmVfTBSTYfJzYirYPj0JRHCi4
 PlL0QXGQsqydyWFt+02uTxXJQVIwRCiyaIVN1cohh6Q3K5em2bCgk3+5iTXWrYQkIEQQyVh6N
 qw4VOrAkHvi1MpF31ASo4m7spFldYxWurd/aa3d/dkPWQ2fO9ZT36L6WK1KXeA8XhMRcAuemM
 54PotexdkbXhZW2ot31Y/bXu8+a5H6qpLmO1Mgu/1lV6jYnOgLgo1LPzR5Pct7o4QEhJzlSgQ
 BoTyn32W24AoUVUzb57nect4pghMsuzCZQWG6IydL6cKBA2ZhUf4PmBtjbUxjsJCVr0LUDrly
 GzSdMw5YY3naUlQkIXzBx4NPpoPdB1+ezEbg3V2dZM48B8UVWCuCk0/qgmrmhaZcQRqcuPoFg
 ylzHX0hx0llkwEOmSNadm8rd411qGGRn+4g4bgFPNgdS+zznkQjD2yzNt+MqzlLvRx0inzia4
 DawfkQCmU/M7qRPGfrhZnE9gX/vGZk4EHCJPX1A3nXuqrfJdTJAzGGOYsp5lQYxBJim+/xcAJ
 BnU09ZIATK3b6GxVZeoyUASshi1Tr7JhZUzixFt9vStggSVCuxM5xeor1QEZlF/6oBjbNLW00
 4JB9CDKgq9ZuRIJWRAoesHWaRAtAqzA9CgNdacNX0/S5OKyP3gI9HTQlHCF1evugmrY/coVK+
 eQcvUbyS+WoXRquTgi81Zpz+LmXHUUNMPcJzLg9Zeii+FPk7Qlj+KSqvmhQvov7ULSzFlUm6p
 fNIcffh6i+Y2Jiikji+19DD4sXZiI7LIyWEV9G1euupTW7cSVrx4AO+s0LXaTfyMUJaGmjYrw
 BdgAJcsyCe3wo1avmtJJTzjpYNfPk+bhjsZwQZ4EkoJ+7DWU/L+ezHSuTtzmw/t0hA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.12.21 um 23:50 schrieb Junio C Hamano:
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Han-Wen Nienhuys <hanwen@google.com>
>>
>> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>> ---
>>  reftable/record.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/reftable/record.c b/reftable/record.c
>> index fbaa1fbef56..423e687b220 100644
>> --- a/reftable/record.c
>> +++ b/reftable/record.c
>> @@ -126,7 +126,8 @@ static int encode_string(char *str, struct string_v=
iew s)
>>  	string_view_consume(&s, n);
>>  	if (s.len < l)
>>  		return -1;
>> -	memcpy(s.buf, str, l);
>> +	if (l)
>> +		memcpy(s.buf, str, l);
>>  	string_view_consume(&s, l);
>>
>>  	return start.len - s.len;
>> @@ -153,7 +154,9 @@ int reftable_encode_key(int *restart, struct string=
_view dest,
>>
>>  	if (dest.len < suffix_len)
>>  		return -1;
>> -	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
>> +
>> +	if (suffix_len)
>> +		memcpy(dest.buf, key.buf + prefix_len, suffix_len);
>>  	string_view_consume(&dest, suffix_len);
>>
>>  	return start.len - dest.len;
>> @@ -569,7 +572,8 @@ static int reftable_obj_record_decode(void *rec, st=
ruct strbuf key,
>>  	uint64_t last;
>>  	int j;
>>  	r->hash_prefix =3D reftable_malloc(key.len);
>> -	memcpy(r->hash_prefix, key.buf, key.len);
>> +	if (key.len)
>> +		memcpy(r->hash_prefix, key.buf, key.len);
>>  	r->hash_prefix_len =3D key.len;
>>
>>  	if (val_type =3D=3D 0) {
>
> I am not sure why any of these are needed.
>
> For a code path that involves a <ptr, len> pair, where ptr is lazily
> allocated only when we have contents to store, i.e. ptr can remain
> NULL until len becomes non-zero, memcpy(dst, ptr, len) can become a
> problem as the standard requires ptr to be a valid even when len is
> 0 (ISO/IEC 9899:1999, 7.21.1 String function conventions, paragraph
> 2), but none of these three calls to memcpy() do any such thing.
>
> Puzzled.

I don't know about the first two, but in the third case dst (i.e.
r->hash_prefix) might be NULL if key.len =3D=3D 0, reftable_malloc is mall=
oc
(which it is, because reftable_set_alloc is never called) and malloc(0)
returns NULL (which it might do according to
https://www.man7.org/linux/man-pages/man3/malloc.3.html).

malloc can return NULL on failure, too, of course, and none of the
reftable_malloc callers check for that.  That seems a bit too
optimistic.

Ren=C3=A9
