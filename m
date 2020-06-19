Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B81DC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0E207FC
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="j/hzmgfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgFSJOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:14:47 -0400
Received: from mout.web.de ([217.72.192.78]:39879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbgFSJOn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 05:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592558078;
        bh=0rAXFQuc40ZeUBrwj+DYjuuWwo8HjdNC1H+kP+yr6oY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=j/hzmgfvCnmHNBAkhQ+QSahA9a2R7BnGg8rMFnfz2aKPb4o1FEiCf2Jm1deyEaShx
         qANCLURC5txMcSsuoo7+Fp+WkLLQzdTas97ouZ9wSF8oHf6pLAZte9VNnYtwAseF5D
         fe71RdT14Jd/eCgjFZCVJKJGuldcBqd4xjngA+UA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAMli-1jbo2B4C8g-00Bcfi; Fri, 19
 Jun 2020 11:14:38 +0200
Subject: Re: [PATCH 5/8] commit-graph: check all leading directories in
 changed path Bloom filters
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <9975fc96f1269b049ebdd54835a63480c3dcbe4e.1592252093.git.gitgitgadget@gmail.com>
 <acfd97a7-9a53-0ad1-41f5-48524ceb99db@web.de>
Message-ID: <0b70fca2-5c3f-5d9b-d56c-ca731450a212@web.de>
Date:   Fri, 19 Jun 2020 11:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <acfd97a7-9a53-0ad1-41f5-48524ceb99db@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FCgcdB3FtQKlOnqgaNQcg4GnGaAijVBrbDkJrX9d9qVDtTe70Er
 2RYWoxgluzDjkfXqQ00QGpZ6rmRnCdhhXTShvpFI2fo68EmgE0MLG9wLWGWNxgeOvsPDZjl
 fsfXbIqq7l8FgAsCaVOIRDNoL+Yi+rE/miuTmBzf0uHGSpxGH5tTs1+7Pr0U93yLke+AjuK
 AorRtQT7wDUalixFZh9tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g8iqO+eph6Q=:awN97ks1DaZCrm3vEROjWE
 A/Vvti/GcghZwH+WnXz28ogesA3PFYkg7zGx/CLA+fN8fno87cjpHEIHGovZS0RRxXBi5gz3e
 YT0krwImPkYvHk8M6B6oXWqg9+6gARWTPOFntzrR5Pi583fYuopZIhd5Nx7zyg85OkL4ogHfE
 IOKkAu+Tm2t/xQrLw3kbl1mzMnmVyM/nFLpRQBVQ0bKpyKbsT9Ck/gzJVa7PWBUHh2P1NtgW5
 rdDKvDTyd/RCy5cdapxFby/j80iSF4oweuhWF5sGrPFsFVGruHDmCppa8iUJsWptTA5VD4oAO
 QHpXHc0fIwZUEtWbEWAp0dpDeKNQC67stBaM2UY+yFVf0VzDfOms3uqxWCZXR58HCl73jxH1X
 2yzLf2DAdx0316x4sQq9SUpA/ul5QgKLmN/ef0BDHWMX4xmPcJYq03VQZ54nSaF3gcmOLqDOF
 fdpwdYA1nwnVQvBTirmLcB60Denn6rI3q+M/7j4DzadDFfw7RggJhST2eOhc44vpZS+cUj6+0
 69+m7W/WDFkp3yyT3v7M1PHut7B8wtJ01hsbAaPgQRxA5opjgPddn5UvYuZGARvaLTxm5f/et
 +A5GKjncUB1TJZi0O7cieUuo7TY8+zaPtrH6LSPcC/5BqCwKJd1zl6xy2DR39RK0RZ3C9Dpry
 R7DOWxKLET2/hkf1cKTi3APxehoztsRRDi/3VRv+TY8CYtDHDiac2mTo2h57l3O1mYVlNzUau
 JCHchq6f8qyBxvDMni0WUXqRAC6Cm8aD/CKNfGDVnVNa6QOn7aS69mECCVSlVSZ797uiDYQL8
 xvNFdWCmGrNmi9TXPvcjrwMPkmw0bbE728Jnz8stcAPlx8vn1mvLg/EMYBCJEem/03s4BOCrS
 50vsOXp3MyyPTcVUqtKXKEQv5j55k7ztiYezP1js9Esc44OGL1VZErs+Zu9jDZli81vui86hF
 ZUByjBKNpD5m/meIUp31HvAfHCZNfLcimNBfMlhKmrocvj3edMq8Sdc0Ellyr32aNCbG98USE
 GHoUB6dJI71sqk1i2c7aPizPT2e93reZlui0SLzS90ZVrz0Q+o9ua2nLnS6iNbDzY2E90wZwc
 IRk9RwTqVCCLT+1yYL1JTbKVIzY53C/SHYtp7ODp7RqwS/ijWWKnTeOuR0d1EwteOmkMUcZjZ
 seI0XQvQT4JfGkRonfbv3RMmtodhSEr3wd4P/nm9MsLHHjSdAkhImBXMoYnFHQmUX1FGM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.06.20 um 22:31 schrieb Ren=C3=A9 Scharfe:
> Am 15.06.20 um 22:14 schrieb SZEDER G=C3=A1bor via GitGitGadget:
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -670,9 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev=
_info *revs)
>>  {
>>  	struct pathspec_item *pi;
>>  	char *path_alloc =3D NULL;
>> -	const char *path;
>> +	const char *path, *p;
>>  	int last_index;
>> -	int len;
>> +	size_t len;
>> +	int path_component_nr =3D 0, j;
>>
>>  	if (!revs->commits)
>>  		return;
>> @@ -705,8 +706,22 @@ static void prepare_to_use_bloom_filter(struct rev=
_info *revs)
>>
>>  	len =3D strlen(path);
>>
>> -	revs->bloom_key =3D xmalloc(sizeof(struct bloom_key));
>> -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_setting=
s);
>> +	p =3D path;
>> +	do {
>> +		p =3D strchrnul(p + 1, '/');
>> +		path_component_nr++;
>> +	} while (p - path < len);

> And shouldn't we use is_dir_sep() or find_last_dir_sep() instead of
> hard-coding a slash?

Not necessarily.  Paths should be normalized to use one specific
separator, probably slash, both when building and querying the Bloom
filter.  Otherwise a filter that knows e.g. "foo/bar" could confidently
claim that "foo\bar" does not match.  If this is done in a previous
step then using a literal slash here would be correct.

Ren=C3=A9
