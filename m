Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B4FE82CCE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjI0T4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjI0T4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D611D
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-76c64da0e46so425665239f.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844557; x=1696449357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CYL5/gskRTdwmKU9Ju2COcf8vtvsc9L64wzn6/3rx8=;
        b=mKzxPVn6seGfOiFPp5nP74wUpVs9MLednrS6IKs4db5BcPWgA8IFZm0rdNW9Do9tiL
         Qvv4OVpNzgbTqe4pEOYS7UOt4P1JOXfDhQWlIuTWzBa8bxBcQzmdbRJJB7kF2AnF3fub
         +wcEnpKlMJvtzvhH7UvvhJSOSfW4T5FZ1msWl6OMn+5484JGMcCayjEIaZUZNjeS/UDP
         SDfPluRgZ4vykdXK5yHt9/biF1GxdfnlOiH3ObhZwcOEcRtAN+0egwjW9mryOw5lh+Oy
         5OesYS6N692PFkZR2EJXbUo7PbaByCV/aXOLbnnnusHIT8TjEBako+Y69HX2wsVZyJwH
         mAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844557; x=1696449357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CYL5/gskRTdwmKU9Ju2COcf8vtvsc9L64wzn6/3rx8=;
        b=p8rsLurN6Lkl5Kxjo+XJArS5m6Qrrb8foJq8Rwp6fkJUFV4BMEs8Ze0dtIRwBTtkQ+
         Ggx/Xni/b25QuL4c//xYfOOkQvby7C5AL2YLX9EAf/EYeE/u7UCgrkJ+vYWj52ClR2nl
         8WIU8JQX5hPJhlpaf2eSz2yEJzIj2tIG9HMV8IgeQs08TfFAIj6Hsn+u5Q8FbssMnU3d
         tkWe5WQwVo/tIepFGPzmvchk+euxvSMbG3UVCy5AMvnhiy12BQm0EnoAofe49i9Sn3sq
         EC+VkPp6cBleE9gjpNko++c7Uw9tLp5K3z7yVKNYdFICtb2CIxGb5M45L/Wuetn30T50
         J6+w==
X-Gm-Message-State: AOJu0YwDBjBrkwHdg3U6vWTZNHGmhQ1b28Xr5m0GrwEH0G1r/XISKp4c
        G3sJGXRbd/b8vnhQIR/C5Uc=
X-Google-Smtp-Source: AGHT+IHBalTRn7XtdowhPfzvHOD5JK7EnA2Q+ro1xDfB4HL0VK7SRDU3+2PNhFXB+6X9WuVlQXtHSw==
X-Received: by 2002:a5e:8b0d:0:b0:79f:9b45:3365 with SMTP id g13-20020a5e8b0d000000b0079f9b453365mr2952851iok.17.1695844557583;
        Wed, 27 Sep 2023 12:55:57 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:57 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 09/30] commit: write commits for both hashes
Date:   Wed, 27 Sep 2023 14:55:16 -0500
Message-Id: <20230927195537.1682-9-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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
 commit.c | 179 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 134 insertions(+), 45 deletions(-)

diff --git a/commit.c b/commit.c
index b3223478bc2a..46696ede8981 100644
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
@@ -1599,70 +1598,160 @@ N_("Warning: commit message did not conform to UTF-8.\n"
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
+	strbuf_init(buffer, 8192); /* should avoid reallocs for the headers */
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
+	struct strbuf buffer, compat_buffer;
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
+
+	nparents = commit_list_count(parents);
+	parent_buf = xcalloc(nparents, sizeof(*parent_buf));
+	for (i = 0; i < nparents; i++) {
+		struct commit *parent = pop_commit(&parents);
+		oidcpy(&parent_buf[i], &parent->object.oid);
+	}
+
+	/* should avoid reallocs for the headers */
+	strbuf_init(&buffer, 8192);
+	strbuf_init(&compat_buffer, 8192);
 
-	if (sign_commit && sign_with_header(&buffer, sign_commit)) {
+	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
 		result = -1;
 		goto out;
 	}
+	if (r->compat_hash_algo) {
+		struct object_id mapped_tree;
+		struct object_id *mapped_parents = xcalloc(nparents, sizeof(*mapped_parents));
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
 
-	result = write_object_file(buffer.buf, buffer.len, OBJ_COMMIT, ret);
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
+
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
 	strbuf_release(&buffer);
+	strbuf_release(&compat_buffer);
+	strbuf_release(&sig);
+	strbuf_release(&compat_sig);
 	return result;
 }
 
-- 
2.41.0

