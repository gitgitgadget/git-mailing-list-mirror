Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABD31F731
	for <e@80x24.org>; Tue,  6 Aug 2019 08:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfHFIuR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 04:50:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43674 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbfHFIuR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 04:50:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so41134146pfg.10
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3wfUL1oq6LZGt4YGr/G7fLpdG8+NZ30Lo8f//2/HuM=;
        b=RIhLKqBYtIoAhqe0WlYGFOGIv8px9cSapE2kXL7B62GfOSx1YUM5QQ2TDRWXA6i7wI
         ek5Nl/9/93N10Drnd0aZ5CTCu9pJpURFzj+zcUFNNeox5iEtgj+o6Zbun3Cj5O9O01yA
         FxLnieX6nQSffEC/W5T3WRNojNvM03CT0J2ehplRA+NHaCQOqusEO6ZYfvl/OJMfsW4S
         l8v/M1ErnwGUGOiiRzTKBw6s+TCdfZAkBUUJoCy8GOFq0aaaDOU9wnPtAlxi4ebpwz7m
         eOgiISNrJ8lNh3EqUu8oYX5+0I7V9dER88LuqU7Yaaoh5ZEq6eXngmmgmi6SzCeXZlrG
         5nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3wfUL1oq6LZGt4YGr/G7fLpdG8+NZ30Lo8f//2/HuM=;
        b=ha/BzHakoTFvJXwgBmcFrRtV2dLKSNnZtJkA2dYc7koSms40dTRr/nKu1jJZ4psq/E
         3ikFz44kcWYpfzpSzOv5tPcviujZKk3qS5qW7JgaQkP0rE9qh/exAcNt7/EbEwKjFDix
         Ir/fDv2H3AqouEUPcvu+Gh/TAC13Px5c28T8w2FPkgRx1fWFAOv9h3nd6PlJmG0AwBrq
         P3lF2Ba0bsSW+cx99eT54c3H6kfV7EKbENstR0Ck7YDO2HYRTQJw8BE6MT0f3kkJdRCJ
         Is54ukd9jTGeU/wtNeP9IZK15hEgFo6RLHd4b62wYkGUKdj5FH+KkIVuIhJEjIDs5gq+
         HduA==
X-Gm-Message-State: APjAAAWOj6Rl0lCMyxDi1G42irA1Y6feibdefUqvrNBbRU+J/JpDJHmT
        BJGVaENO0hluIhoqN0Kkxak=
X-Google-Smtp-Source: APXvYqw64sSRXp0XspwyTqOI2H+Gnv6gnbDqEmaSyBq8+IPx9pfMEnDBqVDLKLfqC4V+Q3WeIU9wHQ==
X-Received: by 2002:a65:6458:: with SMTP id s24mr2035306pgv.158.1565081416526;
        Tue, 06 Aug 2019 01:50:16 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id j5sm75743830pgp.59.2019.08.06.01.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 01:50:16 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: [PATCH 1/3] grep: make PCRE1 aware of custom allocator
Date:   Tue,  6 Aug 2019 01:50:12 -0700
Message-Id: <20190806085014.47776-2-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806085014.47776-1-carenas@gmail.com>
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
 <20190806085014.47776-1-carenas@gmail.com>
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

[1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
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

