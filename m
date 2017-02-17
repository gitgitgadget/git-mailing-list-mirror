Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFF320136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbdBQOUG (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:06 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33508 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so4203321pfg.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqScx05NbLgs2z8S4J8kCG29Kdjw18yVL3LxxvGrqxw=;
        b=C2LN1KdpGKKcJ+ZPqNgpJEGh1f3laPOp/0nvstsUGptPnR9J5k5ZfCEUutjeGQ+1sK
         jwkZXD7AK8ekbqymnCIULgc9OdyiUUDHvIFBJyNHHu4KDpdlqZS7H1A7boNXe+azLpNX
         XJa4LROV7M5AYfpJ5GRY/55/zxGEFZhIuhLY8YYN+LzrNrIIIYXf1Cg8UMHMDbGq0M0H
         GEWS5Xl3DmdxdnJr3z5z0qD39Z89o5lbjlih/43JHYemXV7WaPXGSiemH0sQFwLzBR74
         x6hxzBSpQ+Z1bCJsLK5wjJ+gOiWqgRjxeKgG0To2BZ2CMg87xVQIin7K/t965HUXv/VU
         KnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqScx05NbLgs2z8S4J8kCG29Kdjw18yVL3LxxvGrqxw=;
        b=O221C5elcs6ioX6beWhkpDzbQHSR9omdbdmnvKjNDHatc2nZoiLEPAjQhFQHVSL5kB
         VzKb5JHgKyLii3LV73OoNvS6sdqfyiDMKiyc/0ul4tWpDIRBfWzOHOpjunWAMJ8v3KDT
         9tnlZp1xKSkRBbzFW1Tp5kOosPStwVduGb3u7w0FHmHL/2lA9eNxAYf2ehioezTusFVv
         sTOxy2GuaWSI6Dtn1wCYCSRdPnqBQDon1bxdt5cmjfL+P3j94Qb1JpNVC4uYzXqjPyLF
         VusliqBJFhbAt2rUPeKc6EDoHLPoFNdYPExfCBxOHcqbIK9XEsaKIUt2alvzUR21yhJa
         3C6Q==
X-Gm-Message-State: AMke39ktcScWvbI7JlipbkPN0SJeQSkfoA8ua/C+7T/ZVRQ/9wv+BW3TJWqNGhHCyRGWDw==
X-Received: by 10.99.241.17 with SMTP id f17mr10343944pgi.94.1487341193310;
        Fri, 17 Feb 2017 06:19:53 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id w123sm20079557pfb.44.2017.02.17.06.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:19:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/15] refs: add refs_read_ref[_full]()
Date:   Fri, 17 Feb 2017 21:18:58 +0700
Message-Id: <20170217141908.18012-6-pclouds@gmail.com>
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
 refs.c | 19 ++++++++++++++++---
 refs.h |  5 +++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9c86c44b8..06890db5d 100644
--- a/refs.c
+++ b/refs.c
@@ -186,16 +186,29 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+int refs_read_ref_full(struct ref_store *refs,
+		       const char *refname, int resolve_flags,
+		       unsigned char *sha1, int *flags)
 {
-	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
+	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, sha1, flags))
 		return 0;
 	return -1;
 }
 
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+{
+	return refs_read_ref_full(get_main_ref_store(), refname,
+				  resolve_flags, sha1, flags);
+}
+
+int refs_read_ref(struct ref_store *refs, const char *refname, unsigned char *sha1)
+{
+	return refs_read_ref_full(refs, refname, RESOLVE_REF_READING, sha1, NULL);
+}
+
 int read_ref(const char *refname, unsigned char *sha1)
 {
-	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
+	return refs_read_ref(get_main_ref_store(), refname, sha1);
 }
 
 int ref_exists(const char *refname)
diff --git a/refs.h b/refs.h
index bce77891a..229a97f59 100644
--- a/refs.h
+++ b/refs.h
@@ -568,5 +568,10 @@ int refs_create_symref(struct ref_store *refs,
 		       const char *refname,
 		       const char *target,
 		       const char *logmsg);
+int refs_read_ref_full(struct ref_store *refs,
+		       const char *refname, int resolve_flags,
+		       unsigned char *sha1, int *flags);
+int refs_read_ref(struct ref_store *refs,
+		  const char *refname, unsigned char *sha1);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

