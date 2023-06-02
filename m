Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C23C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 18:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjFBSqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjFBSqx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 14:46:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB891B0
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 11:46:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56552a72cfbso35263497b3.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685731611; x=1688323611;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEatwM26XTR51ujKkT8yBvI29jB7sa2tzSSVpC79R1U=;
        b=ecB2AGFmL6w15QDRDrcb6tLjYB4NjxUAFXPPkJRdzbxcQpHRiA1Nbh65eN2ZYXJFg1
         GvMhjQxXieFvMpDFURuUP1TvICBJOF/RVyjp1JVp4VfpgB08hFpGVTjsg97hVbdc9y3G
         3JpIvVXYheX2SL1oc1UrRuc2opDKXmMQ7XE4k8OTSdthBph2lY/U5E+eybJgESHopvD1
         rf7aZkInRSwKk8xRiA5K6J4K9akgD2ggF6yVa64+cDlI/jn7gIYYIFUuD8ElbN449hk6
         99E2X4RyVkDdkde3EOBkk0+uhBM08gxottxxy0/YsJNpUMhQWjhcgtfQukcYv1OMddDu
         QZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685731611; x=1688323611;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEatwM26XTR51ujKkT8yBvI29jB7sa2tzSSVpC79R1U=;
        b=Fxv0agTz0HK7mq0uamXU25TFTuuKHxsyYwSOZx5KwRJzzYh9dTH0BR1XXcnXZE1VZk
         fGKyHI7ZWvrDi8psKibx7vTEuG8P0FOHAeNXHmbiqIGXGcrIUVyGIdfYGuClrVlXWUD2
         bwv6qz9i4nuWy9VvCMeFABLArbc5TpiMCpV077982/Zkhr6AF2apHbASVLkWinx3FUUJ
         6n6Orq1n1+Gv6H1EbhQT3vuqnRugngTi0bvUkOe+lqcsCpVP7FNBNW0VmP46Zzc4YLEM
         pDjLvSqm7SU9C3kU3rNWvFog40aJTCrDb9jo1xJDRNQQ8aZBVt/USdD3wY9M4fnq+3Z2
         xWvw==
X-Gm-Message-State: AC+VfDzRz31fLppkpGjykahdtfr5iJqvAiaWTD+pwcMCzTHtYqT1HF67
        P0krXLQbyex+yZcSC82pRdI90TdD038fqdk7s8XbGOI7VhH89Y3XLiZ4w2eDN0IwRaQx0QrE+T4
        RtwHVXSG6lXV23QdiiqmlgHlYIyNHnU/0nNQvy3VKrbUio8cY4TcndTYVGaeB
X-Google-Smtp-Source: ACHHUZ73ohLTTIG+VnlsZJ9UcPogCuV/QtZv1MXPOtbB9f/d1vahbPeG+SlwuzksNhGugYE72Fm/eX5y2TUc
X-Received: from nayru.cam.corp.google.com ([2620:15c:93:4:46de:3427:10c3:915f])
 (user=asedeno job=sendgmr) by 2002:a81:b620:0:b0:561:b8d1:743b with SMTP id
 u32-20020a81b620000000b00561b8d1743bmr374496ywh.10.1685731611221; Fri, 02 Jun
 2023 11:46:51 -0700 (PDT)
Date:   Fri,  2 Jun 2023 14:45:57 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602184557.1445044-1-asedeno@google.com>
Subject: [PATCH] statinfo.h: move DTYPE defines from dir.h
From:   "=?UTF-8?q?Aleajndro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        "=?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?=" <asedeno@mit.edu>,
        "=?UTF-8?q?Alejandro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>

These definitions are used in cache.h, which can't include dir.h
without causing name-info.cc to have two definitions of
`struct dir_entry`.

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

