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
	by dcvr.yhbt.net (Postfix) with ESMTP id B80301F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfHFQhD (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:37:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34186 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFQhB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:37:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so41795889pfo.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWDwMajnzuNnNydXZ2TpOxl7woySDxL4YmO8kuthpR0=;
        b=H/KURsP343PRfEOrVk1bnjmeQBpz4C3UyucwXIAZg/GLsUB/+Am+Ldr+GCCGpinRG0
         tHGAVcYccT18CBeEDQYZAZoZqE0HHhwj+7l+7TXSEt+yNFSmCO+no8wy736452y7ImxD
         2yIzbLbZ4x0qU7NATW0yfbyVUybZWBqHk44m0eu2LWb5XjIKw7hmuSQsTOgGTQjKwMqK
         8JB/4ry3hQRg6JjSCkAjf/AXEsJyEMJTUNePx8hKp2phxW6Yf/gANauN4hLPl5lLQkLT
         czXMx2cbbBy4mKK8QJE36Skjk8vnvZZlpatdZh1pH5LFT6GTm2buTRxhIlPfJoOCMnkq
         PaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWDwMajnzuNnNydXZ2TpOxl7woySDxL4YmO8kuthpR0=;
        b=SlzYbK6QmTcbcxuY9XBXC/S9PqK7BW1T48xWv5ZBGAcrO78J/AN2DPu3w22M0lAiaj
         tExXCzuknTDcWlsFziXMYYDgYOH1QqAJfdE9mP8rTb6+iGSnTcZ+kQkjoieqszCo0Xso
         5juBXxibqxNukAWUVpJN5JMaYjr6CwkOo53iMPi7UvJw8p4j2X4jty5FkXdvpqHjkJLY
         ka6Mi+csq39nPTPRyfaImJpO0y8Pf/rtbheN6lbEQDGkZ2+le3/ENvNHR/XgKGhBo3aD
         Pmd5ADTzpFe9zzW4NNOZryDfKmd78RxVH0aFMkuW//AWczoSqUFIjXZfDZvKkmPgmOWY
         3KmA==
X-Gm-Message-State: APjAAAURC2grLd4CcFvoB7xeiT+af6ewd/rtM+D9+job8iLf9bhGQW5P
        O7tjE+MSpHlcEJTipqKKgoujhsmd/Ac=
X-Google-Smtp-Source: APXvYqzvD1WBFVme3w80a4GZPSM0RDZjHmDekSZwDQeYZKwjw96d4mgEfp7Q7ZF6vujOWueBCYO1lQ==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr4193358pjc.31.1565109420844;
        Tue, 06 Aug 2019 09:37:00 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id k36sm89364611pgl.42.2019.08.06.09.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 09:37:00 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v3 1/3] grep: make PCRE1 aware of custom allocator
Date:   Tue,  6 Aug 2019 09:36:56 -0700
Message-Id: <20190806163658.66932-2-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806163658.66932-1-carenas@gmail.com>
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
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

