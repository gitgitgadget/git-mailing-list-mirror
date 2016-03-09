From: David Turner <dturner@twopensource.com>
Subject: [PATCH 06/19] index-helper: add --strict
Date: Wed,  9 Mar 2016 13:36:09 -0500
Message-ID: <1457548582-28302-7-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiyc-0007Hh-SF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834AbcCISgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:45 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34128 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933798AbcCISgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:39 -0500
Received: by mail-qg0-f48.google.com with SMTP id w104so49417672qge.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xz44Ifn2tDJkvcNAe+YX+s83brTEdRYt/G2nMS69KIg=;
        b=j/sKH2T4r6Jdj4X4a0TNgzqQvMU/nI4qc059kIpvk497tEVmUkVPNEQOmAUi+E2kXL
         KtCi8eXCl4M2lfvfzvmF7VmTT+w+o+7Hr4QGP3Rcgdbs/3nOOrya7T+30dCiPqZ5jEcO
         VNiuY9NTFsHekaZ4zZXObL0xgtm41L1ZXlLDC6GiRoEuLxztXyTr+TByEq6oF5RBGMBi
         GXDroPoQ7M03K0JsUySgvOUhJfr03fwPsHmZy8SsHjd13oVSch91edNhc64UeYulEJL8
         B6cr6vN9lRDo5PKkcvtAndaJcdMY3UqUMDr+wY4yyGPpV39og2DYQGa4cMxUe/vyU82G
         6j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xz44Ifn2tDJkvcNAe+YX+s83brTEdRYt/G2nMS69KIg=;
        b=czy+ESVcxYnG0JoDbJQq+fOPSncGpyrc+JoWdvnQRuotcpxUOEJDXXJu4gnN7b6Dc0
         /GDwN3q6RNawMEvt/y5ZW4ZliWa20K9Tb5Iz1fPVU4xLWUN7xnwBRBIf4FCnoMGBM4YI
         tW23auu1TV/AUQnTTcofhjr/STV1/LIYo+NXcDIRiE1Izm4YLD2A+1ABDp85GOLJc0FJ
         Bd17s70Tn8UoP6oWDmGHDeYUhbrpovY2O+hl79nayIiVaDWebCA7KLb2Rv/ZkXHyu4GD
         bWVII/5o70VXox1ENh5oqfidA1dm5JgRTT3faFVGIev22ZcXlXYvvRRQ50Qh6n8sGs8k
         3Waw==
X-Gm-Message-State: AD7BkJLBKaOC5mMREbDIU+RMJKXLxpOJyVLpYMSOduJXo9D3kNUbXbO6SG2TTm+t3qOUnw==
X-Received: by 10.140.234.11 with SMTP id f11mr48839142qhc.51.1457548598692;
        Wed, 09 Mar 2016 10:36:38 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:38 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288555>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

There's are "holes" in the index-helper approach because the shared
memory is not verified again by git. If $USER is compromised, shared
memory could be modified. But then they can already modify
$GIT_DIR/index. A more realistic risk is some bugs in index-helper
produce corrupt shared memory. --strict is added to avoid that

Strictly speaking there's still a very small gap where corrupt shared
memory could still be read by git: after we write the trailing SHA-1 in
the shared memory (thus signaling "this shm is ready") and before
verify_shm() detects an error.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt |  9 +++++++
 cache.h                            |  1 +
 index-helper.c                     | 48 ++++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       |  9 ++++---
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index 9db28cf..ad40366 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -22,6 +22,15 @@ OPTIONS
 	Exit if the cached index is not accessed for `<n>`
 	minutes. Specify 0 to wait forever. Default is 10.
=20
+--strict::
+--no-strict::
+	Strict mode makes index-helper verify the shared memory after
+	it's created. If the result does not match what's read from
+	$GIT_DIR/index, the shared memory is destroyed. This makes
+	index-helper take more than double the amount of time required
+	for reading an index, but because it will happen in the
+	background, it's not noticable. `--strict` is enabled by default.
+
 NOTES
 -----
 On UNIX-like systems, $GIT_DIR/index-helper.pid contains the process
diff --git a/cache.h b/cache.h
index e22296c..1d7e561 100644
--- a/cache.h
+++ b/cache.h
@@ -336,6 +336,7 @@ struct index_state {
 		 keep_mmap : 1,
 		 from_shm : 1,
 		 to_shm : 1,
+		 always_verify_trailing_sha1 : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/index-helper.c b/index-helper.c
index cf2971d..1140bc0 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -14,6 +14,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
+static int to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -69,11 +70,56 @@ static void share_index(struct index_state *istate,=
 struct shm *is)
 	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, is->sha1)=
;
 }
=20
+static int verify_shm(void)
+{
+	int i;
+	struct index_state istate;
+	memset(&istate, 0, sizeof(istate));
+	istate.always_verify_trailing_sha1 =3D 1;
+	istate.to_shm =3D 1;
+	i =3D read_index(&istate);
+	if (i !=3D the_index.cache_nr)
+		goto done;
+	for (; i < the_index.cache_nr; i++) {
+		struct cache_entry *base, *ce;
+		/* namelen is checked separately */
+		const unsigned int ondisk_flags =3D
+			CE_STAGEMASK | CE_VALID | CE_EXTENDED_FLAGS;
+		unsigned int ce_flags, base_flags, ret;
+		base =3D the_index.cache[i];
+		ce =3D istate.cache[i];
+		if (ce->ce_namelen !=3D base->ce_namelen ||
+		    strcmp(ce->name, base->name)) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+		ce_flags =3D ce->ce_flags;
+		base_flags =3D base->ce_flags;
+		/* only on-disk flags matter */
+		ce->ce_flags   &=3D ondisk_flags;
+		base->ce_flags &=3D ondisk_flags;
+		ret =3D memcmp(&ce->ce_stat_data, &base->ce_stat_data,
+			     offsetof(struct cache_entry, name) -
+			     offsetof(struct cache_entry, ce_stat_data));
+		ce->ce_flags =3D ce_flags;
+		base->ce_flags =3D base_flags;
+		if (ret) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+	}
+done:
+	discard_index(&istate);
+	return i =3D=3D the_index.cache_nr;
+}
+
 static void share_the_index(void)
 {
 	if (the_index.split_index && the_index.split_index->base)
 		share_index(the_index.split_index->base, &shm_base_index);
 	share_index(&the_index, &shm_index);
+	if (to_verify && !verify_shm())
+		cleanup_shm();
 	discard_index(&the_index);
 }
=20
@@ -130,6 +176,8 @@ int main(int argc, char **argv)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
 			    N_("exit if not used after some minutes")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 "verify shared memory after creating"),
 		OPT_END()
 	};
=20
diff --git a/read-cache.c b/read-cache.c
index 7bd3ce4..1a0ab0c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1660,9 +1660,12 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
=20
 	istate->mmap =3D mmap;
 	istate->mmap_size =3D mmap_size;
-	if (try_shm(istate) &&
-	    verify_hdr(istate->mmap, istate->mmap_size) < 0)
-		goto unmap;
+	if (try_shm(istate)) {
+		if (verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
+	} else if (istate->always_verify_trailing_sha1 &&
+		   verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
 	hdr =3D mmap =3D istate->mmap;
 	mmap_size =3D istate->mmap_size;
 	if (!istate->keep_mmap)
--=20
2.4.2.767.g62658d5-twtrsrc
