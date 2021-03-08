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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F369C4332B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77D365274
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhCHUFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhCHUEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68682C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e10so12745482wro.12
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4kru7qSX2gm0xTGHIt+9Abl02EW/8NGl20BuIjD3cs=;
        b=K5FCnJ0PYH9w9R53R01f/OrzJvKIxSp2kTaksFYXscKiyLwKvfUxuGG/tW3U95SQCn
         ijIU7qg/IBfdcSEwtHJkShEjikm/oydyBQvreZb+n1rufDmc8298rsM2MUeNuDvqQ52C
         QcoOrJj/x+zvTHED5ntvjTVhVnGeuA2MGMZ38zFnfMfEG9jcQUB/cfX6pWaha1WhUT2H
         fFHBgV5r7uv33+IIac4bYTnIpqgt6DjmSc/ehvY94sU7g8zktbJ+dsWJx7iXwwshbyiS
         psS+cnCNZzWorxbRd/Uc7UEs1PRP5zdq6ijrWKolpe2d0yvBZ9H1ZOM69BOsO15olE8c
         qAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4kru7qSX2gm0xTGHIt+9Abl02EW/8NGl20BuIjD3cs=;
        b=oZ2kcDjw1K6rNusjWshtVnQMKPBJa7MzwNiIzcpX0CysM9g5J/OgjmnnGo1G1X3SCo
         nanaEydwiLsOUwszDYwi7HhlVOiyUvE45D7SjoZC+E3xwGTIVMkc6AyuxNGFzuXYxOa5
         YSc+ndwLJGKKrGdP2+2iqNQh4g380gxbKPy6A/6BUTz9Ezhy5DYD3j+tEeQseDS6WZ8x
         cJ03v+xWdJQskmRVXeR2eyxt1eP+DW+Cmzij44/HJBhPv1KZQmcaxkt0NI/pPReqFzW0
         v4/Am/rY81AiXliyzoe+A1LTM6pADnwsGtHH7UyKTBTJlXjVAYt4429+Ee5pQvcRIal3
         3deQ==
X-Gm-Message-State: AOAM531KQOgb3PwpKQI9SQkr1+VQQnoHMl3jHD0Vy++UZlX1lLsA/fKf
        7BDWUlk5JGXt757lWguhnpx5XROJE5p+/w==
X-Google-Smtp-Source: ABdhPJyOSZie/FL+d5flfnZV4G68qeE0HN9rHPbIyyjDzO7FcC72dPWx9gYdah68BjgvOGxvFdgMAg==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr25480572wrk.146.1615233881949;
        Mon, 08 Mar 2021 12:04:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] object.c: refactor type_from_string_gently()
Date:   Mon,  8 Mar 2021 21:04:20 +0100
Message-Id: <20210308200426.21824-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of the "gently" argument to type_from_string_gently() to make
it consistent with most other *_gently() functions.

This refactoring of adding a third parameter was done in
fe8e3b71805 (Refactor type_from_string() to allow continuing after
detecting an error, 2014-09-10) in preparation for its use in
fsck.c.

Since then no callers of this function have passed a "len < 0" as was
expected might happen, so we can simplify its invocation by knowing
that it's never called like that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c        |  2 +-
 object-file.c |  2 +-
 object.c      | 18 ++++++++++--------
 object.h      |  4 ++--
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index e3030f3b358..6cc4f9ea892 100644
--- a/fsck.c
+++ b/fsck.c
@@ -957,7 +957,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
-	*tagged_type = type_from_string_gently(buffer, eol - buffer, 1);
+	*tagged_type = type_from_string_gently(buffer, eol - buffer);
 	if (*tagged_type < 0)
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
diff --git a/object-file.c b/object-file.c
index 5bcfde84718..42bc579828d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1314,7 +1314,7 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 		type_len++;
 	}
 
-	type = type_from_string_gently(type_buf, type_len, 1);
+	type = type_from_string_gently(type_buf, type_len);
 	if (oi->type_name)
 		strbuf_add(oi->type_name, type_buf, type_len);
 	/*
diff --git a/object.c b/object.c
index 98017bed8ef..c7586e46727 100644
--- a/object.c
+++ b/object.c
@@ -35,22 +35,24 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, ssize_t len, int gentle)
+int type_from_string_gently(const char *str, ssize_t len)
 {
 	int i;
 
-	if (len < 0)
-		len = strlen(str);
-
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strncmp(str, object_type_strings[i], len) &&
 		    object_type_strings[i][len] == '\0')
 			return i;
+	return -1;
+}
 
-	if (gentle)
-		return -1;
-
-	die(_("invalid object type \"%s\""), str);
+int type_from_string(const char *str)
+{
+	size_t len = strlen(str);
+	int ret = type_from_string_gently(str, len);
+	if (ret < 0)
+		die(_("invalid object type \"%s\""), str);
+	return ret;
 }
 
 /*
diff --git a/object.h b/object.h
index 59daadce214..ffdc1298300 100644
--- a/object.h
+++ b/object.h
@@ -93,8 +93,8 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, ssize_t, int gentle);
-#define type_from_string(str) type_from_string_gently(str, -1, 0)
+int type_from_string_gently(const char *str, ssize_t len);
+int type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.0.rc1.210.g0f8085a843c

