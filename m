Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35523C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 13:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiAGNAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 08:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiAGNAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 08:00:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AFAC061245
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 05:00:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v123so3872131wme.2
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OMxWu00TJBkQbeF5J6KeYTBg9uDzLf9KFgWNaXzR3Gg=;
        b=eEea2lqi1/RP0EeuOQx4taiGp0ZYFsq8ikPWsDsbvV2H4FLt/hP3IQmmhnSRUJaOpg
         48bV2UdZBvmDFeL6WgBfuxs7FE/wbwG0Z//SReMMMw3Itku7BCtS3DTfi1/I/NpReY0z
         6oq5XPoMphn7oSBgNeyPm1ifRzmKnYkbWi5NgqbXRnlWywhOwZP/JwE9L2GRHwytD8pz
         OitYpUp0QjqeouA69INh5tnMJJ8hkaEr+/0j+mhub4mKEyy21Gt7xsyDRa4Q2DndP4V9
         IpvXKYaQlpPrWTObKT/4VkTmiteMYVfuQYysuScbcYsPwf50b3YxyTThgl7cObWrGeQf
         mglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OMxWu00TJBkQbeF5J6KeYTBg9uDzLf9KFgWNaXzR3Gg=;
        b=KL/7sEkHnEhip+4pwc6cUrGBVaAh0RLNu8BV7/ZiqSiUsaC96LAF5KFRNc8qscMX7P
         sNI3VFBn4VfcJZITr3RIyLBEXg0p7wt2dE72b6+UgThXo4iNvLRg/ZWXfFkME5dlWyA7
         f3UuxrAkKIpVBNCVH7i8T/u0eA4ohv6kd/J2sgISUlCSHuiTxcY3oJG+8NMG6y2Boof4
         si5OQ0z5i1BAumm96XbVWAf6z4AqOmuINaj755k4OrOs77Yw4jquQ+U4iOafFChoyUfa
         hqmLOi2BjJjuRipjBxzDL0dZXn6giLLomJhKBgv/SYzjdRv1gJTY38JZeT/g+LKVx5p8
         PQKQ==
X-Gm-Message-State: AOAM531bwkv1eZu6l1kgY5fE5+W96CCKLNcT3/G0iTIdxMBZpQ7jVHPy
        nB8HZXGN1iQSSbd1FvwpAaB60A==
X-Google-Smtp-Source: ABdhPJy/WRa2LOeIY6r69VjL10S/3RoQo3K635Nh2sXlqxliug067Byykd2pXcFYk2PgzYP3TpZ73A==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr11335873wmm.50.1641560441768;
        Fri, 07 Jan 2022 05:00:41 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id s10sm7750697wmr.30.2022.01.07.05.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jan 2022 05:00:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for CHERI/Arm's
 Morello
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de>
Date:   Fri, 7 Jan 2022 13:00:41 +0000
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AB57D1A-E4B5-47B6-AD43-97299C9DE92D@jrtc27.com>
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
 <xmqqczl4bhmo.fsf@gitster.g> <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 Jan 2022, at 12:16, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>=20
> Am 06.01.22 um 23:53 schrieb Junio C Hamano:
>> Jessica Clarke <jrtc27@jrtc27.com> writes:
>>=20
>>> On CHERI, and thus Arm's Morello prototype, pointers are implemented =
as
>>> hardware capabilities which, as well as having a normal integer =
address,
>>> have additional bounds, permissions and other metadata in a second =
word.
>>> In order to preserve this metadata, uintptr_t is also implemented as =
a
>>> capability, not a plain integer, which causes problems for binary
>>> operators, as the metadata preserved in the output can only come =
from
>>> one of the inputs. In most cases this is clear, as normally at least =
one
>>> operand is provably a plain integer, but if both operands are =
uintptr_t
>>> and have no indication they're just plain integers then it is =
ambiguous,
>>> and the current implementation will arbitrarily, but =
deterministically,
>>> pick the left-hand side, due to empirical evidence that it is more
>>> likely to be correct.
>>=20
>> What's left-hand side in the context of the code you changed?
>> Between "what" vs "ent->util" you take "what"?  That cannot be
>> true.  Are you referring to the (usually hidden and useless when we
>> use it as an integer) "hardware capabilities" word as "left" vs the
>> value of the pointer as "right"?
>>=20
>>> static uintptr_t register_symlink_changes(struct apply_state *state,
>>> 					  const char *path,
>>> -					  uintptr_t what)
>>> +					  size_t what)
>>> {
>>> 	struct string_list_item *ent;
>>>=20
>>> @@ -3823,7 +3823,7 @@ static uintptr_t =
register_symlink_changes(struct apply_state *state,
>>> 		ent =3D string_list_insert(&state->symlink_changes, =
path);
>>> 		ent->util =3D (void *)0;
>>> 	}
>>> -	ent->util =3D (void *)(what | ((uintptr_t)ent->util));
>>> +	ent->util =3D (void *)((uintptr_t)what | =
((uintptr_t)ent->util));
>>> 	return (uintptr_t)ent->util;
>>> }
>>=20
>> I actually wonder if it results in code that is much easier to
>> follow if we did:
>>=20
>> * Introduce an "enum apply_symlink_treatment" that has
>>   APPLY_SYMLINK_GOES_AWAY and APPLY_SYMLINK_IN_RESULT as its
>>   possible values;
>>=20
>> * Make register_symlink_changes() and check_symlink_changes()
>>   work with "enum apply_symlink_treatment";
>>=20
>> * (optional) stop using string_list() to store the symlink_changes;
>>   use strintmap and use strintmap_set() and strintmap_get() to
>>   access its entries, so that the ugly implementation detail
>>   (i.e. "the container type we use only has a (void *) field to
>>   store caller-supplied data, so we cast an integer and a pointer
>>   back and forth") can be safely hidden.
>>=20
> Or strsets -- we only need two.
>=20
> --- >8 ---
> Subject: [PATCH] apply: use strsets to track symlinks
>=20
> Symlink changes are tracked in a string_list, with the util pointer
> value indicating whether a symlink is kept or removed.  Using fake
> pointer values requires awkward casts.  Use one strset for each type =
of
> change instead to simplify and shorten the code.
>=20
> Original-patch-by: Jessica Clarke <jrtc27@jrtc27.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Thanks, this patch makes sense to me. Incidentally, seeing the bigger
picture as a result of this patch touching everywhere that used that
list, I can see that in fact the existing code would have worked, just
with the compiler warning that something potentially iffy was going on.
I had assumed ent->util was still sometimes storing an actual pointer,
with the low bits being used as flags, as many things tend to do, but
in fact it was always NULL plus a couple of flag bits, so both sides of
the | always had the same bounds/permissions/tag, that of NULL (i.e.
tag cleared as invalid, full bounds). This still looks like a nice
cleanup though.

Jess

> ---
> apply.c | 42 ++++++++----------------------------------
> apply.h | 26 +++++++++++---------------
> 2 files changed, 19 insertions(+), 49 deletions(-)
>=20
> diff --git a/apply.c b/apply.c
> index fed195250b..7deb4f79fd 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -103,7 +103,8 @@ int init_apply_state(struct apply_state *state,
> 	state->linenr =3D 1;
> 	string_list_init_nodup(&state->fn_table);
> 	string_list_init_nodup(&state->limit_by_name);
> -	string_list_init_nodup(&state->symlink_changes);
> +	strset_init(&state->removed_symlinks);
> +	strset_init(&state->kept_symlinks);
> 	strbuf_init(&state->root, 0);
>=20
> 	git_apply_config();
> @@ -117,7 +118,8 @@ int init_apply_state(struct apply_state *state,
> void clear_apply_state(struct apply_state *state)
> {
> 	string_list_clear(&state->limit_by_name, 0);
> -	string_list_clear(&state->symlink_changes, 0);
> +	strset_clear(&state->removed_symlinks);
> +	strset_clear(&state->kept_symlinks);
> 	strbuf_release(&state->root);
>=20
> 	/* &state->fn_table is cleared at the end of apply_patch() */
> @@ -3812,59 +3814,31 @@ static int check_to_create(struct apply_state =
*state,
> 	return 0;
> }
>=20
> -static uintptr_t register_symlink_changes(struct apply_state *state,
> -					  const char *path,
> -					  uintptr_t what)
> -{
> -	struct string_list_item *ent;
> -
> -	ent =3D string_list_lookup(&state->symlink_changes, path);
> -	if (!ent) {
> -		ent =3D string_list_insert(&state->symlink_changes, =
path);
> -		ent->util =3D (void *)0;
> -	}
> -	ent->util =3D (void *)(what | ((uintptr_t)ent->util));
> -	return (uintptr_t)ent->util;
> -}
> -
> -static uintptr_t check_symlink_changes(struct apply_state *state, =
const char *path)
> -{
> -	struct string_list_item *ent;
> -
> -	ent =3D string_list_lookup(&state->symlink_changes, path);
> -	if (!ent)
> -		return 0;
> -	return (uintptr_t)ent->util;
> -}
> -
> static void prepare_symlink_changes(struct apply_state *state, struct =
patch *patch)
> {
> 	for ( ; patch; patch =3D patch->next) {
> 		if ((patch->old_name && S_ISLNK(patch->old_mode)) &&
> 		    (patch->is_rename || patch->is_delete))
> 			/* the symlink at patch->old_name is removed */
> -			register_symlink_changes(state, patch->old_name, =
APPLY_SYMLINK_GOES_AWAY);
> +			strset_add(&state->removed_symlinks, =
patch->old_name);
>=20
> 		if (patch->new_name && S_ISLNK(patch->new_mode))
> 			/* the symlink at patch->new_name is created or =
remains */
> -			register_symlink_changes(state, patch->new_name, =
APPLY_SYMLINK_IN_RESULT);
> +			strset_add(&state->kept_symlinks, =
patch->new_name);
> 	}
> }
>=20
> static int path_is_beyond_symlink_1(struct apply_state *state, struct =
strbuf *name)
> {
> 	do {
> -		unsigned int change;
> -
> 		while (--name->len && name->buf[name->len] !=3D '/')
> 			; /* scan backwards */
> 		if (!name->len)
> 			break;
> 		name->buf[name->len] =3D '\0';
> -		change =3D check_symlink_changes(state, name->buf);
> -		if (change & APPLY_SYMLINK_IN_RESULT)
> +		if (strset_contains(&state->kept_symlinks, name->buf))
> 			return 1;
> -		if (change & APPLY_SYMLINK_GOES_AWAY)
> +		if (strset_contains(&state->removed_symlinks, =
name->buf))
> 			/*
> 			 * This cannot be "return 0", because we may
> 			 * see a new one created at a higher level.
> diff --git a/apply.h b/apply.h
> index 16202da160..4052da50c0 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -4,6 +4,7 @@
> #include "hash.h"
> #include "lockfile.h"
> #include "string-list.h"
> +#include "strmap.h"
>=20
> struct repository;
>=20
> @@ -25,20 +26,6 @@ enum apply_verbosity {
> 	verbosity_verbose =3D 1
> };
>=20
> -/*
> - * We need to keep track of how symlinks in the preimage are
> - * manipulated by the patches.  A patch to add a/b/c where a/b
> - * is a symlink should not be allowed to affect the directory
> - * the symlink points at, but if the same patch removes a/b,
> - * it is perfectly fine, as the patch removes a/b to make room
> - * to create a directory a/b so that a/b/c can be created.
> - *
> - * See also "struct string_list symlink_changes" in "struct
> - * apply_state".
> - */
> -#define APPLY_SYMLINK_GOES_AWAY 01
> -#define APPLY_SYMLINK_IN_RESULT 02
> -
> struct apply_state {
> 	const char *prefix;
>=20
> @@ -86,7 +73,16 @@ struct apply_state {
>=20
> 	/* Various "current state" */
> 	int linenr; /* current line number */
> -	struct string_list symlink_changes; /* we have to track symlinks =
*/
> +	/*
> +	 * We need to keep track of how symlinks in the preimage are
> +	 * manipulated by the patches.  A patch to add a/b/c where a/b
> +	 * is a symlink should not be allowed to affect the directory
> +	 * the symlink points at, but if the same patch removes a/b,
> +	 * it is perfectly fine, as the patch removes a/b to make room
> +	 * to create a directory a/b so that a/b/c can be created.
> +	 */
> +	struct strset removed_symlinks;
> +	struct strset kept_symlinks;
>=20
> 	/*
> 	 * For "diff-stat" like behaviour, we keep track of the biggest =
change
> --
> 2.34.1

