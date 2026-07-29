Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5033D1ABA
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367942; cv=none; b=o4mi3XFqioEScTeGnoUDjcHIgp9qfYhpgmuQgeqzQN1JyAKMolQhry0O9a5fxI4ZbczUTMvHRNC+E/SfcvoH4na5cUsusAQqURZoGnvpCUblP4FNDw6QB+FYAGOdZVlRJhOHgXX5ZXdRJz2DnQFFqUm+YJaIqiL/qPsEhgj1FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367942; c=relaxed/simple;
	bh=XIus+dzl/cu3bvPcfXKmofZYKKEyqNlMSF9teWmEkWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdK5NpfNhIfrxOzLyruXDEfaAVhny/kdoosF6AUhP1bZgVSzuTRXeNEbc/jCWO7RSY2/vlV4SHS5nAcwVaXl3SDmtlS6Zh0pCc5UjJgZcsyLRFAE2NTgiGiTLlTXRGGGzYcMyceMCo4ECkfGmogsd4FDJDkar4nITkSY5IY0RxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Lbx/qwrX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Lbx/qwrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785367938;
	bh=XIus+dzl/cu3bvPcfXKmofZYKKEyqNlMSF9teWmEkWM=;
	h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
	 Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
	 References:Content-Type:Content-Disposition;
	b=Lbx/qwrXPTyR4req8bTwcZk05ylI6LfP/Bdnn/arB6DeIh0ZefCMX4RQMQ+nhcGgU
	 zXsx43wiiznLeB9NIc/0uy+eLwsAkbR3JQEZTM/ttwc6/9EDQqt0xbf+oJVV6Gq906
	 Mw3gA0HkUHgkgZ8Sdhlo+38YVp5L2WgdRKsteM/XYFD7ChzgwXlgSdRuNY7Sk5Kv5+
	 ZLMCNg66I4M7x0Q3ob4UaAqLEOBuOlEJrVFBj69fVKDbsXlFu5StXjcUsDL0sHM9SZ
	 LyCW5YcxK94vjJrmHccRAHGp3EeC7fpHdYBoMo98NP3gjoCGCCU+G1E1GMJj5CVg/G
	 X/T5JuwefJhgMnTZ691nBUPR2awnVkz0KIUFUN6AIr+21UEWVnuAmKWwqMIQ/JPEpm
	 aheFqOLIVEDdajjgH/YD5aelV6Pywid6rDVIwIhUqIZDbUd+3ugk1qqkAJeWmVnjan
	 6l4L0tSbvDCiozLHMTwOknStckVLkzLjGAd9PDNpKycPBdrk3/b
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c292:4852:9051:fdce])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A4531201E2
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:18 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Subject: [RFC PATCH 3/6] hex: make hex_to_bytes accept kind of hex to use
Date: Wed, 29 Jul 2026 23:32:12 +0000
Message-ID: <20260729233215.398654-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260729233215.398654-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to the previous commit, introduce an option for hex_to_bytes
to allow us to specify the kind of hex to use: lowercase only or not.
For now, everything remains the same as before, but we will change
things in a future commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 2 +-
 diagnose.c           | 2 +-
 hex-ll.c             | 4 ++--
 hex-ll.h             | 2 +-
 http-push.c          | 5 +++--
 notes.c              | 5 +++--
 object-file.c        | 2 +-
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bc86925ad0..9660e5967b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1866,7 +1866,7 @@ static void repack_local_links(void)
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		unsigned char binary[GIT_MAX_RAWSZ];
 		if (line.len != the_hash_algo->hexsz ||
-		    !hex_to_bytes(binary, line.buf, line.len))
+		    !hex_to_bytes(binary, line.buf, line.len, HEX_KIND_MIXED))
 			die(_("index-pack: Expecting full hex object ID lines only from pack-objects."));
 
 		/*
diff --git a/diagnose.c b/diagnose.c
index 5092bf80d3..fc11cea229 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -112,7 +112,7 @@ static void loose_objs_stats(struct strbuf *buf, const char *path)
 	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL)
 		if (get_dtype(e, &count_path, 0) == DT_DIR &&
 		    strlen(e->d_name) == 2 &&
-		    !hex_to_bytes(&c, e->d_name, 1)) {
+		    !hex_to_bytes(&c, e->d_name, 1, HEX_KIND_MIXED)) {
 			strbuf_setlen(&count_path, base_path_len);
 			strbuf_addf(&count_path, "%s/", e->d_name);
 			total += (count = count_files(&count_path));
diff --git a/hex-ll.c b/hex-ll.c
index fa85e91827..b2e9684693 100644
--- a/hex-ll.c
+++ b/hex-ll.c
@@ -71,10 +71,10 @@ const signed char hexval_lc_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
 };
 
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len, enum hexkind kind)
 {
 	for (; len; len--, hex += 2) {
-		unsigned int val = (hexval(hex[0], HEX_KIND_MIXED) << 4) | hexval(hex[1], HEX_KIND_MIXED);
+		unsigned int val = (hexval(hex[0], kind) << 4) | hexval(hex[1], kind);
 
 		if (val & ~0xff)
 			return -1;
diff --git a/hex-ll.h b/hex-ll.h
index 26847c7b2f..fe698f0c76 100644
--- a/hex-ll.h
+++ b/hex-ll.h
@@ -28,6 +28,6 @@ static inline int hex2chr(const char *s, enum hexkind kind)
  * values to `binary` as `len` bytes. Return 0 on success, or -1 if
  * the input does not consist of hex digits).
  */
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len, enum hexkind kind);
 
 #endif
diff --git a/http-push.c b/http-push.c
index 94a1fac9ab..0cc990d395 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1030,12 +1030,13 @@ static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 	if (strlen(path) != the_hash_algo->hexsz + 1)
 		return -1;
 
-	if (hex_to_bytes(oid->hash, path, 1))
+	if (hex_to_bytes(oid->hash, path, 1, HEX_KIND_MIXED))
 		return -1;
 	path += 2;
 	path++; /* skip '/' */
 
-	return hex_to_bytes(oid->hash + 1, path, the_hash_algo->rawsz - 1);
+	return hex_to_bytes(oid->hash + 1, path, the_hash_algo->rawsz - 1,
+			    HEX_KIND_MIXED);
 }
 
 static void process_ls_object(struct remote_ls_ctx *ls)
diff --git a/notes.c b/notes.c
index ec9c2cb150..99b8b15d81 100644
--- a/notes.c
+++ b/notes.c
@@ -428,7 +428,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				goto handle_non_note;
 
 			if (hex_to_bytes(object_oid.hash + prefix_len, entry.path,
-					 hashsz - prefix_len))
+					 hashsz - prefix_len, HEX_KIND_MIXED))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			memset(object_oid.hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
@@ -442,7 +442,8 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				/* internal nodes must be trees */
 				goto handle_non_note;
 
-			if (hex_to_bytes(object_oid.hash + len++, entry.path, 1))
+			if (hex_to_bytes(object_oid.hash + len++, entry.path, 1,
+					 HEX_KIND_MIXED))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			/*
diff --git a/object-file.c b/object-file.c
index 7ff2b730ac..8427b2802a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1473,7 +1473,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		strbuf_add(path, de->d_name, namelen);
 		if (namelen == algop->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  algop->rawsz - 1)) {
+				  algop->rawsz - 1, HEX_KIND_MIXED)) {
 			oid_set_algo(&oid, algop);
 			memset(oid.hash + algop->rawsz, 0,
 			       GIT_MAX_RAWSZ - algop->rawsz);
