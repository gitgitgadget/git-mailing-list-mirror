Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CEED20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbdFLWO0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33497 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbdFLWOX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:23 -0400
Received: by mail-pf0-f179.google.com with SMTP id 83so57292950pfr.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kry4PVi9yzC/tOnnj/5bqLO1deuBj/og0si4m6zz9mE=;
        b=CLmrA7TGgRtSpdepIOOScUL8DwMcOcIRXQd6ZCl6FJI7Gy+9TQ2mjqORmo4Ivh1ka0
         7BC49ojWi+toe8mwcsp4Jpbb2A6HL4xgAE34PQi2mm7VYWQYPTnFIaJ3UkCC7bcvfXQG
         vWfEQi2YVyHzA1n6nlTyqcfebOZF4hn0vHc5y76p3cfd7PxIc0gt5Fe8fBEuB+HSH7zK
         vuFYf6pBOq1LmPVKmeMDCol31/MISQYthL78fhaiE8jAVqkpAiWmzCpyyAhq4Jmd19Ud
         lLBrkuf4p9aIt+AxhBNUe7IfHcAZPRyUlJ8faWo9A3dK7tzqqRyj/6Mzd854BROwtD2B
         wrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kry4PVi9yzC/tOnnj/5bqLO1deuBj/og0si4m6zz9mE=;
        b=FryCZhT7VLbrgQBjli3KWk6B4uwH9CwJ5eqFwjZ4ZpP6rLWmkQAOSWTs5lbCpuD5sV
         xp4kYmtfS081xeRnz0Tlq88+vcfqN1HiGF9czVmKpJ/TPQofBZCBV2L9qu5O20bs2cEv
         rglD/jn/Mt5TExFYQXbGwk1mXWkhGCTD8Ng8xYtAazS4tHRWI+/Vc657oVlrpfhs1ZxR
         oDyKrpqiV+kFleCBd7tOXoB+FIbjbFx/SeEUBHQzDvsB7Nx+xk2RTQ2vK0yhF7o4yqf0
         oXCobwyDe47lV7gRC9CifH6DlrmZCRZKLO1GYhbEhNQLsEfPko33/tvsat30idSOrPCD
         HCRg==
X-Gm-Message-State: AODbwcD1sn4Wq3OsOA4+lKokKKbtaEYEsoo0MuFjCwicbPKWYKhsdFE1
        0jLVW4Njp9kuU+OmleJIOQ==
X-Received: by 10.84.175.3 with SMTP id s3mr58114556plb.105.1497305662278;
        Mon, 12 Jun 2017 15:14:22 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 03/17] convert: convert convert_to_git_filter_fd to take an index
Date:   Mon, 12 Jun 2017 15:13:54 -0700
Message-Id: <20170612221408.173876-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 convert.c   | 5 +++--
 convert.h   | 3 ++-
 sha1_file.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 0cafb06f5..c09242cec 100644
--- a/convert.c
+++ b/convert.c
@@ -1108,7 +1108,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
 
-void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
+void convert_to_git_filter_fd(const struct index_state *istate,
+			      const char *path, int fd, struct strbuf *dst,
 			      enum safe_crlf checksafe)
 {
 	struct conv_attrs ca;
@@ -1120,7 +1121,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(&the_index, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
diff --git a/convert.h b/convert.h
index 667b7dfe0..3a813a797 100644
--- a/convert.h
+++ b/convert.h
@@ -52,7 +52,8 @@ static inline int would_convert_to_git(const char *path)
 	return convert_to_git(path, NULL, 0, NULL, 0);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
-extern void convert_to_git_filter_fd(const char *path, int fd,
+extern void convert_to_git_filter_fd(const struct index_state *istate,
+				     const char *path, int fd,
 				     struct strbuf *dst,
 				     enum safe_crlf checksafe);
 extern int would_convert_to_git_filter_fd(const char *path);
diff --git a/sha1_file.c b/sha1_file.c
index 59a4ed2ed..ab09241d2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3580,7 +3580,7 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 	assert(path);
 	assert(would_convert_to_git_filter_fd(path));
 
-	convert_to_git_filter_fd(path, fd, &sbuf,
+	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
 				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
 
 	if (write_object)
-- 
2.13.1.518.g3df882009-goog

