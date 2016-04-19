From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 04/15] index-helper: add --strict
Date: Tue, 19 Apr 2016 19:27:58 -0400
Message-ID: <1461108489-29376-5-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4E-0008Bb-6S
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbcDSX2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:23 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32944 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbcDSX2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:20 -0400
Received: by mail-qk0-f171.google.com with SMTP id n63so9700786qkf.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFfwBM/+eSeBEYx2haw6lHboGWTvehIHdSIqK07VCPA=;
        b=ppenprElhCTxy4MkJ3Ua06pk3rYpveNs9J9u9hZQn6k+nI2GRqxNPnPDzGgZob5ToI
         CA/a8vsKmzdhMkNgrt7mOgsN1OZGL79qP3JbHoxltAZ5lZkk1qKtwaVmmpHZIpZxA4AW
         2+BrivQYAM8W98WL9Q34g8twG4p8njjuV2MoBkbaUiyOx31iZrYnYwASkXWzA38aYQXv
         2W7pAlN3u9DNnghEmirMFGxb7TvLeA0PbMDR1PDTQSLmaqXobblv8bjYvEC2UGbu96VM
         P15buj6nVmJWFO1FrjuHGduV6YJs7xupP7Uw7kEI6egsgn61Lu0a/WrUr3guykz/yUj+
         7Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFfwBM/+eSeBEYx2haw6lHboGWTvehIHdSIqK07VCPA=;
        b=Mxja5rstRf4ikM0fuRbU9UjEU7P6th1lO1jj07OcoNqUt6SwqjTU5LBIcPFgvcm/7E
         pRnjr+LO3kPtfWlc/jg/WUgplepES23sTBqQCAUKmcM8XyxWBV4RePdecEtG4BueZcYl
         uYY/4w5GZOXufwQIUjbp9rpQB+R+NH290TOPNei3DlzeCEv7xyVmMAaeyCQ5QXvZO5kb
         7KvygWg0WwqhFLk2rIIoZODfChNZRhofY9JePbmV4AElu30Xt8MzXg26AZ+KXmdjisIj
         t3PknMAw0cQFuo/zw/RVt+j+fkA01sRifrmX/s9Ay947dPBJPEHK0KVKqiiwSbrsy5/P
         3mQA==
X-Gm-Message-State: AOPr4FWJzywziL4DqSl2/XCfGWQx3tJvaVx7D0vPE+0VKvyMdvg5I0QPXV6WlK11+8JDVA==
X-Received: by 10.55.71.143 with SMTP id u137mr7433135qka.1.1461108499367;
        Tue, 19 Apr 2016 16:28:19 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291953>

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
index 77687c0..a5c058f 100644
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
=20
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
index d64e49b..e8d6b64 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -16,6 +16,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
+static int to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -110,11 +111,56 @@ static void share_index(struct index_state *istat=
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
@@ -246,6 +292,8 @@ int main(int argc, char **argv)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
 			    N_("exit if not used after some seconds")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 "verify shared memory after creating"),
 		OPT_END()
 	};
=20
diff --git a/read-cache.c b/read-cache.c
index af2101f..5df5b21 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1669,9 +1669,12 @@ int do_read_index(struct index_state *istate, co=
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
