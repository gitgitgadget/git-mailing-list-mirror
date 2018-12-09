Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D8320A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 23:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLIXBw (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 18:01:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37566 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeLIXBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 18:01:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so4076960pge.4
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 15:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWk2PlbIJJh/YzUF/nCUNbrw5MvNmSVLtfZf8BvvGBE=;
        b=PV9WOJhNuGbu3vuAVEA1lbcPPg1U3GETfNipHx1RtRVgova05ZeEgyW0LKqecnLdPA
         xUh3l3nnOJZGDkWDygNOUKZcIs9k7nx6+3xRCcBd3AbprV/zhruI1EvW9um7t49m+mH9
         Hil2NXz0RgEKxQ9FrTso2ek7kXvj9TBPyLvY3XQjtaAkprUJ3Lv56YzG3DcFH0X7Ti5I
         u/Q7fgCHwRhHk6zi4BadVP6X5U+gMSGmis4Dzto8BKGXRDCt8UT3jVGMwYwxkehD9DRI
         bcitVBZ94qHba3YbxJamJZDNmUGV3IQfpWUwRoINQ0ssd2JPU3BQPPVE1nbnVQTAfvAt
         pB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWk2PlbIJJh/YzUF/nCUNbrw5MvNmSVLtfZf8BvvGBE=;
        b=oNZ3k82i5k24JsE+Og3ZMBE0B1BtagZa8YEwgipgqD7aYImAdKzYToWHm9yg6xmSyw
         HIRs+JOrewGAZIFXoqKdLCHBGWVyC1dUQJ/TGhtp2OBa4uhcjxoyp5DRPkSb7Jtqca9c
         rtwtNe/ZOjoOGjDr9nzJan8Qvp2FtfI1Ep+c8jbLBDWrgUJLUOogNL3v4hY/5yNXpeHE
         3i3mAO9GWVjK6zvc+d0oTocAlgPZVhgAiWctM94Yu06MKRr9ul9ay4n/FhyEJcwptC8N
         A+AXvFscLBJJm32eXvHb1spfEJDFjnF07RPGZV/SLMXMpWQqfVU6q1RTSuq+L6wKX5CG
         aHSA==
X-Gm-Message-State: AA+aEWbPDffmRQDwaDvy7f4v2PW70OjAs8b7jk2ae0tu1TDlaCAC9JtT
        NyU8dfyDg8Rq9gxdT4LEgyZ40HP1
X-Google-Smtp-Source: AFSGD/VtdCBMJ1sZkTyAxRoqes/GJbKTMOSXZU0TO/qNkmC72LZCtnGKndWyrJ11WqjF1eMGdWlirg==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr9090162pge.433.1544396511015;
        Sun, 09 Dec 2018 15:01:51 -0800 (PST)
Received: from localhost.localdomain ([172.58.92.208])
        by smtp.gmail.com with ESMTPSA id y5sm15110414pge.49.2018.12.09.15.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 15:01:50 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
Date:   Sun,  9 Dec 2018 15:00:23 -0800
Message-Id: <20181209230024.43444-2-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181209230024.43444-1-carenas@gmail.com>
References: <20181209230024.43444-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

JIT support was added to 8.20 but the interface we rely on is only
enabled after 8.32 so try to make the message clearer.

in systems where there are restrictions against creating executable
pages programatically (like OpenBSD, NetBSD, macOS or seLinux) JIT
will fail, resulting in a error message to the user.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 12 ++++++------
 grep.c   |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 1a44c811aa..62b0cb6ee6 100644
--- a/Makefile
+++ b/Makefile
@@ -32,14 +32,14 @@ all::
 # USE_LIBPCRE is a synonym for USE_LIBPCRE2, define USE_LIBPCRE1
 # instead if you'd like to use the legacy version 1 of the PCRE
 # library. Support for version 1 will likely be removed in some future
-# release of Git, as upstream has all but abandoned it.
+# release of Git, as upstream is focusing all development for new
+# features in the newer version instead.
 #
 # When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
-# library is compiled without --enable-jit. We will auto-detect
-# whether the version of the PCRE v1 library in use has JIT support at
-# all, but we unfortunately can't auto-detect whether JIT support
-# hasn't been compiled in in an otherwise JIT-supporting version. If
-# you have link-time errors about a missing `pcre_jit_exec` define
+# library is newer than 8.32 but compiled without --enable-jit or
+# you want to disable JIT
+#
+# If you have link-time errors about a missing `pcre_jit_exec` define
 # this, or recompile PCRE v1 with --enable-jit.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
diff --git a/grep.c b/grep.c
index 4db1510d16..5ccc0421a1 100644
--- a/grep.c
+++ b/grep.c
@@ -405,6 +405,12 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 		die("%s", error);
 
 #ifdef GIT_PCRE1_USE_JIT
+	if (p->pcre1_extra_info &&
+		!(p->pcre1_extra_info->flags & PCRE_EXTRA_EXECUTABLE_JIT)) {
+		/* JIT failed so fallback to the interpreter */
+		p->pcre1_jit_on = 0;
+		return;
+	}
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
 	if (p->pcre1_jit_on == 1) {
 		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
-- 
2.20.0

