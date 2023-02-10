Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8008C636D7
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 20:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjBJUVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 15:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjBJUVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 15:21:25 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1381285
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676060420; bh=/XBjXQj38CPMUPAsvJ3KFy7un0YbYlEvXcm0I2hlzB0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ulvjKKKuxv90girnB4K4cri1ISN+S7lgYNsKSBFbfdf8+vFEfH4r4cV8TC0Tlptgv
         Z4ZYVyegCdkVVjgMS2BAwLEO3JGWJ2TUx53gT4YoBluF721nwZYrjSksFfMW6d+dbA
         u0KkHuTe/jq3Rd6jdijUZuHKqZVOm/bNVvoITpcUEzeherbK/UUC3Xw/7/cf7muIXo
         a+Cb16dTT6qGyQGV53mqw2u+n3aHMTcBmP96jaQ6waZmh50ClB1Irv0kalh/VOaVRD
         ugiOI67dJBTLd/Bt0+OQQqWlEaoIrJaQgjHp/DmM3Ena8MVAqEWsn3ICaAu1BPjQKd
         WGnli1U0bmlDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpqo-1oqgtd3jWc-00ZwdG; Fri, 10
 Feb 2023 21:20:19 +0100
Message-ID: <850c94d5-973a-335e-903f-e0ab7e52f37e@web.de>
Date:   Fri, 10 Feb 2023 21:20:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
 <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jXx8v+4d38m18QrQAHV2RRjAqHkzivL+A1Xgv5wQXr6Kyh0I4Ne
 S26DC9xhxgs2J5hISg6MPRZHyu7usNRc5fkOBSozpp+JR34Iad0JwkmHimklKydSWrwIEFA
 NYsxzjNOgUMaa9+Y14CgpB9rRMdkN+Wn+NscFAW4b4iTDYuAVDfGFqqzXb0jRRuvQQG/YGR
 6UMNfyDQywXw2+gowCoAg==
UI-OutboundReport: notjunk:1;M01:P0:qFkr99EAdMo=;THEkvlwumX8oc2cuc4rfcL7D2MG
 iGkByhlssPyZZzDMncKrLItm1vjwyF4q3CMphfreRlvZHp/BTn6VP5MhB+BmGq3h4x3+BRtRR
 PUW/YXq48iNMbBRvxAXeupF8hXju28shjZ9IWr/42i4SEzn2kVQ1m+Iajqi7ABhRTkCwVP5Md
 W1hQqsOS7e9YFgpBRf1jYm9O1Js39Acfw4pNDnWRT0OmoQiNywSkJUHP2hIzT3THlg7jrOJIr
 QKJw1X4IIWbADNVl0GchDR0TtJBdk269uFExMkMca8sRbFqhBAvkZNKzFuFSQ6F2wFA5Bt/0N
 unVlTRTKffNAu77qWUPcLta4LmhDzxQLvFUyzz/5ofRo3kKW5NH0gzc1KoO9HYH+Ze9JIN23u
 dOEzTW93jaK9+zITs39IGOInmUYzcOGSOq5ofBUuM5ue3ZFA9n2FLpp9jI1dLI8KY+ZGvHAdk
 cVJfBADOhwiuOX9SNtR+Yxaiv7uu/Zfm8rRctNWWMMaud8ChZeErjwvDF8m6VQH7hnbV1Z3Jv
 HbsFIxTgKLD1x6qLGZgtrTGtH2rZq3qilalYohX6bJQUz3mvU4EbKk8Pn44PHEPx6EFPWK3Qn
 MRxiA9QVyMKHPTXO1hIKCPeF/HIj+/M+cb7UThjL53tDJ4Pim2L+jjP+yTYJNHYIwtKrUk3F8
 QFtGgTE2POF7NW7+ai3DEsTOWHONMLRTFP4F0/+uD6NVJmT1mwuZitcd6KRo4tglDPMi5V/Ne
 b8s5yq4qEbieQ7uYS/Ut47SxZfKK3lMiwTSCJx98JPFw/9HrHHfahQKv6pn5Br0mRsfshkjkO
 ++Z0Munq4Estjx3/J4L02pgvko1u6mWnZhKLMx7VTnAm26ShKHb8p9QWX6SMTqCixJblDIWY8
 BA4JZW0hW3C33McUZRrEokaKsFAlweVOBOi/O2bgJb6se0VWfhgK0wNe1c/NN0IODbNN1BHN0
 2tPVL3BvtJDCc5QiW+AokBvaEpY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.23 um 22:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Feb 04 2023, Ren=C3=A9 Scharfe wrote:
>
>> Use size_t to store the original length of the strbuf tree_len, as
>> that's the correct type.
>>
>> Don't double the allocated size of the strbuf when adding a subdirector=
y
>> name.  Only extend it to fit that name and a slash.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  cache-tree.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/cache-tree.c b/cache-tree.c
>> index 9af457f47c..35f7617164 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -760,7 +760,7 @@ static void prime_cache_tree_rec(struct repository =
*r,
>>  	struct tree_desc desc;
>>  	struct name_entry entry;
>>  	int cnt;
>> -	int base_path_len =3D tree_path->len;
>> +	size_t base_path_len =3D tree_path->len;
>>
>>  	oidcpy(&it->oid, &tree->object.oid);
>>
>> @@ -785,7 +785,7 @@ static void prime_cache_tree_rec(struct repository =
*r,
>>  			 */
>>  			if (r->index->sparse_index) {
>>  				strbuf_setlen(tree_path, base_path_len);
>> -				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
>> +				strbuf_grow(tree_path, entry.pathlen + 1);
>>  				strbuf_add(tree_path, entry.path, entry.pathlen);
>>  				strbuf_addch(tree_path, '/');
>>  			}
>
> The size_t conversion is trivially correct.
>
> But what do you mean with "don't double the[...]"? Do you mean that this
> manages to evade growing these to 24 etc?

strbuf_setlen() truncates the string to the directory name.  strbuf_grow()=
 then
makes enough room to add that directory name again (that's what I mean wit=
h
"double") plus the entry path.  We don't add the directory name a second t=
ime,
so we don't need to make room for it.

Ren=C3=A9
