Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAF3E784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjJBClB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjJBCkw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:52 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0BEA
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79f82b26abfso562690339f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214447; x=1696819247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2VdQLCgD1g/wvu2D1A7qPZvOJZIRNkq1Ece2NrTAfo=;
        b=dN0K5QOwbV9/DJJiYGdZFKiIvxKc/aidx9Leva7VS3vkyvYXLSM6bcZbe6XS57ErHO
         mxPfvMzDy74ei35f8zG96j4y+pC9rLGYr01b8bbjoxJbdCNlEDDGxoD6he74a+shRj7T
         M/MhFi53k7M4jiQeo6WB35Sid3Xni7zUYw9vSnvWbD3QagF1Lq4NSiBOY53XdAW252gm
         3MXXUT0NqHJgNe2sXY5AaU7WyQtTPQFPa6LY1wsr1eP+0LZ3kxrQsziqV0Hf1JPS5oQv
         wlle8y72SRpsxhhTtKS3gwg/WLBfkFHO240yY1GCUft0AUIJ5r9Ypk2h1T6fk4ViY1Qn
         4jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214447; x=1696819247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2VdQLCgD1g/wvu2D1A7qPZvOJZIRNkq1Ece2NrTAfo=;
        b=K9zYdacgdFGGcHnxiPQBL7XmnKdYh1x4eJeT7tkggj6CDEZCmFhBwzxiPXD0Iy0+kB
         13lZiEZAHl7zx+4AvB0D2KU4TSR1h51kbHLz1jYgcFrkLD5G2sn8MVAnxx816WN4BFOy
         mTMLdVA5J5ahBVLcWkxnelNaghtKBlAAJljEPkT3bhTFKZ8HTay3FlzA4YsnF1NnUhGT
         eGlDWZo4aAJT0McwwbX4YufAxq3LbHBh/Fhhy5u1hZZHja4nNYQBQO54sbr4yWPm7Q3v
         B8YaW2rCygT6z8XRumMo32StIlc9DleGClfDe4oJTggAb6u7Rvr0fjJAnNfMfHrxFiSE
         XRyw==
X-Gm-Message-State: AOJu0YwJHxmWuUUa7msdH0rRHMgfvqUH6gN8JnOJa+fIsPbzFDSg9Omd
        JTDcYQlzty61xF7/3qpTbPMsvvlRYGBwpg==
X-Google-Smtp-Source: AGHT+IEBv/rcTUED8hHzml1oxYGtqJIHj9rgEpZKf+ohDzkQ0+8Fmlx4t+i+wBxixSODTxRtYEzhoA==
X-Received: by 2002:a6b:651a:0:b0:798:26fb:ff2 with SMTP id z26-20020a6b651a000000b0079826fb0ff2mr12088341iob.10.1696214447603;
        Sun, 01 Oct 2023 19:40:47 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:47 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 09/30] commit: write commits for both hashes
Date:   Sun,  1 Oct 2023 21:40:13 -0500
Message-Id: <20231002024034.2611-9-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

When we write a commit, we include data that is specific to the hash
algorithm, such as parents and the root tree.  In order to write both a
SHA-1 commit and a SHA-256 version, we need to convert between them.

However, a straightforward conversion isn't necessarily what we want.
When we sign a commit, we sign its data, so if we create a commit for
SHA-256 and then write a SHA-1 version, we'll still have only signed the
SHA-256 data.  While this is valid, it would be better to sign both
forms of data so people using SHA-1 can verify the signatures as well.

Consequently, we don't want to use the standard mapping that occurs when
we write an object.  Instead, let's move most of the writing of the
commit into a separate function which is agnostic of the hash algorithm
and which simply writes into a buffer and specify both versions of the
object ourselves.

We can then call this function twice: once with the SHA-256 contents,
and if SHA-1 is enabled, once with the SHA-1 contents.  If we're signing
the commit, we then sign both versions and append both signatures to
both buffers.  To produce a consistent hash, we always append the
signatures in the order in which Git implemented them: first SHA-1, then
SHA-256.

In order to make this signing code work, we split the commit signing
code into two functions, one which signs the buffer, and one which
appends the signature.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 commit.c | 181 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 136 insertions(+), 45 deletions(-)

diff --git a/commit.c b/commit.c
index b3223478bc2a..6765f3a82b9d 100644
--- a/commit.c
+++ b/commit.c
@@ -28,6 +28,7 @@
 #include "shallow.h"
 #include "tree.h"
 #include "hook.h"
+#include "object-file-convert.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1100,12 +1101,11 @@ static const char *gpg_sig_headers[] = {
 	"gpgsig-sha256",
 };
 
-int sign_with_header(struct strbuf *buf, const char *keyid)
+static int add_commit_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
 {
-	struct strbuf sig = STRBUF_INIT;
 	int inspos, copypos;
 	const char *eoh;
-	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(the_hash_algo)];
+	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(algo)];
 	int gpg_sig_header_len = strlen(gpg_sig_header);
 
 	/* find the end of the header */
@@ -1115,15 +1115,8 @@ int sign_with_header(struct strbuf *buf, const char *keyid)
 	else
 		inspos = eoh - buf->buf + 1;
 
-	if (!keyid || !*keyid)
-		keyid = get_signing_key();
-	if (sign_buffer(buf, &sig, keyid)) {
-		strbuf_release(&sig);
-		return -1;
-	}
-
-	for (copypos = 0; sig.buf[copypos]; ) {
-		const char *bol = sig.buf + copypos;
+	for (copypos = 0; sig->buf[copypos]; ) {
+		const char *bol = sig->buf + copypos;
 		const char *eol = strchrnul(bol, '\n');
 		int len = (eol - bol) + !!*eol;
 
@@ -1136,11 +1129,17 @@ int sign_with_header(struct strbuf *buf, const char *keyid)
 		inspos += len;
 		copypos += len;
 	}
-	strbuf_release(&sig);
 	return 0;
 }
 
-
+static int sign_commit_to_strbuf(struct strbuf *sig, struct strbuf *buf, const char *keyid)
+{
+	if (!keyid || !*keyid)
+		keyid = get_signing_key();
+	if (sign_buffer(buf, sig, keyid))
+		return -1;
+	return 0;
+}
 
 int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature,
@@ -1599,70 +1598,162 @@ N_("Warning: commit message did not conform to UTF-8.\n"
    "You may want to amend it after fixing the message, or set the config\n"
    "variable i18n.commitEncoding to the encoding your project uses.\n");
 
-int commit_tree_extended(const char *msg, size_t msg_len,
-			 const struct object_id *tree,
-			 struct commit_list *parents, struct object_id *ret,
-			 const char *author, const char *committer,
-			 const char *sign_commit,
-			 struct commit_extra_header *extra)
+static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg_len,
+			      const struct object_id *tree,
+			      const struct object_id *parents, size_t parents_len,
+			      const char *author, const char *committer,
+			      struct commit_extra_header *extra)
 {
-	int result;
 	int encoding_is_utf8;
-	struct strbuf buffer;
-
-	assert_oid_type(tree, OBJ_TREE);
-
-	if (memchr(msg, '\0', msg_len))
-		return error("a NUL byte in commit log message not allowed.");
+	size_t i;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
-	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
-	strbuf_addf(&buffer, "tree %s\n", oid_to_hex(tree));
+	strbuf_grow(buffer, 8192); /* should avoid reallocs for the headers */
+	strbuf_addf(buffer, "tree %s\n", oid_to_hex(tree));
 
 	/*
 	 * NOTE! This ordering means that the same exact tree merged with a
 	 * different order of parents will be a _different_ changeset even
 	 * if everything else stays the same.
 	 */
-	while (parents) {
-		struct commit *parent = pop_commit(&parents);
-		strbuf_addf(&buffer, "parent %s\n",
-			    oid_to_hex(&parent->object.oid));
-	}
+	for (i = 0; i < parents_len; i++)
+		strbuf_addf(buffer, "parent %s\n", oid_to_hex(&parents[i]));
 
 	/* Person/date information */
 	if (!author)
 		author = git_author_info(IDENT_STRICT);
-	strbuf_addf(&buffer, "author %s\n", author);
+	strbuf_addf(buffer, "author %s\n", author);
 	if (!committer)
 		committer = git_committer_info(IDENT_STRICT);
-	strbuf_addf(&buffer, "committer %s\n", committer);
+	strbuf_addf(buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
-		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+		strbuf_addf(buffer, "encoding %s\n", git_commit_encoding);
 
 	while (extra) {
-		add_extra_header(&buffer, extra);
+		add_extra_header(buffer, extra);
 		extra = extra->next;
 	}
-	strbuf_addch(&buffer, '\n');
+	strbuf_addch(buffer, '\n');
 
 	/* And add the comment */
-	strbuf_add(&buffer, msg, msg_len);
+	strbuf_add(buffer, msg, msg_len);
+}
 
-	/* And check the encoding */
-	if (encoding_is_utf8 && !verify_utf8(&buffer))
-		fprintf(stderr, _(commit_utf8_warn));
+int commit_tree_extended(const char *msg, size_t msg_len,
+			 const struct object_id *tree,
+			 struct commit_list *parents, struct object_id *ret,
+			 const char *author, const char *committer,
+			 const char *sign_commit,
+			 struct commit_extra_header *extra)
+{
+	struct repository *r = the_repository;
+	int result = 0;
+	int encoding_is_utf8;
+	struct strbuf buffer = STRBUF_INIT, compat_buffer = STRBUF_INIT;
+	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
+	struct object_id *parent_buf = NULL, *compat_oid = NULL;
+	struct object_id compat_oid_buf;
+	size_t i, nparents;
+
+	/* Not having i18n.commitencoding is the same as having utf-8 */
+	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+
+	assert_oid_type(tree, OBJ_TREE);
+
+	if (memchr(msg, '\0', msg_len))
+		return error("a NUL byte in commit log message not allowed.");
 
-	if (sign_commit && sign_with_header(&buffer, sign_commit)) {
+	nparents = commit_list_count(parents);
+	CALLOC_ARRAY(parent_buf, nparents);
+	i = 0;
+	while (parents) {
+		struct commit *parent = pop_commit(&parents);
+		oidcpy(&parent_buf[i++], &parent->object.oid);
+	}
+
+	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
 		result = -1;
 		goto out;
 	}
+	if (r->compat_hash_algo) {
+		struct object_id mapped_tree;
+		struct object_id *mapped_parents;
+
+		CALLOC_ARRAY(mapped_parents, nparents);
+
+		if (repo_oid_to_algop(r, tree, r->compat_hash_algo, &mapped_tree)) {
+			result = -1;
+			free(mapped_parents);
+			goto out;
+		}
+		for (i = 0; i < nparents; i++)
+			if (repo_oid_to_algop(r, &parent_buf[i], r->compat_hash_algo, &mapped_parents[i])) {
+				result = -1;
+				free(mapped_parents);
+				goto out;
+			}
+		write_commit_tree(&compat_buffer, msg, msg_len, &mapped_tree,
+				  mapped_parents, nparents, author, committer, extra);
+		free(mapped_parents);
+
+		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
+			result = -1;
+			goto out;
+		}
+	}
+
+	if (sign_commit) {
+		struct sig_pairs {
+			struct strbuf *sig;
+			const struct git_hash_algo *algo;
+		} bufs [2] = {
+			{ &compat_sig, r->compat_hash_algo },
+			{ &sig, r->hash_algo },
+		};
+		int i;
+
+		/*
+		 * We write algorithms in the order they were implemented in
+		 * Git to produce a stable hash when multiple algorithms are
+		 * used.
+		 */
+		if (r->compat_hash_algo && hash_algo_by_ptr(bufs[0].algo) > hash_algo_by_ptr(bufs[1].algo))
+			SWAP(bufs[0], bufs[1]);
+
+		/*
+		 * We traverse each algorithm in order, and apply the signature
+		 * to each buffer.
+		 */
+		for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+			if (!bufs[i].algo)
+				continue;
+			add_commit_signature(&buffer, bufs[i].sig, bufs[i].algo);
+			if (r->compat_hash_algo)
+				add_commit_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
+		}
+	}
 
-	result = write_object_file(buffer.buf, buffer.len, OBJ_COMMIT, ret);
+	/* And check the encoding. */
+	if (encoding_is_utf8 && (!verify_utf8(&buffer) || !verify_utf8(&compat_buffer)))
+		fprintf(stderr, _(commit_utf8_warn));
+
+	if (r->compat_hash_algo) {
+		hash_object_file(r->compat_hash_algo, compat_buffer.buf, compat_buffer.len,
+			OBJ_COMMIT, &compat_oid_buf);
+		compat_oid = &compat_oid_buf;
+	}
+
+	result = write_object_file_flags(buffer.buf, buffer.len, OBJ_COMMIT,
+					 ret, compat_oid, 0);
 out:
+	free(parent_buf);
 	strbuf_release(&buffer);
+	strbuf_release(&compat_buffer);
+	strbuf_release(&sig);
+	strbuf_release(&compat_sig);
 	return result;
 }
 
-- 
2.41.0

