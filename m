Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09DC54F70
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF99214D8
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCWbM2JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSMc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDSMcz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:32:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C38C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b2so1401785ljp.4
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ond4fCjYXUD6XOn0ReDXyFHTo902oD1vmYkIA/0cHgk=;
        b=GCWbM2JO9osznmH7No+47XbfEFlvyKnLbbH70kfMtfUgvXiSWd5guRcsooyqf4WfgM
         9MtZmHSowdKE/2vZlEpmcLHKiEwGKbjgCJ8rEi83bT5dfL9HOjQcJr+h9aitb1BQ/fRq
         9pCDD3yggPmvxApNPnznizsKpd/amvBnDQ+CIxxLlMCXXQNCO2DaYftfWqnSydnDbuOW
         /h8thxjbdjZYOpsKWV8Cv0CEOjevoNcxdbUDAhk2yXhFoj0w70SDaPpFmCA/4F1p/I33
         fwU0ZncW8wXSTX0jW6GRxK9UzB8L8YnXQufP9yCAYqwXoONmjxe4eavSAVaCPt9Ms3NG
         Oa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ond4fCjYXUD6XOn0ReDXyFHTo902oD1vmYkIA/0cHgk=;
        b=ufc55rLA9BzVDi2Q5W5QuyO1btjFYj+tlpOBOjSHG8IjjKTBiMzuCCdUNRDx1c71e7
         hF/jNHHqDnyTBCV/7RX9AI6NAb+9diLggk5cl+wWz/KyuUXzQJhw4FNvC+JHfB/C8cCG
         drLsIOpvQJ72DOKEQvtflSqHJRhMjfZkRdTBs8+2F+AG9V8jguzLMXSdl6WUa8/sWRnq
         oYBEVi4W5o09bO36fWaCEAT006nBsdjC/38N0RxtxA5qzdP5vFBbQKOd/h6dNpy6LsyA
         FjyJBc3mNz6g83brBPk/gLKstFge1VU17J2ZujDPIi6G9x1lnfoXqqImQ25OKgGKVYCJ
         EKrQ==
X-Gm-Message-State: AGi0PubPYA0H2o5Wp7zASDPqaRNPEM1ozowgC24wARmJazCkLmJbeFFD
        u6l+CXc0wUN6INc0kwF/pjjq0qeQ
X-Google-Smtp-Source: APiQypJ0CI8hOQU2tM9oeA0mD/CAFuf6xNSAGovb2s9lXO0+wmFYj9LPMGC1sA9gbYQqgRCPaIw9QA==
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr3396006ljk.42.1587299573202;
        Sun, 19 Apr 2020 05:32:53 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm1843547ljj.72.2020.04.19.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 05:32:52 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/4] strbuf: introduce `strbuf_attachstr()`
Date:   Sun, 19 Apr 2020 14:32:29 +0200
Message-Id: <c3012f1da361af354a904f821b83d61f2534ccb2.1587297254.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587297254.git.martin.agren@gmail.com>
References: <cover.1587240635.git.martin.agren@gmail.com> <cover.1587297254.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous commit, introduce `strbuf_attachstr()` where we
don't even have to pass in the length of the string that we want to
attach. Convert existing callers of `strbuf_attachstr()` that use
`strlen()`.

Note how only one caller passes in `mem == len + 1` and that the others
have been using `strbuf_attach()` in direct contradiction to how it was
(incorrectly) documented up until a few commits ago.

Now that the documentation has been fixed, you might say these are all
fine. But the calling convention of `strbuf_attach()` seems sufficiently
hard to get right that it's probably a good idea to introduce this
helper.

This could help reduce reallocations and memory waste. When we
pessimistically pass in `strlen(foo)` for `mem`, the strbuf will have
`alloc == len` and will do a reallocation, not just to get one more byte
for the NUL (which would have been a no-op), but because we're using
`ALLOC_GROW` under the hood, we will ask for 16 more bytes and another
50% on top of that.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 strbuf.h             | 11 +++++++++++
 path.c               |  3 +--
 pretty.c             |  2 +-
 refs/files-backend.c |  3 +--
 trailer.c            |  2 +-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 7d0aeda434..32cc15de0c 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -140,6 +140,17 @@ static inline void strbuf_attachstr_len(struct strbuf *sb,
 	strbuf_attach(sb, str, len, len + 1);
 }
 
+/**
+ * Attach a string to a buffer similar to `strbuf_attachstr_len()`.
+ * Useful if you do not know the length of the string.
+ */
+static inline void strbuf_attachstr(struct strbuf *sb, char *str)
+{
+	size_t len = strlen(str);
+
+	strbuf_attach(sb, str, len, len + 1);
+}
+
 /**
  * Swap the contents of two string buffers.
  */
diff --git a/path.c b/path.c
index 9bd717c307..3cd8fd56b4 100644
--- a/path.c
+++ b/path.c
@@ -815,8 +815,7 @@ const char *enter_repo(const char *path, int strict)
 			char *newpath = expand_user_path(used_path.buf, 0);
 			if (!newpath)
 				return NULL;
-			strbuf_attach(&used_path, newpath, strlen(newpath),
-				      strlen(newpath));
+			strbuf_attachstr(&used_path, newpath);
 		}
 		for (i = 0; suffix[i]; i++) {
 			struct stat st;
diff --git a/pretty.c b/pretty.c
index e171830389..5ecdf0cbb2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -590,7 +590,7 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 		return buf; /* should not happen but be defensive */
 	len = cp + 1 - (buf + start);
 
-	strbuf_attach(&tmp, buf, strlen(buf), strlen(buf) + 1);
+	strbuf_attachstr(&tmp, buf);
 	if (is_encoding_utf8(encoding)) {
 		/* we have re-coded to UTF-8; drop the header */
 		strbuf_remove(&tmp, start, len);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 561c33ac8a..eb058d85b6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1511,10 +1511,9 @@ static int commit_ref(struct ref_lock *lock)
 		 * the lockfile to. Hopefully it is empty; try to
 		 * delete it.
 		 */
-		size_t len = strlen(path);
 		struct strbuf sb_path = STRBUF_INIT;
 
-		strbuf_attach(&sb_path, path, len, len);
+		strbuf_attachstr(&sb_path, path);
 
 		/*
 		 * If this fails, commit_lock_file() will also fail
diff --git a/trailer.c b/trailer.c
index 0c414f2fed..56c4027943 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1095,7 +1095,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	for (ptr = trailer_lines; *ptr; ptr++) {
 		if (last && isspace((*ptr)->buf[0])) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_attachstr(&sb, *last);
 			strbuf_addbuf(&sb, *ptr);
 			*last = strbuf_detach(&sb, NULL);
 			continue;
-- 
2.26.1

