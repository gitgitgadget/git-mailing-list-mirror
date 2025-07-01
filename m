Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC726AAA9
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404965; cv=none; b=guoivc+Vn0OmwRrM+dls970vPBwwvnGygowTmZ25v9npZnj/3BMnIibs7P2VChmrzRfbeyTjWuBSMWQSIi/Akeo3x75DkPvvyeENwSMxMiTMIvTKl7RZWFP82Pzleobz0ofj03tQxRdaq47B8iK/kNYmScxsEiPJnfUiAmZa6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404965; c=relaxed/simple;
	bh=e6kqvw0oXcinN0KLbXxtqgTjSrDguuS0f2zP77esfVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEpHVPmrNJ82GiXnRLgKkc4otYCZfT6yMK6y4akyHrvRH2AADV9UG+KByXpAhvWsgpBGe7jvN+Y+O18UIMDihiYobHASvhncdOKL0AaEf/SGxdiXZj7G1Lqlp28ws85ShdbEyaywbOJlY9WAKDw5KljROAf9ianonrunLCygswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=etwHG+2N; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="etwHG+2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=e6kqvw0oXcinN0KLbXxtqgTjSrDguuS0f2zP77esfVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=etwHG+2NvOpOXebF+jnuOqo6c2fNyRmvZ30FMHWqw3qlxktiAf0xg39pyRe9ogzli
	 vidwZlI0KPA1WcSxVRRGwdU6NZUBmuINYslFUbvRHONs9rV768NSxDDx6anPFR8UcT
	 LsFX6qhQiD4l+LhixO/OxfDc3LUTyFzQj2SzC/Blran8PnlX/RH2lOasFuRGnkW+ZG
	 favU4sw4PB4B7pNOm+2sQkyT4RYOcbwuxVD6i4HcsgVkxO2Ge2Fi08mhjo0xSih4ns
	 faMnuAHBxoCmHZvg9Vg6w46AAVWRpCxyLUr42pZ+c3dMSqCujNossHdHngoASegLJ2
	 uspIetDtUK3aYEttG7NmIU6clZyzaGVy1bBAAcn03EAYZGsrvOO+wB0rzlSgIMhnZL
	 15+wqC1ig5VQeVYmdZn1ksXQRXpBY6gdDbhdiOyiKhKMH8rNUkOcKxRMYFNLemgTJE
	 9c0x2PWvyRgOKi9usSPoD2MvJNKMDmko69mgfQROsRLGC+ofCG/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5115520198;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 04/11] Use legacy hash for legacy formats
Date: Tue,  1 Jul 2025 21:22:30 +0000
Message-ID: <20250701212237.766774-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a large variety of data formats and protocols where no hash
algorithm was defined and the default was assumed to always be SHA-1.
Instead of explicitly stating SHA-1, let's use the constant to represent
the legacy hash algorithm (which is still SHA-1) so that it's clear
for documentary purposes that it's a legacy fallback option and not an
intentional choice to use SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 2 +-
 bundle.c               | 4 ++--
 connect.c              | 6 +++---
 fetch-pack.c           | 2 +-
 pkt-line.c             | 2 +-
 remote-curl.c          | 2 +-
 serve.c                | 2 +-
 setup.c                | 4 ++--
 transport.c            | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a317d6c278..24b33a3a5c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2136,7 +2136,7 @@ static struct command *read_head_info(struct packet_reader *reader,
 				use_push_options = 1;
 			hash = parse_feature_value(feature_list, "object-format", &len, NULL);
 			if (!hash) {
-				hash = hash_algos[GIT_HASH_SHA1].name;
+				hash = hash_algos[GIT_HASH_SHA1_LEGACY].name;
 				len = strlen(hash);
 			}
 			if (xstrncmpz(the_hash_algo->name, hash, len))
diff --git a/bundle.c b/bundle.c
index b0a3fee2ef..61e81bb0c3 100644
--- a/bundle.c
+++ b/bundle.c
@@ -95,7 +95,7 @@ int read_bundle_header_fd(int fd, struct bundle_header *header,
 	 * by an "object-format=" capability, which is being handled in
 	 * `parse_capability()`.
 	 */
-	header->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	header->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 
 	/* The bundle header ends with an empty line */
 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
@@ -507,7 +507,7 @@ int create_bundle(struct repository *r, const char *path,
 	 *    SHA1.
 	 * 2. @filter is required because we parsed an object filter.
 	 */
-	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] || revs.filter.choice)
+	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1_LEGACY] || revs.filter.choice)
 		min_version = 3;
 
 	if (argc > 1) {
diff --git a/connect.c b/connect.c
index 3280435331..e77287f426 100644
--- a/connect.c
+++ b/connect.c
@@ -251,7 +251,7 @@ static void process_capabilities(struct packet_reader *reader, size_t *linelen)
 			reader->hash_algo = &hash_algos[hash_algo];
 		free(hash_name);
 	} else {
-		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 	}
 }
 
@@ -500,7 +500,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 		reader->hash_algo = &hash_algos[hash_algo];
 		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
 	} else {
-		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 	}
 	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
 		char *reply = promisor_remote_reply(promisor_remote_info);
@@ -665,7 +665,7 @@ int server_supports_hash(const char *desired, int *feature_supported)
 	if (feature_supported)
 		*feature_supported = !!hash;
 	if (!hash) {
-		hash = hash_algos[GIT_HASH_SHA1].name;
+		hash = hash_algos[GIT_HASH_SHA1_LEGACY].name;
 		len = strlen(hash);
 	}
 	while (hash) {
diff --git a/fetch-pack.c b/fetch-pack.c
index fa4231fee7..95f66ffc1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1342,7 +1342,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);
 		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
-	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
 		die(_("the server does not support algorithm '%s'"),
 		    the_hash_algo->name);
 	}
diff --git a/pkt-line.c b/pkt-line.c
index a5bcbc96fb..fc583feb26 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -617,7 +617,7 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->buffer_size = sizeof(packet_buffer);
 	reader->options = options;
 	reader->me = "git";
-	reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 	strbuf_init(&reader->scratch, 0);
 }
 
diff --git a/remote-curl.c b/remote-curl.c
index b8bc3a80cf..84f4694780 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -285,7 +285,7 @@ static const struct git_hash_algo *detect_hash_algo(struct discovery *heads)
 	 * back to SHA1, which may or may not be correct.
 	 */
 	if (!p)
-		return &hash_algos[GIT_HASH_SHA1];
+		return &hash_algos[GIT_HASH_SHA1_LEGACY];
 
 	algo = hash_algo_by_length((p - heads->buf) / 2);
 	if (algo == GIT_HASH_UNKNOWN)
diff --git a/serve.c b/serve.c
index e3ccf1505c..53ecab3b42 100644
--- a/serve.c
+++ b/serve.c
@@ -14,7 +14,7 @@
 
 static int advertise_sid = -1;
 static int advertise_object_info = -1;
-static int client_hash_algo = GIT_HASH_SHA1;
+static int client_hash_algo = GIT_HASH_SHA1_LEGACY;
 
 static int always_advertise(struct repository *r UNUSED,
 			    struct strbuf *value UNUSED)
diff --git a/setup.c b/setup.c
index f93bd6a24a..3d2b3e745b 100644
--- a/setup.c
+++ b/setup.c
@@ -2222,11 +2222,11 @@ void initialize_repository_version(int hash_algo,
 	 * version will get adjusted by git-clone(1) once it has learned about
 	 * the remote repository's format.
 	 */
-	if (hash_algo != GIT_HASH_SHA1 ||
+	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
 	    ref_storage_format != REF_STORAGE_FORMAT_FILES)
 		target_version = GIT_REPO_VERSION_READ;
 
-	if (hash_algo != GIT_HASH_SHA1 && hash_algo != GIT_HASH_UNKNOWN)
+	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
 		git_config_set("extensions.objectformat",
 			       hash_algos[hash_algo].name);
 	else if (reinit)
diff --git a/transport.c b/transport.c
index 6c2801bcbd..c123ac1e38 100644
--- a/transport.c
+++ b/transport.c
@@ -1243,7 +1243,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 			ret->smart_options->receivepack = remote->receivepack;
 	}
 
-	ret->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	ret->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 
 	return ret;
 }
