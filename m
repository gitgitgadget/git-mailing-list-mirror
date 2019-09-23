Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639781F463
	for <e@80x24.org>; Mon, 23 Sep 2019 19:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502430AbfIWTzU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 15:55:20 -0400
Received: from mout.web.de ([212.227.15.14]:45105 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfIWTzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 15:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569268512;
        bh=6AEC0FesAUu7wvicMDLtEC4rZLFsIOjne9M4il01UBg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FEplVyUl5aysGnHeSRU7Njhyq6alQUXBMGCGy70WYW5SkLRjFlXObxe6nvm3B+WQ/
         m3Kw+3lG3ehfPxAfmWgGVmP34rjdpPAsQwibrfqmkGYudOWQVXA59dUn3PXI6yUTz3
         Nv2duIDzgw5tEo9V3yQdBOmXDoXfQmYg0aROjaRM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hsk-1huYhi1oGk-00urTp; Mon, 23
 Sep 2019 21:55:12 +0200
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev> <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
 <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
 <20190922190511.GB10866@szeder.dev>
 <822d19dc-5202-b67f-5c0c-e5c69a679237@web.de>
 <20190923185908.GB2637@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0febc113-ce84-4794-890f-4703c07057dc@web.de>
Date:   Mon, 23 Sep 2019 21:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923185908.GB2637@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZUzTS3+GaRFj77xhir2qBKOEvD7VUL/5kLXKybbdn84V6Gklwpz
 9QdbuQ4OmgF7U1DEpE5QniWI9GKpYgZ7AQbvR2PABoY2Dcxc+DqPO1U5PKrrl22E3w/cJlK
 FbTGWad+dxWR6G3sV/EvD8MWZHvLoFGL7PuyNmXf8BwiQfIAsNZQWeOEj4xcpL8nUBz7PZ9
 iu7lBomcn5lHgElagMVeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mMrNPJsOUso=:0cnatg6QZTG+KxcK8gkaLj
 er/HXz1SlholARUREYZxHxoHK9jcwLxmjamSAz+Y8H6dIbTmzoKjKElRBsq8O8xgB3V3p1MiK
 547PrMMojRHpdb37dxUPxfz9JKE+0csVJhl6fUKu70rHt50+1qEe2Smd9c1C0FVgNPvNyzcwt
 kjwvrVj6rDwfdxzOumKZOrD9MiNyPGJ1u8eNHm6o0L5LT+6l8LP32ohJJf52g6W9+fMdoZedr
 1kqMfSw7tcuIU2S+Dn1MoEk5jMpBVV5pfx4QAgsfbQj48OI3AN7TFBxh5i782jbaVK0XvDjhq
 zOoaw1zEBdVrFj5qYnKYnq/2TlSjPLWS6THQbD1qYpWvQpTVKVWzZbiBemUFJ+QDrUzwCdAJV
 KOzBhDz81aVxyzHE8LMXikrCTorv8l6xR8MDhjfvcxkvHjErNVNtI3jtBrMNfh3mVThDjNob6
 Rgag8RDesaYY2FKckenQZhbHXSgeQ1LicBUg+28WCNucpHzvtORHncTsNykD18neE6ITP5YfO
 ZqyrjWcyugUV7HkWN24PidZnHIHDCfQ0WDirqJi4/NpqgxeYLCMTWyxnVAWbUDr0XrIhpu4mI
 h96ViyDoLpV9sSIQYA7iG/JnmgJ46U3S9KojvXlX+SpTKFNJ75gE+7+OxdQT2g9udb1OmwyXy
 9FDeT9yLM8IvBGaaiAedorAqrdQVLT8fVnPq2KkOwFw4cd6WzZggRPOjyKiI75HMidsq3V2CT
 jeKt8in61SzxBIQcuQZw58pPKOIcQvUyCQlviVsF5+QSESg1zVKLuRCp/iLLWTLfF9CZzsATL
 z+O+VU3ISEUCKxAZhf6UGmeTM3apjQptSFnIxRaeZkcNSmtJlq2rJxCb99U7AkIRbQd633QUM
 hHO7i7LkG9h8GaD8Qp+AqMNyyKzw18ejCzuUhNwyzljgKam92en+j3bLFSAUoX/jyf3jCSbuE
 DbTuL4ZFCwhc8KvykSEg0T9ZmuJ01cyi5LsUmHYhvWPEcmHB/S8f4EUL4AU3k9FXj5MnNRfCG
 JIajBj0d52qklv5ktNGWg8Pm8qriOo6fLL2nnjXNSGZ6/EJ5ZspkpmjyTEI7+YT9IDGic8ZaD
 rYWDShx64Ekzv9q9t5eTTm6j+DthvnHqTJHy7ycDJ58X0SIyd+Y23B5RVIT4aRlJ89ZCrPq5e
 mfq2SvdoaIIAz2+S6aDsOPeZnBmcBS6Vs9rXjme6NLdL2x73OdWtyLxTCO/vJ/v2yq0pQC94L
 jzAkgs9p9B9s3TuBcoGrIKHRC2FLYVPTUB7itUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.19 um 20:59 schrieb SZEDER G=C3=A1bor:
> On Mon, Sep 23, 2019 at 08:43:11PM +0200, Ren=C3=A9 Scharfe wrote:
>>> It's overall memory usage, the avarage of five runs of:
>>>
>>>   /usr/bin/time --format=3D'%M' ~/src/git/git name-rev --all
>>>
>>>> And how much is that in absolute terms?
>>>
>>> git:     29801 ->  28514
>>> linux:  317018 -> 332218
>>> gcc:    106462 -> 114140
>>> gecko:  315448 -> 344486
>>> webkit:  55847 ->  62780
>>> llvm:   112867 -> 134384
>>
>> I only have the first two handy, and I get numbers like this with
>> master:
>>
>> git, lots of branches with long names: 3075476
>> git, local clone, single branch:       1349016
>> linux, single branch:                  1520468
>>
>> O_o
>
> I have commit graph present and enabled.  Without that I get approx.
> the same memory usage in my linux repo as you did (along with much
> longer runtime).

OK.  Cloned git afresh and tried with master and without commit-graph
again, after "git commit-graph write" and both again with the patch
below:

git:                           109880
git w/ commit-graph:            47208
git w/ patch:                   94304
git w/ commit-graph and patch:  31220

Strange numbers, at least compared to my number for the clone above:
One order of magnitude less!  Not sure what to make of it.  (Tried
the clone again, same result.)

Anyway, here's the patch:

=2D- >8 --
Subject: [PATCH] name-rev: use FLEX_ARRAY for tip_name in struct rev_name

Give each rev_name its very own tip_name string.  This simplifies memory
ownership, as callers of name_rev() only have to make sure the tip_name
parameter exists for the duration of the call and don't have to preserve
it for the whole run of the program.

It also saves four or eight bytes per object because this change removes
the pointer indirection.  Memory usage is still higher for linear
histories that previously shared the same tip_name value between
multiple name_rev instances.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c785fe16ba..4162fb29ee 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -12,11 +12,11 @@
 #define CUTOFF_DATE_SLOP 86400 /* one day */

 typedef struct rev_name {
-	const char *tip_name;
 	timestamp_t taggerdate;
 	int generation;
 	int distance;
 	int from_tag;
+	char tip_name[FLEX_ARRAY];
 } rev_name;

 define_commit_slab(commit_rev_name, struct rev_name *);
@@ -97,17 +97,14 @@ static void name_rev(struct commit *commit,
 			die("generation: %d, but deref?", generation);
 	}

-	if (name =3D=3D NULL) {
-		name =3D xmalloc(sizeof(rev_name));
-		set_commit_rev_name(commit, name);
-		goto copy_data;
-	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-copy_data:
-		name->tip_name =3D tip_name;
+	if (!name || is_better_name(name, taggerdate, distance, from_tag)) {
+		free(name);
+		FLEX_ALLOC_STR(name, tip_name, tip_name);
 		name->taggerdate =3D taggerdate;
 		name->generation =3D generation;
 		name->distance =3D distance;
 		name->from_tag =3D from_tag;
+		set_commit_rev_name(commit, name);
 	} else {
 		free(to_free);
 		return;
@@ -131,12 +128,14 @@ static void name_rev(struct commit *commit,
 			name_rev(parents->item, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
 				 from_tag, 0);
+			free(new_name);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
 				 generation + 1, distance + 1,
 				 from_tag, 0);
 		}
 	}
+	free(to_free);
 }

 static int subpath_matches(const char *path, const char *filter)
@@ -270,8 +269,7 @@ static int name_ref(const char *path, const struct obj=
ect_id *oid, int flags, vo
 		if (taggerdate =3D=3D TIME_MAX)
 			taggerdate =3D ((struct commit *)o)->date;
 		path =3D name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref);
+		name_rev(commit, path, taggerdate, 0, 0, from_tag, deref);
 	}
 	return 0;
 }
=2D-
2.23.0
