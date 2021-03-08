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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2896C433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB1F65274
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhCHUFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhCHUEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE68C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l22so250209wme.1
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KipHiPsZVwAPYodCfTd8SF40vSGhuGSBk2G5AKWbUz4=;
        b=I6IOvalpWsDl9Lmnr53keAkSizp4eO37GssYsZoXylY3fLBjrwXlbHDQc3Ik2hWhuV
         ssN7U5YT5B7OUDRVmN1iX/ENcGMRQRRf6/9xeHphersWB+x6Bc5MTeUGH9qA57tNrB0j
         bwe7phB1eiyky0RtKFQxpL7dJCZg7MT51NT2CsSZWrEJlIzrXVmIBiXfniH7s67hF990
         xiEq8U3xEmlcrRtrNVNuoaNmlfNWjp2q8z7aA9nBVL+AMZTmT8XIbi7xWIhl0Fqewdyu
         4TOBeqGwHAZKKNqiIecqI49qATFosx/IfW46yaSwKBSMF3R8ofWFxiUvVBw2qdMCX4+G
         MxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KipHiPsZVwAPYodCfTd8SF40vSGhuGSBk2G5AKWbUz4=;
        b=bCZc19WZmbNHEC/LR54B6bIRwum8W5Xwh84TvNQ6vJV/D2VXVS9RrN5ZW92Hk1gCK7
         iOcvI48ieUzYfzd0CBKBn886s2ondn6+TLG4fxVz/cXdTU/uifzrAtWYXla3FF1O8hnn
         fGrVLzM2PCpXDvOx6YUfD2xqCopqmuAbWZJdYWMGrjMzrNrEvQH7rf2UsrK69s7jV13h
         hCX1stHk5hBWHO9Rxg9eg51peLz8OxypaBfyOoUovXQcwd6ErN1E1QblC+MCGO4Rtn7h
         PiIih37F/pQr8m/futczrfV2a0jWCOL7MFsLJD73pR66T9bCloae9AiyJh8yD3gstpoL
         S3Sw==
X-Gm-Message-State: AOAM5322K2dlWV9GLq2DzxDz0EIr82Ye+d68ufPOBEaSApb1cDlbpqbe
        OF3QHtxPQuYvptig70Atma0sKi2x0meE/g==
X-Google-Smtp-Source: ABdhPJz65vuLI5qVfeAbDuKB+nxfq6rICHt14yYTYFoo0SgWOUf98ehwB/htroxOnmbMT3tq01PEPA==
X-Received: by 2002:a1c:2017:: with SMTP id g23mr439651wmg.126.1615233882715;
        Mon, 08 Mar 2021 12:04:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/7] object.c: make type_from_string() return "enum object_type"
Date:   Mon,  8 Mar 2021 21:04:21 +0100
Message-Id: <20210308200426.21824-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the type_from_string*() functions to return an "enum
object_type", and refactor their callers to check for "== OBJ_BAD"
instead of "< 0".

This helps to distinguish code in object.c where we really do return
-1 from code that returns an "enum object_type", whose OBJ_BAD happens
to be -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c        |  2 +-
 object-file.c |  2 +-
 object.c      | 12 ++++++------
 object.h      |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6cc4f9ea892..a6d00dfa2e6 100644
--- a/fsck.c
+++ b/fsck.c
@@ -958,7 +958,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		goto done;
 	}
 	*tagged_type = type_from_string_gently(buffer, eol - buffer);
-	if (*tagged_type < 0)
+	if (*tagged_type == OBJ_BAD)
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
 		goto done;
diff --git a/object-file.c b/object-file.c
index 42bc579828d..cd30c2b5590 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1324,7 +1324,7 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 	 */
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
 		type = 0;
-	else if (type < 0)
+	else if (type == OBJ_BAD)
 		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep = type;
diff --git a/object.c b/object.c
index c7586e46727..eebacc28847 100644
--- a/object.c
+++ b/object.c
@@ -35,22 +35,22 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, ssize_t len)
+enum object_type type_from_string_gently(const char *str, ssize_t len)
 {
-	int i;
+	enum object_type i;
 
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strncmp(str, object_type_strings[i], len) &&
 		    object_type_strings[i][len] == '\0')
 			return i;
-	return -1;
+	return OBJ_BAD;
 }
 
-int type_from_string(const char *str)
+enum object_type type_from_string(const char *str)
 {
 	size_t len = strlen(str);
-	int ret = type_from_string_gently(str, len);
-	if (ret < 0)
+	enum object_type ret = type_from_string_gently(str, len);
+	if (ret == OBJ_BAD)
 		die(_("invalid object type \"%s\""), str);
 	return ret;
 }
diff --git a/object.h b/object.h
index ffdc1298300..5e7a523e858 100644
--- a/object.h
+++ b/object.h
@@ -93,8 +93,8 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, ssize_t len);
-int type_from_string(const char *str);
+enum object_type type_from_string_gently(const char *str, ssize_t len);
+enum object_type type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.0.rc1.210.g0f8085a843c

