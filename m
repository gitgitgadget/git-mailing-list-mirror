Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354093A7F59
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665095; cv=none; b=QoZisWNj3l0HkpbR9izMcoHRbek5w5Ip0OPu5eTjnQlGUdUdMLjVmSvxCAZubjj8AzpI8OjpLruXktF4wSu5p9Q06beDkllahnNki9gWZAgwCqCuG0alFrt46hXiZbSUx5Y+fEt5JQdv2YvB5yOzUe2tdFqjw8kLqBFPW8VflF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665095; c=relaxed/simple;
	bh=6+JrNXrDfz4GtpWBmjYvxbto6cDPC8FBr7XZmxCW11s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=IDWcDJfoh5DGICGP9zcNNDwDhy199h7zBi7G4R2tLLNy2CCE/IM0WW7BLZJ2m6rAriTZrtx1eDqh6wA5HnGjl29xQy7fHxwmole5OW6dA7Nc8jZskORTAew8YiG/TP7vgjCxqswaIrJEF6UzDk8SOYxZAMSEC5rFJNElAUahCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JnRONeoR; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JnRONeoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770665092; x=1771269892; i=l.s.r@web.de;
	bh=B6ePvMIRP2sIkRn2Z0x9YyBMuHIH5ZJKiKqb0u0AeDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JnRONeoRw7wduyGmEzWym2ryJHyEGXdOLOQN401aLS1QPGXxhuis81zsjyD3qC2B
	 faV1cjQKwW0k1ccbzcqbHYoS6WVm+ZVdytIKejfz3snebeAuTbaYSNpw+F4VNAZ3n
	 LF1OksFxcA4IT91x4sWYFR8J7nvTJNBY3ieL5NV4d19s2VkNq6mM/BldREiR9qfrY
	 tr0W8Q2zjgkb1v5PfAtcSHIK7DSQAwDnZAl2HGAVu3xjAV1g0T9FuIpfJ3qVfgKa8
	 nwJtzUbQ4+oeZgWjnocaqOQDzLsendlIyDbYJyOmtRyBE0NhzTj4Sny/D/+Ya9B0E
	 md+hMseWuR+2RHX3KQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1vNJoD1SLh-00aX78; Mon, 09
 Feb 2026 20:24:52 +0100
Message-ID: <59fe4ac7-605d-4eae-b13c-46996dd8814e@web.de>
Date: Mon, 9 Feb 2026 20:24:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] xdiff-interface: stop using the_repository
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
In-Reply-To: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jOOcCJHxoQoSAEhLq7Ma5z6jfs9c6TPdLoQyllZcWG0thWucbKw
 /S36aBewZx+1dpLMfiYZ6wyNM2CW7UCwxGNJETIIsDTyWxm0tvvyNpatEuHM2cqOw9JWx5Y
 3/Ba3bIF2MPGj78yO3P82BEdyzKXhCr5IyGTM+ceAir8a8V1aJ8fKlfxxrcf44UNtY3GhXy
 mjRbKGWSjC5nUBoC+gS6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DZBGC5nJmYs=;eL934ap51ZxiVHX+yvgYmm6mw/7
 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

Use the algorithm-agnostic is_null_oid() and push the dependency of
read_mmblob() on the_repository->objects to its callers.  This allows it
to be used with arbitrary object databases.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Change since v1: don't add unnecessary #include

 apply.c              | 6 +++---
 builtin/checkout.c   | 6 +++---
 builtin/merge-file.c | 2 +-
 merge-ort.c          | 6 +++---
 notes-merge.c        | 6 +++---
 xdiff-interface.c    | 8 ++++----
 xdiff-interface.h    | 5 ++++-
 7 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/apply.c b/apply.c
index 3de4aa4d2e..ea90ed16be 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -3568,9 +3568,9 @@ static int three_way_merge(struct apply_state *state=
,
 	else if (oideq(base, theirs) || oideq(ours, theirs))
 		return resolve_to(image, ours);
=20
-	read_mmblob(&base_file, base);
-	read_mmblob(&our_file, ours);
-	read_mmblob(&their_file, theirs);
+	read_mmblob(&base_file, the_repository->objects, base);
+	read_mmblob(&our_file, the_repository->objects, ours);
+	read_mmblob(&their_file, the_repository->objects, theirs);
 	merge_opts.variant =3D state->merge_variant;
 	status =3D ll_merge(&result, path,
 			  &base_file, "base",
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0ba4f03f2e..f7b313816e 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -294,9 +294,9 @@ static int checkout_merged(int pos, const struct check=
out *state,
 	if (is_null_oid(&threeway[1]) || is_null_oid(&threeway[2]))
 		return error(_("path '%s' does not have necessary versions"), path);
=20
-	read_mmblob(&ancestor, &threeway[0]);
-	read_mmblob(&ours, &threeway[1]);
-	read_mmblob(&theirs, &threeway[2]);
+	read_mmblob(&ancestor, the_repository->objects, &threeway[0]);
+	read_mmblob(&ours, the_repository->objects, &threeway[1]);
+	read_mmblob(&theirs, the_repository->objects, &threeway[2]);
=20
 	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
 	ll_opts.renormalize =3D renormalize;
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 46775d0c79..c5dbd028fd 100644
=2D-- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -128,7 +128,7 @@ int cmd_merge_file(int argc,
 				ret =3D error(_("object '%s' does not exist"),
 					      argv[i]);
 			else if (!oideq(&oid, the_hash_algo->empty_blob))
-				read_mmblob(mmf, &oid);
+				read_mmblob(mmf, the_repository->objects, &oid);
 			else
 				read_mmfile(mmf, "/dev/null");
 		} else if (read_mmfile(mmf, fname)) {
diff --git a/merge-ort.c b/merge-ort.c
index e80e4f735a..a4103d56ed 100644
=2D-- a/merge-ort.c
+++ b/merge-ort.c
@@ -2136,9 +2136,9 @@ static int merge_3way(struct merge_options *opt,
 		name2 =3D mkpathdup("%s:%s", opt->branch2,  pathnames[2]);
 	}
=20
-	read_mmblob(&orig, o);
-	read_mmblob(&src1, a);
-	read_mmblob(&src2, b);
+	read_mmblob(&orig, the_repository->objects, o);
+	read_mmblob(&src1, the_repository->objects, a);
+	read_mmblob(&src2, the_repository->objects, b);
=20
 	merge_status =3D ll_merge(result_buf, path, &orig, base,
 				&src1, name1, &src2, name2,
diff --git a/notes-merge.c b/notes-merge.c
index 586939939f..47e9d7580a 100644
=2D-- a/notes-merge.c
+++ b/notes-merge.c
@@ -359,9 +359,9 @@ static int ll_merge_in_worktree(struct notes_merge_opt=
ions *o,
 	mmfile_t base, local, remote;
 	enum ll_merge_result status;
=20
-	read_mmblob(&base, &p->base);
-	read_mmblob(&local, &p->local);
-	read_mmblob(&remote, &p->remote);
+	read_mmblob(&base, the_repository->objects, &p->base);
+	read_mmblob(&local, the_repository->objects, &p->local);
+	read_mmblob(&remote, the_repository->objects, &p->remote);
=20
 	status =3D ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
 			  &local, o->local_ref, &remote, o->remote_ref,
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 1a35556380..f043330f2a 100644
=2D-- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
=20
 #include "git-compat-util.h"
@@ -177,18 +176,19 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	return 0;
 }
=20
-void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
+void read_mmblob(mmfile_t *ptr, struct object_database *odb,
+		 const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
=20
-	if (oideq(oid, null_oid(the_hash_algo))) {
+	if (is_null_oid(oid)) {
 		ptr->ptr =3D xstrdup("");
 		ptr->size =3D 0;
 		return;
 	}
=20
-	ptr->ptr =3D odb_read_object(the_repository->objects, oid, &type, &size)=
;
+	ptr->ptr =3D odb_read_object(odb, oid, &type, &size);
 	if (!ptr->ptr || type !=3D OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 	ptr->size =3D size;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index dfc55daddf..fbc4ceec40 100644
=2D-- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -4,6 +4,8 @@
 #include "hash.h"
 #include "xdiff/xdiff.h"
=20
+struct object_database;
+
 /*
  * xdiff isn't equipped to handle content over a gigabyte;
  * we make the cutoff 1GB - 1MB to give some breathing
@@ -45,7 +47,8 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
 int read_mmfile(mmfile_t *ptr, const char *filename);
-void read_mmblob(mmfile_t *ptr, const struct object_id *oid);
+void read_mmblob(mmfile_t *ptr, struct object_database *odb,
+		 const struct object_id *oid);
 int buffer_is_binary(const char *ptr, unsigned long size);
=20
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflag=
s);
=2D-=20
2.52.0
