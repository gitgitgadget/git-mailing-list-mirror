Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D72B1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbdEaVqC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:46:02 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34363 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdEaVpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:10 -0400
Received: by mail-pf0-f176.google.com with SMTP id 9so18583695pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PDnUkzXVmSihJF0JI0AiUZLzNh1vk+8PlRAki+6MhK0=;
        b=U6KJkkTjvq3BXFbfF+xLvhJJ9LZDxjWzQxfc6d6tnQW6HkWtwLKGd1+V9N5EoXuy91
         v9+8WDVuVLqdRKUTtBM3BLGH7JvP5ZXL76ANuLCKQok+ZiXkXYlINAGXNFKBCrWNvVXH
         H2If7U6aT5XPRI76MwCEIDLkYdlXOA1pN6TYSbS/EGTS68qSzSNXpjSj+U7vpIBBOYBH
         Cg0f7s3ZVeClH7mz0WL/uBi2SuvrExYa9dxFznOZcX40SrdG5SstuYuJZyCaq81VW10s
         N5Fqa+9p5UwrGiVopGfr6tHlr8Le9sJW4xmIoSqXwOYn2PTkl5E7R75cLpQ2i6DWeWJN
         FTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PDnUkzXVmSihJF0JI0AiUZLzNh1vk+8PlRAki+6MhK0=;
        b=rxGbIO0BKuFnEttXYMCIvMnzr2VaNKHsrf05rxlPCIJlvz0+sdYdRKvVQKbhi2+bKe
         hAiQ3Q2CAPB+rQtxl2V0haIwnbuBQ9gfloAc33IFFv9mvMqjRidot4lvdzaQgtnbhUwv
         GgbDwvZ7PjUyWgmmzGS2u9p6dSsH3Phwgk+p7ItZCN8XumF0dnc27I8ZyRVCLbNg/HnZ
         85nQThzoHo2o5/N/JkPL3rky2Ozns+vVOD3i2tDq5LpDxKO+CzF/5r2qtmoUu4e6WzB6
         Fl7MsgpK7zrI/x/KwEcClayoJFWWNW3tIhdQeeoEdkdKL6QmHPbYIecTDLW+U38uYAlp
         WTCA==
X-Gm-Message-State: AODbwcCL0OjE+nNFL/WvULWzjt8dRR3RGClgC6CAvQLiBpBi/1W8PvkL
        f/0dVyornosW/WhCbPG/ww==
X-Received: by 10.99.115.29 with SMTP id o29mr36176884pgc.140.1496267099243;
        Wed, 31 May 2017 14:44:59 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:58 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 17/31] convert: convert convert_to_git_filter_fd to take an index
Date:   Wed, 31 May 2017 14:44:03 -0700
Message-Id: <20170531214417.38857-18-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
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
2.13.0.506.g27d5fe0cd-goog

