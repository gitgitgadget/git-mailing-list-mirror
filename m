Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326B41F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfGAOqH (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:46:07 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:50112 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfGAOqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:46:06 -0400
Received: by mail-ua1-f73.google.com with SMTP id h37so2258152uad.16
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lY2g25qlH/7Gavjz5snKkuIJIxTc1qkxz3A0cDGgC5E=;
        b=q0CutxMVDwcdy14NqWQn/e9QNpU+teoLx4fRa94ul867Gu/i2ehn/3QNsf7GRps2HK
         rlmqspRHrIE8jl8vBbVxVcFSaAOqKXnM7sAqxS29hkCnhzBMjXtUmHseROso2El0iaQF
         X/Yg5/2rAczmB6YJ5mxiI5+3w42xzPOlH4Vz+tq3QTDg/mgpJtqCeN4d4z49nmGTf9VY
         DPRU3a83boD8e/JYrgrQ6S2U4fE133N63uvzTAG5Ct+haSCz7H49c8vqkACgWmc45G/b
         jbJ9KTHmqK8k8iQt3ui7GO/gyggND02EWdnj+zssiz35gbLuTpBzAmfl/H0eKwOZ/Bgm
         xS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lY2g25qlH/7Gavjz5snKkuIJIxTc1qkxz3A0cDGgC5E=;
        b=uCk6u626Qe/hzHiLUbGLHaOzN1JxUl7DpY5+oRpl7oJV+9/DoYfo3LOm5Dvfpph79Z
         R5GYWTSzapLpzJ6vE9Wx4+CAii8BsXrS6uJ6d+4kXbo6yyrJIHkD06IZdwcV4fcA3Jhg
         OvSD4zPG3EBpZ5Q/Lzt5UdV7KgqJDTedjOd5ZED5PcgsfdDM/v8RWInwmRdvZV8ASwH0
         zJz/Jmlh8G3HgudUpfBd6cByxmKNnUUtnTpYn8Tx4ZdQCRoIJjlrt/k4iq+Y8tTqwmkl
         7iKhADLYmEWgPqlkQtFdrdj3r2hg7Rmiqa1iCG8sx6pA46GNYD/I0KGeQJwuvUXQAXfj
         lgJQ==
X-Gm-Message-State: APjAAAW9L/8dfkJ6tBjq+0NbCNbfJKJCHB0RGO115WSxC2/8dV1mSoGy
        MVUEL4sUk0eNdDQZuPisluLIuROnx2j/VsRH8AHjusjI0/lKSd+vPVAJoZwboT4LOKEcAoOYu0D
        xUJ7aBClpkhidYbor6rPzGCoTRFqL5pg0qGPi0kzS4H0IF787Jr9w
X-Google-Smtp-Source: APXvYqyh1vIkwgCJhRe6jdpCcyAMysVRjgjRIbbKcuXxV1PNe5tQ6Pawst8opuM663pdhJtp4m42xQsy
X-Received: by 2002:a67:9946:: with SMTP id b67mr14933499vse.37.1561992365665;
 Mon, 01 Jul 2019 07:46:05 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:45:41 -0400
In-Reply-To: <20190701144548.129635-1-brho@google.com>
Message-Id: <20190701144548.129635-3-brho@google.com>
Mime-Version: 1.0
References: <20190701144548.129635-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v10 2/9] Move oidset_parse_file() to oidset.c
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

