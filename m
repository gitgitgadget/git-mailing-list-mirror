Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B783C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 20:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274DC60E9B
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 20:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhHTUX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 16:23:28 -0400
Received: from mout.web.de ([217.72.192.78]:56855 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhHTUX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 16:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629490962;
        bh=Ai/cMMyhLHcurq2rPYTE7bKmTgOQX78uQhxTSR+WQ6w=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=GQL/2HjppdI4tylP+k7t43xnm/Ke6ipwSodf7Y3fhHUbyW7Gyab4//Xu8pEhVNDXz
         S6CAbV28w4OB/5XKy3YKgWaO8gY9pdRpJFublUCrXWBuIAIwEK3AmH4TNKLXfrsSJj
         NIdaG2dW++SN/YOhybvxX4211poSTcHs6CCaQ6aE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MIya8-1mbaGm2ZJq-00KM5L; Fri, 20 Aug 2021 22:22:42 +0200
Subject: Re: [PATCH v3 4/8] unpack-trees: fix nested sparse-dir search
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <10bcadb284e49419f9b4baf75e05f719ec395d98.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108190950540.55@tvgsbejvaqbjf.bet>
 <b7bd8e73-de86-c563-8b7d-405310ce6c57@gmail.com>
 <6d3844e7-bcda-490b-ba08-57c9e8058c4b@web.de>
Message-ID: <15624e06-d5cd-d83d-f894-f8ffe3809db0@web.de>
Date:   Fri, 20 Aug 2021 22:22:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6d3844e7-bcda-490b-ba08-57c9e8058c4b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hArIMcF7f65WCsGPe1MCEznZmK0h8rx29auV3CXVijefuXmcZOl
 sgEubW8sDrJGjp5wVEtHvOmIsHp2lTUBZt8Rj532bDfbWooNX/OH4AXeBqDR5awPrRz0M22
 YkvPxIE7GyYXskNmknARuiMsCXvcwZKc0IPbNe/209CIxorkfA27EDJtY/SnqQP5Bz4/mXN
 FBn6iZmjB+tdTOhI4aeFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xZfVui5xsmo=:PVhmUbMUei55NNkTu1m3jv
 3e56boRnUoBAnEet23VwxtcZI5707sxSA15liBh2EGiaw/VGJ5wIvIyMSJ7RxmW+xJryQFUoO
 ZOWhPVYhmujyCYEAIwkX43wd33sI8Ur73oT4WU0oYmczy/J/NeCmDR+r8asjOR+xIGu2NICBC
 TvzuHMrSNDSAkh2WDY+8vgGQvdlcGLQqHrf+A9Z/+p1AENDI4m8qqcqj2w759V6vsndK0UySQ
 R6zc/Jxrc6jsz8fUSFSD2OoGNXU0g19MqmQTI83O96iuG8BfyCU9D59HnczWHS4nQNO9cVNb7
 zlEp0StRxrOYe+t75gYF+ZTki5lp1EU5HHz4yhGC5C7PWKmmaXPi8ZfXkAgYI3ITrfUCxFUWA
 deeV1Of9r1Cid4qZB8yLnzeUtFyveUddcy0GG2sU3z6n2u/5KkdfY4rZ15ZY7Gd7r8akkacRN
 82QWKriiJdISkos851sA1GQomin6ZnSlLronyuReNE9VY4vhkrHvSF/k/jI4bpbpIfUpBbCob
 NC1GGWpPLK3E6OI7N5oFMrONdFtv10D89gY0XWRgtJKVmrryobv9UJOv7wIvrBvTYa6aw414X
 2EOY3dDPWlzyEpBwdZnAIObd7zImYafBTBv7AFtthZ9rUOVFDYIolt8MTGMIQRvvHXWFQ069D
 PxJNJgwTEbZwTjJaXWhQNX6dls0vTLU1l657Mp2cy0UDJNZKXMvJE87BKYF5r7XzSVVltoUDd
 GHcQdGUEfiK07sSvMUOOafRNVMFZSEyCwbIGcRKdIpgzyspL7RkxA84z8XQXV1cGDDZSkE8wL
 ysb05hKCIKSeM++KaxVVR76/tBBZrNOXSxlGPWm07VQBmxOl9AGqhX3zb6B5Tob6YLUP6sMgW
 CLnRP+bMBl7iIYzETrgQ7K3SVp3n0EJgJYL0IbkWLJeBBu1kDgJHblaDfYY3Yq3IXA7aTk8m6
 B6hVMD90B1HSQ+1E5diSb9QNX8ZI5KyOcYH7b0dAPxo4o2dS46wZj0tfs42MXsCiuJAa8j3Qj
 2GIQSh12dkFHkpuGAjx/IwDcfW0fGWy5WXCXsTm4wZV3zwyUJTdjJP+G31EchM2J0nB9hY+6d
 yDz9aSvk9HoG5LGve1yyzMx0C/JkATyUvnJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.21 um 21:35 schrieb Ren=C3=A9 Scharfe:
> Am 20.08.21 um 17:18 schrieb Derrick Stolee:
>> On 8/19/2021 4:01 AM, Johannes Schindelin wrote:
>>> Hi Stolee,
>>>
>>> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
>>>
>>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>>
>>>> The iterated search in find_cache_entry() was recently modified to
>>>> include a loop that searches backwards for a sparse directory entry t=
hat
>>>> matches the given traverse_info and name_entry. However, the string
>>>> comparison failed to actually concatenate those two strings, so this
>>>> failed to find a sparse directory when it was not a top-level directo=
ry.
>>>>
>>>> This caused some errors in rare cases where a 'git checkout' spanned =
a
>>>> diff that modified files within the sparse directory entry, but we co=
uld
>>>> not correctly find the entry.
>>>
>>> Good explanation.
>>>
>>> I wonder a bit about the performance impact. How "hot" is this functio=
n?
>>> I.e. how often is it called, on average?
>>>
>>> I ask because I see opportunities to optimize in both directions: it c=
ould
>>> be written more concisely (if speed does not matter as much), and it c=
ould
>>> be made faster (if speed matters a lot). See below for more.
>>
>> I would definitely optimize for speed here. This can be a very hot path=
,
>> I believe.
>>
>>>> +	strbuf_addstr(&full_path, info->traverse_path);
>>>> +	strbuf_add(&full_path, p->path, p->pathlen);
>>>> +	strbuf_addch(&full_path, '/');
>>>
>>> This could be reduced to:
>>>
>>> 	strbuf_addf(&full_path, "%s%.*s/",
>>> 		    info->traverse_path, (int)p->pathlen, p->path);
>>
>> We should definitely avoid formatted strings here, if possible.
>>
>>> But if speed matters, we probably need something more like this:
>>>
>>> 	size_t full_path_len;
>>> 	const char *full_path;
>>> 	char *full_path_1 =3D NULL;
>>>
>>> 	if (!*info->traverse_path) {
>>> 		full_path =3D p->path;
>>> 		full_path_len =3D p->pathlen;
>>> 	} else {
>>> 		size_t len =3D strlen(info->traverse_path);
>>>
>>> 		full_path_len =3D len + p->pathlen + 1;
>>> 		full_path =3D full_path_1 =3D xmalloc(full_path_len + 1);
>>> 		memcpy(full_path_1, info->traverse_path, len);
>>> 		memcpy(full_path_1 + len, p->path, p->pathlen);
>>> 		full_path_1[full_path_len - 1] =3D '/';
>>> 		full_path_1[full_path_len] =3D '\0';
>>> 	}
>>
>> The critical benefit here is that we do not need to allocate a
>> buffer if the traverse_path does not exist. That might be a
>> worthwhile investment. That leads to justifying the use of
>> bare 'char *'s instead of 'struct strbuf'.
>>
>> If the traverse_path is usually non-null, then we could continue using
>> strbufs as a helper and get the planned performance gains by using
>> strbuf_grow(&full_path, full_path_len + 1) followed by strbuf_add()
>> (instead of strbuf_addstr()). That would make this code a bit less
>> ugly with the only real overhead being the extra insertions of '\0'
>> characters as we add the strings to the strbuf().
>
> You create full_path only to compare it to another string.  You can
> compare the pieces directly, without allocating and copying:
>
> 	const char *path;
>
> 	if (!skip_prefix(ce->name, info->traverse_path, &path) ||
> 	    strncmp(path, p->path, p->pathlen) ||
> 	    strcmp(path + p->pathlen, "/"))

The strcmp line is wrong (should be path[p->pathlen] !=3D '/'), but
you get the idea..

> 		return NULL;
>
> A test would be nice to demonstrate the fixed issue.
>
> Ren=C3=A9
>
