Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B51BC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1387E613D0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhDTNBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhDTNBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D6C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so33801128wrt.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgpIewiNJqsQihOIOhvRifQ+LRIesJ7Toi14n/mINmE=;
        b=kyLAKvAukdaJH9WZp3Q94xOJK6wG/DtG/mz88JSsHCWGppewLqP4d+J4v7yUK45+9+
         OcrruernZAB+p5vZZ5GUyAY2o5pqs3fZIUcw+Pz17KnkwekqbIeIqdkohybNA+minKzw
         pHa0bZhJefYEOXwr1xg5uNFC5Irk+sAUc/YZ5yh1R2yzKbBbuE5KGSc0AdnIceOBvFD+
         0mlkfKtsgOJrvn7mrPm5W7IRE8iTHbW1Ba7hlRPxoev7DSIwfVjiaCTAZOXrsN47PaJW
         8kAnbjjjt8TSfpZfXshsvpjumdg0KyRnSZzl41V90KX/JjOmys0i1TPK4vljEtDcgHvT
         M2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgpIewiNJqsQihOIOhvRifQ+LRIesJ7Toi14n/mINmE=;
        b=UE52GiZBiCJXMKwwhirx6s7wPp5ZO3m0QEVW/dW7M//Tsp1Mc8h0CSP4b4D8zwxLRJ
         Y2PNcAtxE5MBJIQVfd++y0g3coxYl+w93BCMcpHhCqU7ylhoCICu+6Fl3DRIiQQBwRs+
         R0Tld8qzFt4IoFIoC0L/Tu0dmRzrvG4QI1z2IFrpj4MPIw80jTUwl+lMYuV5tWA4DvP5
         o7eqvdfGrsOngkgOCVHvCcG6zbXFiYgXxC06hpSUKeEUNnj2aE52QSqJB0mONpGeoShh
         Pq7hnRswXi0Dql7FkXVzGIXyhq4sMhxBJm5XgYbXnRIhJHL3mUAFZBnngJIM5XNoDY9Y
         SLGA==
X-Gm-Message-State: AOAM5327l8FOR7q9uF6WBAP2NPIH673+jhuHZ2aGmfpsKcdkVLBDqunA
        1ehvODQyxXYSLfHIxoALIL36JdbT44qVKA==
X-Google-Smtp-Source: ABdhPJy2llF+zV9otHE0wdQQ8QQ+FWIuPDQAPM1QL8q1dL8LAueHrgQUoYZNTKZPeTeDTAHQkQRlyA==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr21076999wrn.53.1618923636035;
        Tue, 20 Apr 2021 06:00:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] hash-object: show usage on invalid --type
Date:   Tue, 20 Apr 2021 15:00:15 +0200
Message-Id: <patch-09.10-eaa1b8f44c-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the error displayed on "hash-object -t bogus" (without
--literally) to show the usage_with_options(), like we do for the
other usage errors.

As noted in a preceding commit it makes sense to pass the "len" down
to the object.c code, so now that we're using
type_from_string_gently() let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/hash-object.c  | 44 ++++++++++++++++++++++++++++--------------
 t/t1007-hash-object.sh | 10 ++++++----
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 4b337e0d25..705521bc7f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -31,8 +31,9 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	return ret;
 }
 
-static void hash_fd(int fd, const char *type, size_t type_len,
-		    const char *path, unsigned flags, int literally)
+static void hash_fd(int fd, enum object_type otype, const char *type,
+		    size_t type_len, const char *path, unsigned flags,
+		    int literally)
 {
 	struct stat st;
 	struct object_id oid;
@@ -40,8 +41,8 @@ static void hash_fd(int fd, const char *type, size_t type_len,
 	if (fstat(fd, &st) < 0 ||
 	    (literally
 	     ? hash_literally(&oid, fd, type, flags)
-	     : index_fd(the_repository->index, &oid, fd, &st,
-			type_from_string(type), path, flags)))
+	     : index_fd(the_repository->index, &oid, fd, &st, otype, path,
+			flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
@@ -49,17 +50,19 @@ static void hash_fd(int fd, const char *type, size_t type_len,
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
-static void hash_object(const char *path, const char *type, size_t type_len,
+static void hash_object(const char *path, enum object_type otype,
+			const char *type, size_t type_len,
 			const char *vpath, unsigned flags, int literally)
 {
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die_errno("Cannot open '%s'", path);
-	hash_fd(fd, type, type_len, vpath, flags, literally);
+	hash_fd(fd, otype, type, type_len, vpath, flags, literally);
 }
 
-static void hash_stdin_paths(const char *type, size_t type_len, int no_filters,
+static void hash_stdin_paths(enum object_type otype, const char *type,
+			     size_t type_len, int no_filters,
 			     unsigned flags, int literally)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -74,7 +77,7 @@ static void hash_stdin_paths(const char *type, size_t type_len, int no_filters,
 			strbuf_swap(&buf, &unquoted);
 		}
 		vpath = no_filters ? NULL : buf.buf;
-		hash_object(buf.buf, type, type_len, vpath , flags, literally);
+		hash_object(buf.buf, otype, type, type_len, vpath , flags, literally);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&unquoted);
@@ -89,6 +92,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	};
 	const char *type = blob_type;
 	size_t type_len;
+	enum object_type otype = OBJ_BAD;
 	int hashstdin = 0;
 	int stdin_paths = 0;
 	int no_filters = 0;
@@ -109,6 +113,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	};
 	int i;
 	const char *errstr = NULL;
+	int errstr_arg_type = 0;
 
 	argc = parse_options(argc, argv, prefix, hash_object_options,
 			     hash_object_usage, 0);
@@ -123,7 +128,12 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	if (stdin_paths) {
+	type_len = strlen(type);
+	otype = type_from_string_gently(type, type_len);
+	if (otype < 0 && !literally) {
+		errstr = "the object type \"%.*s\" is invalid, did you mean to use --literally?";
+		errstr_arg_type = 1;
+	} else if (stdin_paths) {
 		if (hashstdin)
 			errstr = "Can't use --stdin-paths with --stdin";
 		else if (argc)
@@ -137,27 +147,31 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	}
 
 	if (errstr) {
-		error("%s", errstr);
+		if (errstr_arg_type)
+			error(errstr, (int)type_len, type);
+		else
+			error("%s", errstr);
 		usage_with_options(hash_object_usage, hash_object_options);
 	}
 
-	type_len = strlen(type);
 	if (hashstdin)
-		hash_fd(0, type, type_len, vpath, flags, literally);
+		hash_fd(0, otype, type, type_len, vpath, flags, literally);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
 		char *to_free = NULL;
+		const char *tmp;
 
 		if (prefix)
 			arg = to_free = prefix_filename(prefix, arg);
-		hash_object(arg, type, type_len, no_filters ? NULL : vpath ? vpath : arg,
-			    flags, literally);
+		tmp = no_filters ? NULL : vpath ? vpath : arg;
+		hash_object(arg, otype, type, type_len, tmp, flags, literally);
 		free(to_free);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, type_len, no_filters, flags, literally);
+		hash_stdin_paths(otype, type, type_len, no_filters, flags,
+				 literally);
 
 	return 0;
 }
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 74486f6f1a..cb1517bd90 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -230,17 +230,19 @@ test_expect_success 'corrupt tag' '
 '
 
 test_expect_success 'hash-object complains about bogus type name' '
-	test_must_fail git hash-object -t bogus --stdin 2>actual </dev/null &&
+	test_expect_code 129 git hash-object -t bogus --stdin 2>err </dev/null &&
+	grep ^error err >actual &&
 	cat >expect <<-\EOF &&
-	fatal: invalid object type "bogus"
+	error: the object type "bogus" is invalid, did you mean to use --literally?
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'hash-object complains about truncated type name' '
-	test_must_fail git hash-object -t bl --stdin 2>actual </dev/null &&
+	test_expect_code 129 git hash-object -t bl --stdin 2>err </dev/null &&
+	grep ^error err >actual &&
 	cat >expect <<-\EOF &&
-	fatal: invalid object type "bl"
+	error: the object type "bl" is invalid, did you mean to use --literally?
 	EOF
 	test_cmp expect actual
 '
-- 
2.31.1.723.ga5d7868e4a

