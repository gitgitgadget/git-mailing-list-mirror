Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BE41F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfFTQif (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:38:35 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43514 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFTQie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:38:34 -0400
Received: by mail-pl1-f202.google.com with SMTP id t2so1901293plo.10
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lY2g25qlH/7Gavjz5snKkuIJIxTc1qkxz3A0cDGgC5E=;
        b=D4ZNGAkdGV9xNS/QO7phsLS4I5Zsdwv4GUz88FikSlLP+y1RllNqfrewfEmTlO07rP
         Bo7URaVTqH65dSd5jAQDE/bkieiZoUKqS8V6oLc+bII43VsZcifPYNTGBkQQ55fkjCcz
         Yl8GcDw6k6+kQiIeXCY1ey4AGdKyYKp7FCxMn10FMLFkktilICJ8WWudjwWVi88O+NTo
         UMg3Wy4PVXFXEHWT9OyRFrlIwKrzG76lhU006yoO014hZyOdyEkb1icSn8+MZLfwF+io
         WW/QKqrh0EWA+Rralo0QpEiM4ChXNylPxOvGMmfpqGbPyOQV8wJ4IjCSzOd0OznSQ/t9
         VMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lY2g25qlH/7Gavjz5snKkuIJIxTc1qkxz3A0cDGgC5E=;
        b=afu2wP9VD5HhcM6m8PXRxNVinB1yuyg0qv++AzDCytMwneThyJRiyCMDMfmljM5wEt
         s498ztu1AEhA3Du+FQgGx8hrLKCGEeXQu0T/jjws/mUkXg/Qak/kcxs7MQUjvfo+ADXq
         tSS63j6kICPivTyppdv7/0XIrGQakHaOc3izdLpNDctllPJ6X7dvRCxBfe3sx58AYOmu
         zgzRo4PuivczRUM5pVDg/Vu6pWOxdSHM/NvvI9bSTt8O6ools047GNvK1S+KDMYRY9jG
         w7jBz0cIycivB7Hyss8jKrIo1mSrhZJSk2WDQDy4kbvvdW8GTZV/01f4vGb88U/VhSwe
         bo9g==
X-Gm-Message-State: APjAAAVx1ubNB2hhtxVUEkeCYmbsfgPP3Zlzlr5QHjhcRGBKkogwb9fa
        Ai9C0Y2ETQCYCWTUZY5z2GF4NlGabEShMsA4kv4QiafJ5FYVs9FC75DBtX7M1S8CwvjIsBAF/x4
        k2+5bcXd6xOUwEvOWOcDOPsULjJh/ycmBVTDvvTq5vNuDZU4X5GfR
X-Google-Smtp-Source: APXvYqzGXXf9VV44VN7Me+PM4cL/G4HipXqT8YwZowBUQnpS8gFEt3bhtaKFvcMkX9Kz801CmnYbVhYU
X-Received: by 2002:a63:ec13:: with SMTP id j19mr13261598pgh.174.1561048713867;
 Thu, 20 Jun 2019 09:38:33 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:38:13 -0400
In-Reply-To: <20190620163820.231316-1-brho@google.com>
Message-Id: <20190620163820.231316-3-brho@google.com>
Mime-Version: 1.0
References: <20190620163820.231316-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 2/9] Move oidset_parse_file() to oidset.c
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Barret Rhoden <brho@google.com>
---
 fsck.c   | 35 -----------------------------------
 oidset.c | 35 +++++++++++++++++++++++++++++++++++
 oidset.h |  8 ++++++++
 3 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/fsck.c b/fsck.c
index a28cba6b05dd..58ff3c4de992 100644
--- a/fsck.c
+++ b/fsck.c
@@ -181,41 +181,6 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return msg_type;
 }
 
-void oidset_parse_file(struct oidset *set, const char *path)
-{
-	FILE *fp;
-	struct strbuf sb = STRBUF_INIT;
-	struct object_id oid;
-
-	fp = fopen(path, "r");
-	if (!fp)
-		die("could not open object name list: %s", path);
-	while (!strbuf_getline(&sb, fp)) {
-		const char *p;
-		const char *name;
-
-		/*
-		 * Allow trailing comments, leading whitespace
-		 * (including before commits), and empty or whitespace
-		 * only lines.
-		 */
-		name = strchr(sb.buf, '#');
-		if (name)
-			strbuf_setlen(&sb, name - sb.buf);
-		strbuf_trim(&sb);
-		if (!sb.len)
-			continue;
-
-		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
-			die("invalid object name: %s", sb.buf);
-		oidset_insert(set, &oid);
-	}
-	if (ferror(fp))
-		die_errno("Could not read '%s'", path);
-	fclose(fp);
-	strbuf_release(&sb);
-}
-
 static int parse_msg_type(const char *str)
 {
 	if (!strcmp(str, "error"))
diff --git a/oidset.c b/oidset.c
index fe4eb921df81..584be63e520a 100644
--- a/oidset.c
+++ b/oidset.c
@@ -35,3 +35,38 @@ void oidset_clear(struct oidset *set)
 	kh_release_oid(&set->set);
 	oidset_init(set, 0);
 }
+
+void oidset_parse_file(struct oidset *set, const char *path)
+{
+	FILE *fp;
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id oid;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		die("could not open object name list: %s", path);
+	while (!strbuf_getline(&sb, fp)) {
+		const char *p;
+		const char *name;
+
+		/*
+		 * Allow trailing comments, leading whitespace
+		 * (including before commits), and empty or whitespace
+		 * only lines.
+		 */
+		name = strchr(sb.buf, '#');
+		if (name)
+			strbuf_setlen(&sb, name - sb.buf);
+		strbuf_trim(&sb);
+		if (!sb.len)
+			continue;
+
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
+			die("invalid object name: %s", sb.buf);
+		oidset_insert(set, &oid);
+	}
+	if (ferror(fp))
+		die_errno("Could not read '%s'", path);
+	fclose(fp);
+	strbuf_release(&sb);
+}
diff --git a/oidset.h b/oidset.h
index 14f18f791fea..2dbca84d798f 100644
--- a/oidset.h
+++ b/oidset.h
@@ -61,6 +61,14 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
  */
 void oidset_clear(struct oidset *set);
 
+/**
+ * Add the contents of the file 'path' to an initialized oidset.  Each line is
+ * an unabbreviated object name.  Comments begin with '#', and trailing comments
+ * are allowed.  Leading whitespace and empty or white-space only lines are
+ * ignored.
+ */
+void oidset_parse_file(struct oidset *set, const char *path);
+
 struct oidset_iter {
 	kh_oid_t *set;
 	khiter_t iter;
-- 
2.22.0.410.gd8fdbe21b5-goog

