Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE21C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 00:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378260AbhLGA1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:27:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64345 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhLGA1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 19:27:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3598F10AD89;
        Mon,  6 Dec 2021 19:24:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F8zqaB3XEff8
        SfKVMRpELkQQyTCLe6LBqmX0zUi1T1I=; b=vRgdjfFuEuVvGSBnJ+wxNuRbiRLB
        7/0eu3xc1LAwIt1Klv9n/BnW0ypTtugcxpMhPTAXqiKun/KMOmtzyLVooyVA/E30
        cSHE8eJsp4OdwhPJyAe5jg9LjeoE+BMgpFRXN/Q6VUoG9AIN9VtEaNvMu44c7hQu
        qZXDm/9kqvIxm8E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2A7410AD88;
        Mon,  6 Dec 2021 19:24:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E86FC10AD87;
        Mon,  6 Dec 2021 19:24:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/2] replace die("BUG: ...") with BUG("...")
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
Date:   Mon, 06 Dec 2021 16:24:01 -0800
In-Reply-To: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Dec
 2021 17:25:19 +0100")
Message-ID: <xmqqsfv5b6u6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAFF354C-56F3-11EC-AF83-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A trivial clean-up to change a couple of die() uses to BUG() where
> appropriate. This is split off from an earlier RFC series I sent
> in[1], as the range-diff to the relevant patches there shown there are
> no changes since then.
>
> 1. https://lore.kernel.org/git/RFC-patch-07.21-3f897bf6b0e-20211115T220=
831Z-avarab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   pack-objects: use BUG(...) not die("BUG: ...")
>   strbuf.h: use BUG(...) not die("BUG: ...")
>
>  builtin/pack-objects.c | 2 +-
>  strbuf.h               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Range-diff:
> 1:  2507ea71700 =3D 1:  2a17ed9f135 pack-objects: use BUG(...) not die(=
"BUG: ...")
> 2:  5dedcee3fb0 =3D 2:  ab89fec50c3 strbuf.h: use BUG(...) not die("BUG=
: ...")

There are a bit more that you didn't include and I am having a hard
time guessing why.

 object.c    | 2 +-
 pathspec.h  | 3 +--
 tree-diff.c | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git c/object.c w/object.c
index 23a24e678a..4be82c1e7b 100644
--- c/object.c
+++ w/object.c
@@ -199,7 +199,7 @@ struct object *lookup_object_by_type(struct repositor=
y *r,
 	case OBJ_BLOB:
 		return (struct object *)lookup_blob(r, oid);
 	default:
-		die("BUG: unknown object type %d", type);
+		BUG("unknown object type %d", type);
 	}
 }
=20
diff --git c/pathspec.h w/pathspec.h
index 2341dc9901..402ebb8080 100644
--- c/pathspec.h
+++ w/pathspec.h
@@ -58,8 +58,7 @@ struct pathspec {
 #define GUARD_PATHSPEC(ps, mask) \
 	do { \
 		if ((ps)->magic & ~(mask))	       \
-			die("BUG:%s:%d: unsupported magic %x",	\
-			    __FILE__, __LINE__, (ps)->magic & ~(mask)); \
+			BUG("unsupported magic %x", (ps)->magic & ~(mask)); \
 	} while (0)
=20
 /* parse_pathspec flags */
diff --git c/tree-diff.c w/tree-diff.c
index 437c98a70e..69031d7cba 100644
--- c/tree-diff.c
+++ w/tree-diff.c
@@ -603,8 +603,7 @@ static void try_to_follow_renames(const struct object=
_id *old_oid,
 	 * about dry-run mode and returns wildcard info.
 	 */
 	if (opt->pathspec.has_wildcard)
-		die("BUG:%s:%d: wildcards are not supported",
-		    __FILE__, __LINE__);
+		BUG("wildcards are not supported");
 #endif
=20
 	/* Remove the file creation entry from the diff queue, and remember it =
*/
