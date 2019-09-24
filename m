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
	by dcvr.yhbt.net (Postfix) with ESMTP id 502381F463
	for <e@80x24.org>; Tue, 24 Sep 2019 17:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfIXRE3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 13:04:29 -0400
Received: from mout.web.de ([212.227.15.3]:45353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfIXRE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 13:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569344652;
        bh=q7M8ev8+lVcYNYXTbGN3t6j4l8xyBkhvGAweCAFz2NA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G6bGjDdtTd9uTfLLtSWRa3B3UbH+2jD8wY4PTeyWdL/fhG182+bhF87uI/f66iPTh
         RgR1+8Fp6RJRXNg4qYsPNFqC/nyk9Kl6XRoxR03nBOdVlLxqzrZjUfxw6WXjqio2cw
         YUtV3irisBW6ozcRKTHtWUxkjtDT4Zyv+yxMM3LM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhNmy-1hr01L3q40-00maK3; Tue, 24
 Sep 2019 19:04:11 +0200
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev> <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
 <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
 <20190922190511.GB10866@szeder.dev>
 <822d19dc-5202-b67f-5c0c-e5c69a679237@web.de>
 <20190923185908.GB2637@szeder.dev>
 <0febc113-ce84-4794-890f-4703c07057dc@web.de>
 <20190923204714.GC2637@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ce55a33b-aa8b-9325-fe87-8ff4c7e02627@web.de>
Date:   Tue, 24 Sep 2019 19:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923204714.GC2637@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BJSOJGinDfszFSU4G2N3xZ+vFkT2/k9vusTljY+nF1XaVY+cL1Y
 44Qy90w3Qn6DXF7YanY8ik4blSfNw1WBZ9sozA/xboQicdgnC8RoDI/RuJTgqEmK3Fpsv3B
 b2csPUiTSY6pA17hEH0YSjzTQva1CNwYhcy1nKlQuE++QoSrXqAMSdIpnDEFEBLpwS1nvIQ
 qhHDfyh0XteHDMz+iCdDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:asiRtF6Too0=:88S/I1IRw9fdIsIhds3NSV
 38qnSszRAbfU7Hwr/CLNh7duXBDd4UGgy5gBC24e1on+xN6wayf7rz2ywIiFge/WCZaPa/5V6
 AXYeVeB/jCUesKRJfweRJi0F6GA9FteM+4EXh3w4ZZp/cqhUdXoE/dIehuDnXk5qzbkW2dXTP
 yQneF6wvTCh6EEcIZm7BhAwewJl9Rk2taVpri5rntTnq06FHMVYDW/s4JysKTVL4vFR1D+xc0
 Txg5HM9+BCfDqjpvd4V2MxR812TUpgLWQCacWWpR5q3H6kyaSmPfFewifrfxh4kr+1HfYTIvy
 ggdCXgJwoCinbWiI7FSYjYFxJoy9/iRDLgCEpQqcCwRgzDoo7o2/ovgkBbzYHLbPk4F7r25kA
 fvZS7fkRr4AmzzTksrgo0e+zLSXDB6o2NcRinc1SYEKa0jQTF5cAyblPGqRDR57IOoGK/MCyk
 DbhJapddcR67GdklEVGnoT5IvqOIi6DfedA/Twon2bF1L+s1REIDMI9FvZLIlpZTfga4VDq/O
 8D6fNfDxB9gQktBiqBLFwYvACW/vrj40sVMxJ4ygAoSfcnK/lYno6KiR2g3tG52rtJSlebonp
 Rkdf8JXpbXEO5Xs/SUYr+XUqQWNgOlnII2ruAf4EWHEikdU/+nJkBKELgpXgJqwEWLUmYmHPD
 rpocpv0caC4E2Bcv7Mr4RJRsFy4SEz5gp/tQsNFG1Mpz7dV50/+ihvtG/y9bwSYVWsX1tjbzF
 obCp1+LPVlUy4CCDwuUJymzsPE4UFSgKqpZgegd8QsGuH3H4IfEsADddjQUCt+Oe9ATCl3O9e
 Zq4L7PeoBZY4vzU2LUhxXzBrpiMDKj/BGH1TzaxNGGcyvHNn0Opw5V1OQiwB+APwEx267n28N
 uqddq3bArnt3OkzRuDqZa+UE1IYVDpu1Vtfd5Vl6KbkHbaXUozR4IwQS8eamHEQ4FV5aREsN6
 YQVRA/Bis+9Ul5bk1JwuHUAS5UVQE1rTE9wmVrAMOq7tqvAFm1Bu5Vo60MAvmYrAGVdyhOcbE
 AlDpzNLTUtWEPVkvQKjQdLLuMx8DaTvgjT20uvtBtfzQI8uyoGwab+LtbbFlrH4JTA/5ac4jz
 qEwhkrYQMzJDUC19qG+TMQU1qM1K/aBrDaB0qpoGEzqpYEFJq4sndhPJI3N4GbAlGuZ/LZdI7
 vEN7VI4gmEz4GydHu2ZEsIApujRJLGAcJDrUGGXy+Z9nEd+dRFPWjBZlUEcQCraAlYqt7Lrpx
 j69CkD0seKjUX2n2tsSlIp1u/6SL5oJEzgr/AZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.19 um 22:47 schrieb SZEDER G=C3=A1bor:
> On Mon, Sep 23, 2019 at 09:55:11PM +0200, Ren=C3=A9 Scharfe wrote:
>> -- >8 --
>> Subject: [PATCH] name-rev: use FLEX_ARRAY for tip_name in struct rev_na=
me
>>
>> Give each rev_name its very own tip_name string.  This simplifies memor=
y
>> ownership, as callers of name_rev() only have to make sure the tip_name
>> parameter exists for the duration of the call and don't have to preserv=
e
>> it for the whole run of the program.
>>
>> It also saves four or eight bytes per object because this change remove=
s
>> the pointer indirection.  Memory usage is still higher for linear
>> histories that previously shared the same tip_name value between
>> multiple name_rev instances.
>
> Besides looking at memory usage, have you run any performance
> benchmarks?  Here it seems to make 'git name-rev --all >out' slower by
> 17% in the git repo and by 19.5% in the linux repo.

Did measure now; I also see a slowdown with my patch applied:

git:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):     462.8 ms =C2=B1   2.8 ms    [User: 440.6 =
ms, System: 20.5 ms]
  Range (min =E2=80=A6 max):   459.6 ms =E2=80=A6 466.5 ms    10 runs

git w/ commit-graph:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):     104.0 ms =C2=B1   1.5 ms    [User: 93.7 m=
s, System: 10.0 ms]
  Range (min =E2=80=A6 max):   101.5 ms =E2=80=A6 107.1 ms    28 runs

git w/ patch:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):     475.1 ms =C2=B1   3.7 ms    [User: 458.3 =
ms, System: 16.0 ms]
  Range (min =E2=80=A6 max):   470.4 ms =E2=80=A6 481.4 ms    10 runs

git w/ commit-graph and patch:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):     110.9 ms =C2=B1   1.5 ms    [User: 106.6 =
ms, System: 4.1 ms]
  Range (min =E2=80=A6 max):   109.0 ms =E2=80=A6 114.7 ms    26 runs


linux:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):      6.670 s =C2=B1  0.027 s    [User: 6.450 =
s, System: 0.208 s]
  Range (min =E2=80=A6 max):    6.640 s =E2=80=A6  6.721 s    10 runs

linux w/ patch:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):      6.784 s =C2=B1  0.160 s    [User: 6.567 =
s, System: 0.214 s]
  Range (min =E2=80=A6 max):    6.638 s =E2=80=A6  7.211 s    10 runs

linux w/ commit-graph:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):     929.6 ms =C2=B1   5.3 ms    [User: 881.4 =
ms, System: 46.8 ms]
  Range (min =E2=80=A6 max):   924.1 ms =E2=80=A6 939.5 ms    10 runs

linux w/ commit-graph and patch:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):      1.004 s =C2=B1  0.007 s    [User: 957.4 =
ms, System: 45.6 ms]
  Range (min =E2=80=A6 max):    0.997 s =E2=80=A6  1.021 s    10 runs

We can reuse a strbuf instead of allocating new strings when adding
suffixes to get some of the performance loss back.  I guess it's easier
after the recursion is removed.  Numbers:

git w/ both patches:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):     448.0 ms =C2=B1   2.4 ms    [User: 428.2 =
ms, System: 19.6 ms]
  Range (min =E2=80=A6 max):   445.3 ms =E2=80=A6 453.4 ms    10 runs

git w/ commit-graph and both patches:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):      98.7 ms =C2=B1   1.6 ms    [User: 93.5 m=
s, System: 5.0 ms]
  Range (min =E2=80=A6 max):    96.7 ms =E2=80=A6 102.8 ms    30 runs

linux w/ both patches:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):      6.727 s =C2=B1  0.063 s    [User: 6.486 =
s, System: 0.226 s]
  Range (min =E2=80=A6 max):    6.675 s =E2=80=A6  6.872 s    10 runs

linux w/ commit-graph and both patches:
Benchmark #1: ~/src/git/git name-rev --all
  Time (mean =C2=B1 =CF=83):     988.8 ms =C2=B1   4.5 ms    [User: 937.5 =
ms, System: 49.2 ms]
  Range (min =E2=80=A6 max):   981.4 ms =E2=80=A6 994.8 ms    10 runs


=2D--
 builtin/name-rev.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 4162fb29ee..7fee664574 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -75,15 +75,14 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }

-static void name_rev(struct commit *commit,
-		const char *tip_name, timestamp_t taggerdate,
+static void name_rev(struct commit *commit, struct strbuf *sb,
+		timestamp_t taggerdate,
 		int generation, int distance, int from_tag,
 		int deref)
 {
 	struct rev_name *name =3D get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number =3D 1;
-	char *to_free =3D NULL;

 	parse_commit(commit);

@@ -91,7 +90,7 @@ static void name_rev(struct commit *commit,
 		return;

 	if (deref) {
-		tip_name =3D to_free =3D xstrfmt("%s^0", tip_name);
+		strbuf_addstr(sb, "^0");

 		if (generation)
 			die("generation: %d, but deref?", generation);
@@ -99,14 +98,13 @@ static void name_rev(struct commit *commit,

 	if (!name || is_better_name(name, taggerdate, distance, from_tag)) {
 		free(name);
-		FLEX_ALLOC_STR(name, tip_name, tip_name);
+		FLEX_ALLOC_MEM(name, tip_name, sb->buf, sb->len);
 		name->taggerdate =3D taggerdate;
 		name->generation =3D generation;
 		name->distance =3D distance;
 		name->from_tag =3D from_tag;
 		set_commit_rev_name(commit, name);
 	} else {
-		free(to_free);
 		return;
 	}

@@ -114,28 +112,26 @@ static void name_rev(struct commit *commit,
 			parents;
 			parents =3D parents->next, parent_number++) {
 		if (parent_number > 1) {
-			size_t len;
-			char *new_name;
-
-			strip_suffix(tip_name, "^0", &len);
+			int stripped =3D strbuf_strip_suffix(sb, "^0");
+			size_t base_len =3D sb->len;
 			if (generation > 0)
-				new_name =3D xstrfmt("%.*s~%d^%d", (int)len, tip_name,
-						   generation, parent_number);
-			else
-				new_name =3D xstrfmt("%.*s^%d", (int)len, tip_name,
-						   parent_number);
+				strbuf_addf(sb, "~%d", generation);
+			strbuf_addf(sb, "^%d", parent_number);

-			name_rev(parents->item, new_name, taggerdate, 0,
+			name_rev(parents->item, sb, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
 				 from_tag, 0);
-			free(new_name);
+			strbuf_setlen(sb, base_len);
+			if (stripped)
+				strbuf_addstr(sb, "^0");
 		} else {
-			name_rev(parents->item, tip_name, taggerdate,
+			size_t base_len =3D sb->len;
+			name_rev(parents->item, sb, taggerdate,
 				 generation + 1, distance + 1,
 				 from_tag, 0);
+			strbuf_setlen(sb, base_len);
 		}
 	}
-	free(to_free);
 }

 static int subpath_matches(const char *path, const char *filter)
@@ -200,6 +196,7 @@ static int tipcmp(const void *a_, const void *b_)

 static int name_ref(const char *path, const struct object_id *oid, int fl=
ags, void *cb_data)
 {
+	static struct strbuf sb =3D STRBUF_INIT;
 	struct object *o =3D parse_object(the_repository, oid);
 	struct name_ref_data *data =3D cb_data;
 	int can_abbreviate_output =3D data->tags_only && data->name_only;
@@ -269,7 +266,9 @@ static int name_ref(const char *path, const struct obj=
ect_id *oid, int flags, vo
 		if (taggerdate =3D=3D TIME_MAX)
 			taggerdate =3D ((struct commit *)o)->date;
 		path =3D name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, path, taggerdate, 0, 0, from_tag, deref);
+		strbuf_reset(&sb);
+		strbuf_addstr(&sb, path);
+		name_rev(commit, &sb, taggerdate, 0, 0, from_tag, deref);
 	}
 	return 0;
 }
=2D-
2.23.0
