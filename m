Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675EC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2123B6115C
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhHTTgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 15:36:41 -0400
Received: from mout.web.de ([212.227.17.11]:52873 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhHTTgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 15:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629488154;
        bh=VuVqxvdHd5BhRGYTCXHaidXIxSkdHHN4OX9VikrStqs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d4A9I447k7ibm1NHiC/kf8oEIOtxP0Q8vllWMgWUOVrMIPXW19cso2L9BGxp/3K5c
         Z0Ua6nrUE8auZjiumkiMUgkS0uro2ojQdYwyLwqxeZL+mlouy24hNbVVMKIqTPN8og
         87/nx6aC4ZE0Fs555d9pzVO081DLvKm8hkRtKcv8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lb1wz-1mkDjf36uP-00kh2U; Fri, 20 Aug 2021 21:35:54 +0200
Subject: Re: [PATCH v3 4/8] unpack-trees: fix nested sparse-dir search
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6d3844e7-bcda-490b-ba08-57c9e8058c4b@web.de>
Date:   Fri, 20 Aug 2021 21:35:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b7bd8e73-de86-c563-8b7d-405310ce6c57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TdFb4HJCrIhabwt5pCz24xSb48DRHKCI7PGKL6F3tTVlqpOMTzG
 OXTUL53XRYvFsMHb+Y3fL5oK9zvdm4rEv4RIk5/szB0vgB5FeZZdbuO/iIUkilXqCvHD750
 zpyhF3EeAXTieNbf5GUeCKoGK2TwDVWoi7x5tw0DQORqwbpu3XbLCSzD6vNyoxQslEAQRLR
 o/ejheb2iIiCG3gC79QnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E6U6bvMrt8M=:20/yme7ohLlyKVSlti+7b0
 D7W4yUuXOO0pWmxYqAM3/G/nt9QeV30XngO34llnMsBcg7F8uAe4TJKp+OKY95DmmHUsEtViF
 dv0kvcXTvulV9gNc2TjRC5npR2FliEn9KQSt+yGNfwD+ZUDR7+6kVfrOx8pXMI4WrWydlgo3w
 Qf7xUJwnmH86DEFBIH8Pceea7gFBWFRAugkgcV/8x5gWyql7tSKlfP+RrMj0Hv1xvEkhrATHQ
 hlls0Is9MC/3mqoxY8VGBSNCprPJhImi8FHiHlRrUYlh2uJs7p3Y6axxJJKUm0oTiYcHHd83Y
 SDT+3cbmj3ev311BMn7Imf0NpgR6ptf2hGCsm/x0/gOkaIUhdrkngHIaPZUG1YDGkdlfxtJ+m
 /PQNA42oLZmsZxJ8RaKCaAYmIDc7h7OUrFqNbXCNFvUUiOro0aV5SdHUcP6vrexQKPl/eX8QJ
 f/PE2RjbOT5TvrthuDw93o53unzaqdvHTaA30qp0O2EX3OpgHo8oCNP8wvPs9AAnICkh48TZC
 UP49XydFshEO3glzjSeLlloJtdl79apqm+8M0f5SUBcvgra/8K8AHXuQNdOkZMaWB5Zjcbsk+
 ILgOiqp+KP4IhVkyeJS7tPRULygmwDpgdeiIh49SJAXb46gIP4PVA9zor+blnswKTVke0/oCy
 tThGK2aB42TMoLs4/vFGmKNxfRccvO60/z6P7L9ZIqDFKfW4Azd7bUEaTs0FeIHrg43NR9ENp
 5c539J2UGGs+1mvtFDJH2Seswf10eMGfGtcEYwrc3HWrzeriQ1orG+V5ecUc4Y2AI0LILbRE2
 3TwbJWGLhKQWagUfsQij1rmtxKBaQfJi+gxIdqjjxqcXS/CQSe75+YCsK9UxQNf/yTKq1y5mE
 O0XH9BTEmfY35JxMSA+tI9Av/j3L0E7rG64L83B1Cso9pyFglqGkcAH/uTrE9hO/XtrSszpXc
 DSrLvIUZS1x4uXdLW0oAaxrgtnP6NUq4I4XJ3NkATvNm/z1OjLZMaBoS9fwCBacjTUHPz2Vom
 2t166IO+p2yVNkowhzIaHtVhDPMIfaNM98qrjU1j0CPe5eIUU4mZED/bnvOqNZv7rc09OwR+M
 dyUCd/Lmo1RCTXvW6/HF9sU31jRPH3sQ9JX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.21 um 17:18 schrieb Derrick Stolee:
> On 8/19/2021 4:01 AM, Johannes Schindelin wrote:
>> Hi Stolee,
>>
>> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> The iterated search in find_cache_entry() was recently modified to
>>> include a loop that searches backwards for a sparse directory entry th=
at
>>> matches the given traverse_info and name_entry. However, the string
>>> comparison failed to actually concatenate those two strings, so this
>>> failed to find a sparse directory when it was not a top-level director=
y.
>>>
>>> This caused some errors in rare cases where a 'git checkout' spanned a
>>> diff that modified files within the sparse directory entry, but we cou=
ld
>>> not correctly find the entry.
>>
>> Good explanation.
>>
>> I wonder a bit about the performance impact. How "hot" is this function=
?
>> I.e. how often is it called, on average?
>>
>> I ask because I see opportunities to optimize in both directions: it co=
uld
>> be written more concisely (if speed does not matter as much), and it co=
uld
>> be made faster (if speed matters a lot). See below for more.
>
> I would definitely optimize for speed here. This can be a very hot path,
> I believe.
>
>>> +	strbuf_addstr(&full_path, info->traverse_path);
>>> +	strbuf_add(&full_path, p->path, p->pathlen);
>>> +	strbuf_addch(&full_path, '/');
>>
>> This could be reduced to:
>>
>> 	strbuf_addf(&full_path, "%s%.*s/",
>> 		    info->traverse_path, (int)p->pathlen, p->path);
>
> We should definitely avoid formatted strings here, if possible.
>
>> But if speed matters, we probably need something more like this:
>>
>> 	size_t full_path_len;
>> 	const char *full_path;
>> 	char *full_path_1 =3D NULL;
>>
>> 	if (!*info->traverse_path) {
>> 		full_path =3D p->path;
>> 		full_path_len =3D p->pathlen;
>> 	} else {
>> 		size_t len =3D strlen(info->traverse_path);
>>
>> 		full_path_len =3D len + p->pathlen + 1;
>> 		full_path =3D full_path_1 =3D xmalloc(full_path_len + 1);
>> 		memcpy(full_path_1, info->traverse_path, len);
>> 		memcpy(full_path_1 + len, p->path, p->pathlen);
>> 		full_path_1[full_path_len - 1] =3D '/';
>> 		full_path_1[full_path_len] =3D '\0';
>> 	}
>
> The critical benefit here is that we do not need to allocate a
> buffer if the traverse_path does not exist. That might be a
> worthwhile investment. That leads to justifying the use of
> bare 'char *'s instead of 'struct strbuf'.
>
> If the traverse_path is usually non-null, then we could continue using
> strbufs as a helper and get the planned performance gains by using
> strbuf_grow(&full_path, full_path_len + 1) followed by strbuf_add()
> (instead of strbuf_addstr()). That would make this code a bit less
> ugly with the only real overhead being the extra insertions of '\0'
> characters as we add the strings to the strbuf().

You create full_path only to compare it to another string.  You can
compare the pieces directly, without allocating and copying:

	const char *path;

	if (!skip_prefix(ce->name, info->traverse_path, &path) ||
	    strncmp(path, p->path, p->pathlen) ||
	    strcmp(path + p->pathlen, "/"))
		return NULL;

A test would be nice to demonstrate the fixed issue.

Ren=C3=A9
