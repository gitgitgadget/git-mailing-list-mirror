Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E66D1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfHGVjy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 17:39:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33334 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfHGVjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 17:39:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so2042038pgn.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2d9hzHtsNy+lwihRcEFRhNq/3DTOD3fwiPkRvW/vqc=;
        b=kZwxSX+7zRa8QquchDtO+vq0J4dYbjvRVtaggl7PgKbQ4/sR9i02MfBp0q4LtxdDjr
         wDfBv9RmDTYbWlCoAdDKbqqc7VmnNHdvnQgu4MxQYtyjwTZHNAp1Uj67HT2O4YAg+Iye
         +laJcH9QEu8bbKEqhiRuHHO6v0PFD5wEl9w5ALw0JoppjWgNN3RKRgisSka25weTEq3e
         GoyAcqnrnyhnvZdvu5sWC4nWkf3EygZ/ogLqvmbL1PiErWxqiceIZsGl8dhyvUX08w14
         dKPFaPCn2b59OeBXckyTfR3sbGjTn5DJzL0NI445kZCwj7mBHOJRymh9kUHHrgXYpzlj
         Wu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2d9hzHtsNy+lwihRcEFRhNq/3DTOD3fwiPkRvW/vqc=;
        b=MC8pOBHP2T3PtVf3At5LZX+dQ8jF/aFWkG+fWEGb4SpU1Hae9VNj74kRyKxLzluuxD
         xsAcXiQ3o4X3CvdNzx5jGcQB+SzMJkJqDr7Wr6c4kC8GVG/43JGWb5ib1o5sA1ghT8Z8
         Mg1Ko6yzc7YvT0mpjfmKp2wsz5dqBzwE/Ab0ivjS1KbPM3uiog2atS7ShKsZdOMFrh6k
         O0mhZCgD7zZcyzwYuYtsv+PTTuP8W7vg8PEFSWSuZU8yC6X6a1BkxmPFNbFSjsSKA5g1
         s8HDoA1etcT9AoJEwiTo6+vqTtDLJmOqJ70ExxQ9e9LtB/eglfxPB4tA2mgnIIr+4OwJ
         cq4w==
X-Gm-Message-State: APjAAAU5YYvBwlxTRxnNBeV9PrqAVaAa2OWvJQE6qlh0PT5qeKbJyDsT
        RKfkzBg7sIYpOahBvaZWHaSpNTEUX5A=
X-Google-Smtp-Source: APXvYqyi2YiqMWNhXxCb5ddCoNeXWb6ObmlSw7s9k1xnmzxLY2bAzRiWTUUKv1K+IBxsx19bI0vDOg==
X-Received: by 2002:a63:7e17:: with SMTP id z23mr9666215pgc.14.1565213993153;
        Wed, 07 Aug 2019 14:39:53 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id b24sm63840303pfd.91.2019.08.07.14.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 14:39:52 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v4 1/3] grep: make PCRE1 aware of custom allocator
Date:   Wed,  7 Aug 2019 14:39:43 -0700
Message-Id: <20190807213945.10464-2-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190807213945.10464-1-carenas@gmail.com>
References: <20190806163658.66932-1-carenas@gmail.com>
 <20190807213945.10464-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09) didn't include a way
to override the system alocator, and so it is incompatible with
USE_NED_ALLOCATOR as reported by Dscho[1] (in similar code from PCRE2)

Make the minimum change possible to ensure this combination is supported
by extending grep_init to set the PCRE1 specific functions to the NED
versions (using the aliased names though) and therefore making sure all
alocations are done inside PCRE1 with the same allocator than the rest
of git.

This change might have performance impact (hopefully for the best) and
so will be good idea to test it in a platform where NED might have a
positive impact (ex: Windows 7)

[1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |  2 +-
 grep.c   | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bd246f2989..4b384f3759 100644
--- a/Makefile
+++ b/Makefile
@@ -1764,7 +1764,7 @@ ifdef NATIVE_CRLF
 endif
 
 ifdef USE_NED_ALLOCATOR
-	COMPAT_CFLAGS += -Icompat/nedmalloc
+	COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -Icompat/nedmalloc
 	COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 	OVERRIDE_STRDUP = YesPlease
 endif
diff --git a/grep.c b/grep.c
index cd952ef5d3..0154998695 100644
--- a/grep.c
+++ b/grep.c
@@ -150,12 +150,22 @@ int grep_config(const char *var, const char *value, void *cb)
  * Initialize one instance of grep_opt and copy the
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
+ *
+ * If using PCRE make sure that the library is configured
+ * to use the right allocator (ex: NED)
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
 	int i;
 
+#ifdef USE_NED_ALLOCATOR
+#ifdef USE_LIBPCRE1
+	pcre_malloc = malloc;
+	pcre_free = free;
+#endif
+#endif
+
 	memset(opt, 0, sizeof(*opt));
 	opt->repo = repo;
 	opt->prefix = prefix;
-- 
2.23.0.rc1

