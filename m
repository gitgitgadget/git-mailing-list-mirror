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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3376C43332
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FD222583
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgLWBjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbgLWBjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB533C0611CF
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k10so3967558wmi.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJlCgo29KShB8vnudpa+o7J4PLWS48Rw7sINvkcv3nk=;
        b=RkcQ6cob4gmrXUkaoPOG/B70+WMRfwYQ6aR1tEk2kq6Hm6iyda08u404nIeRCf+gvo
         8j5RtpxqRQEJTdgV2rjGLtXSxG9eZQ7bXWHyC2zR+peF1O+Vg6ZHyTEwwtAKNGCafu/H
         FNg7ANSAOTVkxKx1TTRhnXGtooXJ/wiC/I5xTn+wYOloNx8zS3IPYW979lazkByT2O4D
         vFxTFHLu7bbgvxdk7X/cylkzl2tOGLVu20WiqQ577Y5fuwrvOjm8XhSDbQDH2aXWoXtK
         O8+HRTcsV6d/a6BLBydXtN92o6aS+H5vCTHwNNarIvOE0yBRcBJCH2Sxx9GA5OZjd42Y
         vwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJlCgo29KShB8vnudpa+o7J4PLWS48Rw7sINvkcv3nk=;
        b=jIy+SX/UD9CG4QH31c5jaa1FE1pJjvOwEQtIkLmWWw/mUkv79MBDBQzszDYvHigdWa
         mP8Ly4UqcOL8JjnIG8tR73poYDmBaRkzQ3/CRibzyhpAUdMde6YryHxj3xVslbaJKxzO
         HDifyzJ3UBUwhy0wbya9VEfr2E0IZt1yHfC9g/hA3VmhsI1r5uISPcoO2FdBHLF6kokU
         2qaLO36RebIKnfY81w+XB+zi8C4WX+CuSaBIJ8Gi5cMiFquPYUbITE7YBoR/yr6hPavs
         WijVSXkKM+TkJY7o5kSJ3OKXOVlzzm6jpvRVdkpR8Sc7jEpNsRTMrq6SUyBNmCqL3S1Y
         x++g==
X-Gm-Message-State: AOAM532TRJveC07aUWqCVpMRsqUa7fnavvN4AKn6JxctXY0RY6naBb5r
        tCLec/GzjPKURAwRUoyWEclpa9pp1S27eg==
X-Google-Smtp-Source: ABdhPJz+3Czubta0bscBQphpgqy0L3p0NkqEHlaCffgKr9HtmvbSx/YE9fptdc7Hk/hbDrfRrCsBMA==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr24114104wmj.104.1608687477189;
        Tue, 22 Dec 2020 17:37:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/20] fsck: make fsck_config() re-usable
Date:   Wed, 23 Dec 2020 02:36:00 +0100
Message-Id: <20201223013606.7972-16-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the fsck_config() function from builtin/fsck.c to fsck.[ch]. This
allows for re-using it in other tools that expose fsck logic and want
to support its configuration variables.

A logical continuation of this change would be to use a common
function for all of {fetch,receive}.fsck.* and fsck.*. See
5d477a334a6 (fsck (receive-pack): allow demoting errors to warnings,
2015-06-22) and my own 1362df0d413 (fetch: implement fetch.fsck.*,
2018-07-27) for the relevant code.

However, those routines want to not parse the fsck.skipList into OIDs,
but rather pass them along with the --strict option to another
process. It would be possible to refactor that whole thing so we
support e.g. a "fetch." prefix, then just keep track of the skiplist
as a filename instead of parsing it, and learn to spew that all out
from our internal structures into something we can append to the
--strict option.

But instead I'm planning to re-use this in "mktag", which'll just
re-use these "fsck.*" variables as-is.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c | 20 +-------------------
 fsck.c         | 25 +++++++++++++++++++++++++
 fsck.h         |  7 +++++++
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fbf26cafcf..821e7798c7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -73,25 +73,7 @@ static const char *printable_type(const struct object_id *oid,
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
-	if (strcmp(var, "fsck.skiplist") == 0) {
-		const char *path;
-		struct strbuf sb = STRBUF_INIT;
-
-		if (git_config_pathname(&path, var, value))
-			return 1;
-		strbuf_addf(&sb, "skiplist=%s", path);
-		free((char *)path);
-		fsck_set_msg_types(&fsck_obj_options, sb.buf);
-		strbuf_release(&sb);
-		return 0;
-	}
-
-	if (skip_prefix(var, "fsck.", &var)) {
-		fsck_set_msg_type(&fsck_obj_options, var, value);
-		return 0;
-	}
-
-	return git_default_config(var, value, cb);
+	return fsck_config_internal(var, value, cb, &fsck_obj_options);
 }
 
 static int objerror(struct object *obj, const char *err)
diff --git a/fsck.c b/fsck.c
index bed5e20e03..9067a290a2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1310,3 +1310,28 @@ int fsck_finish(struct fsck_options *options)
 	oidset_clear(&gitmodules_done);
 	return ret;
 }
+
+int fsck_config_internal(const char *var, const char *value, void *cb,
+			 struct fsck_options *options)
+{
+	if (strcmp(var, "fsck.skiplist") == 0) {
+		const char *path;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
+		strbuf_addf(&sb, "skiplist=%s", path);
+		free((char *)path);
+		fsck_set_msg_types(options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	if (skip_prefix(var, "fsck.", &var)) {
+		fsck_set_msg_type(options, var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
diff --git a/fsck.h b/fsck.h
index 29ee4c45e8..423c467feb 100644
--- a/fsck.h
+++ b/fsck.h
@@ -103,4 +103,11 @@ void fsck_put_object_name(struct fsck_options *options,
 const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
+/*
+ * git_config() callback for use by fsck-y tools that want to support
+ * fsck.<msg> fsck.skipList etc.
+ */
+int fsck_config_internal(const char *var, const char *value, void *cb,
+			 struct fsck_options *options);
+
 #endif
-- 
2.29.2.222.g5d2a92d10f8

