Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22F25B1D2
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595816; cv=none; b=KATy+cD6PH57S/5kW7ft3ERP8XY+M2Q+M+s2sQoKs5IZXPTKLrbYS4NG6TQItlv80b1gLG03gkw6tRmjKUGsN/SXN4eZL742KBVzxZtAX48DJBdkweMKjc/Je12GB10XwwjGZoh9HSBGcwHFlClCM8B0XeK6AHoUMSqY2MH4oRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595816; c=relaxed/simple;
	bh=+zEQUZursPFOP5y/aSqeCBVLfGF9XU1Wb5dFB5DOBWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LH4SfgDDbnh6u2rU3L0OPF9mqS+iLcPOwXb4Rz3LPjn//WBcAG/GIfraOe+sSBL3A4aIakE4HYofnOE3FTqq6VeOWVyVCdOMQUUyg4jc4gvfPvB+yO6WjR379bsC8A6Kf2N9TOApUVbfL5dXWolQYmbv5rASo3m1V4fuYZecV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=mHVTxVpq; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mHVTxVpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595808; x=1767200608; i=l.s.r@web.de;
	bh=dz+DBYTEvvZykgGi3lTmbg0dwV8AcGeass684Mm0xrs=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mHVTxVpqXnEGY6uu86SeZWQ7pEAo6CSv7h+ju1cbRkAzi/hN1bOlaiZSF31zx/Ic
	 owNApH7nV061TAwZy9rwkOpDBSKDbHQSjuUJecHEEF6aEV6HQmouCDu4+KrJGKBYf
	 XWTKooCoihOVPzZd561Ii8OWQCqVFKL7LiMsDznPtMwobKsbpwX+Dp+PknZo4QEY8
	 PX+V9pk1imCBPhNkpayHtQTJmWC1spCey2KyepiDKaU96DtBS/vNx965cFAg2a9tY
	 LjV6xdi4MDlOth8dXp0Zn5zOw77tNOTj44rrxk1tY1LofqxhkCLwK7JU3Kf5Juemg
	 SEJNeY/OV4l1z2ijBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Ml46y-1wDJKG2bHA-00kV9b for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:28
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 02/14] log: use commit_stack
Date: Wed, 24 Dec 2025 18:03:15 +0100
Message-ID: <20251224170327.68049-3-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224170327.68049-1-l.s.r@web.de>
References: <20251224170327.68049-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YLk7rFYAyL+QIjvkIoc+/1yqjQEZdlHzSSjEo8JoZyvEKbnEabc
 KxsM9xBW4WIi93pb4PBGlzHYx+nc3jthw7qRQ60eMl7BXXkjMT9tGNc3yKKMizcc/4IFVVX
 A48BgqXVY6CL62QP+98/vEel6yRPfWFITHYyjH4AvtrIa35BcgLB5joaNGBawooJWGSZc2y
 /bcpm6dfnE2zVf902EL5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lOUT2lEM5E8=;ColIuvzAhFlgOhWs3X6Kx+tqKg7
 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

Calling commit_stack_push() to add commits is simpler and more efficient
than using REALLOC_ARRAY.  Calling commit_stack_pop() to consume them in
LIFO order is also a tad simpler than calculating the array index from
the end.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/log.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d4cf9c59c8..5c9a8ef363 100644
=2D-- a/builtin/log.c
+++ b/builtin/log.c
@@ -1896,11 +1896,11 @@ int cmd_format_patch(int argc,
 {
 	struct format_config cfg;
 	struct commit *commit;
-	struct commit **list =3D NULL;
+	struct commit_stack list =3D COMMIT_STACK_INIT;
 	struct rev_info rev;
 	char *to_free =3D NULL;
 	struct setup_revision_opt s_r_opt;
-	size_t nr =3D 0, total, i;
+	size_t total, i;
 	int use_stdout =3D 0;
 	int start_number =3D -1;
 	int just_numbers =3D 0;
@@ -2283,14 +2283,12 @@ int cmd_format_patch(int argc,
 		if (ignore_if_in_upstream && has_commit_patch_id(commit, &ids))
 			continue;
=20
-		nr++;
-		REALLOC_ARRAY(list, nr);
-		list[nr - 1] =3D commit;
+		commit_stack_push(&list, commit);
 	}
-	if (nr =3D=3D 0)
+	if (!list.nr)
 		/* nothing to do */
 		goto done;
-	total =3D nr;
+	total =3D list.nr;
 	if (cover_letter =3D=3D -1) {
 		if (cfg.config_cover_letter =3D=3D COVER_AUTO)
 			cover_letter =3D (total > 1);
@@ -2308,7 +2306,7 @@ int cmd_format_patch(int argc,
 		if (!cover_letter && total !=3D 1)
 			die(_("--interdiff requires --cover-letter or single patch"));
 		rev.idiff_oid1 =3D &idiff_prev.oid[idiff_prev.nr - 1];
-		rev.idiff_oid2 =3D get_commit_tree_oid(list[0]);
+		rev.idiff_oid2 =3D get_commit_tree_oid(list.items[0]);
 		rev.idiff_title =3D diff_title(&idiff_title, reroll_count,
 					     _("Interdiff:"),
 					     _("Interdiff against v%d:"));
@@ -2324,7 +2322,7 @@ int cmd_format_patch(int argc,
 			die(_("--range-diff requires --cover-letter or single patch"));
=20
 		infer_range_diff_ranges(&rdiff1, &rdiff2, rdiff_prev,
-					origin, list[0]);
+					origin, list.items[0]);
 		rev.rdiff1 =3D rdiff1.buf;
 		rev.rdiff2 =3D rdiff2.buf;
 		rev.creation_factor =3D creation_factor;
@@ -2360,11 +2358,11 @@ int cmd_format_patch(int argc,
 	}
=20
 	memset(&bases, 0, sizeof(bases));
-	base =3D get_base_commit(&cfg, list, nr);
+	base =3D get_base_commit(&cfg, list.items, list.nr);
 	if (base) {
 		reset_revision_walk();
 		clear_object_flags(the_repository, UNINTERESTING);
-		prepare_bases(&bases, base, list, nr);
+		prepare_bases(&bases, base, list.items, list.nr);
 	}
=20
 	if (in_reply_to || cfg.thread || cover_letter) {
@@ -2381,7 +2379,8 @@ int cmd_format_patch(int argc,
 		if (cfg.thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, description_file, branch_name, quiet, &cfg);
+				  origin, list.nr, list.items,
+				  description_file, branch_name, quiet, &cfg);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(signature, rev.diffopt.file);
 		total++;
@@ -2395,12 +2394,12 @@ int cmd_format_patch(int argc,
 	if (show_progress)
 		progress =3D start_delayed_progress(the_repository,
 						  _("Generating patches"), total);
-	for (i =3D 0; i < nr; i++) {
-		size_t idx =3D nr - i - 1;
+	while (list.nr) {
+		size_t idx =3D list.nr - 1;
 		int shown;
=20
 		display_progress(progress, total - idx);
-		commit =3D list[idx];
+		commit =3D commit_stack_pop(&list);
 		rev.nr =3D total - idx + (start_number - 1);
=20
 		/* Make the second and subsequent mails replies to the first */
@@ -2469,7 +2468,7 @@ int cmd_format_patch(int argc,
 		}
 	}
 	stop_progress(&progress);
-	free(list);
+	commit_stack_clear(&list);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
=20
=2D-=20
2.52.0

