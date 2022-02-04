Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E2C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359136AbiBDNvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244829AbiBDNvg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87675C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s18so11457608wrv.7
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNOJUJlkCD8qpcw0wiZZtHtfKdSJJ3TMF/8hSuye8dk=;
        b=f+gt/ydQOiGJJSZQhRamTyzqONP89iwETkSV9oPhHvT6e04GL2k0oWZ8HkjbO4YaaM
         0PfhWklEkCBz8ijVM5F3b1F9Un1yxqlaw6fF5OPaArssvtf8j+wxA82rOQVouCxjrBPq
         y0cOJHjRA+yYsdLwVd2xWTrWOD1hhL4rxwPmW9Ulsfsr/V31m9i8p+Of9eLGclAdCfvU
         pZa4thtQvUxouNrpsq0ShRQRyY9MCBaqk4ch9gH/JvUdTzX8q4ILQhTtYqVETxoKPlRe
         /Iky5fpPZqYNqQqOkhy7Nv1aSh2GLwMq1W2vJw9/X4iTv5ILiCEotm7vI4SeTGKgw8c3
         7xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNOJUJlkCD8qpcw0wiZZtHtfKdSJJ3TMF/8hSuye8dk=;
        b=JxN4A63UdcMCYUlmqUj/n6KUV62Rmmvkw6i/NZeUGUkONyN2bLEhATsbwNOoIORadn
         IW2Grk/Q6cfAGJnX4BBKtBjcacEj3/GEWfqNef7zEiZXowBv+3CYrS0RQHJM2Hn3GaNc
         pNVPR5g4oaZU0Y2tTnWFXa6tK2sj+nhyeLsYfllfBVxi1QouvQLHaCkhbHQGxsj/Dcb5
         hCd56E3XW0f8gmizihos+meAv7P0vdTF6l/qpjoaVez7sxcjO3uiRTCsJORQa4P40Z03
         RI3Y70dXS8ZD7Z9HlZx2AKDA48WRWyVPXZroSrCsO0OZ4vUGE9CJNk01LHF6cF4pRwWL
         fI6Q==
X-Gm-Message-State: AOAM531oKpWP7JoCPVD92KStKs/aepCCt2F74PeUzt+k4DFqf/rErHfp
        O20mkMt8lZOB427I3dDbuB7GuQ3GzbQMzg==
X-Google-Smtp-Source: ABdhPJycvz4VT3K8FLjc/XVNyP6+hbXjbBzdnPPNa+BTWjSPLAW3HYMacWf0uI4eBGxWVLAhBP57Zg==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr2681740wrt.350.1643982694780;
        Fri, 04 Feb 2022 05:51:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] object API: correct "buf" v.s. "map" mismatch in *.c and *.h
Date:   Fri,  4 Feb 2022 14:51:19 +0100
Message-Id: <patch-v2-05.11-207aec4eb64-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the name of the second argument to check_object_signature() to
be "buf" in object-file.c, making it consistent with the prototype in
cache..h

This fixes an inconsistency that's been with us since 2ade9340262 (Add
"check_sha1_signature()" helper function, 2005-04-08), and makes a
subsequent commit's diff smaller, as we'll move these API docs to
cache.h.

While we're at it fix a small grammar error in the documentation,
dropping an "an" before "in-core object-data".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 59eb793e0ac..271acf4dd15 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1067,13 +1067,13 @@ int format_object_header(char *str, size_t size, enum object_type type,
 }
 
 /*
- * With an in-core object data in "map", rehash it to make sure the
+ * With in-core object data in "buf", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
- * With "map" == NULL, try reading the object named with "oid" using
+ * With "buf" == NULL, try reading the object named with "oid" using
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size, const char *type,
+			   void *buf, unsigned long size, const char *type,
 			   struct object_id *real_oidp)
 {
 	struct object_id tmp;
@@ -1084,8 +1084,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	if (map) {
-		hash_object_file(r->hash_algo, map, size, type, real_oid);
+	if (buf) {
+		hash_object_file(r->hash_algo, buf, size, type, real_oid);
 		return !oideq(oid, real_oid) ? -1 : 0;
 	}
 
-- 
2.35.1.940.ge7a5b4b05f2

