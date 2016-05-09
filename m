From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 04/19] index-helper: add --strict
Date: Mon,  9 May 2016 16:48:34 -0400
Message-ID: <1462826929-7567-5-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:51:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7y-0004ef-30
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbcEIUt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 16:49:59 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32963 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbcEIUtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:09 -0400
Received: by mail-qk0-f171.google.com with SMTP id n63so102045523qkf.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeDvJMLSbeaSGYLoT+3r+TBQFo5bH3+83aJaslKMuHg=;
        b=l3eKN50KhHIzNFFjilIQI36B7MmOqOWqXS2VTS2lhtuQE2kN/Eox1hjNJnjmeK0M4+
         CNq2w597FFmt6d+lK7OZqYDi1PKRR7vSCZiGauBjB9EZlM+PjL1xiGqA1t6krstTmhpT
         VDQtCOylnQQW5E+wqWlPaCctnkICxo9v31RODApvrezgTJVRT6Ew2EvUj2F5cbpFdIoS
         8qBnSAF8maHFiRSpajykioYU7BVyjptNB3bRSKeURsi3BgJn+wi96xF+dtZtQMsAdLxG
         TAjh36DWh08vzHZmqOAxoeCABSA/3XO6aRe5m4VfeNOV31fRdYGql/29sN/MRsE/5QSS
         rbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeDvJMLSbeaSGYLoT+3r+TBQFo5bH3+83aJaslKMuHg=;
        b=aeibGFs6/WyLaMAvHCvEWYKE0BrlunlGAI7z0sNNHYbizld6ljF/ISswEQOld6siYP
         afHukosxZU0m5jOqNDZCy/CXZaIUR8E7pRBnW+SlXoBeirgqKoCbK8AbvCTD6DE7pktk
         KYP2HaMfr9FVoYpg8WeN5E4q9rVCXQ7NjXGEDaMFObl0HDd9/60VJs7dD5WTrTon8+H3
         GTl3KyqSF7E6I3+4gQPm2W5hl4eNrPXRUapcDGNtE76wjA6iP+G2F1HrpdtwOj4+OlfJ
         WLiHaUE1g5CkWYInyAxSl7AQpRwwYaJNRZMx0CQON6O1cXEpGZcznIWaTp3L3ZQ1TOAR
         ZWKA==
X-Gm-Message-State: AOPr4FVv+7bSNMtWY/bSybSJRNzZD69opmNlNbSjt9z3zXzzgfqiFc++tCu0NoIzuf9rrQ==
X-Received: by 10.55.173.5 with SMTP id w5mr40704357qke.115.1462826948810;
        Mon, 09 May 2016 13:49:08 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:07 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294062>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

There are "holes" in the index-helper approach because the shared
memory is not verified again by git. If $USER is compromised, shared
memory could be modified. But anyone who could do this could already
modify $GIT_DIR/index. A more realistic risk is some bugs in
index-helper that produce corrupt shared memory. --strict is added to
avoid that.

Strictly speaking there's still a very small gap where corrupt shared
memory could still be read by git: after we write the trailing SHA-1 in
the shared memory (thus signaling "this shm is ready") and before
verify_shm() detects an error.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  9 +++++++
 cache.h                            |  1 +
 index-helper.c                     | 48 ++++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       |  9 ++++---
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index f892184..1f92c89 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -25,6 +25,15 @@ OPTIONS
 	Exit if the cached index is not accessed for `<n>`
 	seconds. Specify 0 to wait forever. Default is 600.
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
=20
diff --git a/cache.h b/cache.h
index 2d7af6f..6cb0d02 100644
--- a/cache.h
+++ b/cache.h
@@ -345,6 +345,7 @@ struct index_state {
 		  * on it.
 		  */
 		 to_shm : 1,
+		 always_verify_trailing_sha1 : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/index-helper.c b/index-helper.c
index b9443f4..bc7e110 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -17,6 +17,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
+static int to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -114,11 +115,56 @@ static void share_index(struct index_state *istat=
e, struct shm *is)
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
@@ -247,6 +293,8 @@ int main(int argc, char **argv)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
 			    N_("exit if not used after some seconds")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 "verify shared memory after creating"),
 		OPT_END()
 	};
=20
diff --git a/read-cache.c b/read-cache.c
index 1a5a03d..d7849d6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1674,9 +1674,12 @@ int do_read_index(struct index_state *istate, co=
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
