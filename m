Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D69C07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C2761C99
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhGGKlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhGGKla (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:41:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45379C06175F
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:38:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so1361283wmc.2
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJLKXoBIGLVWprYasrssCGZuic8ul8OV3m8stBCij+4=;
        b=FywS1z5F12KYw+j8F4QUEtY023Cx83+221IRyOIgKL5j7vHSyBV7P0H+N4ESSRRioz
         eJYCGGSZrTatuyneqztMpcjnVLQ4CJUEr9PZahYDgCYQsro+UIgCImNp/BpZxUpRUgUb
         Kjaak+VEz9P5QnkMCCWV9oLuMrt31eUXpKEbO1LU3fih9p/0PfjAYIgCNYFhTb7Q3uYm
         tmYYpD8DnbM2ss1Qj5Ru3UupeyQA6eH8C/Jkcg8aWrhOQZXAPRC/roY0fBZB3pRF9EHJ
         mqO2OqWeQOxgTATYzeijrEkoocFfyCXzSovMu28UtlifO117uMjEo+JuNfBB03zKRp5N
         sifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJLKXoBIGLVWprYasrssCGZuic8ul8OV3m8stBCij+4=;
        b=o4XoXDl/aa3PEvsvaC/RPjLp2ZCnHihTYge0jzyBgAbnOlpwamyS27sPOUqF2D4QKn
         xEXQAkQCM8YfvsgQkORgAJSQRrdJ+xM0YU6pYJqzjI7AMUcVXT7sdMk2SBeWyIZBjy/h
         vWpDx97pYzsqdzBCcTftglKAGI89lE1La9If/ObxVteeb7C7K1rZXjM2NeKvX/4fUs3F
         5UtkyZvTtsdTNRujuJvc3YbRW+eYWwnY1Ef9BGHQBBOKU1hwQ9JuYlDoQfPxBdfj+16L
         uInVp1owovDYIh0t5JrTEID6srRZhuwHODYz4Ip5ahQ3vWo/CRKGIIboDdJtrEKYIev1
         5Hbw==
X-Gm-Message-State: AOAM5318frhph95LcArLD+4TWjyOU6xvefSUfIb+BiXtjjQQddSLlx/b
        rDqpQZ2dp5yqaAWIjlWuq2pNtidIiQjREg==
X-Google-Smtp-Source: ABdhPJwN0eokcW3PflPKg7Yrnw8co7+RtaULQlteMCLxlZHccDvQaycGhl5hElEEFcDWCvQM/izKHQ==
X-Received: by 2002:a1c:7410:: with SMTP id p16mr26598177wmc.24.1625654327593;
        Wed, 07 Jul 2021 03:38:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p3sm5859104wmq.17.2021.07.07.03.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:38:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] strbuf.[ch]: add STRBUF_HINT_SIZE macro = 8192
Date:   Wed,  7 Jul 2021 12:38:40 +0200
Message-Id: <patch-1.3-f5a6c4a2720-20210707T103712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b449f4cfc97 (Rework strbuf API and semantics., 2007-09-06) the
first hardcoding of 8192 appeared in strbuf.[ch], then in
f1696ee398e (Strbuf API extensions and fixes., 2007-09-10) another one
was added, and in b4e04fb66e8 (strbuf: add strbuf_read_once to read
without blocking, 2015-12-15) a third.

Let's factor that out into a STRBUF_HINT_SIZE macro, and add a
strbuf_hint() helper macro for "hint ? hint : STRBUF_HINT_SIZE".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strbuf.c |  6 +++---
 strbuf.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 4df30b45494..7e9f5fdc4de 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -517,7 +517,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	size_t oldlen = sb->len;
 	size_t oldalloc = sb->alloc;
 
-	strbuf_grow(sb, hint ? hint : 8192);
+	strbuf_grow(sb, strbuf_hint(hint));
 	for (;;) {
 		ssize_t want = sb->alloc - sb->len - 1;
 		ssize_t got = read_in_full(fd, sb->buf + sb->len, want);
@@ -532,7 +532,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 		sb->len += got;
 		if (got < want)
 			break;
-		strbuf_grow(sb, 8192);
+		strbuf_grow(sb, STRBUF_HINT_SIZE);
 	}
 
 	sb->buf[sb->len] = '\0';
@@ -544,7 +544,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	size_t oldalloc = sb->alloc;
 	ssize_t cnt;
 
-	strbuf_grow(sb, hint ? hint : 8192);
+	strbuf_grow(sb, strbuf_hint(hint));
 	cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
 	if (cnt > 0)
 		strbuf_setlen(sb, sb->len + cnt);
diff --git a/strbuf.h b/strbuf.h
index 223ee2094af..ca3c47966a0 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -72,6 +72,17 @@ struct strbuf {
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
 
+/**
+ * Various functions take a `size_t hint` to give a hint about the
+ * file size, to avoid reallocs. This is the default hint size when
+ * `0` is given. 
+ *
+ * The strbuf_hint() convenience macro is used internally in the
+ * API. DO NOT USE any expression with side-effect for 'size'.
+ */
+#define STRBUF_HINT_SIZE 8192
+#define strbuf_hint(size) ((size) ? (size) : STRBUF_HINT_SIZE)
+
 /*
  * Predeclare this here, since cache.h includes this file before it defines the
  * struct.
-- 
2.32.0.636.g43e71d69cff

