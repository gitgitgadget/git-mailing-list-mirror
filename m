Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5327449B12
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811202; cv=none; b=fMnrEake1HHDezEZhgB9TDs1MdDO5eOGYxG8J8E3pie6vrnsJsPlxiltX5K755ueS6utnyp8oD3T9X5hvUVqfoZ/psafh1Njg53e1V2LjNRoG59rY7UPXrVI6CRBmHDgeOqyOzHbe+jJOnoEamlS7HxuEVcyTERuR7KKfgiibeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811202; c=relaxed/simple;
	bh=5WWBLuSi1nV0xnketXZO66GrzUe9jadoFky6dQRFFvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqyvhkm/Hxn0VUiaQRt14CzsGnhXYkNQBGz/nLOk2a5KBdITRpcYGMj0bVH0OQTC6WW+/14j4j9uLteIzy0U6E5HHvndHON1OX0LuKEgd0Q1wgw8QsO9BFEDe4fXhIz6iM7wjS5NJBxhXLJGI0wfuhinp4MkUkqRBzuj+J4W34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=027Esjo0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="027Esjo0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788811198;
	bh=5WWBLuSi1nV0xnketXZO66GrzUe9jadoFky6dQRFFvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=027Esjo0zvy0Z0JUauVq/FZ7zuPuakm5sosjWQkHPcb2K1GMrMrD8ro5dwUM1ShSr
	 pO7QuyD39ZNnCve6yiPVM4r0B4dAD0I5BvLTT+l3Plrl3/QQR6x9aCNBiZl3d+DGAi
	 HyoX9zd0muBUMw0EGAuNN2+HnXjIAt4W50VapV3Esrzjb7oj+PpxGMFcgOzSlublKT
	 d7HVz8SSLPRJGQ0J8PffiEFn4Ni093bpW76jRyt6F7fsBvXbf73m5M1+9gCu1qa/dg
	 ZZVZItuzwXEhPbsrdH8eXqxBOH/Lg1Wk2NuMVb/FPMROKwmgfv/e0ig1hqn/C9Aakb
	 tfAfknchUXodFX7OcIrMGKDlvasD3/GqPbD9at81hiTu1IyEYw5W1MYnLkhiQzeMHo
	 xMvqBl9WArovNltx/pWT4VYmVoejgxwybOhnedrm7zitQBg9HhFtVkhogFXlxD9bWM
	 LcrVtWZEuVDYdKU3VK1k05AoRgUls3tyLaRZGhTznA5WHMgeizE
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 25FFE201EB;
	Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/7] hex: make hex_to_bytes accept kind of hex to use
Date: Mon,  7 Sep 2026 19:59:36 +0000
Message-ID: <20260907195941.1024289-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260907195941.1024289-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260907195941.1024289-1-sandals@crustytoothpaste.net>
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
index 6b2a87e2d3..44ac72ef1e 100644
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
index 8f5a4e4644..3b7d22a824 100644
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
index b8f3faaed9..b5c5bad3db 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1031,12 +1031,13 @@ static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
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
index a4cbf8b081..892be4bbb2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1079,7 +1079,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		strbuf_add(path, de->d_name, namelen);
 		if (namelen == algop->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  algop->rawsz - 1)) {
+				  algop->rawsz - 1, HEX_KIND_MIXED)) {
 			oid_set_algo(&oid, algop);
 			memset(oid.hash + algop->rawsz, 0,
 			       GIT_MAX_RAWSZ - algop->rawsz);
