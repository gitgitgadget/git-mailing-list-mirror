Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763737FD
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737277880; cv=none; b=j235eM0YZhd1Ai0Hzbhi4UkLGlj362MnnBuV7SAYlDleHBM+HdjdZPCXheomxW/hvBG3tNzy/zKoIIM7nTHm0lENX1LhMbTXldR03OoC2f/7H2pP4mfyoVOqVzi7gwMNosZ0/qCoYvoultaxGc6ZOHyXZ1HNi3XJRU+x23G9vxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737277880; c=relaxed/simple;
	bh=YlP384QuCKfUdpRoVknEiHnOVAOe/wijfGGaomYFxs8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QRi1XjncFjdjBmg1LdzTfJ23XHzY8R8Gdy7UOMFyKpPVmzlLjELdH/ZIu5DwblQ3WrbwikuXoFe8OfjsNUOiLlOQq2f1hW12sC0X2LLXqAZKkg1jahCB/DedPe6+46fnoCDKJAoDyLbNusBC+SaUUp1oJktKl6K8PygQDlZ/YAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=J5ZdcAEo; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="J5ZdcAEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737277867; x=1737882667; i=l.s.r@web.de;
	bh=UYsOXucmZ1Oe1JP3IAKKwBDy+79NepsdbK6fqqp6yaE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J5ZdcAEoVN0EBzTC36QIjCstNv7nu9Ir5nRx+dkHD+90hNu6fkLxppYorAvT3UOa
	 WgJBL8z/FSUoD09Ff18gy3fuCuI4WtZlUT+i1hhIeq4GN/apA/Wdzd+V9lR06qIjV
	 PLw3AXZj3oeZfNQ+NJ0lPftj4300pKIICPY9l37trnE1PMaBGbf4gvxlukLN5WymT
	 t1Ui1ECVjw6sBL27WYtq3hPFsvuPXakfmUvFzTFYO8KXnVuXaK2H9h15Q9qM5qGcD
	 9cDs26eC6gcihJh7/Me63/ldeU7u9bmbfRnTa/qe9TexTxyuq6ObLp9JWSrK/UHbA
	 KgspHsSGJx3/1/HGxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8TBM-1tdrBb2PJY-004KJ9; Sun, 19
 Jan 2025 10:11:07 +0100
Message-ID: <246b8d96-19a5-4834-bd17-d0dbb79da182@web.de>
Date: Sun, 19 Jan 2025 10:11:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
 <20250116095128.GA144555@coredump.intra.peff.net>
 <20250116100637.GB144555@coredump.intra.peff.net>
 <20250116102154.GA724126@coredump.intra.peff.net>
 <2fbe47c2-22c0-49ff-a211-057bd96ddbc9@web.de>
Content-Language: en-US
In-Reply-To: <2fbe47c2-22c0-49ff-a211-057bd96ddbc9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D/hVpt9utaeiaU2How0l0ANdRTe3mEYZ1Rf0jqZvuh4bEAooovW
 7gBmEp60eYZwN+vH/0dqmPX0ffb+SMN3RVdi3qWR2sK71dDL3z7VkzCWgR6TInCzxLNFE1G
 r3AfBk4lOZQFcXQXv98uAotslsY7B3TZiT/4BIcrNgHATvZRMCSZilij89mPaykWhP2rgGY
 7/MF1Oi3TeDBNxY9t2T3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ulofy4H7foI=;WvKoGg6qZqYorojio3ycm7IjtWU
 5CTn6MT7q/y0rPTFEVmT+w8kZcrBnlLQw3l/mGn9cIAWlfI/yuZe1YefmWyU16q9dObbGshOK
 4KtGxlBK03TwEi9OIv7EGy8eP9es6L9/hHsIdFkToUbQ4MGtKsagpgAS6l0i62ecwzb1Fncfs
 ORfmT81VdSPtHdv4/Q6PNqe0UPkSt0RBCWcUQDcx8vtk+0lFFh3PGCCQN5DTIZpo22PPRdFeE
 f5AU+SnUlbCeoxT1AjhUOZT2vGOtp4gw9iu9lwkrYNQblZnq48h+vMPi8n1ulYtl1EXIduyLr
 36CmMexndNY/WoyBpLwqGtQJGfL1YCcArGYq8GxgV4hiLvmRJwfvH4LNKOY5tZuQoBieEokBh
 s7h17VDJBaCB0owyQz36HWFli0fUOpVa1bidq1TmO2CgErjJPGIXipp+UzZ1XqH3ZDkayM6P9
 hfcgen9eIWa4NKVC3K0giNX9ZzIUHoloMPnbaTyaoicSE+1/K0jtLcMZ3F+We+lS6L2Wrw//N
 X1Dl4dcU5WwBr+XLGZPzEcSDWwnfO93qRs7Fq5Nlt7hJH9CQA2ZYnhy/n3tSrh3AoOTh1+WsC
 Fp8yc+ELAvZMgN8DahxjBKoqd4o48uo3pu1THg+2uOKgb09VPKyZh6uDRm7PN2B1PLAPAvEv9
 gsdICsmUqt4mGYd90gC/f9CLd2DBz1fkTq8adOlrIgQjC8ZBYSfkJ2sIwgN7q4w8Mvofd3136
 1XrorFuUPV8Ai5rVoEG+bcMUZY2VnBJxy/fZROTwQGVaSOlsf+HJq+ieAaOtTrEU9Fd3Kg2pE
 MC5SchvFC0ex8i2VBgGYPMg/YO2ieb4jxdBMBWJeZolnrJu5xo6d7WZXdNyu754qehaLqfvQw
 i5FY9kGoXfHPKMADYRUZx0Y/kooi31PbbD4c+3n0wsXXunX+jtMY0ig93G7KA46tOzXezSmUz
 RiMprCVy8co0J7C8CrdSTbYVFXgmPOYpEpzl2aQsoht7ci0CE1LLAcf//8mEyI9aVwbiy7v4E
 RrsWX3wo7biR06bno32wlHn3c/vQhZLpap4Mm21zmyYK+cc/p6IRIwFuSnaz3P4CZEDssyUrC
 mKKr7r/QtCtyswFDrCpf5qg+RC9cQDLI9jiH6/qGR7WScOcIkot1haHb/oHc5FXACdtfv0v0T
 g4im9Waq42wVEsBzQErbd2TRFVfqsiJ7HZTbeJbxqvw==

Am 18.01.25 um 18:11 schrieb Ren=C3=A9 Scharfe:
> I think moving to the right place in one step requires less churn.  Let'=
s
> compare; v2 coming up.

... and this:

=2D--
 ref-filter.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index caf28466ab..6da8d4c03b 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -236,6 +236,7 @@ static struct used_atom {
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
 		struct {
+			char *name;
 			struct commit *commit;
 		} base;
 		struct strvec describe_args;
@@ -245,9 +246,6 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;

-/* List of bases for is-base indicators. */
-static struct string_list is_base_tips =3D STRING_LIST_INIT_DUP;
-
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
  * Allow to save few lines of code.
@@ -912,17 +910,15 @@ static int ahead_behind_atom_parser(struct ref_forma=
t *format UNUSED,
 }

 static int is_base_atom_parser(struct ref_format *format UNUSED,
-			       struct used_atom *atom UNUSED,
+			       struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
-	struct string_list_item *item;
-
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(is-base:<committ=
ish>)"));

-	item =3D string_list_append(&is_base_tips, arg);
-	item->util =3D lookup_commit_reference_by_name(arg);
-	if (!item->util)
+	atom->u.base.name =3D xstrdup(arg);
+	atom->u.base.commit =3D lookup_commit_reference_by_name(arg);
+	if (!atom->u.base.commit)
 		die("failed to find '%s'", arg);

 	return 0;
@@ -3012,6 +3008,8 @@ void ref_array_clear(struct ref_array *array)
 			free(atom->u.head);
 		else if (atom->atom_type =3D=3D ATOM_DESCRIBE)
 			strvec_clear(&atom->u.describe_args);
+		else if (atom->atom_type =3D=3D ATOM_ISBASE)
+			free(atom->u.base.name);
 		else if (atom->atom_type =3D=3D ATOM_TRAILERS ||
 			 (atom->atom_type =3D=3D ATOM_CONTENTS &&
 			  atom->u.contents.option =3D=3D C_TRAILERS)) {
@@ -3027,7 +3025,6 @@ void ref_array_clear(struct ref_array *array)
 	}
 	FREE_AND_NULL(used_atom);
 	used_atom_cnt =3D 0;
-	string_list_clear(&is_base_tips, 0);

 	if (ref_to_worktree_map.worktrees) {
 		hashmap_clear_and_free(&(ref_to_worktree_map.map),
@@ -3140,10 +3137,17 @@ void filter_is_base(struct repository *r,
 		    struct ref_array *array)
 {
 	struct commit **bases;
-	size_t bases_nr =3D 0;
+	size_t bases_nr =3D 0, is_base_nr;
 	struct ref_array_item **back_index;

-	if (!is_base_tips.nr || !array->nr)
+	if (!array->nr)
+		return;
+
+	for (size_t i =3D is_base_nr =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_ISBASE)
+			is_base_nr++;
+	}
+	if (!is_base_nr)
 		return;

 	CALLOC_ARRAY(back_index, array->nr);
@@ -3153,7 +3157,7 @@ void filter_is_base(struct repository *r,
 		const char *name =3D array->items[i]->refname;
 		struct commit *c =3D lookup_commit_reference_by_name_gently(name, 1);

-		CALLOC_ARRAY(array->items[i]->is_base, is_base_tips.nr);
+		CALLOC_ARRAY(array->items[i]->is_base, is_base_nr);

 		if (!c)
 			continue;
@@ -3163,15 +3167,20 @@ void filter_is_base(struct repository *r,
 		bases_nr++;
 	}

-	for (size_t i =3D 0; i < is_base_tips.nr; i++) {
-		struct commit *tip =3D is_base_tips.items[i].util;
-		int base_index =3D get_branch_base_for_tip(r, tip, bases, bases_nr);
+	for (size_t i =3D 0, j =3D 0; i < used_atom_cnt; i++) {
+		struct commit *tip;
+		int base_index;

+		if (used_atom[i].atom_type !=3D ATOM_ISBASE)
+			continue;
+
+		tip =3D used_atom[i].u.base.commit;
+		base_index =3D get_branch_base_for_tip(r, tip, bases, bases_nr);
 		if (base_index < 0)
 			continue;

 		/* Store the string for use in output later. */
-		back_index[base_index]->is_base[i] =3D xstrdup(is_base_tips.items[i].st=
ring);
+		back_index[base_index]->is_base[j++] =3D xstrdup(used_atom[i].u.base.na=
me);
 	}

 	free(back_index);
@@ -3290,10 +3299,10 @@ static inline int can_do_iterative_format(struct r=
ef_filter *filter,
 	for (size_t i =3D 0; i < used_atom_cnt; i++) {
 		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
 			return 0;
+		if (used_atom[i].atom_type =3D=3D ATOM_ISBASE)
+			return 0;
 	}
-	return !(filter->reachable_from ||
-		 filter->unreachable_from ||
-		 is_base_tips.nr);
+	return !(filter->reachable_from || filter->unreachable_from);
 }

 void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
=2D-
2.48.1

