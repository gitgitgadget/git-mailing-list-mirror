Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3CE20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934405AbdBQOUM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33081 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:09 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so5070928pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcg9Yb2NiUAbgofJfWgzDkyrI9cpBZ4fRTxg87cdLjo=;
        b=e4MrmU5vJWBEVClegHyxPkBu0JqfgOf7ljCXOkKYefLARXChgFugYI+PBmmX3pk6rv
         BNUbWfHXmPQVg/Nh64t0voaYyhTzTClaCOieKmiWu7nmdskZ65/pilUe24naveqAsdY5
         DtboCbHR4lWqsgLn67mQ0Bx7tZUACp9xqQ5sT2RRbvmRpLqsp5zmjOT0/9bRKaHAWPYM
         xYBCKK4He/uKtaL5RTo8+CApatNJrCALiZD9zE5ptnsryxyaRle5PlzZyKJItUuXXzKj
         7zJDaAgnc9fbJBLxxti2rK7AaHYlBjocvGYimgCJIJZHBDgslYBLMKWQ2N9SNEbf1gHF
         Rdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcg9Yb2NiUAbgofJfWgzDkyrI9cpBZ4fRTxg87cdLjo=;
        b=RCugllzp4S4PdfZuzPxHyOr6R3K1HTYpDeW6+S2ay5n8NFpyJ7MeJD1vPhyCz0c/t4
         9BgNg/aYZ3jzg+Z2lUo2FsldlLpgTp8DvpiLcwvSMH6aaOmqOFOzUWpxyaLXn5/f21Xl
         sr1p0GO46l1m5Xfjt5WMyU/gdLlKPIyIxMSOiG2gCZ4jf0hLFYFefB/YL8g4rVAF8qwG
         +3qV+SNJ1C0jRnwxLRCsJbWQpZQe2eKiD7s31788hFuGEhAaKIk8ldhTQvIjQsfxEvEG
         xCcNJAXyGcS2GrfjPepKs9Tuuas10NC0gKkbcGVuE4rscYvcEZ0v/TbP25wnMUu7wS/V
         dNHQ==
X-Gm-Message-State: AMke39m60F/RDOd7Ba9S2bb3ndlwSs4gA5LkQrZGv9k0ytF2Ua2GxoyZfRYwpfsfkF5xKQ==
X-Received: by 10.84.135.34 with SMTP id 31mr11601222pli.50.1487341208852;
        Fri, 17 Feb 2017 06:20:08 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id e13sm20178130pgn.38.2017.02.17.06.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/15] refs: add refs_for_each_ref()
Date:   Fri, 17 Feb 2017 21:19:00 +0700
Message-Id: <20170217141908.18012-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 33 ++++++++++++++++++++++-----------
 refs.h |  1 +
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 26758b8cf..fc6cca3db 100644
--- a/refs.c
+++ b/refs.c
@@ -1170,10 +1170,9 @@ int head_ref(each_ref_fn fn, void *cb_data)
  * non-zero value, stop the iteration and return that value;
  * otherwise, return 0.
  */
-static int do_for_each_ref(const char *submodule, const char *prefix,
+static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
-	struct ref_store *refs = get_submodule_ref_store(submodule);
 	struct ref_iterator *iter;
 
 	if (!refs)
@@ -1185,19 +1184,26 @@ static int do_for_each_ref(const char *submodule, const char *prefix,
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
 
+int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(get_main_ref_store(), "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(get_submodule_ref_store(submodule),
+			       "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_main_ref_store(),
+			       prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
@@ -1206,19 +1212,23 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(NULL, prefix, fn, 0, flag, cb_data);
+	return do_for_each_ref(get_main_ref_store(),
+			       prefix, fn, 0, flag, cb_data);
 }
 
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_submodule_ref_store(submodule),
+			       prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base), 0, cb_data);
+	return do_for_each_ref(get_main_ref_store(),
+			       git_replace_ref_base, fn,
+			       strlen(git_replace_ref_base),
+			       0, cb_data);
 }
 
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
@@ -1226,14 +1236,15 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(NULL, buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_ref(get_main_ref_store(),
+			      buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "", fn, 0,
+	return do_for_each_ref(get_main_ref_store(), "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
diff --git a/refs.h b/refs.h
index 54c038e3c..8e3b4e839 100644
--- a/refs.h
+++ b/refs.h
@@ -574,5 +574,6 @@ int refs_read_ref_full(struct ref_store *refs,
 int refs_read_ref(struct ref_store *refs,
 		  const char *refname, unsigned char *sha1);
 int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

