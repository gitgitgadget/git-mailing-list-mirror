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
	by dcvr.yhbt.net (Postfix) with ESMTP id 537BE1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfITQiF (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:38:05 -0400
Received: from mout.web.de ([212.227.15.3]:34665 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbfITQiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568997478;
        bh=lBOD3e802gH/MBtXI+tvnhsZ9/H7124r6c5FxAxZ0M4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QATwe7pzjdbHl5+dC40e41I2PguqEB7QXkCqq23FAwrgGN+v61ER2rtb6H5JL3EqR
         wj7EPCrE9L9eAmfKN6hEk0mC1aZOiFbQd3LynZ58MRR8flY/wNEsrsQ5SXZ+3J7Y1o
         c5vmMao01o0Zww/8NysQjArqZMzizlh2XSM+kVwE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LseoD-1i4jDr0XI9-012DpK; Fri, 20
 Sep 2019 18:37:58 +0200
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
Date:   Fri, 20 Sep 2019 18:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-9-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:amg871/JOqGfGNcsZ6fLPr5G8mD30Ud6GEQYPFRfoqj/4cAea/V
 AhTg6xSMU4zWsMl8/g1EGchh1U9WtuhMLO1FneU/GslBAzYAxauBLPPl4x3LybQqV9irQ+c
 VKSOGo8Pj/99BXSxTNcgAAWYnjdqG1Dmqae8P4OWGebCT+eIxvjbyGqBJbnUFJqsuPwI/JT
 M/8X4Q65zqyzZa1aezmlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yDPmx5++Lio=:eFqqW9/2Tg0xLoFKf8/Qyq
 boukwioX6234eW+eTxKUW+GQTraNjI/T1R7P76VoQw7L5tdBKf4MROVPqjfjvd/tJwSnCxquC
 WLu2JjjUUHDLl9WKQ9hzopGktO3FoIuKuF1wXnfEs4xUVWfVOWfGDr64Z2VPtwCRJZ0jsz+7g
 /KyEayzVUa86h/zD6EqWOSnYMSihdVUiINU2o+VWDcS/5q7OukMhaWoNwt3PsQdEJFD2wrZVm
 ymStKj5JL1Z40SnbpluTnmPvXEOCGyikGpw0tVvX4br+SpN7HX4axONP2zdiE6NXrwT0UbaE3
 h7gMg3FwCYyZ8H6a6iycdzMv+bklcM2ZM40wtOW0efpQVHLToQhnctpN8/Qp0u4h+b+hAh4L4
 m+GzzuIrjAs94iCLehiIrLXxUtCJ2ESEoLh7i2kdNcbh8oZ9k+mGN/PB9vYJHQU5ZCfHXOARg
 TFxQz91pVHLMz9kFFZbbJvlSxGyPtLmVV1Dr1wkyM1USFXZ3LLosDDwG0IPuGFcbmtANYsm8w
 QlRgkad95XjMXSh/k2IsFI0wZ2mT776euUD5MBhA3XBRd3AqjrhYTWdmGF6ymw2oYwg5ZYcRS
 scRNJdyvsmGX3NXlQxhpR/uqtn9uFDDpazZ9lP8ZMd+flREbTj9HCF3iv0GTqXEvCpEofFF/A
 9zM5ZFOvKWEX95g/3gD6PKpDreqhDiECQXlvX3BpJMyxGIeI2uITV2fCMaU3Wl+TIjqWpxNna
 xDsvnJh5VsuMTcLaYqH5jSHqFNl6VfGwLUHeHm89EzWUv/6iJ01Cf+mcuOxkOfLo419OqdCjv
 yAGKR/goWdiq9fOglGIV28tS51KM/OuyksUdKs2Lv0OLKnrJbxQvhtWIdinmfe0v6DlZ/Imon
 /4qctkL+Zf27RqoU08VTT8F8+zJVz9wnHNtI8xmTIgJbRs23J3Py7Pa5a9HG/ah0KS63kBl3d
 RmRtsLreL/CazDtSYVO6pCtEJX1ZGkzGr++537KvR5BFdwYgGq7HID3KSPRnpTcZqPV6H9DSD
 rWxK1drU8aan4cDF9+gQ2AC7deOSLtMvD5kqjEU2Nn1Z5PE3gvdQeRAorVg5y2/fQN80ovEd6
 vfsRlyuEOysPLISsWNx/4XRZ/QX9TyA6a5u8lrYh/v74bbQMQVCO3ghBrxuOWsgPgsORQ9M4s
 mEKOxA2kjhov/o+TCBcYctsF88OiLS7LTE26QveSKLM/beXhHGP7jq0svuXjq0lBikQxVDdPG
 watGc5jkByv7yjNeMPYPrbWdR0VaP+tlcVm6J4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.19 um 23:47 schrieb SZEDER G=C3=A1bor:
> The 'if (deref) { ... }' condition near the beginning of the recursive
> name_rev() function can only ever be true in the first invocation,
> because the 'deref' parameter is always 0 in the subsequent recursive
> invocations.
>
> Extract this condition from the recursion into name_rev()'s caller and
> drop the function's 'deref' parameter.  This makes eliminating the
> recursion a bit easier to follow, and it will be moved back into
> name_rev() after the recursion is elminated.
>
> Furthermore, drop the condition that die()s when both 'deref' and
> 'generation' are non-null (which should have been a BUG() to begin
> with).
>
> Note that this change reintroduces the memory leak that was plugged in
> in commit 5308224633 (name-rev: avoid leaking memory in the `deref`
> case, 2017-05-04), but a later patch in this series will plug it in
> again.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index cb8ac2fa64..42cea5c881 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -102,30 +102,19 @@ static struct rev_name *create_or_update_name(stru=
ct commit *commit,
>
>  static void name_rev(struct commit *commit,
>  		const char *tip_name, timestamp_t taggerdate,
> -		int generation, int distance, int from_tag,
> -		int deref)
> +		int generation, int distance, int from_tag)
>  {
>  	struct commit_list *parents;
>  	int parent_number =3D 1;
> -	char *to_free =3D NULL;
>
>  	parse_commit(commit);
>
>  	if (commit->date < cutoff)
>  		return;
>
> -	if (deref) {
> -		tip_name =3D to_free =3D xstrfmt("%s^0", tip_name);
> -
> -		if (generation)
> -			die("generation: %d, but deref?", generation);
> -	}
> -
>  	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
> -				   distance, from_tag)) {
> -		free(to_free);
> +				   distance, from_tag))
>  		return;
> -	}
>
>  	for (parents =3D commit->parents;
>  			parents;
> @@ -144,11 +133,11 @@ static void name_rev(struct commit *commit,
>
>  			name_rev(parents->item, new_name, taggerdate, 0,
>  				 distance + MERGE_TRAVERSAL_WEIGHT,
> -				 from_tag, 0);
> +				 from_tag);
>  		} else {
>  			name_rev(parents->item, tip_name, taggerdate,
>  				 generation + 1, distance + 1,
> -				 from_tag, 0);
> +				 from_tag);
>  		}
>  	}
>  }
> @@ -280,12 +269,16 @@ static int name_ref(const char *path, const struct=
 object_id *oid, int flags, vo
>  	if (o && o->type =3D=3D OBJ_COMMIT) {
>  		struct commit *commit =3D (struct commit *)o;
>  		int from_tag =3D starts_with(path, "refs/tags/");
> +		const char *tip_name;

This should not be const because you allocate the buffer it points to
right here in the function, in each execution path.

>
>  		if (taggerdate =3D=3D TIME_MAX)
>  			taggerdate =3D commit->date;
>  		path =3D name_ref_abbrev(path, can_abbreviate_output);
> -		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
> -			 from_tag, deref);
> +		if (deref)
> +			tip_name =3D xstrfmt("%s^0", path);
> +		else
> +			tip_name =3D xstrdup(path);
> +		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);

tip_name should be free(3)'d here.  Except we can't do that because
name_rev() sometimes stores that pointer in a commit slab.  Ugh.

If the (re)introduced leak doesn't impact performance and memory
usage too much then duplicating tip_name again in name_rev() or
rather your new create_or_update_name() would likely make the
lifetimes of those string buffers easier to manage.

>  	}
>  	return 0;
>  }
>

