Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62671F461
	for <e@80x24.org>; Wed, 15 May 2019 21:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfEOVpR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:45:17 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:50852 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEOVpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:45:17 -0400
Received: by mail-oi1-f202.google.com with SMTP id p83so573487oih.17
        for <git@vger.kernel.org>; Wed, 15 May 2019 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gRRG9XpZZpvbGu2aPerK8AG7XWvPXSC6hS0TzDRS8C4=;
        b=lZIO8++Nwpsf4+FrBzXpdI8iHjlwkVON5WEYZP+hqQ9goKl0Yq81HGlLKC/TusEXag
         i2p0VeOWDkPVlhNuBESSYrjkKNtcUygjICggnsGikbMc1WI43pMB+XCYGlInZtYCKOLz
         HdGMrUrUJPqUHRoXnMbc4dfXxvAcPSfbmeBvKtamL1t+610n8LVoAR/z11LOaN/Fr6Ze
         VJvTHuTYU7MB5dxvWyueGvQ7Zpi+Hxo3ev+S2YNHlo3eV26jeZPF+uY9eDI34IcXsp4E
         zkOGglShPCvoUf0vMqhCYTwY8O/RahzafvJ6ARmFAat5F2Rp8w5GYlrZOu4ob17OirnC
         npbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gRRG9XpZZpvbGu2aPerK8AG7XWvPXSC6hS0TzDRS8C4=;
        b=l/aJu0bOZB6TsuM0jVff6uI497BvUiHRUSE3xTJtnF8Bz+QWefmKu59jhJiMCQrxoA
         c+hfn62y/KmFuIGVw1bpmkItwZqoKWGY3NJKgS0twoure6K2xrucCHrW8U6wNwBiscKU
         EIUMW9XyDZ1D5Tq6sZxKLr7m9a8t2RV8GTjz3mwrEsnEgBPf8YLqTyntE+G+I147Pxy7
         jxLmvfOefndt3y0RLmT2EvEXaAc0Zx4Hee1t1Wi7VEmZ0Ryqey16V/fTATao/fQsfrue
         qjLFwEbOrx1PXZ+SKeVD4+o6xgUtuGwV7v1czhhrCWkDB6OjQJL+41goCx+gxeG+gEYs
         ReLQ==
X-Gm-Message-State: APjAAAXXjvMEL6dXXEn9oUVzGY7gbfQH2+792uYm+ntk9lVOM/QPiJDP
        BWyZSYLHJnQWYfPh1MU9SCk9JzPiKTjjNQ/FFYlrIo6ecr0z3L2juhFzgTMJSIjGF0VDeeNn88J
        Oqbh1xPaAP6yOuFVQfqmDD6Cltw7ACMWnuXbDEgfzjdi6D1Wk43+e
X-Google-Smtp-Source: APXvYqzK8/KudH4nhx+2Fu6xjIoUb6aMi8Hzr4Hnxz1+3WDCSkfR9zw7eQw0TLhc6/ygM8CrU+VgDR8H
X-Received: by 2002:aca:c5d7:: with SMTP id v206mr8296437oif.20.1557956716603;
 Wed, 15 May 2019 14:45:16 -0700 (PDT)
Date:   Wed, 15 May 2019 17:44:57 -0400
In-Reply-To: <20190515214503.77162-1-brho@google.com>
Message-Id: <20190515214503.77162-3-brho@google.com>
Mime-Version: 1.0
References: <20190515214503.77162-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v7 2/8] Move oidset_parse_file() to oidset.c
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
2.21.0.1020.gf2820cf01a-goog

