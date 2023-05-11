Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E7C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbjEKTtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbjEKTtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:49:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955E72A2
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-518d6f87a47so4445430a12.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834513; x=1686426513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=frkXVvp6yG2x745+Lt+a4pQaSaIgvbG38H+8YGuxcbk=;
        b=gxkbhHveQuRy0fmuGBdbSXJD2NB74CfGwh7EYisqu1NdjVWFnkFW0g96d7kbwCK+1W
         tlxWQxCOuBIrq6KKmhctxazG7SKU9NWGJ8iSkcdleZ+GpzwOBPccG300c+NsZGDJN5IX
         MFXVQFhGyeFL67mqj+bj+ZlllEOQGtGyGJoeli9uEX1EcwDFTKUr562FjuXNl6jzjaBC
         lzTy55ShuMvk8hMtzTPCk492RdmxgtUNV80sNixsPaVT/KXWHEw2JvEHSBK/Zpuyk1MT
         YcEQj4CbgEMFWj4VYdz9inVH79g6VYQyhshZKjAAt9A2r2Kdyoxk/scZjb0DgsMEklD6
         c1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834513; x=1686426513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frkXVvp6yG2x745+Lt+a4pQaSaIgvbG38H+8YGuxcbk=;
        b=BXcO+rwvE6ZemUPhh1ha5tUDtbvCZFp9KEfCBSOah66MZbbalzpHNFkTRRLabDXqGj
         WC0yk9Zwo+nj7thmpR9S81esa9G/mAhCo8iJgaO0POlhZXYtpmxPQ2lxBufsG1mRfcMm
         TFNcSjXIotXE/oPZYX3vkYTOp+iOYMJagAt87usf0+55cjHyeUixX2yriCN84j8mU6zP
         uK/rYrhT82LTpPhfrrktvhcy/J6e7//wDRe0PF35xRkCdxjXZ2tbHxlwuEgvYOepxwJC
         YkEVQgoVb1WJbqXDrqqYBsC4fgsI2P3LeQKvPbVG6M9lL5cmAVaO+PqPgGi1ImV9vaDL
         Sppg==
X-Gm-Message-State: AC+VfDwj+8P7z4g09UT1VpTj8Lj9NjrfspteCpNSxwDXbrf0nrPGpUGw
        t8lu8THJoRuigvIVIgEaCbncixO5dMyXi99dJ0f31LzDKzC6iF0+HkhG6k6CMPorL0cqhEVKp0j
        G8VfudMjCqfEDIW/lJikMapNOsVLp5LiMU96UfRAdBlq6Da+HYSapFdmXMuDcpfKaXA==
X-Google-Smtp-Source: ACHHUZ6E/HU7RP7guVc+piirzHICH6aazcEq5Uyzhgrg/H9kjoG5NU2cxnpvZBtyErgAPKW4o88bBMdOmCUTLVM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:6b04:0:b0:51b:8f87:6da4 with SMTP id
 g4-20020a636b04000000b0051b8f876da4mr6200482pgc.11.1683834513146; Thu, 11 May
 2023 12:48:33 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:20 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194822.1493798-5-calvinwan@google.com>
Subject: [PATCH v5 5/7] path: move related function to path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move path-related function from strbuf.[ch] to path.[ch] so that strbuf
is focused on string manipulation routines with minimal dependencies.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 path.c   | 20 ++++++++++++++++++++
 path.h   |  5 +++++
 strbuf.c | 20 --------------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/path.c b/path.c
index 7c1cd8182a..e17a2613c5 100644
--- a/path.c
+++ b/path.c
@@ -1213,6 +1213,26 @@ int normalize_path_copy(char *dst, const char *src)
 	return normalize_path_copy_len(dst, src, NULL);
 }
 
+int strbuf_normalize_path(struct strbuf *src)
+{
+	struct strbuf dst = STRBUF_INIT;
+
+	strbuf_grow(&dst, src->len);
+	if (normalize_path_copy(dst.buf, src->buf) < 0) {
+		strbuf_release(&dst);
+		return -1;
+	}
+
+	/*
+	 * normalize_path does not tell us the new length, so we have to
+	 * compute it by looking for the new NUL it placed
+	 */
+	strbuf_setlen(&dst, strlen(dst.buf));
+	strbuf_swap(src, &dst);
+	strbuf_release(&dst);
+	return 0;
+}
+
 /*
  * path = Canonical absolute path
  * prefixes = string_list containing normalized, absolute paths without
diff --git a/path.h b/path.h
index 60e83a49a9..639372edd9 100644
--- a/path.h
+++ b/path.h
@@ -191,6 +191,11 @@ const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
 int normalize_path_copy(char *dst, const char *src);
+/**
+ * Normalize in-place the path contained in the strbuf. If an error occurs,
+ * the contents of "sb" are left untouched, and -1 is returned.
+ */
+int strbuf_normalize_path(struct strbuf *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
diff --git a/strbuf.c b/strbuf.c
index 6533559e95..178d75f250 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1088,26 +1088,6 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 	strbuf_setlen(sb, j);
 }
 
-int strbuf_normalize_path(struct strbuf *src)
-{
-	struct strbuf dst = STRBUF_INIT;
-
-	strbuf_grow(&dst, src->len);
-	if (normalize_path_copy(dst.buf, src->buf) < 0) {
-		strbuf_release(&dst);
-		return -1;
-	}
-
-	/*
-	 * normalize_path does not tell us the new length, so we have to
-	 * compute it by looking for the new NUL it placed
-	 */
-	strbuf_setlen(&dst, strlen(dst.buf));
-	strbuf_swap(src, &dst);
-	strbuf_release(&dst);
-	return 0;
-}
-
 void strbuf_strip_file_from_path(struct strbuf *sb)
 {
 	char *path_sep = find_last_dir_sep(sb->buf);
-- 
2.40.1.606.ga4b1b128d6-goog

