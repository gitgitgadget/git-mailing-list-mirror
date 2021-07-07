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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7834AC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6735B61C99
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhGGKld (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhGGKlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:41:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24AC061760
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:38:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so10445851wmq.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbDSmypinBHLdEFNoRlvO9vbddnho2qoZ5PGlnEqxQU=;
        b=DoPZW2qU6OyEMnhee8QpI6H9yFlFtWc5fDTyr74+jle/0H2ADYAqAcRoXfd9P+PEwG
         x8GOdOKUnooHwqafbiVy9IH/HeKJiqxKZ4JDrdJCjq6fVgIeXe1kKJyYMdRbyaWNhdvL
         AfBkQ20YmA/HcgT9E7ehAmV1KNY5uSo2XRF+aW2/Edd6dI/dE4RQdF303iINhA6nhJtd
         Rx4+DUnuGkJIZA+xXxlRHUvEFdAAym49HsozZwH7/jvMnqYMN7LV268jnpByKMBhTArX
         mPgHl7wF3/m8RiicO8k7hNcApeI69EDsYuMgb/iQIxVyeVKT/a4AQ/Fz+qXVpvIeqRNC
         i5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbDSmypinBHLdEFNoRlvO9vbddnho2qoZ5PGlnEqxQU=;
        b=YFbhuWNo831gFDwtspB8LEDypIl0eT4SHouYDzSLky11cbmA7YKznUmmFRvRI7z0i8
         GeHNgq6uCanCFHdplMUPOGE8ZQTUk8z8CnyuBCEAotnyEk97IBmKVynklJyR0jtIF5gE
         EVVKd1IewlZabyLYRXgHzFbbisOU5s3+jSQGW8FsLo5/jZTIcc0wXi6/8/YOI6mhwsWC
         f8NHFZ5U5Hn+so80lX+IN3YMamYWGkqA6uU11HglLdU7Styaoh0kcZVQCq3Pf9y4FOky
         ICR90rCl7/lYrZe5yMVgZCYvBchHnfyrQQFaSSXyp1GOB7fLm90nsjAJUxOFkv5l4N34
         EAyA==
X-Gm-Message-State: AOAM531vAt5/z6m9FVb4wq4HlEQIbl5kxri0QOgC1oQA5nlOACX4h7uS
        yvrlgmY9B+hlpYs+apET5HiH6ljDvQGnOQ==
X-Google-Smtp-Source: ABdhPJx9P/KTsKvoeFxJjW+o+NuevikRwNAeI2X7Mc4bX9qt41ZixG0YNfLPNzWNgJ4cbuqqnxToZg==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr5886945wmh.127.1625654329441;
        Wed, 07 Jul 2021 03:38:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p3sm5859104wmq.17.2021.07.07.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:38:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] strbuf.[ch]: make strbuf_fread() take hint, not size
Date:   Wed,  7 Jul 2021 12:38:42 +0200
Message-Id: <patch-3.3-46c65a7ae12-20210707T103712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the strbuf_fread() function to take a "size_t hint" instead of
a "size_t size", for consistency with e.g. strbuf_read(). We can then
change callers that explicitly passed in our default hint of 8192.

The strbuf_fread() has not taken a hint ever since it was added in
b449f4cfc97 (Rework strbuf API and semantics., 2007-09-06), it was
left out when strbuf_read() learned to do it in f1696ee398e (Strbuf
API extensions and fixes., 2007-09-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 4 ++--
 strbuf.c     | 3 ++-
 strbuf.h     | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81b..295b9c4080c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -781,7 +781,7 @@ static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 	}
 
 	strbuf_reset(&sb);
-	while (strbuf_fread(&sb, 8192, in) > 0) {
+	while (strbuf_fread(&sb, 0, in) > 0) {
 		fwrite(sb.buf, 1, sb.len, out);
 		strbuf_reset(&sb);
 	}
@@ -898,7 +898,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 	}
 
 	strbuf_reset(&sb);
-	while (strbuf_fread(&sb, 8192, in) > 0) {
+	while (strbuf_fread(&sb, 0, in) > 0) {
 		fwrite(sb.buf, 1, sb.len, out);
 		strbuf_reset(&sb);
 	}
diff --git a/strbuf.c b/strbuf.c
index 7e9f5fdc4de..af3af7622d1 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -498,10 +498,11 @@ void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags)
 	}
 }
 
-size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
+size_t strbuf_fread(struct strbuf *sb, size_t hint, FILE *f)
 {
 	size_t res;
 	size_t oldalloc = sb->alloc;
+	size_t size = strbuf_hint(hint);
 
 	strbuf_grow(sb, size);
 	res = fread(sb->buf + sb->len, 1, size, f);
diff --git a/strbuf.h b/strbuf.h
index ca3c47966a0..7d178e3c8de 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -442,13 +442,14 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt,
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
+ * if the size is 0 the default hint is used.
  *
  * NOTE: The buffer is rewound if the read fails. If -1 is returned,
  * `errno` must be consulted, like you would do for `read(3)`.
  * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline_*()`
  * family of functions have the same behaviour as well.
  */
-size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *file);
+size_t strbuf_fread(struct strbuf *sb, size_t hint, FILE *file);
 
 /**
  * Read the contents of a given file descriptor. The third argument can be
-- 
2.32.0.636.g43e71d69cff

