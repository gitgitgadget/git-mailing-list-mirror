Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED374C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354773AbiALPrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 10:47:14 -0500
Received: from mout.web.de ([212.227.15.3]:35913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241305AbiALPrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 10:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642002431;
        bh=lUbF8XyDQ0rM1Hunz8fMW+wtHEiRaFv5g94EgfQDSnU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=nnQ+hd9RxZ7UfNMglDPDzHBhj+HI6aATAeeCIoG3vZxG04wkVHq4SRpEni6Blp3Vs
         6wsnQUkZdDCXmLsk3bxjhjLwQsD18qCj+IQb0f52MhDdvOE8zQ5DWQnWxfgpTxorgA
         7yQ5uN/8ELmw0tI7jRnuCkTy3J/Qc/UL/13/H+Zc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xaR-1mKjwC1GRn-014a3v; Wed, 12
 Jan 2022 16:47:11 +0100
Message-ID: <c4de043e-45e1-6066-37d5-6b06b7a820f7@web.de>
Date:   Wed, 12 Jan 2022 16:47:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <641A33F3-E98A-40B1-BB11-ADC8C1FECA75@jrtc27.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <641A33F3-E98A-40B1-BB11-ADC8C1FECA75@jrtc27.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4s+9FRoWQhGPgd3Ce3hTqRlEbFXGPfDrgd6+SVeRJtSGU52bPKw
 8LmmIAxViAkToMd8wUVwwRomCGMAbdynNuPvFJB8Zr3na/QgdMPv1Hl9tRYszWU2bo99+RB
 C6TBvY2oeJNuycNRmldnckTbEqm+3XzOgKvoxUWHkycULvOEMK3OLN8gwCL70L3igTu6wf3
 dKSFTNiVTj/EbFLqqUDIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gn2pK5zKjJg=:qdaMUGnuHi2MFiLJ7LPU5D
 iIn2y/dGimZ0cazCFFx4I9dET3JovLFZgXV1KoxvE8gI6x5DCm5FZr+JgzCm9WyK3wNavdX4M
 OKwg+oWwi3bh6h7llemIX0cdBECISfuEXEjnZq4JDiVGG0PCHuVAFbpAoaoUSy+8YqF2PPfAL
 ZnuDgfT+z4QGjvSaBpCmvxKAY7ytKwgBvj+bbnkCylo7r2E4wGs708WpTFsGhmMzcUhqrLSMv
 gaD42LXzVMkeAVHHmC5KndnXha0PNWQf2WQT9H+L9EtIow1IflkfYmP37rX8D0tuTbsC0rlH7
 uVnXVIIznsJjN0K0JtT9wkVExpnAdEKEl4W/+GSfV2aQM/iqMFhoyr3cYETyRkj+U+P7z8Wmw
 RvzGAv+cp4RBZ79dNH3niQo30O2zANTzNYlQYaQsrIGv5iYbucREYLur89dcQXrXczOmXdCkK
 ZTZginnHq594WfB5Z1qa/AlFtL6Cs15sdE3PcedpY644/rCTYOMgUschmqlpQJn26vvcZWLm/
 dK7/GgHWgyiJihyQFXsAqDOfUfRPYkiaEowqf9RDcQ/B0W99ShrUQUbOiNFRmkdTFVdnhHhjW
 JI+qHktOIkRk0ffnGuFjyonqy3huFY2hkUHRJPOKUsSkpwm5Xt6JhQ9nUJOm1v2sowXXQls5b
 oG4tsdyxF6ebFUzXOiIoV/MPbXvH5fp61PCVzMAJlRoXhwewlOy8wjxZnJiCJHL8zWePEWV48
 e/GWBoHL012D7mNhBJ1rPCwtd1FIJXaB1OMfYX0DxoyX8VAq5Ws3H2HfoVFTw7DgVmElbGi3l
 uIHtoY/RYMs7ROteHUzi2HYwuRV2dSuPKKxmuVjvSC/wMHPNLfw78IDM+DH8wls5qRw2QlXoC
 xdKJE6fLh/WERC+ABJobUDRuo1LHtI9Xm4SpMrWBGuew5/nRd2BMQMmYn9UeCKZGko7QXdTpK
 fGM5gWl3jjqYjk5/UmawG6RcjTFAXvKI1ThfnaJ6B1+JN3cbpuhMG04fdLWSg0XLFz+QkjMGn
 2SVA25GeF56t6hyL7G74JPTdLHWdJ0Bmu2zK+zE/ICVHPF7guJQ7nfioUKERVvH9YRdj4ovJz
 hTKWMYxIm4iQpQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.01.22 um 14:58 schrieb Jessica Clarke:
>
> I can see the alternative fixes for qsort are now in next, as is the
> cleanup of register_symlink_changes to use string sets, which just
> leaves the mem-pool.c change to not assume that uintmax_t is
> sufficiently aligned for every type that git will use. If I move
> GIT_MAX_ALIGNMENT and its helper aggregates to mem-pool.c would that be
> acceptable?

Defining it at its single site of use sounds like a good idea to me.
We can export it to git-compat-util.h later, iff necessary.

>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5fa54a7afe..28581a45c5 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
>> #define _ALL_SOURCE 1
>> #endif
>>
>> +typedef union {
>> +	uintmax_t max_align_uintmax;
>> +	void *max_align_pointer;
>> +} git_max_align;
>> +
>> +typedef struct {
>> +	char unalign;
>> +	git_max_align aligned;
>> +} git_max_alignment;
>> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)

Style nit: We tend to use typedef sparingly.  And the union type doesn't
even need a name.  E.g. this would work as well, while reducing the name
space footprint:

   struct git_max_alignment {
      char unalign;
      union {
         uintmax_t max_align_uintmax;
         void *max_align_pointer;
      } aligned;
   };
   #define GIT_MAX_ALIGNMENT offsetof(struct git_max_alignment, aligned)

When someone uses a mempool for objects that requires 128-bit alignment
(e.g. because it includes a long double or uint128_t member) then we'd
need add long double to the union as well, like e.g. compat/obstack.c
does.  That would be the safe route, but currently only add 8 bytes of
unnecessary overhead to each allocation.

Perhaps mempool alignment should be configurable.  For now a comment
might suffice which indicates that GIT_MAX_ALIGNMENT is only the
maximum alignment requirement of current mempool users, not the
highest possible requirement for the machine.  Renaming it to something
with MEMPOOL in the name would help in this regard as well.

>> +
>> /* used on Mac OS X */
>> #ifdef PRECOMPOSE_UNICODE
>> #include "compat/precompose_utf8.h"
>> diff --git a/mem-pool.c b/mem-pool.c
>> index ccdcad2e3d..748eff925a 100644
>> --- a/mem-pool.c
>> +++ b/mem-pool.c
>> @@ -69,9 +69,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t le=
n)
>> 	struct mp_block *p =3D NULL;
>> 	void *r;
>>
>> -	/* round up to a 'uintmax_t' alignment */
>> -	if (len & (sizeof(uintmax_t) - 1))
>> -		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
>> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
>> +	if (len & (GIT_MAX_ALIGNMENT - 1))
>> +		len +=3D GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
>>
>> 	if (pool->mp_block &&
>> 	    pool->mp_block->end - pool->mp_block->next_free >=3D len)
>> --
>> 2.33.1
>>
>

