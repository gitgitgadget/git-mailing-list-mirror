Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1D51F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeCWRp7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39551 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeCWRp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id p142-v6so19483889lfd.6
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+tPk+NkaQBgOQDbkTsUFjLecjM8RrArJ6FgPzXSD9c=;
        b=afMHFVx73hv/8hdxErmHFBNbFqVHjhTwQwrc0tq8fOomCJsQjUHGZmTkfHqVK66OtH
         HHoSPrfrfxhlsrzfZgWl2dTct6Ef6mTgwXTkeYwcGD51uM0S6hFur4racSyh+aZLMxU6
         ZRx5ZN0n29hBYmqr9yOr1v5VcfxXdNWVtFkuiwNSaIhB/xvKiryweYNEMS3+kD6VXtav
         mSJOcY69sh6Nvh93R1eGRjwy5cZB7hBU8tjgD2OpKFrWfQp1r/0VwHUo40Ktw66gNcFp
         ldIMyytAt4cB1+lBDI/aDnJAcupMhr8CnfG0sjg68MefpmT/f2BNCyi0E15fYyIO4Qyu
         0+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+tPk+NkaQBgOQDbkTsUFjLecjM8RrArJ6FgPzXSD9c=;
        b=RASvH2KU5Jfrt7N3orZdIQeTY7Cp7DRjKp433/1cOhnrylIBxAN+EEw2y84q7ies1A
         gWPgEaUyVD7UEV1hLkEtCE+NEUVmnOU1FOHWy8d/cTOosROp4FQjvVIxd17ErxD+SPp5
         ggFY4goa2MTfYUNRrGtDKkeQoQh6ZMLnwIfpjlO7VgjZL2aJTmaLF8xXPGeOdsnC3Z3v
         U1FkHZUa18k9D2c3nvGuiZDocX9Qh3zyScMS2MVYOaVyrzkYF1RiF8sJtgrn6wdJQEz5
         LX27o4afJyTUokb5AHITvVe6F+G+M+BSOahz9z41HSouV8vyJeOuxzHSuGMnm/0ETEH6
         Rh2w==
X-Gm-Message-State: AElRT7HVB0MmKtCfJ2C20nsvfhSTxKdBGBnS5YPC8/Aa3eCkhUpQoAHS
        qehvMy6d/NPliQ/2pBVW++k=
X-Google-Smtp-Source: AG47ELsFOyhkY9c5e4tOaQcqJQnh37kqggcFDkf+6r0hmsO2+L4O9xv38zhaXmCK0GLcQRnw7Pr+OQ==
X-Received: by 2002:a19:be4b:: with SMTP id o72-v6mr20991943lff.20.1521827154318;
        Fri, 23 Mar 2018 10:45:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/12] packfile: add repository argument to find_pack_entry
Date:   Fri, 23 Mar 2018 18:45:25 +0100
Message-Id: <20180323174527.30337-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323174527.30337-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323174527.30337-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

While at it move the documentation to the header and mention which pack
files are searched.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c  | 8 ++------
 packfile.h  | 7 ++++++-
 sha1_file.c | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index eb2dc53331..26d5a17dfe 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1845,11 +1845,7 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
-/*
- * Iff a pack file contains the object named by sha1, return true and
- * store its location to e.
- */
-int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
@@ -1871,7 +1867,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
+	return find_pack_entry(the_repository, sha1, &e);
 }
 
 int has_pack_index(const unsigned char *sha1)
diff --git a/packfile.h b/packfile.h
index ee6da3a9ae..e68f790ea7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -123,7 +123,12 @@ extern int packed_object_info(struct packed_git *pack, off_t offset, struct obje
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
-extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
+/*
+ * Iff a pack file in the given repository contains the object named by sha1,
+ * return true and store its location to e.
+ */
+#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
+extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
diff --git a/sha1_file.c b/sha1_file.c
index 9c024cd957..314ff55b47 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1266,7 +1266,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	}
 
 	while (1) {
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(the_repository, real, &e))
 			break;
 
 		/* Most likely it's a loose object. */
@@ -1275,7 +1275,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git(the_repository);
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(the_repository, real, &e))
 			break;
 
 		/* Check if it is a missing object */
@@ -1655,7 +1655,7 @@ static int freshen_loose_object(const unsigned char *sha1)
 static int freshen_packed_object(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(sha1, &e))
+	if (!find_pack_entry(the_repository, sha1, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
-- 
2.17.0.rc0.348.gd5a49e0b6f

