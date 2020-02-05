Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB72C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C38D21741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ATloB8YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBERua (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:50:30 -0500
Received: from mout.web.de ([212.227.17.12]:49315 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgBERua (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 12:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580925023;
        bh=l36ob/0OrXSOgC9js48GRTpcvC/6vJjC8ujxPLG7NjA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ATloB8YO5vzZBceoAK7KqWcLZHVk4nSlaqia1BDu43JN5FwG+JTJy8sh4mrWRIwmG
         wCUnxZwzUZkGiKmJUTr6u+pHZRE03V1rSEajLNh5okQY6Dv98ysVeIs2+LRWjuoF/q
         8sim0Jzz/3TQtT89fyg9y1nhdV5XcKGGQEBIt5xM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzXS-1ilhhl2Gna-00DsYl; Wed, 05
 Feb 2020 18:50:23 +0100
Subject: [PATCH 11/10] name-rev: sort tip names before applying
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <6f1a2547-ad0d-942e-b4a0-c614da1973fd@web.de>
Date:   Wed, 5 Feb 2020 18:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GqHZhjTqm/gS3FYLmlDqw0Ei8B6VRpcJ881L57UesyosRzWeFbK
 EjbDt5DsrdSI0Ju8VBsHUCG90zcL7mPi77smn+3/+ICL3R7cZd43ZU7+nhRuokmgny8IQ66
 a29mFErggOlUqhN3Zyuq5XDIBFs029WbF5QBk2wuTBLJaXaBPTIO/XVFI4+zS0HdD637kyl
 Aomay4VMwWN22p7sVQwqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lK5qouVAjxw=:Gl+Gzc50xW92T9hNWxVqme
 jDbm8pZPAYRyInbR9FLrLyQjx8F+6SUFsL0PAxK8V7L+HpZUS+85cqSU7PGFNt3mRlRq4ga30
 GvG9ZgmUBzfPJgaO0wcY7LV8+a2h6Oex2yAiE99m/xGEeKFb+icV2w6cNTjjCz6MFbfCkt49F
 k2hEzUCCiS3nw+v6Rc4dZKj4+NjRPb7XBLsq3J3vJ0xnUbq3To3dWiimiB+xjBT7JG8rqbSLw
 44ZK73D9R53tkGJZUcUSNRPfOQ5oFcX1+R2h9fFbQNUI8nxPglw4DiNl+e2q1pR9SXKukGRYv
 QUTh//8HoPFQQG4b9B0mYoJGiC7ZwWONj3ix2HWOupyFTo3fgCaQ9aMi0Ip4gZZG1DoYEwUjR
 z6x+/7uCBxgH/MVRHo4frj3AYM2UzBnqtZBBntgETuQwajcoNUYOkZs0WpbbS2TD9X5BZqp/8
 cg7UIYyQubGhk1/fzkVa4DlLd/c71Xxh8Npdd6T8lUn3a0FYUhLmH3FCCxtvpAbhIBcc7eruX
 8PdDL9ALVOiQRaSbijw9cAp9tMpELNFmImOey1CCOqVeU9QLojATRsZMpnmhZQ0i+c/ben0sT
 bnXliHAcR0gQUfeSer03X3FIsgYEwxxbYjdw/IH8X5nCrKY80M6JNkcvaEc3JMAviUf54sFKi
 6Iz8YJdVfMS9DhJwHCizrLUVjVBV2OBCo0AJNov3LLD7XgO4UYJc26EgLy4oFRNytGNHgZVpO
 /p/x3hyroSK9xHp9s3Qgcm/USllbKywTPQukZvFTMhvwGMPdfATZN95wpvBC07RH0Uw8m1LMr
 Cu/oLZ6cF4Ziz7uiBN3ru5LgOHpOxWglvP9ygT+4SGvI3lVPxNtcyFldkRB1+zSVbYklgcLMv
 l8vvyafrY/siAcDXIo9hVvfArwOaQ0qy/QfNB5rZacOBuWTl2j36dOGnGAOHh02lNFqmbyPf0
 4gUbE0tWLd0/lKngLbJI8BurqQcBlA4OFIaCFOOR6UvrqlW50wmOMTKh63JiDgC+oWqXKuv35
 UcvYOeO22BjsYLjNq96hb4DcJ85ACCCgIyGBH0n7TYI71otPFZzJA8FmMrzi3NCjK1b+mjAP2
 bOazRwgkTZ+brHAR9lfBkcDoyzeJnjz2983nO4tAxbMMoKIYAvLk3oazH2OEhQphPXhJfWSvW
 VCXkndSgEoDdo3Ds5AJ0NDH6SXr+i3hZABz46kUTp8dR4qNV9DMEODxiLHIg+I0WOO3HVI49b
 dRHbaHxhDHHketWP2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

name_ref() is called for each ref and checks if its a better name for
the referenced commit.  If that's the case it remembers it and checks if
a name based on it is better for its ancestors as well.  This in done in
the the order for_each_ref() imposes on us.

That might not be optimal.  If bad names happen to be encountered first
(as defined by is_better_name()), names derived from them may spread to
a lot of commits, only to be replaced by better names later.  Setting
better names first can avoid that.

is_better_name() prefers tags, short distances and old references.  The
distance is a measure that we need to calculate for each candidate
commit, but the other two properties are not dependent on the
relationships of commits.  Sorting the refs by them should yield better
performance than the essentially random order we currently use.

And applying older references first should also help to reduce rework
due to the fact that older commits have less ancestors than newer ones.

So add all details of names to the tip table first, then sort them
to prefer tags and older references and then apply them in this order.
Here's the performance as measures by hyperfine for the Linux repo
before:

Benchmark #1: ./git -C ../linux/ name-rev --all
  Time (mean =C2=B1 =CF=83):     851.1 ms =C2=B1   4.5 ms    [User: 806.7 =
ms, System: 44.4 ms]
  Range (min =E2=80=A6 max):   845.9 ms =E2=80=A6 859.5 ms    10 runs

... and with this patch:

Benchmark #1: ./git -C ../linux/ name-rev --all
  Time (mean =C2=B1 =CF=83):     736.2 ms =C2=B1   8.7 ms    [User: 688.4 =
ms, System: 47.5 ms]
  Range (min =E2=80=A6 max):   726.0 ms =E2=80=A6 755.2 ms    10 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 60 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 23a639ff30..a9dcd25e46 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -247,6 +247,10 @@ static struct tip_table {
 	struct tip_table_entry {
 		struct object_id oid;
 		const char *refname;
+		struct commit *commit;
+		timestamp_t taggerdate;
+		unsigned int from_tag:1;
+		unsigned int deref:1;
 	} *table;
 	int nr;
 	int alloc;
@@ -254,13 +258,18 @@ static struct tip_table {
 } tip_table;

 static void add_to_tip_table(const struct object_id *oid, const char *ref=
name,
-			     int shorten_unambiguous)
+			     int shorten_unambiguous, struct commit *commit,
+			     timestamp_t taggerdate, int from_tag, int deref)
 {
 	refname =3D name_ref_abbrev(refname, shorten_unambiguous);

 	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
 	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
 	tip_table.table[tip_table.nr].refname =3D xstrdup(refname);
+	tip_table.table[tip_table.nr].commit =3D commit;
+	tip_table.table[tip_table.nr].taggerdate =3D taggerdate;
+	tip_table.table[tip_table.nr].from_tag =3D from_tag;
+	tip_table.table[tip_table.nr].deref =3D deref;
 	tip_table.nr++;
 	tip_table.sorted =3D 0;
 }
@@ -271,12 +280,30 @@ static int tipcmp(const void *a_, const void *b_)
 	return oidcmp(&a->oid, &b->oid);
 }

+static int cmp_by_tag_and_age(const void *a_, const void *b_)
+{
+	const struct tip_table_entry *a =3D a_, *b =3D b_;
+	int cmp;
+
+	/* Prefer tags. */
+	cmp =3D b->from_tag - a->from_tag;
+	if (cmp)
+		return cmp;
+
+	/* Older is better. */
+	if (a->taggerdate < b->taggerdate)
+		return -1;
+	return a->taggerdate !=3D b->taggerdate;
+}
+
 static int name_ref(const char *path, const struct object_id *oid, int fl=
ags, void *cb_data)
 {
 	struct object *o =3D parse_object(the_repository, oid);
 	struct name_ref_data *data =3D cb_data;
 	int can_abbreviate_output =3D data->tags_only && data->name_only;
 	int deref =3D 0;
+	int from_tag =3D 0;
+	struct commit *commit =3D NULL;
 	timestamp_t taggerdate =3D TIME_MAX;

 	if (data->tags_only && !starts_with(path, "refs/tags/"))
@@ -325,8 +352,6 @@ static int name_ref(const char *path, const struct obj=
ect_id *oid, int flags, vo
 			return 0;
 	}

-	add_to_tip_table(oid, path, can_abbreviate_output);
-
 	while (o && o->type =3D=3D OBJ_TAG) {
 		struct tag *t =3D (struct tag *) o;
 		if (!t->tagged)
@@ -336,17 +361,35 @@ static int name_ref(const char *path, const struct o=
bject_id *oid, int flags, vo
 		taggerdate =3D t->date;
 	}
 	if (o && o->type =3D=3D OBJ_COMMIT) {
-		struct commit *commit =3D (struct commit *)o;
-		int from_tag =3D starts_with(path, "refs/tags/");
-
+		commit =3D (struct commit *)o;
+		from_tag =3D starts_with(path, "refs/tags/");
 		if (taggerdate =3D=3D TIME_MAX)
 			taggerdate =3D commit->date;
-		path =3D name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, path, taggerdate, from_tag, deref);
 	}
+
+	add_to_tip_table(oid, path, can_abbreviate_output, commit, taggerdate,
+			 from_tag, deref);
 	return 0;
 }

+static void name_tips(void)
+{
+	int i;
+
+	/*
+	 * Try to set better names first, so that worse ones spread
+	 * less.
+	 */
+	QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
+	for (i =3D 0; i < tip_table.nr; i++) {
+		struct tip_table_entry *e =3D &tip_table.table[i];
+		if (e->commit) {
+			name_rev(e->commit, e->refname, e->taggerdate,
+				 e->from_tag, e->deref);
+		}
+	}
+}
+
 static const unsigned char *nth_tip_table_ent(size_t ix, void *table_)
 {
 	struct tip_table_entry *table =3D table_;
@@ -559,6 +602,7 @@ int cmd_name_rev(int argc, const char **argv, const ch=
ar *prefix)
 			cutoff =3D TIME_MIN;
 	}
 	for_each_ref(name_ref, &data);
+	name_tips();

 	if (transform_stdin) {
 		char buffer[2048];
=2D-
2.25.0
