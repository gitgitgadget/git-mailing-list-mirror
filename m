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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6DC64E7D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C42B2173E
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLbWFunx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgKZB3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbgKZB3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F585C061A55
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s8so325081wrw.10
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wjQylGKSs6f5k46AiccndFCBivbC1+sb7NZBEoxknM=;
        b=gLbWFunxAHTrWPVNE/Al7nBbo7WJ4BrylatbsU4z3PUBz9HBYZFjrob/Iq5QqLXZ+d
         zQMNLcuhCXaQqJuQMJPlIuu/OmJnlg8Nz4MtW8bI9DRZmxR2mJXAUBnZ8osbmdCMtqA0
         Vr9kmGyzRKOB/lR8ZtJUkUFlAheqMpsRA9VFg6O30dmOGRcvkw0jQuo3SYcj6ln4Hzxl
         twJBahs8NF4nFHfY0aZqf7EvJvL8qCQbLy1w8Efr1jhh3Zu6vorGoo2iG6KSEHXuTRDN
         Gkm9m6yDtGmH0cWW7E7PVTEiVd8cMIEVrrYHzPdQ4jvFzd1K0kMUMjgyHj0G1VJRq29s
         ak6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wjQylGKSs6f5k46AiccndFCBivbC1+sb7NZBEoxknM=;
        b=U6jjGil41vEpFmdJMLrwn7Wkdmcq7hFh2m5fnHwJcin6zKj17hobEeE8wzHVDEnQHN
         SJF/AYC3eXqytC7WbXSq6vHnbFMg46MVHKQICpI8yBr0bnbSjtV/PX3X1BZesoqr8d6w
         8RfthJR2nogks8pMjl4dEVT4pbB1jV3fcDdqWSZZ3NeDidy1Rl4SMa5GNdkBSbvDGYMn
         GBBBTcJBBKjneB/37sScL0UAT/VbjYyZ807y/dus8DE2LSgBXYG48AI8j8izvRb8fOA4
         IOT6LDoOFBKfkTTcObfQy54kyUmfIavdRk4I3iY/kxgMwUFdx+QB6Af7z2ZTwt2bvLBR
         kn0g==
X-Gm-Message-State: AOAM530qS/uFkT2kH8tQabWaek2PoGDp9oeekIsxFwg5MeThMNL1QbzC
        5CPE3BnZmC96/F0XFPixp//r2Gx4NYk08A==
X-Google-Smtp-Source: ABdhPJwb1mK9oylPXRNLhLq00LwK92ftQrMBlE3phFPwXcNbHv22KgL0UlUrIRnt16jJb15/D5qCxQ==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr689365wrn.231.1606354148773;
        Wed, 25 Nov 2020 17:29:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 08/12] mktag: use fsck instead of custom verify_tag()
Date:   Thu, 26 Nov 2020 02:28:50 +0100
Message-Id: <20201126012854.399-9-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TODO: This subtly breaks one check, see the last patch in this series.

Change the validation logic in "mktag" to use fsck's fsck_tag()
instead of its own custom parser. Curiously the logic for both dates
back to the same commit[1]. Let's unify them so we're not maintaining
two sets functions to verify that a tag is OK.

Moving to fsck_tag() required teaching it to optionally use some
validations that only the old mktag code could perform. That was done
in an earlier commit, the "extraHeaderEntry" and
"extraHeaderBodyNewline" tests being added here make use of that
logic.

There was other "mktag" validation logic that I think makes sense to
just remove. Namely:

 A. fsck only cares that the timezone matches [-+][0-9]{4}. The mktag
    code disallowed values larger than 1400.

    Yes there's currently no timezone with a greater offset[2], but
    since we allow any number of non-offical timezones (e.g. +1234)
    passing this through seems fine. Git also won't break in the
    future if e.g. French Polynesia decides it needs to outdo the Line
    Islands when it comes to timezone extravagance.

 B. fsck allows missing author names such as "tagger <email>", mktag
    wouldn't, but would allow e.g. "tagger <email>" (but not "tagger
    <email>"). Now we allow all of these.

 C. Like B, but "mktag" disallowed spaces in the <email> part, fsck
    allows it.

We didn't only lose obscure validation logic, we also gained some:

 D. fsck disallows zero-padded dates, but mktag didn't care. So
    e.g. the timestamp "0000000000 +0000" produces an error now. A
    test in "t1006-cat-file.sh" relied on this, it's been changed to
    use "hash-object" (without fsck) instead.

1. ec4465adb38 (Add "tag" objects that can be used to sign other
   objects., 2005-04-25)

2. https://en.wikipedia.org/wiki/List_of_UTC_time_offsets

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c     | 45 +++++++++++++++++++++++++---
 t/t1006-cat-file.sh |  2 +-
 t/t3800-mktag.sh    | 72 +++++++++++++++++++++++++++------------------
 3 files changed, 86 insertions(+), 33 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index dc354828f7..a1ae80702d 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -2,6 +2,7 @@
 #include "tag.h"
 #include "replace-object.h"
 #include "object-store.h"
+#include "fsck.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
@@ -47,6 +48,9 @@ static int verify_tag(char *buffer, unsigned long size)
 	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
 	size_t len;
 
+	/* verify_tag() will be removed in the next commit */
+	return 0;
+
 	if (size < 84)
 		return error("wanna fool me ? you obviously got the size wrong !");
 
@@ -153,10 +157,34 @@ static int verify_tag(char *buffer, unsigned long size)
 	return 0;
 }
 
+static int mktag_fsck_error_func(struct fsck_options *o,
+				 const struct object_id *oid,
+				 enum object_type object_type,
+				 int msg_type, const char *message)
+{
+	switch (msg_type) {
+	case FSCK_WARN:
+	case FSCK_ERROR:
+	case FSCK_EXTRA:
+		/*
+		 * We treat both warnings and errors as errors, things
+		 * like missing "tagger" lines are "only" warnings
+		 * under fsck, we've always considered them an error.
+		 */
+		fprintf_ln(stderr, "error: %s", message);
+		return 1;
+	default:
+		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
+		    msg_type);
+	}
+}
+
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
+	struct object obj;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id result;
+	struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 	if (argc != 1)
 		usage("git mktag");
@@ -164,10 +192,19 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno("could not read from stdin");
 
-	/* Verify it for some basic sanity: it needs to start with
-	   "object <sha1>\ntype\ntagger " */
-	if (verify_tag(buf.buf, buf.len) < 0)
-		die("invalid tag signature file");
+	/* verify_tag() will be removed in the next commit */
+	verify_tag("", 0);
+
+	/*
+	 * Fake up an object for fsck_object()
+	 */
+	obj.parsed = 1;
+	obj.type = OBJ_TAG;
+
+	fsck_options.extra = 1;
+	fsck_options.error_func = mktag_fsck_error_func;
+	if (fsck_object(&obj, buf.buf, buf.len, &fsck_options))
+		die("tag on stdin did not pass our strict fsck check");
 
 	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
 		die("unable to write annotated tag object");
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2f501d2dc9..5d2dc99b74 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -166,7 +166,7 @@ tag_content="$tag_header_without_timestamp 0000000000 +0000
 
 $tag_description"
 
-tag_sha1=$(echo_without_newline "$tag_content" | git mktag)
+tag_sha1=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
 
 run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 3801d3a285..bc57ee85c9 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -37,7 +37,7 @@ too short for a tag
 EOF
 
 check_verify_failure 'Tag object length check' \
-	'^error: .*size wrong.*$'
+	'^error: missingObject:'
 
 ############################################################
 #  2. object line label check
@@ -50,7 +50,7 @@ tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
+check_verify_failure '"object" line label check' '^error: missingObject:'
 
 ############################################################
 #  3. object line SHA check
@@ -64,7 +64,7 @@ tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1 hash$'
+check_verify_failure '"object" line check' '^error: badObjectSha1:'
 
 ############################################################
 #  4. type line label check
@@ -77,7 +77,7 @@ tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"type" line label check' '^error: char.*: .*"\\ntype "$'
+check_verify_failure '"type" line label check' '^error: missingTypeEntry:'
 
 ############################################################
 #  5. type line eol check
@@ -85,7 +85,7 @@ check_verify_failure '"type" line label check' '^error: char.*: .*"\\ntype "$'
 echo "object $head" >tag.sig
 printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
 
-check_verify_failure '"type" line eol check' '^error: char.*: .*"\\n"$'
+check_verify_failure '"type" line eol check' '^error: unterminatedHeader:'
 
 ############################################################
 #  6. tag line label check #1
@@ -99,7 +99,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure '"tag" line label check #1' \
-	'^error: char.*: no "tag " found$'
+	'^error: missingTagEntry:'
 
 ############################################################
 #  7. tag line label check #2
@@ -111,7 +111,7 @@ tag
 EOF
 
 check_verify_failure '"tag" line label check #2' \
-	'^error: char.*: no "tag " found$'
+	'^error: badType:'
 
 ############################################################
 #  8. type line type-name length check
@@ -123,7 +123,7 @@ tag mytag
 EOF
 
 check_verify_failure '"type" line type-name length check' \
-	'^error: char.*: type too long$'
+	'^error: badType:'
 
 ############################################################
 #  9. verify object (SHA1/type) check
@@ -159,7 +159,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (SHA1/type) check' \
-	'^error: char7: could not verify object.*$'
+	'^error: badType:'
 
 ############################################################
 # 10. verify tag-name check
@@ -173,7 +173,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify tag-name check' \
-	'^error: char.*: could not verify tag name$'
+	'^error: badTagName:'
 
 ############################################################
 # 11. tagger line label check #1
@@ -187,7 +187,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #1' \
-	'^error: char.*: could not find "tagger "$'
+	'^error: missingTaggerEntry:'
 
 ############################################################
 # 12. tagger line label check #2
@@ -202,10 +202,10 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #2' \
-	'^error: char.*: could not find "tagger "$'
+	'^error: missingTaggerEntry:'
 
 ############################################################
-# 13. disallow missing tag author name
+# 13. allow missing tag author name like fsck
 
 cat >tag.sig <<EOF
 object $head
@@ -216,8 +216,9 @@ tagger  <> 0 +0000
 This is filler
 EOF
 
-check_verify_failure 'disallow missing tag author name' \
-	'^error: char.*: missing tagger name$'
+test_expect_success 'allow missing tag author name' '
+	git mktag <tag.sig
+'
 
 ############################################################
 # 14. disallow missing tag author name
@@ -232,7 +233,7 @@ tagger T A Gger <
 EOF
 
 check_verify_failure 'disallow malformed tagger' \
-	'^error: char.*: malformed tagger field$'
+	'^error: badEmail:'
 
 ############################################################
 # 15. allow empty tag email
@@ -250,7 +251,7 @@ test_expect_success \
     'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
 ############################################################
-# 16. disallow spaces in tag email
+# 16. allow spaces in tag email like fsck
 
 cat >tag.sig <<EOF
 object $head
@@ -260,8 +261,9 @@ tagger T A Gger <tag ger@example.com> 0 +0000
 
 EOF
 
-check_verify_failure 'disallow spaces in tag email' \
-	'^error: char.*: malformed tagger field$'
+test_expect_success 'allow spaces in tag email like fsck' '
+	git mktag <tag.sig
+'
 
 ############################################################
 # 17. disallow missing tag timestamp
@@ -275,7 +277,7 @@ tagger T A Gger <tagger@example.com>__
 EOF
 
 check_verify_failure 'disallow missing tag timestamp' \
-	'^error: char.*: missing tag timestamp$'
+	'^error: badDate:'
 
 ############################################################
 # 18. detect invalid tag timestamp1
@@ -289,7 +291,7 @@ tagger T A Gger <tagger@example.com> Tue Mar 25 15:47:44 2008
 EOF
 
 check_verify_failure 'detect invalid tag timestamp1' \
-	'^error: char.*: missing tag timestamp$'
+	'^error: badDate:'
 
 ############################################################
 # 19. detect invalid tag timestamp2
@@ -303,7 +305,7 @@ tagger T A Gger <tagger@example.com> 2008-03-31T12:20:15-0500
 EOF
 
 check_verify_failure 'detect invalid tag timestamp2' \
-	'^error: char.*: malformed tag timestamp$'
+	'^error: badDate:'
 
 ############################################################
 # 20. detect invalid tag timezone1
@@ -317,7 +319,7 @@ tagger T A Gger <tagger@example.com> 1206478233 GMT
 EOF
 
 check_verify_failure 'detect invalid tag timezone1' \
-	'^error: char.*: malformed tag timezone$'
+	'^error: badTimezone:'
 
 ############################################################
 # 21. detect invalid tag timezone2
@@ -331,10 +333,10 @@ tagger T A Gger <tagger@example.com> 1206478233 +  30
 EOF
 
 check_verify_failure 'detect invalid tag timezone2' \
-	'^error: char.*: malformed tag timezone$'
+	'^error: badTimezone:'
 
 ############################################################
-# 22. detect invalid tag timezone3
+# 22. allow invalid tag timezone3 (the maximum is -1200/+1400)
 
 cat >tag.sig <<EOF
 object $head
@@ -344,8 +346,9 @@ tagger T A Gger <tagger@example.com> 1206478233 -1430
 
 EOF
 
-check_verify_failure 'detect invalid tag timezone3' \
-	'^error: char.*: malformed tag timezone$'
+test_expect_success 'allow invalid tag timezone' '
+	git mktag <tag.sig
+'
 
 ############################################################
 # 23. detect invalid header entry
@@ -360,7 +363,20 @@ this line should not be here
 EOF
 
 check_verify_failure 'detect invalid header entry' \
-	'^error: char.*: trailing garbage in tag header$'
+	'^error: extraHeaderEntry:'
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+
+
+this line should be one line up
+EOF
+
+check_verify_failure 'detect invalid header entry' \
+	'^error: extraHeaderBodyNewline:'
 
 ############################################################
 # 24. create valid tag
-- 
2.29.2.222.g5d2a92d10f8

