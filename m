Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B2BC56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1789621734
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRzkpXuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgKZB3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbgKZB3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:12 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD7C08E862
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:11 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so360474wrt.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW7sYWlismP6ozbuDJ/KNw5x9kB6k+wmAoxiuougQcY=;
        b=HRzkpXuhsPkjaMiP876JxEJSGM9CVYyue/Hbp65DZItzB7Ko/heTpLoCETsMPAI4wx
         kIA/RSKG9hEUndEFyZnpukmp9hCsc3fWp+stu9HpyAxVPsViIAgdDQQKxWNaPuOReCId
         Vna5E7NCJEfwZH+wy1q5qvQvbAgykA/bTVazEBbZ+ZDQOcWQfFfzkpqwLhVzlKGvn7pS
         lVlnWZofsb7RvJrwqrrtB/+DFIV5rjBvV+SrWsXfnFAiEc/fUPrhM/8C+m4nwOeDSWpj
         DVHX6CiCZukmhizwUkQIffNca/KllVTj7qGikeKXqq1q4wUhS+xvDV+3jMQSUajTrVGx
         8ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW7sYWlismP6ozbuDJ/KNw5x9kB6k+wmAoxiuougQcY=;
        b=GZHcW/LSB/49wobVysCnJXql5JvtcbE5hYXkCA6AkKvbyGEL2qVQGE2Gdalwnjd6Dw
         ceU9qwNcGXtSEHmJFuHWRg4hgCcUKOh9OBUD2MXy09t6Qsv1WMd2UNSjr322AJzfBT78
         DwNo9kfISuHbAXPzxKyJ/ewCZPnnYdSn2EMWIfdPjVej49AC1wiSS612SGdeqM6WytmN
         u9heJtqghsrxrLAWbZH0MFdEXqJcXG7jok0yf5K93m3zvGTA2zU36BqVV0V8rXVIHL4/
         s02XRaRO7xFAQqHxWRcLkLozta/BMAEVYe3b1Fpk4Lz81fh/oIg/sHHwIwkWUnaKTNtj
         rZ5g==
X-Gm-Message-State: AOAM530EbiaSWqzprw/uu2Tr/EpnblHD3QZiwT0V33xaIh/56kf6R+H/
        GYnZtA9rLvjoLIVPf6hnyGA4OMRverIxVg==
X-Google-Smtp-Source: ABdhPJwVCigjywaGF4nKcksmlWiMIRIZ1bIe9MBU0xJ2SDo2AD7zePNzvmNgAmnT0kxSOTTauBDYlA==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr753845wrr.222.1606354149687;
        Wed, 25 Nov 2020 17:29:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 09/12] mktag: remove now-unused verify_tag() code
Date:   Thu, 26 Nov 2020 02:28:51 +0100
Message-Id: <20201126012854.399-10-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preceding commit removed the use of the verify_tag() function, but
didn't remove this code to keep the diff smaller. Let's remove this
unused code now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 157 ------------------------------------------------
 1 file changed, 157 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index a1ae80702d..e9a0954dcb 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,162 +1,8 @@
 #include "builtin.h"
 #include "tag.h"
-#include "replace-object.h"
 #include "object-store.h"
 #include "fsck.h"
 
-/*
- * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
- * "tagger <committer>", followed by a blank line, a free-form tag
- * message and a signature block that git itself doesn't care about,
- * but that can be verified with gpg or similar.
- *
- * The first four lines are guaranteed to be at least 83 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
- * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
- * single-character-tag line, and "tagger . <> 0 +0000\n" at 20 bytes is
- * the shortest possible tagger-line.
- */
-
-/*
- * We refuse to tag something we can't verify. Just because.
- */
-static int verify_object(const struct object_id *oid, const char *expected_type)
-{
-	int ret = -1;
-	enum object_type type;
-	unsigned long size;
-	void *buffer = read_object_file(oid, &type, &size);
-	const struct object_id *repl = lookup_replace_object(the_repository, oid);
-
-	if (buffer) {
-		if (type == type_from_string(expected_type)) {
-			ret = check_object_signature(the_repository, repl,
-						     buffer, size,
-						     expected_type);
-		}
-		free(buffer);
-	}
-	return ret;
-}
-
-static int verify_tag(char *buffer, unsigned long size)
-{
-	int typelen;
-	char type[20];
-	struct object_id oid;
-	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
-	size_t len;
-
-	/* verify_tag() will be removed in the next commit */
-	return 0;
-
-	if (size < 84)
-		return error("wanna fool me ? you obviously got the size wrong !");
-
-	buffer[size] = 0;
-
-	/* Verify object line */
-	object = buffer;
-	if (memcmp(object, "object ", 7))
-		return error("char%d: does not start with \"object \"", 0);
-
-	if (parse_oid_hex(object + 7, &oid, &p))
-		return error("char%d: could not get SHA1 hash", 7);
-
-	/* Verify type line */
-	type_line = p + 1;
-	if (memcmp(type_line - 1, "\ntype ", 6))
-		return error("char%d: could not find \"\\ntype \"", 47);
-
-	/* Verify tag-line */
-	tag_line = strchr(type_line, '\n');
-	if (!tag_line)
-		return error("char%"PRIuMAX": could not find next \"\\n\"",
-				(uintmax_t) (type_line - buffer));
-	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char%"PRIuMAX": no \"tag \" found",
-				(uintmax_t) (tag_line - buffer));
-
-	/* Get the actual type */
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= sizeof(type))
-		return error("char%"PRIuMAX": type too long",
-				(uintmax_t) (type_line+5 - buffer));
-
-	memcpy(type, type_line+5, typelen);
-	type[typelen] = 0;
-
-	/* Verify that the object matches */
-	if (verify_object(&oid, type))
-		return error("char%d: could not verify object %s", 7, oid_to_hex(&oid));
-
-	/* Verify the tag-name: we don't allow control characters or spaces in it */
-	tag_line += 4;
-	for (;;) {
-		unsigned char c = *tag_line++;
-		if (c == '\n')
-			break;
-		if (c > ' ')
-			continue;
-		return error("char%"PRIuMAX": could not verify tag name",
-				(uintmax_t) (tag_line - buffer));
-	}
-
-	/* Verify the tagger line */
-	tagger_line = tag_line;
-
-	if (memcmp(tagger_line, "tagger ", 7))
-		return error("char%"PRIuMAX": could not find \"tagger \"",
-			(uintmax_t) (tagger_line - buffer));
-
-	/*
-	 * Check for correct form for name and email
-	 * i.e. " <" followed by "> " on _this_ line
-	 * No angle brackets within the name or email address fields.
-	 * No spaces within the email address field.
-	 */
-	tagger_line += 7;
-	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
-		strpbrk(tagger_line, "<>\n") != lb+1 ||
-		strpbrk(lb+2, "><\n ") != rb)
-		return error("char%"PRIuMAX": malformed tagger field",
-			(uintmax_t) (tagger_line - buffer));
-
-	/* Check for author name, at least one character, space is acceptable */
-	if (lb == tagger_line)
-		return error("char%"PRIuMAX": missing tagger name",
-			(uintmax_t) (tagger_line - buffer));
-
-	/* timestamp, 1 or more digits followed by space */
-	tagger_line = rb + 2;
-	if (!(len = strspn(tagger_line, "0123456789")))
-		return error("char%"PRIuMAX": missing tag timestamp",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line += len;
-	if (*tagger_line != ' ')
-		return error("char%"PRIuMAX": malformed tag timestamp",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line++;
-
-	/* timezone, 5 digits [+-]hhmm, max. 1400 */
-	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
-	      strspn(tagger_line+1, "0123456789") == 4 &&
-	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
-		return error("char%"PRIuMAX": malformed tag timezone",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line += 6;
-
-	/* Verify the blank line separating the header from the body */
-	if (*tagger_line != '\n')
-		return error("char%"PRIuMAX": trailing garbage in tag header",
-			(uintmax_t) (tagger_line - buffer));
-
-	/* The actual stuff afterwards we don't care about.. */
-	return 0;
-}
-
 static int mktag_fsck_error_func(struct fsck_options *o,
 				 const struct object_id *oid,
 				 enum object_type object_type,
@@ -192,9 +38,6 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno("could not read from stdin");
 
-	/* verify_tag() will be removed in the next commit */
-	verify_tag("", 0);
-
 	/*
 	 * Fake up an object for fsck_object()
 	 */
-- 
2.29.2.222.g5d2a92d10f8

