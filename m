Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA260C2D0EE
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8104020757
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FcSjhgLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgCaXVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:21:36 -0400
Received: from mout.web.de ([217.72.192.78]:53441 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgCaXVf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 19:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585696888;
        bh=s8ORTLmveJLbBrbQ0fN7x+PccgCPh5b/htoYe4+6GLo=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=FcSjhgLimgYoOa1VpGccuyOKYlbsHwJVzVubL2YOICpwiNXmSmNVnXSAIdGtnpJYy
         /FdsJKULDlEnrVE5ONMM0dYcqffRKHRMaxtQRym6NtlCliaDUH01SGF8dbDO5MXDgG
         7KEvMHU7g5Ltccn3l4WNQvNv6TX+zhCRUYf5OR/M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dTd-1j2RmH096j-00sQzG; Wed, 01
 Apr 2020 01:21:28 +0200
Subject: Re: fast-import's hash table is slow
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
Message-ID: <c0398484-15f4-e5c2-d229-82037094417c@web.de>
Date:   Wed, 1 Apr 2020 01:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wu395Up0lboTix9ZI/ylLZKf5Da+Cd5J2sm7CEIoGmLTG2/53nD
 aiWbzqFihqKFfGoehCqTYIQen+uj4i/eoAgIaSuBQvzcJZ8efUigWKH6mGkWGBajMH1y5bY
 JBe01ODFr9A14nyikmf76I4VEygyGi7sD5fTUaCg/9o/+1QSlWr+3ICF5xJJFz1YeFwmTj8
 nzGAWJ2ubVMzHtfuIFVAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BsJjAuk/UBs=:+JHtltHY8w99bLUrc2vAp0
 LCk+bOj/AsBtpoouk/Wq07XJGauo4CK9ENmM9UTOjoFHYNdQ8OnE7JU57F/3ChIMGqjU0l6z2
 6rgVhXj2Av3au/wfwwgmNgw13F3Gv8Yds+9C2WUys+Sjxc6Xz3UQ1OmiSDjFb9MjJEVwnHyc4
 DQTpDAj+crBKM0wISWbF5A/3RSiw382V+H2D3avzG6AJPXUkds+K/pM8fywbA2kMiFHRJhKYh
 WULSq7I+CFAQni9E+gHwySw4eFIz4Ub0MfSxGNTcUXlFLbvpx8GNpmOdilTmJ+nOCHuOJDlnj
 V86DdpFSvp+Ro14K9yUU0BpYs2eRDlmkBe8v35+27Y3BVXCQJ6jZVt/RY+VaG+QOX3UMrLVYP
 i5uixiPSmj5G2Q+L9BAxcqwK5/qVbk/YQPQepb4QHC4sHKvbkjUuS/AZo+C9A7xV4oohLqxpi
 MkCkCckgMDGXRTLWBQ4mU5jVxlxWWzlO2CbgJNpI9ZUULk/lcwco08w1e35voFaZmTSkgKpb6
 AFspRjgMI/mR2rac/hrzBCWEGeL+DGbsilTjGZlq74Y7xqiidPNe7TOellkJcy+SkeHj1n3Uq
 Xpn7mz0EUWk79bMS3KowWA5ji56k2LiLwx5WqSelrGp/feJp0Fp7H8QWd4YByv/xL8F85pgiZ
 P0BXXpPj2450NiU1i9K6iQCYyuPcKa6G7X1/2qikYulEaqVfbL+f7naI7mQQkZ0sSDrYq0BdM
 mjeKvKzzSD6gDv22nLT05LBXaQtWizDwWtMxqQDi/scUPah1zyIPL1CiFj6HXLwcbkbQVhN5u
 FMCWEtYK5E0+IXYVjnWrAL9t8zYnXfThhQ+NI5e6OKRvuOTUUz28WES3TJYs6s+ephHsZoaPo
 bgTqiwSxec8ZoXLQ9poU8UpkKkwGmtU0prTh+QmEXEawuBeaUYOzCwVjUbflwNb7KDUnWd5JZ
 NjCCWbv/5FrAI/UH6zh4f/kxwK73hujzgIbZamFIArjU83gHuavem2n15xANEtiLufi0gYqLc
 IvJIZkB7hnv72YDnfZicdSeCND+ALr6qzx8nJvdeeE5t8PzA5W8FBeOatEEeYNyjfgjdcSP+v
 zDyQnj7QwjtZ/I0MxFBhdpSR7YR2XTH6vcLB/dhYq8iGqXxbVxSNirKeBQXBo29n3MwFJyVN3
 HAIaT3SyP8BB3lBCpmW8I3TtqudVmXiswQqVySvjQ6Z7YWy3sCW2tRo2ZEyPAjoG79HmDSLuA
 Gb5/KDcq6vGCPo7gu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.03.20 um 21:14 schrieb Ren=C3=A9 Scharfe:
> Am 31.03.20 um 11:45 schrieb Jeff King:
>> diff --git a/fast-import.c b/fast-import.c
>> index 202dda11a6..6ebac665a0 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -39,12 +39,25 @@
>>
>>  struct object_entry {
>>  	struct pack_idx_entry idx;
>> -	struct object_entry *next;
>>  	uint32_t type : TYPE_BITS,
>>  		pack_id : PACK_ID_BITS,
>>  		depth : DEPTH_BITS;
>>  };
>>
>> +static inline unsigned int object_entry_hash(struct object_entry *oe)
>> +{
>> +	return oidhash(&oe->idx.oid);
>> +}
>> +
>> +static inline int object_entry_equal(struct object_entry *a,
>> +				     struct object_entry *b)
>> +{
>> +	return oideq(&a->idx.oid, &b->idx.oid);
>> +}
>> +
>> +KHASH_INIT(object_entry_set, struct object_entry *, int, 0,
>> +	   object_entry_hash, object_entry_equal);
>> +
>>  struct object_entry_pool {
>>  	struct object_entry_pool *next_pool;
>>  	struct object_entry *next_free;
>> @@ -178,7 +191,7 @@ static off_t pack_size;
>>  /* Table of objects we've written. */
>>  static unsigned int object_entry_alloc =3D 5000;
>>  static struct object_entry_pool *blocks;
>> -static struct object_entry *object_table[1 << 16];
>> +static kh_object_entry_set_t object_table;
>>  static struct mark_set *marks;
>>  static const char *export_marks_file;
>>  static const char *import_marks_file;
>> @@ -455,44 +468,45 @@ static struct object_entry *new_object(struct obj=
ect_id *oid)
>>
>>  static struct object_entry *find_object(struct object_id *oid)
>>  {
>> -	unsigned int h =3D oid->hash[0] << 8 | oid->hash[1];
>> -	struct object_entry *e;
>> -	for (e =3D object_table[h]; e; e =3D e->next)
>> -		if (oideq(oid, &e->idx.oid))
>> -			return e;
>> +	/*
>> +	 * this cast works because we only look at the oid part of the entry,
>> +	 * and it comes first in the struct
>> +	 */
>> +	khiter_t pos =3D kh_get_object_entry_set(&object_table,
>> +					       (struct object_entry *)oid);
>
> Dirty, but I can believe the comment.
>
>
>> +	if (pos !=3D kh_end(&object_table))
>> +		return kh_key(&object_table, pos);
>>  	return NULL;
>>  }
>>
>>  static struct object_entry *insert_object(struct object_id *oid)
>>  {
>> -	unsigned int h =3D oid->hash[0] << 8 | oid->hash[1];
>> -	struct object_entry *e =3D object_table[h];
>> +	struct object_entry *e;
>> +	int was_empty;
>> +	khiter_t pos;
>>
>> -	while (e) {
>> -		if (oideq(oid, &e->idx.oid))
>> -			return e;
>> -		e =3D e->next;
>> -	}
>> +	pos =3D kh_put_object_entry_set(&object_table, (struct object_entry *=
)oid, &was_empty);
>
> Now this looks illegal.  khash is surely reading a full object_entry fro=
m oid,
> which only is a mere object_id, no?

No, it's a set of pointers, and khash only accesses the referenced objects
via the hash and comparison functions.

Storing the objects directly in the set and getting rid of new_object()
could improve performance due to reduced dereferencing overhead -- or
make it slower because more data has to be copied when the hashmap needs
to grow.  Worth a shot.  Later.

Ren=C3=A9
