Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFE14375C
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737278188; cv=none; b=NyTsX9egQBFVdLcqUyBlU1iq7HxDYALopaPUVq3zlCuR+hGZnsD+5OYnI56GnBaSbYfG4CmhdZ0lfOWwPlWpYYFXPFcD7pz+KCSEuDjj9Uk2frM1SNIIt/YOAixA3lfGDjfhEFdM0HtFhJ2IH7igMhXr6b4PKG02bSrsnh1j7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737278188; c=relaxed/simple;
	bh=soFd3aB10MXZGwSxlSDnE5/QPY6UqxgWZDtagN5hE2k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FEzFig4Uv/0H87xRy/fuB6G5M2u4+GUTBzEbJO821ErqLKM6kyItCPI/xZKeodDUpbYIhEU8q0DKoNZCKpmrZSnnNWXH9q490pf8mdg00NF+EV0QJtnNqnQer/7pejXLCzaAFVVtuqloUOQqkBP/kJMrtulAR0WL9uqVjzDm6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=KMcf/KnD; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="KMcf/KnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737278184; x=1737882984; i=l.s.r@web.de;
	bh=F1qrf1aO53FiUSExwW6Bwfa3PPYoR6iP/W+uOwMJBgc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KMcf/KnDZQncryNNZUyeAvbjYX8IbNgtLjhlgVORGlZ/3KbiUCuid3e1USujZ4vL
	 DtZL78ZKDh6wDWiW6CXTffvwuOZXOdev1CymXXd+BLaajGQmkyKLJojS3aUKqJfE+
	 Wvf9jdn4P8RwwKpT/TYuJC3GjOPi89JQX2ZeU9RM00OmMX0Ke7ZxYxZ5XbV5hxTi7
	 u9fXIggi6DekK5tnoiR2WXhfVTh+1B+lR0wkouQ9lDcjlT8u0QQQ9d2amZCLZKVPk
	 0PsskuOfDr/LPZEDPZ+eLBzjXafOLfNZFIiTb5XctXblm9DpqJ6OPMoBCam/lnkdr
	 GvTS8e9deUwb0az/5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Euv-1tWQWj3O7J-0057eg; Sun, 19
 Jan 2025 10:11:04 +0100
Message-ID: <d5029c1b-4a21-442c-bb72-00b4e855c3c2@web.de>
Date: Sun, 19 Jan 2025 10:11:04 +0100
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
X-Provags-ID: V03:K1:LjEB87KFB7N6FwiL/rjfvcLxslIx+GtGS5M6lpigdr/8psbczsF
 LUUVXX47KLs/9VsE12YnfaLORK6VyWN7RPvhsvpAmlFiIxU/5yeSCk3x/D55vfqseUZR+nj
 aiBmZPmuNKR10SxMKQJ1VozaekYc+6MnzwnCuJr3x9lihsRMXtc8e4WPvBLwVCRJBuqzdsZ
 2bpJCMqNqBSJ9ouSQyBhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IIFbU7yCXRw=;+CDo8E8S6W6j6jnm15JXglyyYsB
 ulb+WVYkD7jB8tay9d4dcLlnfvuSl5pS2NYkfHKl0hSGK/of+Cf3ZcZpUTsq0jEbqvKv2Upo/
 9MdKIVwBPEVj3TA+z7lfNFdeoT5sOJbmmZQm/6S0hg07oGwQm1VMFcvKAUv4lMp80Pt5Mi7NT
 qFdPPBGs0THrDkFnsPBVTykKV5UHC1YHtz0mffyJepejXbQmxN6RwjhA1NQOMio0TxvXknyWW
 mOoHBKEKapu0wexaNK9GkRnYe1NkJYIoffdxXnzzDptCexVRbXM8EgGV07TkrzH45rsgz1ZFs
 hMDZF7w6GoZeCk46IobAY1lKsHnRy7Kdxv44af5EUOlsFj5j48ndz/dX3ax99x0+K0Yzm+4SL
 /JDbLW7nD2uVBlxGmPDQ5P9thtz7spt9kEcBIqIu0eRoQnVAjkiaBPFqRtOtNWrir92wNzp9T
 /LX7dpA9knR9ZiNZtOdsp1GODKs9oWtzTLBAodI1Ef0y/4aqde6nuiYeB8Fu6hQ5kVSTBOycF
 Pm6NRtNSbcqLovAd3klJWy6r6fWsMePola6L9lPSiFIGMNyB636ygRhumnBPFp+Nl1XKo+lC6
 M+e+YXcflYpe1Ol5oaiCsWCu9GgJQRo22CxiC5kRA4HoZwsZLXlZSnGlq1/1QEBFZ6S28HjbC
 7B358gZtlSj0f5FkUjN703oVfUT9NQxLoNV1/VbfkVz+jnMwxPVd1l9cTESV9xwdu5LVpTp/6
 ri9tQ8W8gV0AwcpHeZe8kJvTpQBGpj9NEd86hbbdHQw4/HzCKD8E54coTG7xzzKYIf1qL71EG
 rhuvqfma1QjMiKrwZdDVexeBYYrfV9HUe5C94naNN1f4xawhz+TLoe2V2MSTxtOliN9y/yRnh
 +n+gn9nBqX8WC/9+2t7UTfwM0SeAU1g0tq3k8L32da0smh2ffQkdHIRg6ej0VgqVBNedSmxDf
 o69t9Ya2SmHurSK2rTqc12QDnUUCCYVdNSmO5CtMqJW1lf+9H1DMJzrwelt4CS1sHhmT4pAaT
 7kvNHM59z8SA/aT268eBd3nQah01vvSVYo91JbaXRv7NMouwpyzC3OgC+dllywRWPWJdsONU4
 X4NT8OW06gj2YgoSIXMbtT3ev7eqAoRxlJXDOo/qmwFi86xMufxqZ9AmRYxj6QHtL9rp+5FS+
 bLLubZEiieoj8sAvInMXJPw0tOK65Z8FRgUp6ywVWeQ==

Am 18.01.25 um 18:11 schrieb Ren=C3=A9 Scharfe:
> I think moving to the right place in one step requires less churn.  Let'=
s
> compare; v2 coming up.

The version building on top of v1 would look like this:

=2D--
 ref-filter.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 89f44936f9..caf28466ab 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -235,6 +235,9 @@ static struct used_atom {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
+		struct {
+			struct commit *commit;
+		} base;
 		struct strvec describe_args;
 		struct refname_atom refname;
 		char *head;
@@ -242,9 +245,6 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;

-/* List of bases for ahead-behind counts. */
-static struct string_list bases =3D STRING_LIST_INIT_DUP;
-
 /* List of bases for is-base indicators. */
 static struct string_list is_base_tips =3D STRING_LIST_INIT_DUP;

@@ -898,17 +898,14 @@ static int rest_atom_parser(struct ref_format *forma=
t UNUSED,
 }

 static int ahead_behind_atom_parser(struct ref_format *format UNUSED,
-				    struct used_atom *atom UNUSED,
+				    struct used_atom *atom,
 				    const char *arg, struct strbuf *err)
 {
-	struct string_list_item *item;
-
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<co=
mmittish>)"));

-	item =3D string_list_append(&bases, arg);
-	item->util =3D lookup_commit_reference_by_name(arg);
-	if (!item->util)
+	atom->u.base.commit =3D lookup_commit_reference_by_name(arg);
+	if (!atom->u.base.commit)
 		die("failed to find '%s'", arg);

 	return 0;
@@ -3030,7 +3027,6 @@ void ref_array_clear(struct ref_array *array)
 	}
 	FREE_AND_NULL(used_atom);
 	used_atom_cnt =3D 0;
-	string_list_clear(&bases, 0);
 	string_list_clear(&is_base_tips, 0);

 	if (ref_to_worktree_map.worktrees) {
@@ -3095,18 +3091,27 @@ void filter_ahead_behind(struct repository *r,
 			 struct ref_array *array)
 {
 	struct commit **commits;
-	size_t commits_nr =3D bases.nr + array->nr;
+	size_t bases_nr, commits_nr;
+
+	if (!array->nr)
+		return;

-	if (!bases.nr || !array->nr)
+	for (size_t i =3D bases_nr =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
+			bases_nr++;
+	}
+	if (!bases_nr)
 		return;

-	ALLOC_ARRAY(commits, commits_nr);
-	for (size_t i =3D 0; i < bases.nr; i++)
-		commits[i] =3D bases.items[i].util;
+	ALLOC_ARRAY(commits, st_add(bases_nr, array->nr));
+	for (size_t i =3D 0, j =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
+			commits[j++] =3D used_atom[i].u.base.commit;
+	}

-	ALLOC_ARRAY(array->counts, st_mult(bases.nr, array->nr));
+	ALLOC_ARRAY(array->counts, st_mult(bases_nr, array->nr));

-	commits_nr =3D bases.nr;
+	commits_nr =3D bases_nr;
 	array->counts_nr =3D 0;
 	for (size_t i =3D 0; i < array->nr; i++) {
 		const char *name =3D array->items[i]->refname;
@@ -3115,8 +3120,8 @@ void filter_ahead_behind(struct repository *r,
 		if (!commits[commits_nr])
 			continue;

-		CALLOC_ARRAY(array->items[i]->counts, bases.nr);
-		for (size_t j =3D 0; j < bases.nr; j++) {
+		CALLOC_ARRAY(array->items[i]->counts, bases_nr);
+		for (size_t j =3D 0; j < bases_nr; j++) {
 			struct ahead_behind_count *count;
 			count =3D &array->counts[array->counts_nr++];
 			count->tip_index =3D commits_nr;
@@ -3282,9 +3287,12 @@ static inline int can_do_iterative_format(struct re=
f_filter *filter,
 	 * - filtering on reachability
 	 * - including ahead-behind information in the formatted output
 	 */
+	for (size_t i =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
+			return 0;
+	}
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
-		 bases.nr ||
 		 is_base_tips.nr);
 }

=2D-
2.48.1

