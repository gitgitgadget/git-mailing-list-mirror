Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A6391FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbdFHXlw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:52 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33629 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdFHXlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:50 -0400
Received: by mail-pf0-f172.google.com with SMTP id 83so22171159pfr.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bmcdb1fKC6VbOoYPN6AwtvXA3xCBrcxKAsiMtZrDioc=;
        b=rYjGaKTS422tbtGKbmSM8sPka3P2czre/1bNrUSkcu1XvQd1JqjHN/8P0/TDgODWtN
         Y4rt5F0Y4mN/kZrS0oTshyquG3VETzy98vSKlyrFTrsoOsUbvYU/IJO3WrUo8o+jr3Gd
         j1Yd3W4R7O7VXe7FzDX/97Ed8WoLjewTanxS1nbdLo5cfTJ8ggiFitVolYBzRZYsXpSc
         IJFNRYEm6qjNy5lqQ3ze9iZ3gDUF2NDzZREPZo0YAS+lGNVOxxQY2VFgJ08D2OEWM4Jg
         ZHyitjHbfI2cZIjGkFXCkzbwIjo7SMxKFdPABZMDltjJgFaFLVwIXcgVzm1uk9c+CuDF
         BiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bmcdb1fKC6VbOoYPN6AwtvXA3xCBrcxKAsiMtZrDioc=;
        b=ZLXAU7eJhkUJR9Oxz1yEgNhQWARRlSSU2NXo1Qlr+VqhWgSIZGbsF6jaWa41NqmIXX
         wv5idrqNr+GCYN0G3hkUM27RAwCKSUFcNBTCw9VastyhTADNRBMBDX+0dD9PlEzTSuhw
         VLSAOoqwRMFbm7M5cJkR/S+RqqqbQZUq7eW3pdPoNqgIvLYoLBGUAjwM48j2gEifI6yK
         sPdAvrwwCOhPcYiE9CGoOn3H6bI958n5f9TV9fdjrAB1NmV26uURUuGuwjUnXsJu7TBV
         eNrE/YZA7O3EW44gV78j2rpAAtsbqIcYAN+dm/oH/TQu4SMYpmcCFiBmsVkK7cZx0VEQ
         eByg==
X-Gm-Message-State: AODbwcBINGGbTdDvlyio2E2FntxJXqrpL5NooEluscor93R9uwnEayCg
        rr+ThbdUJ/X4RbUBLXXy7g==
X-Received: by 10.98.50.129 with SMTP id y123mr39525634pfy.53.1496965304001;
        Thu, 08 Jun 2017 16:41:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:42 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 18/32] convert: convert convert_to_git_filter_fd to take an index
Date:   Thu,  8 Jun 2017 16:40:46 -0700
Message-Id: <20170608234100.188529-19-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
index ff3e72657..824b606fa 100644
--- a/convert.c
+++ b/convert.c
@@ -1109,7 +1109,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
 
-void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
+void convert_to_git_filter_fd(const struct index_state *istate,
+			      const char *path, int fd, struct strbuf *dst,
 			      enum safe_crlf checksafe)
 {
 	struct conv_attrs ca;
@@ -1121,7 +1122,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
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
index 44561e0b9..80e9ef3bb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3581,7 +3581,7 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 	assert(path);
 	assert(would_convert_to_git_filter_fd(path));
 
-	convert_to_git_filter_fd(path, fd, &sbuf,
+	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
 				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
 
 	if (write_object)
-- 
2.13.1.508.gb3defc5cc-goog

