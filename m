Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CDC388F9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60664208C3
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFaEA3Mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgKWMBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgKWMBV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 07:01:21 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5BBC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 04:01:20 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so15749877wmd.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yl0DibPT5EHr46md/+zw42RlU85dWtLBJP27kxsVUH0=;
        b=BFaEA3MiMO0dv4w6pMae/lN4kOjGfUMEFc+reBvb0PmYkt7sSsYi4HY7XNatI0ZMBU
         hOYk2nXmUJ5j9Yll/TX6F89woA7DgbWq5G6MdzS2bz/PfBgIKLJIixrOjW06V1360lSd
         Xjbl2HvIvNhCdAq+2jK1glRZupxg/e20HPJcMcVEkN/oqrrLZ/lmCKuZvtiqKunvbXGO
         PD1EMZeb23ddq7L5bksacD4/3F0uz17N5R9LWmJDbD3AkJh+VJT3np9tymMFbzrj4dvf
         dDEbVqK4hTbialpkSdldxrBA3NQwz6VfRSs51h9knr0H0ufL1X1mRRQIaaDVfzSPZfu6
         DfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yl0DibPT5EHr46md/+zw42RlU85dWtLBJP27kxsVUH0=;
        b=T5cJEHLpo/QYb+u90qVxfB6h/3yWCWwyaf/Ezuq2Es17j+8TrLs+9z5zVsMPhc+69j
         JYnZcozVQbc5pq4RlFuJ5s8AiyceoypHqqvhZ2fGIJebjwbtXMSz+2MivdveOVl9qYUP
         G0yzTrvxx2iPzFAWSvRYFLtmDIKKuvV/DDyjY+ao1v+Uf+kVRTcDUCMhh+wolwFP0yhh
         8LkFgFQDhv+qcxl8dZyLTcODybq2korwNJ2lZnwBAIJKLmGgU9P6V8gKHXLk6jOdj6a2
         568Lz9ZWlyZyioyEDYu73+zCWZluZkFVIT5xuRTOVaPU1az0O45txlBK5G/Am0Pn5BNZ
         iaUg==
X-Gm-Message-State: AOAM530rcXE6w/vnWW6HgrpnVlg0GpFA+Z1gZpjd0Rvmxa78pKgZxQ4O
        upZwbATHBD6JuNbtqAPd7+GXFbMHGeOxCw==
X-Google-Smtp-Source: ABdhPJybzPxFJJogabxcW8dkvcZj+2x7RyuwAT+mWvZtUCZr6dMgNrSN6uU3k03F+jH3G8CsiujHIw==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr24004700wmb.34.1606132879004;
        Mon, 23 Nov 2020 04:01:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p19sm21248700wrg.18.2020.11.23.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 04:01:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] mktag: don't check SHA-1 object length under SHA-256
Date:   Mon, 23 Nov 2020 13:01:11 +0100
Message-Id: <20201123120111.13567-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20190826014344.16008-11-sandals@crustytoothpaste.net>
References: <20190826014344.16008-11-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hardcoded minimum tag length size to vary based on whether
we're operating in the SHA-1 or SHA-256 mode, and update the "mktag"
documentation, tests and code comments to reflect that this command
can take either SHA-1 or SHA-256 input.

Let's make the code more self-documenting by verbosely inlining what a
minimum tag looks like. The fixed-string strlen() will be optimized
away by any modern compiler. This also future-proofs us for any future
hash function transition.

Then change the tests amended in acb49d1cc8b (t3800: make hash-size
independent, 2019-08-18) even more for SHA-256. Some of the tests were
failing for the wrong reasons. E.g. yes <some sha-1 length garbage> is
an invalid SHA-1, but we should test <some sha256 length garbage> when
under SHA-256. For testing an invalid non-hexadecimal object ID let's
use ROT13.

For the "object line label check" test the "139e9b339..." SHA-1 didn't
exist, but what's actually being tested there is getting "xxxxxx"
instead of "object", so let's provide a valid SHA there
instead. There's no need to make or hardcode a nonexisting object ID.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt |  2 +-
 builtin/mktag.c             | 26 +++++++++++++-------
 t/t3800-mktag.sh            | 47 ++++++++++++++++++++++++++-----------
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index fa6a7561236..bbcc0a086bf 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -23,7 +23,7 @@ Tag Format
 A tag signature file, to be fed to this command's standard input,
 has a very simple fixed format: four lines of
 
-  object <sha1>
+  object <sha>
   type <typename>
   tag <tagname>
   tagger <tagger>
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4982d3a93ef..3fa17243e34 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -5,13 +5,15 @@
 
 /*
  * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
+ * of "object <sha>" + "type <typename>" + "tag <tagname>" +
  * "tagger <committer>", followed by a blank line, a free-form tag
  * message and a signature block that git itself doesn't care about,
  * but that can be verified with gpg or similar.
  *
- * The first four lines are guaranteed to be at least 83 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
+ * The first four lines are guaranteed to be either 83 or 107 bytes;
+ * depending on whether we're referencing a SHA-1 or SHA-256 tag.
+ *
+ * "object <sha1>\n" is 48 or a 72 bytes, "type tag\n" at 9 bytes is the
  * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
  * single-character-tag line, and "tagger . <> 0 +0000\n" at 20 bytes is
  * the shortest possible tagger-line.
@@ -46,9 +48,17 @@ static int verify_tag(char *buffer, unsigned long size)
 	struct object_id oid;
 	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
 	size_t len;
-
-	if (size < 84)
-		return error("wanna fool me ? you obviously got the size wrong !");
+	int minimum_size =
+		/* Minimum possible input, see t/t3800-mktag.sh */
+		strlen("object ") + the_hash_algo->hexsz + strlen("\n") +
+		strlen("type tag\n") +
+		strlen("tag x\n") +
+		strlen("tagger . <> 0 +0000\n") +
+		strlen("\n");
+
+	if (size < minimum_size)
+		return error("got %"PRIuMAX" bytes of input, need at least %d bytes",
+			     size, minimum_size);
 
 	buffer[size] = 0;
 
@@ -58,7 +68,7 @@ static int verify_tag(char *buffer, unsigned long size)
 		return error("char%d: does not start with \"object \"", 0);
 
 	if (parse_oid_hex(object + 7, &oid, &p))
-		return error("char%d: could not get SHA1 hash", 7);
+		return error("char%d: expected object ID, got garbage", 7);
 
 	/* Verify type line */
 	type_line = p + 1;
@@ -166,7 +176,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Verify it for some basic sanity: it needs to start with
-	   "object <sha1>\ntype\ntagger " */
+	   "object <sha>\ntype\ntagger " */
 	if (verify_tag(buf.buf, buf.len) < 0)
 		die("invalid tag signature file");
 
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index d696aa4e52e..93a19bb8df9 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -26,24 +26,42 @@ test_expect_success 'setup' '
 	echo Hello >A &&
 	git update-index --add A &&
 	git commit -m "Initial commit" &&
-	head=$(git rev-parse --verify HEAD)
+	head=$(git rev-parse --verify HEAD) &&
+
+	git tag -m"some tag" annotated &&
+	annotated=$(git rev-parse --verify annotated)
 '
 
 ############################################################
 #  1. length check
-
-cat >tag.sig <<EOF
-too short for a tag
-EOF
-
-check_verify_failure 'Tag object length check' \
-	'^error: .*size wrong.*$'
+for objType in t ta tag
+do
+	cat >tag.sig <<-EOF
+	object $annotated
+	type $objType
+	tag x
+	tagger . <> 0 +0000
+
+	EOF
+	len=$(wc -c tag.sig)
+
+	if test $objType = "tag"
+	then
+		test_expect_success "Tag object length check $len passed" '
+			git mktag <tag.sig >.git/refs/tags/x 2>message &&
+			git rev-parse refs/tags/x
+		'
+	else
+		check_verify_failure "Tag object length check on length $len" \
+			'^error: got .* bytes of input, need at least'
+	fi
+done
 
 ############################################################
 #  2. object line label check
 
 cat >tag.sig <<EOF
-xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
+xxxxxx $head
 type tag
 tag mytag
 tagger . <> 0 +0000
@@ -53,17 +71,18 @@ EOF
 check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
 
 ############################################################
-#  3. object line SHA1 check
+#  3. object line SHA check
 
+invalid_sha=$(echo $head | tr A-Za-z N-ZA-Mn-za-m)
 cat >tag.sig <<EOF
-object zz9e9b33986b1c2670fff52c5067603117b3e895
+object $invalid_sha
 type tag
 tag mytag
 tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1 hash$'
+check_verify_failure '"object" line object check' '^error: char7: .*expected object ID, got garbage'
 
 ############################################################
 #  4. type line label check
@@ -125,7 +144,7 @@ check_verify_failure '"type" line type-name length check' \
 	'^error: char.*: type too long$'
 
 ############################################################
-#  9. verify object (SHA1/type) check
+#  9. verify object (SHA/type) check
 
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
@@ -135,7 +154,7 @@ tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure 'verify object (SHA1/type) check' \
+check_verify_failure 'verify object (SHA/type) check' \
 	'^error: char7: could not verify object.*$'
 
 ############################################################
-- 
2.29.2.222.g5d2a92d10f8

