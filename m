Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463EEC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 20:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbjFFU7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjFFU7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 16:59:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C771717
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 13:59:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5695f6ebd85so75145607b3.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686085184; x=1688677184;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDoHpzWxEzo66a3vKqJ38sCQrQXqNPH+DNQNbvZGjwI=;
        b=OAEVRQbO3x/ePhZ0n2oIRWdVXVEw6hPPVJz71GPcA2TDksf/l4g5Oc3bcpNUNQ/sVq
         6m1goEumPWG9cJC/vecck/Oz2VeuzoGR0hEt84JFA9f9C7AT5HfVu+rKY5L+vGvxp78f
         qnxJiUFw3AxHpYoiSGF5d/1aylJqM0OYJHUFbPt406xS9uHHhVrpoaPrA4uFpXSO1L1V
         6YQ423p3iexf2PNjDtBn93o8TVYjLHUxh77u/6mDGn7/f0K6NdYTA7Bs8E03D78YiA73
         H69xQEJypQeBqnQQqgr/C4Y4VwwfL0wchMPhgFqyr3kJef6+IFgKTSDeJC3lqeiM47rO
         u1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686085184; x=1688677184;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDoHpzWxEzo66a3vKqJ38sCQrQXqNPH+DNQNbvZGjwI=;
        b=iUQusrOanpIrQCexVSfa09hedDgOpMmHRj+PrZ3LgiDZKOHgSKjG8kYRChaQEAOWx7
         TDyuuv6Gdo+FLwq8hVAsAzuK7AlCGLIy0zfKTBuORuNTihg63Vpwz48Pcx+oMKSkDexF
         aFAWHjVBb0ccwJBYECUAiK5YFioyqddRqWDu4y2sFE3gp2CxWNw5Ii3TJS8WgJyVXD3x
         eCKLM2OnHKMgoaL5UBPsO/mxC3mnWhrssxFOUJa6F5VrXHBymIgeRP07zA/1VeGAJX7Y
         iMwml9xGVVTOk6Y2ZuJ10yczWYqbbuPGLpYROeErQkqiOjhFvHshDgnk5yXRtjseDczK
         qpRA==
X-Gm-Message-State: AC+VfDyx2vLVan61ieu8ycOivF6p2wyq7T0UVBMMsiXdJRC/hYASQ9oR
        Wvhvm3QRkU8f0XNG6ZYIOvdHKkmp/W/q
X-Google-Smtp-Source: ACHHUZ5HQXcKFgocFW07mGE9OO7RQNHL33ag4B6AErBdV/8RFEDRNb4kKcBXlqYDAGdh/g4SUc1caNTmfsyQ
X-Received: from nayru.cam.corp.google.com ([2620:15c:93:4:c99f:feb:b1e3:2144])
 (user=asedeno job=sendgmr) by 2002:a05:6902:110c:b0:bac:c28a:e025 with SMTP
 id o12-20020a056902110c00b00bacc28ae025mr1218423ybu.5.1686085184354; Tue, 06
 Jun 2023 13:59:44 -0700 (PDT)
Date:   Tue,  6 Jun 2023 16:59:35 -0400
In-Reply-To: <xmqqilc571hf.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqilc571hf.fsf@gitster.g>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606205935.3183276-1-asedeno@google.com>
Subject: [PATCH] statinfo.h: move DTYPE defines from dir.h
From:   "=?UTF-8?q?Alejandro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
To:     gitster@pobox.com
Cc:     asedeno@google.com, asedeno@mit.edu, git@vger.kernel.org,
        newren@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>

592fc5b3 (dir.h: move DTYPE defines from cache.h, 2023-04-22) moved
DTYPE macros from cache.h to dir.h, but they are still used by cache.h
to implement ce_to_dtype(); cache.h cannot include dir.h because that
would cause name-hash.c to have two different and conflicting
definitions of `struct dir_entry`. (That should be separately fixed.)

Both dir.h and cache.h include statinfo.h, and this seems a reasonable
place for these definitions.

This change fixes a broken build issue on old SunOS.

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>
---
 dir.h      | 14 --------------
 statinfo.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/dir.h b/dir.h
index 79b85a01ee..d65a40126c 100644
--- a/dir.h
+++ b/dir.h
@@ -641,18 +641,4 @@ static inline int starts_with_dot_dot_slash_native(con=
st char *const path)
 	return path_match_flags(path, what | PATH_MATCH_NATIVE);
 }
=20
-#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-#define DTYPE(de)	((de)->d_type)
-#else
-#undef DT_UNKNOWN
-#undef DT_DIR
-#undef DT_REG
-#undef DT_LNK
-#define DT_UNKNOWN	0
-#define DT_DIR		1
-#define DT_REG		2
-#define DT_LNK		3
-#define DTYPE(de)	DT_UNKNOWN
-#endif
-
 #endif
diff --git a/statinfo.h b/statinfo.h
index e49e3054ea..fe8df633a4 100644
--- a/statinfo.h
+++ b/statinfo.h
@@ -21,4 +21,18 @@ struct stat_data {
 	unsigned int sd_size;
 };
=20
+#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
+#define DTYPE(de)	((de)->d_type)
+#else
+#undef DT_UNKNOWN
+#undef DT_DIR
+#undef DT_REG
+#undef DT_LNK
+#define DT_UNKNOWN	0
+#define DT_DIR		1
+#define DT_REG		2
+#define DT_LNK		3
+#define DTYPE(de)	DT_UNKNOWN
+#endif
+
 #endif
--=20
2.41.0.rc2.161.g9c6817b8e7-goog

