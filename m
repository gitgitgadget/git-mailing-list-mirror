From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 04/16] index-helper: add --strict
Date: Wed,  6 Apr 2016 18:11:50 -0400
Message-ID: <1459980722-4836-5-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvh9-0004rp-FN
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbcDFWMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:44 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33473 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbcDFWMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:41 -0400
Received: by mail-qg0-f42.google.com with SMTP id j35so48392892qge.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5a6tpwat6Ms2birTsUKqjt8T92X9blcwiRhLhFA2uZ0=;
        b=HRfVHQYSZeBi+obhkEnP2swIimQOsTb3O///qkFeuDvrFREu+kuIwSFCxpewAeeG4K
         nxVSCthBuTSLipEjGjU0c1sh7TAvxv9WqTYfMuPVcpYW/PlW+Uqb7Dgb/SWPXKseaLeW
         EkY3N4NbedJajj92sGcFxmc0J5SSYvfZBAkNBxZIEzAshvsNDc/Kq6eq968EyBFsI9DH
         N8MegFtM7YuakZyv/Qsv27IYzFP6meW+8UG5L4EafN4gIOzzUd5ZQK1MH0Mm53DfkwN4
         G7vYOsBI43FmVkhJpVA+7dAm4Hzjxd3IigtJJWX49WNWJwqjvCqbUsh4L1ydRNnbp7ad
         zxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5a6tpwat6Ms2birTsUKqjt8T92X9blcwiRhLhFA2uZ0=;
        b=dhcdcQ2XqbQcfdmAweO+KoD3VON9zOE5OadQftcB8A39EpvcsM9EKr4frcGjOhanNr
         pO1M5tb5StIMW5Thj/GLc4kTO2KcZRP3ETYX9oYadzxy7CsonVP/J2oQDoZh3PUhL1is
         81qHtcyk8jJUAn3X+d6uljx4bQAJAVyoy6PUfrn+Gqsxotz2++2CKILiVOsHLIQN7xED
         wAMHQcrIaJwrNBGDKUcfYQe1Yp+6b0Dr4lafc6/H+JDYf7DTIBi2jhmKc6T9oOGf16oS
         NeKEXOCxNLkpeDj1iVFsP5+t/49LdHqTGGgupQjm3AbP6tf7oZ5cvxcXYfA8jbI/uTex
         hS0w==
X-Gm-Message-State: AD7BkJLwJ6atSPipFFabFkvDw1hiUxRpojyMzhPB/NyfIGQSrDhjDiE/e+zL9M6XFbh4sQ==
X-Received: by 10.140.32.203 with SMTP id h69mr27822778qgh.55.1459980760076;
        Wed, 06 Apr 2016 15:12:40 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290877>

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
---
 Documentation/git-index-helper.txt |  9 +++++++
 cache.h                            |  1 +
 index-helper.c                     | 48 ++++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       |  9 ++++---
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index 61605e9..b177fb8 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -22,6 +22,15 @@ OPTIONS
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
 $GIT_DIR/index-helper.path is a symlink to a Unix domain socket in
diff --git a/cache.h b/cache.h
index 43fb314..4b678e9 100644
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
index 263b066..8288e30 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -15,6 +15,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
+static int to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -76,11 +77,56 @@ static void share_index(struct index_state *istate,=
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
@@ -249,6 +295,8 @@ int main(int argc, char **argv)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
 			    N_("exit if not used after some seconds")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 "verify shared memory after creating"),
 		OPT_END()
 	};
=20
diff --git a/read-cache.c b/read-cache.c
index 66f2874..7215a17 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1665,9 +1665,12 @@ int do_read_index(struct index_state *istate, co=
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
