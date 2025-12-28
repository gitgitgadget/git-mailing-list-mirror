Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB0234994
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766945462; cv=none; b=ELHQqH8l87qBAIfVOO8woGa7SO4rAzgHb4YjSK5X913unTQOVhYcRxSu5RQvJz/94Il1r+um3PdTxJPQ7Gc5MZ1ExwBQJ9h55M28FlzsHFZPiQyvRIGqMWuNwVigMgG/ou0llUOOvyYm5BAKWYEjweoumBzAOAnk5Dp9AxQAMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766945462; c=relaxed/simple;
	bh=Z0BI9ukvSw9554lTxvfPLc6EMMnpYuSjbrqs/HQCGgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=il3lxZg6kgGbungKI/kBuLijzk1afjOh7VAIxFODLanSnd7Fv10p2CzXPFWUL42T/jlykgVbY2s3VzyBNeTdUeMI84Z0FVSfcHmbEgXVgC4eqlBA0D5FJwQpfrbJGj3HgWaMFYh0n+Scp4mV1RQv1aKgIyaNUHgfqyML6NWxVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lUQmf3sS; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lUQmf3sS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766945452; x=1767550252; i=l.s.r@web.de;
	bh=1oi4E0Dotn7ukoOMXgKD6AnW5dnGg2Z0TC68ndOq4SQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lUQmf3sSBB89EqASTusbCvdDiwB1ur1oLR/rshecWcJHmS5fu3QFjc0R50yDRaTD
	 oZlyRxv4wjyaGogi0ME5gQptxx+xfvLd+yjK8VJtjuqoViRaMj/rZ8/VwpA3RP6nw
	 tWDv2gMbhGfs0tyR5qlBieZ7g32KJ8fAR/VE29mH7R2FuNKnOr+pSMRFn6eCVymMz
	 lOsvTRwiI2b8cOKPBQP1C3Zt4iAglQWw+afyByryqdUkaxEGQ8G7lq56sJcUIIDSk
	 AIedNORkxow7kIwZWE4HzQ2pD93E83wVGuLLiN9vca5zU/3QZFa6cn6sgUpIoaowG
	 CKqa9CflPHmQTPpiAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.18.156]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Myv70-1vniiv3OEc-00xDvz for <git@vger.kernel.org>; Sun, 28 Dec 2025 19:10:51
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 2/4] tag: support arbitrary repositories in gpg_verify_tag()
Date: Sun, 28 Dec 2025 19:10:49 +0100
Message-ID: <20251228181051.68724-3-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228181051.68724-1-l.s.r@web.de>
References: <20251228181051.68724-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YBmKFdFg9H2Zn/xNfdxaCR4EtypyeecxUTWqKb0fz5pDF+SPlnJ
 0ZAuQ9rS6sEPwp7e7RQLVCUn/rHagpxyXL4h5knuDP3hU6DrTdPAB2Q5CPYjb1g23BqzbyT
 3WLrl+sX7Xse+cfrYRmRt0sOXZDKiM/9T4vnKStjKj18eLcqRJxQeRFUC+Ufy5RdIMVMTfI
 T5D/rtuj37cUw1yYdStQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Escqg/Gsi1U=;MISYakB5ue7AVtk3Bmd/KKbarvr
 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
 eatwYYIjgtd0PPLU9HrYhldMH4ATMrK7eUBZrf

Allow callers of gpg_verify_tag() specify the repository to use by
providing a parameter for that.  One of the two has not been using
the_repository since 43a8391977 (builtin/verify-tag: stop using
`the_repository`, 2025-03-08); let it pass in the correct repository.
The other simply passes the_repository to get the same result as before.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 tag.c                | 12 ++++++------
 tag.h                |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 01eba90c5c..aeb04c487f 100644
=2D-- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -149,7 +149,7 @@ static int verify_tag(const char *name, const char *re=
f UNUSED,
 	if (format->format)
 		flags =3D GPG_VERIFY_OMIT_STATUS;
=20
-	if (gpg_verify_tag(oid, name, flags))
+	if (gpg_verify_tag(the_repository, oid, name, flags))
 		return -1;
=20
 	if (format->format)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 558121eaa1..4a261b2369 100644
=2D-- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -61,7 +61,7 @@ int cmd_verify_tag(int argc,
 			continue;
 		}
=20
-		if (gpg_verify_tag(&oid, name, flags)) {
+		if (gpg_verify_tag(repo, &oid, name, flags)) {
 			had_error =3D 1;
 			continue;
 		}
diff --git a/tag.c b/tag.c
index dec5ea8eb0..9373c49d06 100644
=2D-- a/tag.c
+++ b/tag.c
@@ -44,28 +44,28 @@ static int run_gpg_verify(const char *buf, unsigned lo=
ng size, unsigned flags)
 	return ret;
 }
=20
-int gpg_verify_tag(const struct object_id *oid, const char *name_to_repor=
t,
-		unsigned flags)
+int gpg_verify_tag(struct repository *r, const struct object_id *oid,
+		   const char *name_to_report, unsigned flags)
 {
 	enum object_type type;
 	char *buf;
 	unsigned long size;
 	int ret;
=20
-	type =3D odb_read_object_info(the_repository->objects, oid, NULL);
+	type =3D odb_read_object_info(r->objects, oid, NULL);
 	if (type !=3D OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
 				name_to_report :
-				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV),
+				repo_find_unique_abbrev(r, oid, DEFAULT_ABBREV),
 				type_name(type));
=20
-	buf =3D odb_read_object(the_repository->objects, oid, &type, &size);
+	buf =3D odb_read_object(r->objects, oid, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
 				name_to_report ?
 				name_to_report :
-				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV));
+				repo_find_unique_abbrev(r, oid, DEFAULT_ABBREV));
=20
 	ret =3D run_gpg_verify(buf, size, flags);
=20
diff --git a/tag.h b/tag.h
index ef12a61037..55c2d0792b 100644
=2D-- a/tag.h
+++ b/tag.h
@@ -16,7 +16,7 @@ int parse_tag_buffer(struct repository *r, struct tag *i=
tem, const void *data, u
 int parse_tag(struct tag *item);
 void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const cha=
r *, int);
-int gpg_verify_tag(const struct object_id *oid,
+int gpg_verify_tag(struct repository *r, const struct object_id *oid,
 		   const char *name_to_report, unsigned flags);
 struct object_id *get_tagged_oid(struct tag *tag);
=20
=2D-=20
2.52.0

