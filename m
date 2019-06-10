Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300031F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbfFJPa3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:30:29 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46187 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389786AbfFJPa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:30:29 -0400
Received: by mail-qk1-f202.google.com with SMTP id 18so8445540qkl.13
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lw+6RkUsv1QseX8nn4vGeqUB8IQO2AX7DK+i5aECGx8=;
        b=cpVMcIXZSpJK2gxpheYg7BoB2Gsk3Ck6LsBDOCyTIN2g3VPLd7sBURBkn2pSmEcRNx
         JZBD/wyw/5wzgF1R3oTlq94VyNZH5VCC1LttL7e21woocaADj6FzUodWLzeKyhA+tndM
         H+3nMYu+HR+6QCQBzx/9QDPPRCGrW9vgZk5SuRpB1QxqoUUnnQfb0ipcqIKsj4hhxzoh
         RoHMTEgsbg8WAit+6vQyvuElIe53t8XLpk9KPuctyWeGvyS9dDcR9NwkdqCDjx82grXW
         aImNTmlSQzuDWrHXTBVuQpfLRhi9ch7vNKaMTnbRl6Mq/mtb67Gt1QFPO77EVwhWsm4D
         htHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lw+6RkUsv1QseX8nn4vGeqUB8IQO2AX7DK+i5aECGx8=;
        b=aakVbkRc820eKamlp4R513pPNsYfN59tvKSFRpuRwaCvUmBGH/NiMrHgTi8u4/rTyG
         +UnO6Cuzt1Xl9/3WYXtb7+BAkQYFawWrC+d4tB/I3M7ZIzeAj76UaNC9uySu+OdCcQv+
         xQWC3aN1yACeylDy37xapLQeShgu7yUDiLiActtEkd9yMih4PuMowcZI33cf7r6ehkrM
         Srlh7oSqu3nA+TVNuZ/OWo/SuIEOdxMvSZu/gW10lvlWrkAs+C0hMbOmxX6VHCeiNBcm
         11q0fAbxCCR51qEH0ST0iQvrvqobOcNcKIxyCF9ipm35D/qmbVXM3fdnaW1om5TAc0pG
         hYWA==
X-Gm-Message-State: APjAAAWl8IFwZ1I7FQOdFMg/Ct4i05UElLPMZpZlLzsTUk/1rExp38Ht
        i3kCVjQojSGWLLIwvjoBrrAZkyfG0z+BhICXypaXybz+f8VAzPCVNTskLTjYFQ5JZEyiFZim3in
        giwFjkYb+q8mBwzDyQecvh5Hj39wGsuJOkIxJdsDaIDc2muxQfTcU
X-Google-Smtp-Source: APXvYqw4z5ryLwNCd4DUFamir0v0XBy69DmcY6Kovmcocd2sJ8c1KpOpyGR/EBHosKCcAtlNf37WQE5R
X-Received: by 2002:a0c:879d:: with SMTP id 29mr34192929qvj.91.1560180627685;
 Mon, 10 Jun 2019 08:30:27 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:30:07 -0400
In-Reply-To: <20190610153014.42055-1-brho@google.com>
Message-Id: <20190610153014.42055-3-brho@google.com>
Mime-Version: 1.0
References: <20190610153014.42055-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v8 2/9] Move oidset_parse_file() to oidset.c
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
2.22.0.rc2.383.gf4fbbf30c2-goog

