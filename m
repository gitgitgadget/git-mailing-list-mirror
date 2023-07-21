Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4EEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGUMm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGUMmU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:42:20 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F730E8
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943317; x=1690548117; i=l.s.r@web.de;
 bh=V8Qp3OSxWSlDOf8VnUUS6IDPnRuZSeXgr4a7EiEzGJ0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=X8Tw9CLdLtWzvSXUQLer2QfpTm4QGtdOhuAJsODzIrx2LU0kuwBJ/+++ZD+JhS5+Tdu225i
 iEywaJOu3ffvLVg1OBy+YMNOzrzwq2U3/14xkFiHyRJWau9LhAUH3A43bCQ1I0V2wUty8sWSD
 Jv5NXj2Y+cv4s1CAQZgyV7PW2dHdrXXRyihi411veCbp5DVIxc7YkdyqkVjwSmIJC4T/Vc4w0
 dIoYNlUhueBpE/xmdw9p6hrqg1p7AFqdchN/VdS7WLeUJdLbh+8qiqXlRWKxRaABpiJAuYX4q
 KrMRRLvJi8lpG7q4fP+tJ396iJ89e+9y85bRiS4yv0jme7FvWHTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPdl-1qaDTA1PWr-00MRnu; Fri, 21
 Jul 2023 14:41:57 +0200
Message-ID: <fe7e43a0-5f08-73a7-fd04-b9127592b45c@web.de>
Date:   Fri, 21 Jul 2023 14:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] pack-objects: fix --no-keep-true-parents
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vAqMuFdfZ18bevzkZKG5Ju0oB5ZQn3fs8eiWAjT6FkUGzxWzvSp
 s0BW1+A8J0kHPuFx3+pYjJScEdQwcujg8em+65yQtG4dy+194Yu2ZJWboZygy4UDxZmH/yx
 x68fmvVCTVUD12S/3g/lMdHPBVOu0k+Ghc/q/3Y12LP00m2EK8e03eMf1LIPpP+s5xAjLO8
 GnjNVX1X8D/YCn3MoXR+g==
UI-OutboundReport: notjunk:1;M01:P0:EDbOmfCqNJA=;XcEfzuph9G+GOwfA9Rbsz0g5EZZ
 5iJDAe5Ac1yX+phTEMi/Fzlpj+kRWda6guYX3GRUECjJcTjLtwhD+mmT49oYvdrOVIP/kKp/o
 nXAZZT1BwSzZrK8tYLsYW0iXsC4z5YKvg6Iu68o83B7mchgEexLT1w2YCVIbJ+mrNN4v9DOX0
 T+dJl/rTioudA86GD0FQPFw7kKgaBeWa42821zbh31eMbQURwehxfuDKcBsdmR3SgqaSEKbJB
 fTQInkoQs2OBwSc3FYbPh+makelS382B+a+ypAl3FhvvcIURBNH+jF2VVIqCqOt6pgGB7xoZW
 yAfJq5Y2Phi2Vb0+TwQUTVGMATM5hmZ+To4X+xJ2y0EuJV7SwDvb87h2HtQcb/6+24PI4pSS9
 q0tutjPn1WrY1/vn0CD18A+US88jA5wypfaBVcS5Qc9WwAYKZzCQgV5Z1AO3N/YxkV9stQxG0
 FzeAeOR5NGooVs1aPoL9tppIU0kFhen2XBV1/ot8YtpGM6fkLJvL7MOvthYsa1a6JEZaw611G
 eBF1JkK5vTAJlIZs5Z2fKbqYvaOt3lKWiBCke5cIztVjYz1XdKI7zWoFWlRaVbFDLoELcIqfk
 eDWt9Qmzz9cdSX0H2YHt9uIO7ojCRJkxyjfypyc3wFVYkfz/beYER0G8PctwKWdheuthemF1D
 79zboCD8kwZIBOAMosiDzSu2lwzVY+5WuH+euKGSlvA8etdqG+WNJi/H20Dy5GVz23VtOgvNB
 pC5eA8CsTuiaF0sQkajmFCsO7Ga7rJYM3EwAqevSTcCGGSNHE6IWzrfi9F7x7FLBr54LBi4PA
 D2QP0QpdHpFD8j0uNM5/3wuDnON4ZRoFr7LEJ77e6DDFdRNMx9E4y25LIUcHgrot4sHB9nVDh
 EYhgtMxe8pchKSELsCsJ1aIMiSlmUDjhgS+JmARsevCu8PfiaAovGHA3AQbvvHrF7eKJr/a8W
 sruJXQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 99fb6e04cb (pack-objects: convert to use parse_options(),
2012-02-01) git pack-objects has accepted --no-keep-true-parents, but
this option does the same as --keep-true-parents.  That's because it's
defined using OPT_SET_INT with a value of 0, which sets 0 when negated
as well.

Turn --no-keep-true-parents into the opposite of --keep-true-parents by
using OPT_BOOL and storing the option's status directly in a variable
named "grants_keep_true_parents" instead of in negative form in
"grafts_replace_parents".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c | 4 ++--
 commit.c               | 2 +-
 environment.c          | 2 +-
 environment.h          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 06b33d49e9..7bff1be7aa 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4255,8 +4255,8 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 				N_("ignore this pack")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
 			    N_("pack compression level")),
-		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
-			    N_("do not hide commits by grafts"), 0),
+		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
+			 N_("do not hide commits by grafts")),
 		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_SET_INT(0, "write-bitmap-index", &write_bitmap_index,
diff --git a/commit.c b/commit.c
index 6507791061..b3223478bc 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -516,7 +516,7 @@ int parse_commit_buffer(struct repository *r, struct c=
ommit *item, const void *b
 		 * The clone is shallow if nr_parent < 0, and we must
 		 * not traverse its real parents even when we unhide them.
 		 */
-		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
+		if (graft && (graft->nr_parent < 0 || !grafts_keep_true_parents))
 			continue;
 		new_parent =3D lookup_commit(r, &parent);
 		if (!new_parent)
diff --git a/environment.c b/environment.c
index a0d1d070d1..f98d76f080 100644
=2D-- a/environment.c
+++ b/environment.c
@@ -73,7 +73,7 @@ enum push_default_type push_default =3D PUSH_DEFAULT_UNS=
PECIFIED;
 #endif
 enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MODE;
 char *notes_ref_name;
-int grafts_replace_parents =3D 1;
+int grafts_keep_true_parents;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
diff --git a/environment.h b/environment.h
index 611aa0ffed..c5377473c6 100644
=2D-- a/environment.h
+++ b/environment.h
@@ -193,7 +193,7 @@ extern enum object_creation_mode object_creation_mode;

 extern char *notes_ref_name;

-extern int grafts_replace_parents;
+extern int grafts_keep_true_parents;

 extern int repository_format_precious_objects;

=2D-
2.41.0
