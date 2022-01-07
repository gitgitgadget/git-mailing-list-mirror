Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88630C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 12:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346804AbiAGMRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 07:17:02 -0500
Received: from mout.web.de ([217.72.192.78]:43273 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346781AbiAGMRC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 07:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641557814;
        bh=ZVWV6D6BLbXI8K3MlT/uFvQLoEZeU79yz56oJLcOib4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MoqJa29kUEAWqkmWReJoLpXUC/mBTMz+sGzj0MqpjReqIXov2nZoEkTQ3cvTnjXKR
         ZGMAA6OwNo94e02VBRC9BM94+vuYe8qTo8lmVt2tEY8GfX3phGXDq9chVc6Hly8WcI
         ig6SYwLOSKAnUeaajip28V1euAcHngSByePCa3I8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myf3v-1m9ztD1JAj-00yjyu; Fri, 07
 Jan 2022 13:16:54 +0100
Message-ID: <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de>
Date:   Fri, 7 Jan 2022 13:16:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for CHERI/Arm's
 Morello
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
 <xmqqczl4bhmo.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqczl4bhmo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PT4QwQ9O9uwL2R4qTHk+NytaLwsboBOslQEGRa2YW3qLPojwamh
 b7vEg+alIKJPcE13FFALs/HH6r/nT8V6KTAXaBEppeDRUN9gaREcXCwOEV8fm6YGa1HHiJd
 rp1FcgPWz2fDNQF1rZccDfwO9irvdz/xf9VfmYbh45ZxBnn3989x1dwccFt8uztpVEpMq51
 ciPkBz9NJ+BK7VdEWFDhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qKk0jL5s9Tg=:23Jh0zc1IGUHY36qfD1/kC
 4N7PlGdLqZ0xNPWCBKhzv5m7j87u5ObX68CnAeMGQXSo71XvKj8r+mR2MR4LOuvIE2hKjdRve
 IYkv1P1vsoECM3rjcZG0qY5dDGA/43bTO0Syci3BP359DfjP0/dz64AGhGGHjL9pDmSdFW3Uc
 5stS/TcqKdzlBQaVLA1EcHWabfT4u6XwXjH+WDP0Nqpyq7kDWuu1x6b5j5tntV/zwGaaKQHYe
 2ydgIMuyP7/ny1IOgKAbgD/dMwkZgX3wLfTkSx+/vc2NilfmDIXzFnOoRW0lR0WpKVcF4Kp9S
 pTDR9BdFNG0WwytBRofFz/bBS4yrtNMmWS6VF27IJnTuOKKo1aDLWg3Cb5Mg2TZXmh1px59N7
 dycL3t2fODgeOQuEWE1Q6CyCw97jXu4O8va2K5A/AcoDNqKt/SA+L3tPBtTpaQ0WzK848ljEm
 Bad51IdIi4wTsqGrvmj8rcpDxAcMAcnG3AehBptdvOJkOAkTpcR8IYzbg2gy8Ep7GpgGgXNmQ
 ETnUg++Lcu7Mz8XNXTZDiC/CbwDL9l+tHhNUOgEM1YT0649WuL8vE11S65IUCDsK+bul6HxQ/
 bTTivVK9rAF/gcTiTj54Nzikff9xqEhrOl3Fl6uWKrbKsVFZjcvnWoX0CLpB7QMOTM9mRjxyY
 LnK84eYfAb1LrjUsAf7lc+LOjmI2vdsyoSwB3poJjTpUWU4a2i43VK6KkQU/SjTEwJxjOldE8
 ZodLfC/OcmBx7gkEKoIbP5+LhZO542/NL5APR4eyIlGLLfbt87A+SWkWyGbPPpV14ktc3rKKz
 yqEgoqtUB5ofoj2kCWq1nhE2ofGxsq0woP56Vwf798tHTF5Qr9yKtVCWQsaBOpIT48ysIgiVl
 cixjed9sa+cCTe0oveiAAaGhxz63bgDm61dHwyOMET4tJVa9sc+acAledZ8m0gO1hifdiRO/q
 HtW2tP3havCftTdvsHTpd9vpu6hT3fpw/EZ/Ml1WVhV5BXCQq3AT+keadJa3rUKQWbUZIJ7rA
 J8+mQWHxydop5mJ+a29iTa3UpMtB3JyFraA+q+ExJgVgm30nwUUXMye9TQGdGz1YuA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.01.22 um 23:53 schrieb Junio C Hamano:
> Jessica Clarke <jrtc27@jrtc27.com> writes:
>
>> On CHERI, and thus Arm's Morello prototype, pointers are implemented as
>> hardware capabilities which, as well as having a normal integer address=
,
>> have additional bounds, permissions and other metadata in a second word=
.
>> In order to preserve this metadata, uintptr_t is also implemented as a
>> capability, not a plain integer, which causes problems for binary
>> operators, as the metadata preserved in the output can only come from
>> one of the inputs. In most cases this is clear, as normally at least on=
e
>> operand is provably a plain integer, but if both operands are uintptr_t
>> and have no indication they're just plain integers then it is ambiguous=
,
>> and the current implementation will arbitrarily, but deterministically,
>> pick the left-hand side, due to empirical evidence that it is more
>> likely to be correct.
>
> What's left-hand side in the context of the code you changed?
> Between "what" vs "ent->util" you take "what"?  That cannot be
> true.  Are you referring to the (usually hidden and useless when we
> use it as an integer) "hardware capabilities" word as "left" vs the
> value of the pointer as "right"?
>
>>  static uintptr_t register_symlink_changes(struct apply_state *state,
>>  					  const char *path,
>> -					  uintptr_t what)
>> +					  size_t what)
>>  {
>>  	struct string_list_item *ent;
>>
>> @@ -3823,7 +3823,7 @@ static uintptr_t register_symlink_changes(struct =
apply_state *state,
>>  		ent =3D string_list_insert(&state->symlink_changes, path);
>>  		ent->util =3D (void *)0;
>>  	}
>> -	ent->util =3D (void *)(what | ((uintptr_t)ent->util));
>> +	ent->util =3D (void *)((uintptr_t)what | ((uintptr_t)ent->util));
>>  	return (uintptr_t)ent->util;
>>  }
>
> I actually wonder if it results in code that is much easier to
> follow if we did:
>
>  * Introduce an "enum apply_symlink_treatment" that has
>    APPLY_SYMLINK_GOES_AWAY and APPLY_SYMLINK_IN_RESULT as its
>    possible values;
>
>  * Make register_symlink_changes() and check_symlink_changes()
>    work with "enum apply_symlink_treatment";
>
>  * (optional) stop using string_list() to store the symlink_changes;
>    use strintmap and use strintmap_set() and strintmap_get() to
>    access its entries, so that the ugly implementation detail
>    (i.e. "the container type we use only has a (void *) field to
>    store caller-supplied data, so we cast an integer and a pointer
>    back and forth") can be safely hidden.
>
Or strsets -- we only need two.

=2D-- >8 ---
Subject: [PATCH] apply: use strsets to track symlinks

Symlink changes are tracked in a string_list, with the util pointer
value indicating whether a symlink is kept or removed.  Using fake
pointer values requires awkward casts.  Use one strset for each type of
change instead to simplify and shorten the code.

Original-patch-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 apply.c | 42 ++++++++----------------------------------
 apply.h | 26 +++++++++++---------------
 2 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/apply.c b/apply.c
index fed195250b..7deb4f79fd 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -103,7 +103,8 @@ int init_apply_state(struct apply_state *state,
 	state->linenr =3D 1;
 	string_list_init_nodup(&state->fn_table);
 	string_list_init_nodup(&state->limit_by_name);
-	string_list_init_nodup(&state->symlink_changes);
+	strset_init(&state->removed_symlinks);
+	strset_init(&state->kept_symlinks);
 	strbuf_init(&state->root, 0);

 	git_apply_config();
@@ -117,7 +118,8 @@ int init_apply_state(struct apply_state *state,
 void clear_apply_state(struct apply_state *state)
 {
 	string_list_clear(&state->limit_by_name, 0);
-	string_list_clear(&state->symlink_changes, 0);
+	strset_clear(&state->removed_symlinks);
+	strset_clear(&state->kept_symlinks);
 	strbuf_release(&state->root);

 	/* &state->fn_table is cleared at the end of apply_patch() */
@@ -3812,59 +3814,31 @@ static int check_to_create(struct apply_state *sta=
te,
 	return 0;
 }

-static uintptr_t register_symlink_changes(struct apply_state *state,
-					  const char *path,
-					  uintptr_t what)
-{
-	struct string_list_item *ent;
-
-	ent =3D string_list_lookup(&state->symlink_changes, path);
-	if (!ent) {
-		ent =3D string_list_insert(&state->symlink_changes, path);
-		ent->util =3D (void *)0;
-	}
-	ent->util =3D (void *)(what | ((uintptr_t)ent->util));
-	return (uintptr_t)ent->util;
-}
-
-static uintptr_t check_symlink_changes(struct apply_state *state, const c=
har *path)
-{
-	struct string_list_item *ent;
-
-	ent =3D string_list_lookup(&state->symlink_changes, path);
-	if (!ent)
-		return 0;
-	return (uintptr_t)ent->util;
-}
-
 static void prepare_symlink_changes(struct apply_state *state, struct pat=
ch *patch)
 {
 	for ( ; patch; patch =3D patch->next) {
 		if ((patch->old_name && S_ISLNK(patch->old_mode)) &&
 		    (patch->is_rename || patch->is_delete))
 			/* the symlink at patch->old_name is removed */
-			register_symlink_changes(state, patch->old_name, APPLY_SYMLINK_GOES_AW=
AY);
+			strset_add(&state->removed_symlinks, patch->old_name);

 		if (patch->new_name && S_ISLNK(patch->new_mode))
 			/* the symlink at patch->new_name is created or remains */
-			register_symlink_changes(state, patch->new_name, APPLY_SYMLINK_IN_RESU=
LT);
+			strset_add(&state->kept_symlinks, patch->new_name);
 	}
 }

 static int path_is_beyond_symlink_1(struct apply_state *state, struct str=
buf *name)
 {
 	do {
-		unsigned int change;
-
 		while (--name->len && name->buf[name->len] !=3D '/')
 			; /* scan backwards */
 		if (!name->len)
 			break;
 		name->buf[name->len] =3D '\0';
-		change =3D check_symlink_changes(state, name->buf);
-		if (change & APPLY_SYMLINK_IN_RESULT)
+		if (strset_contains(&state->kept_symlinks, name->buf))
 			return 1;
-		if (change & APPLY_SYMLINK_GOES_AWAY)
+		if (strset_contains(&state->removed_symlinks, name->buf))
 			/*
 			 * This cannot be "return 0", because we may
 			 * see a new one created at a higher level.
diff --git a/apply.h b/apply.h
index 16202da160..4052da50c0 100644
=2D-- a/apply.h
+++ b/apply.h
@@ -4,6 +4,7 @@
 #include "hash.h"
 #include "lockfile.h"
 #include "string-list.h"
+#include "strmap.h"

 struct repository;

@@ -25,20 +26,6 @@ enum apply_verbosity {
 	verbosity_verbose =3D 1
 };

-/*
- * We need to keep track of how symlinks in the preimage are
- * manipulated by the patches.  A patch to add a/b/c where a/b
- * is a symlink should not be allowed to affect the directory
- * the symlink points at, but if the same patch removes a/b,
- * it is perfectly fine, as the patch removes a/b to make room
- * to create a directory a/b so that a/b/c can be created.
- *
- * See also "struct string_list symlink_changes" in "struct
- * apply_state".
- */
-#define APPLY_SYMLINK_GOES_AWAY 01
-#define APPLY_SYMLINK_IN_RESULT 02
-
 struct apply_state {
 	const char *prefix;

@@ -86,7 +73,16 @@ struct apply_state {

 	/* Various "current state" */
 	int linenr; /* current line number */
-	struct string_list symlink_changes; /* we have to track symlinks */
+	/*
+	 * We need to keep track of how symlinks in the preimage are
+	 * manipulated by the patches.  A patch to add a/b/c where a/b
+	 * is a symlink should not be allowed to affect the directory
+	 * the symlink points at, but if the same patch removes a/b,
+	 * it is perfectly fine, as the patch removes a/b to make room
+	 * to create a directory a/b so that a/b/c can be created.
+	 */
+	struct strset removed_symlinks;
+	struct strset kept_symlinks;

 	/*
 	 * For "diff-stat" like behaviour, we keep track of the biggest change
=2D-
2.34.1
