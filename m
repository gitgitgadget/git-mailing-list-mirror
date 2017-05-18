Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC4A2027C
	for <e@80x24.org>; Thu, 18 May 2017 23:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754490AbdERXWP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:15 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36337 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbdERXWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:12 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so30747327pfg.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=igSblXQwnrjsfBCq4kImSk74JowJiMkh6IclGxKZHys=;
        b=VJg/vkh+dZuIHOkhyhT9f/PWkc6a7CCQhE/yrdd2baRw0xXzO5uyMjK3Uux/eolHyG
         rRQSGW4Z63xVCKjT173/jtKCnzqeia9j2JKURDFRRdJtjjQewJ0NmZ8t5cHL3bLp4etN
         Rq7obx/xmK1R0+y0Uot4p0g5xdVOpgAzhQQdGsOiROQShVtEUZbTjHzl319LgRNaFKK/
         g04n+4+yAcfLemwgD+jOpwKXRmLlIwuDZvCyrLjCXw+uVoZFef2RhlHwKUtdMp3hWilX
         ll3JomJTIPQW2sWlHJQaeY8l6ayuIwHMjYeUJtbKTWBo7zY7DWyMGkyw1Cb4eQU/++LT
         8Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=igSblXQwnrjsfBCq4kImSk74JowJiMkh6IclGxKZHys=;
        b=XzojnHmVrbUvJboSrthNQeTSYGnqUq3pTTikdyg6em/v6OBqS5MwMcAYDeOhD4bZFX
         vxfTU9R+WNxsPPTnXhHBQfk6OvcrXyS/2jY/+zX0EvXQ8jI3lb+5pdt02LGTqRSqMQ/B
         hjxoWQY/ubydmIRTLASJZ9tqumMPJlEir65ch8FZ4451LqBwMSXELXAz8snvJHNDZMF1
         hPhb9oQBzETOSQGNUjzKCN/CagE0pNzxpjG/6d5X2gyY+oDQy5+2HbazTgyY8xWGBAUb
         kzl/Dmz6Spusz0AyIX7Y8WxML8YtOoV5Ua4AKOt396zsZaZVIQFdkvwAyheqNUD9MZpL
         uS0Q==
X-Gm-Message-State: AODbwcCgEiKgpPcpJI0GWLrNTSqqF8Zrcbsnr3EgWHZP/XiAiO4gtvgh
        K9ZtX5hyVkHoYdxA
X-Received: by 10.84.171.193 with SMTP id l59mr7559108plb.139.1495149731873;
        Thu, 18 May 2017 16:22:11 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 03/23] convert: convert convert_to_git_filter_fd to take an index
Date:   Thu, 18 May 2017 16:21:14 -0700
Message-Id: <20170518232134.163059-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
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
index f5773cfe1..d50e7f7aa 100644
--- a/convert.c
+++ b/convert.c
@@ -1203,7 +1203,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
 
-void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
+void convert_to_git_filter_fd(const struct index_state *istate,
+			      const char *path, int fd, struct strbuf *dst,
 			      enum safe_crlf checksafe)
 {
 	struct conv_attrs ca;
@@ -1215,7 +1216,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
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
2.13.0.303.g4ebf302169-goog

