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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E8AC56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FF8216C4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2KD/HWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgKZB3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbgKZB3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:15 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD32C061A52
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:14 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so486885wmg.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVKyRnsXPjyW72TxMP0IT7PzzwJNWjf+o6NrECnfcG8=;
        b=m2KD/HWfJmewuElJu1sG2c5wf6jlq8zvBpNIFk3EjLwOXJxn0wRbbZKemZExuOtoXE
         ZquoOCXaaPxSgko7FWyUQ7/bciQvJyUXcjhXa63jQDydKWvljfumhX1/MbRsZ8/l+N4K
         f+QnGwct6CbYERwftx1xyb0xSmeUpXL2ZYq4m+L5k5g4XweiSOCbRqZXAwDYZhn6JA8S
         FA4OXCa/A0fLeGSqHIeqyC0H8u+uaVkGib2VeNdTuwGIiq0pf/KJoFWTTIju7pSuAKoC
         JZiS1ZT68gr5Fom9t2d/6jFLUJKXf1VOeBQmPnSmRdvQ15OYHmVH7AVCrM9S/9NuURbp
         NZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVKyRnsXPjyW72TxMP0IT7PzzwJNWjf+o6NrECnfcG8=;
        b=buRgnjfUsnVj78mnCc897UchvQWhbrhZZYonu0QXTtnokdJuXzhwL86nLNKp31lscV
         nD4W7qaB8Cvx6dZQZEVCQtn/9TtdOptP2PFj9VZo3e6msgMzOXa28bb6L1Epu0kmVbBR
         VqbrubMbrJvePpqqythxFl/QKSwmII+Dj6xPjOVDxP9+VxqleHTtFPbUhxWPM3rSXsUv
         qZ7zAg3BNG+VA4x/GLbjYNYKWSR6UORvlB2K8NWTyAW3HegCVaZdO9QNjjHWXsYASj4X
         ykrLRlM1NPN3wyXhTOTKAQ8mWhWipMFEcf1161+P1PCc7UZRuagTJxIIANRpfGUgYqQd
         k5Yg==
X-Gm-Message-State: AOAM530/x7fIIpmhyx2be+T8pl5IwqeHrf/AbBhP7Z8IUy9l4Xxnv4bX
        q4XMMpFY/eCb7yyqWNNcnS440TD2Vsy21Q==
X-Google-Smtp-Source: ABdhPJy4ltXHIo7pvozwD2iaQV39Hs9tikGuDJ3zKufdQ9zaVim2arCbHMMqjw/r7XAi9MLwo93tAA==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr493050wmh.54.1606354153127;
        Wed, 25 Nov 2020 17:29:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 12/12] mktag: bring back some of the verify_object() logic
Date:   Thu, 26 Nov 2020 02:28:54 +0100
Message-Id: <20201126012854.399-13-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working on this series I saw too late that I'd removed the mktag
check for validating the object the tag points to. The fsck_tag() code
doesn't do this because it's meant for the context of fsck, where
we're validating reachability anyway.

We'd need to either refactor fsck_tag() so that it can pass us back
its "tagged_oid" and the "type_from_string_gently()" value it throws
away to get rid of the re-parsing of stdin here, or just duplicate the
logic as I'm doing here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t3800-mktag.sh |  4 ++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index e9a0954dcb..f1f1cf04ff 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "tag.h"
+#include "replace-object.h"
 #include "object-store.h"
 #include "fsck.h"
 
@@ -25,6 +26,50 @@ static int mktag_fsck_error_func(struct fsck_options *o,
 	}
 }
 
+static int verify_object_in_tag(const char *stdin)
+{
+	struct object_id oid;
+	char *eol;
+	const char *p;
+	int expected_type_id;
+	const char *expected_type;
+	int ret = -1;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	const struct object_id *repl;
+
+	if (!skip_prefix(stdin, "object ", &stdin))
+		goto bug;
+	if (parse_oid_hex(stdin, &oid, &p) || *p != '\n')
+		goto bug;
+	stdin = p + 1;
+	if (!skip_prefix(stdin, "type ", &stdin))
+		goto bug;
+	eol = strchr(stdin, '\n');
+	expected_type_id = type_from_string_gently(stdin, eol - stdin, 1);
+	if (expected_type_id < 0)
+		goto bug;
+	expected_type = type_name(expected_type_id);
+
+	buffer = read_object_file(&oid, &type, &size);
+	repl = lookup_replace_object(the_repository, &oid);
+
+	if (buffer) {
+		if (type == type_from_string(expected_type)) {
+			ret = check_object_signature(the_repository, repl,
+						     buffer, size,
+						     expected_type);
+		}
+		free(buffer);
+	}
+	goto ok;
+bug:
+	BUG("fsck_object() should have ensured a sane tag format already!");
+ok:
+	return ret;
+}
+
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct object obj;
@@ -49,6 +94,9 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (fsck_object(&obj, buf.buf, buf.len, &fsck_options))
 		die("tag on stdin did not pass our strict fsck check");
 
+	if (verify_object_in_tag(buf.buf))
+		die("tag on stdin did not refer to a valid object");
+
 	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
 		die("unable to write annotated tag object");
 
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index bc57ee85c9..74cd2eb141 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -137,7 +137,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (SHA1/type) check' \
-	'^error: char7: could not verify object.*$'
+	'^fatal: tag on stdin did not refer to a valid object'
 
 cat >tag.sig <<EOF
 object $head
@@ -148,7 +148,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (SHA1/type) check' \
-	'^fatal: invalid object type'
+	'^error: badType:'
 
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
-- 
2.29.2.222.g5d2a92d10f8

