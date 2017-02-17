Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C4E20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbdBQOUR (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:17 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35180 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOUO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:14 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so4212103pfx.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82Vj4Dpw8r8XylO0iZB4g8H+oju3u6Y9BCEmqYNLn6Q=;
        b=o2jZyyy/4pY5R4fXrcww7MAmn5KIo/SlvPNMhCK+NubqZT1QdjyYU0EhXivSCyI5QS
         tT3xtDA7CmHr5PFDdb9900C0Neu2GANpKBqrTRBmwnWQLNRmwPz8I+nR3+NrQ9Ov3+Qj
         5bFTMkoy7DRsdzGtzEqEqOyJevQmH6a0j5AO8onpIIL+XUe+e4Rxv4W8OMLGAtU5Bv5x
         /LtO7gfJQlT+IigTVs0AKWYHnY8tgfkAmG6ZEiSrKzjLbK4hqlzoqKqkpwuWuK8aY6NT
         DDlNaH5nOCSF+S84l/DIqrWX0WvMoxwizBfTGyVOaf0W/VGAbkSEpd0vXX3ChOCORGKH
         2UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82Vj4Dpw8r8XylO0iZB4g8H+oju3u6Y9BCEmqYNLn6Q=;
        b=ZJD+Wk7DX0fko4tCqDUmBXoyHbB5GawQ+cJnSXDGnmCwX27BiMHQMnGu8y5MdtgnC4
         M7n0dhNw8/rPOMnytzhV38e4k5qcVwuwWFTaMOHqj1BCQqCGOHhMEGs6FwwguL1LAwhK
         fq3qBeFpjL9EAqXnZkChXE4kuzuzZH6S30EEWUJx5o3Z6qZFxsWUecFbSbSvW+1Epcjs
         KxV3BSKaiWUt5J6HDixxiN+c1P/M7pJSiIHURDdI2BtLXjjLh2BBGI1PG6WaRDpLKf/p
         m75eLt0pBIC16NrTfnZc8lJqmtpzi/WyPKE/LO1i/B2R9oR34M72IFJavMEBqy6etAax
         u8ew==
X-Gm-Message-State: AMke39momsCk0M/HRAGPfEAWAosOpoQoLhpzT9eLoT1PB5pU618zYj11LPSEIjIvdcrxnA==
X-Received: by 10.84.254.1 with SMTP id b1mr11479200plm.76.1487341214157;
        Fri, 17 Feb 2017 06:20:14 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id e13sm20173673pgf.48.2017.02.17.06.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/15] refs: add a refs_for_each_in() and friends
Date:   Fri, 17 Feb 2017 21:19:01 +0700
Message-Id: <20170217141908.18012-9-pclouds@gmail.com>
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
 refs.c | 39 +++++++++++++++++++++++++++++++--------
 refs.h |  5 +++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index fc6cca3db..37b03d4ff 100644
--- a/refs.c
+++ b/refs.c
@@ -300,34 +300,52 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
+int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
+}
+
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/tags/", fn, cb_data);
+	return refs_for_each_tag_ref(get_main_ref_store(), fn, cb_data);
 }
 
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
+	return refs_for_each_tag_ref(get_submodule_ref_store(submodule),
+				     fn, cb_data);
+}
+
+int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/heads/", fn, cb_data);
+	return refs_for_each_branch_ref(get_main_ref_store(), fn, cb_data);
 }
 
 int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
+	return refs_for_each_branch_ref(get_submodule_ref_store(submodule),
+					fn, cb_data);
+}
+
+int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/remotes/", fn, cb_data);
+	return refs_for_each_remote_ref(get_main_ref_store(), fn, cb_data);
 }
 
 int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
+	return refs_for_each_remote_ref(get_submodule_ref_store(submodule),
+					fn, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -1200,10 +1218,15 @@ int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 			       "", fn, 0, 0, cb_data);
 }
 
+int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
+			 each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
+}
+
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(),
-			       prefix, fn, strlen(prefix), 0, cb_data);
+	return refs_for_each_ref_in(get_main_ref_store(), prefix, fn, cb_data);
 }
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
diff --git a/refs.h b/refs.h
index 8e3b4e839..8fc82deda 100644
--- a/refs.h
+++ b/refs.h
@@ -575,5 +575,10 @@ int refs_read_ref(struct ref_store *refs,
 		  const char *refname, unsigned char *sha1);
 int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
+			 each_ref_fn fn, void *cb_data);
+int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

