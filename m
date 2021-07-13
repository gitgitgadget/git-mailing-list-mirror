Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970A6C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7907D611AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhGMIIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhGMIIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:08:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD20C0613EE
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w13so12998502wmc.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBo8eNqOrYJMV53sgaWTLFXvOnAaTQxRo1nWRArKKm8=;
        b=YmPiGyKqScRss1cJkw3OkNiGlQ0bdtDHxKXbwTQzllLjsfBQS2DT4s6nIDkVIZXOzc
         z3N+jFv4L39D8PuUQlFdRUw5IvOdL4qD2phz08gQgfurKMqnYGKnNuK310Ys3PCrC1rH
         6wjIQq/VtjEgQyxFe2SYenKEPhO5etvb92CuivA0pD2pEv9oS6Pee9Yzn4VuL/xKXFSC
         /4sosusvIHsMYQ+ZzLOzbnrdtB0/sq5rRGEWWNq2EVSQpRumQUVtBaTkQQ4SlxCY721S
         lI62YSIKraO/kjtJ9MAZ220OYwp0/kbv178KO8OoWeQWjvkwO8AB4G5dB7941YF2wT7Y
         R19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBo8eNqOrYJMV53sgaWTLFXvOnAaTQxRo1nWRArKKm8=;
        b=QFSET1iwkGogYQzV05VU0UT+SetL44GMIOtEsKwjUXn/5xT2X68PT0RG7v3Uy4Dp7b
         3PsjWMSfNr8sCrGzQu+JnRDwHEZqO3i5Gni06GFkid9MkQt57BSiaHNZ/rAbDlVfyeMc
         +4TTSLrzTnKjXHgm3DPuQm+Me/mwVshcN7/xtK6rHqBRhIzXS6Pg57j0FIZIGXqlsta+
         /+raE6CSlNd2DTnkZTCOD0R0kOVoqcgIeypQSnqkJH/x4kj8JEfScVVuCzhsrdhEEk1B
         zip8KwSgAacrq8SUb4Mszixw2ZYC+3q+028zda5w1f5LpoA7qC021WZGOSQtxtmobkAH
         IK6A==
X-Gm-Message-State: AOAM5327ivTxX6eXjdX8vMoRdzTNyXODUuR1Xxu8R0WlrAbWZuouySMX
        ANS4TCa8MDezKuURhlP0CAd7PkWdVWPHSw==
X-Google-Smtp-Source: ABdhPJxa7IgldMpwbvLnJe34YdvCWeyTxnyzZjxSR53Jn+hrlswrsf8CMCVtPa0g0Vob42kgOxQsig==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr19125401wmq.149.1626163528704;
        Tue, 13 Jul 2021 01:05:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z11sm17156772wru.65.2021.07.13.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:05:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] strbuf.h: add a comment about "missing" strftime() checking
Date:   Tue, 13 Jul 2021 10:05:21 +0200
Message-Id: <patch-6.6-fe66e06754-20210713T080411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com> <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've recently added missing __attribute__((format)) checking of
printf formats in various places, but in the case of strbuf_addftime()
we've intentionally omitted adding an:

    __attribute__((format (strftime, 2, 0)))

There was a proposed change[1] to do that, but I agree that it's not
worth it, see e.g. [2] for the rationale. Let's add a comment to note
this.

1. http://lore.kernel.org/git/patch-4.6-3bf8637c16a-20210710T084445Z-avarab@gmail.com
2. https://lore.kernel.org/git/YOyhd%2FodtQxwQk2W@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strbuf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index f1e9821a54..04952e94c4 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -425,6 +425,12 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
  * with modifiers (e.g. %Ez) are passed to `strftime`.
  * `suppress_tz_name`, when set, expands %Z internally to the empty
  * string rather than passing it to `strftime`.
+ *
+ * Note: The omission of "__attribute__((format (strftime, [...])))"
+ * is intentional. As noted above we take %z and %Z which aren't
+ * portable. It would "work" anyway on modern compilers, but since
+ * this is mainly used in date.c (via"git log --date=<format>") we
+ * don't have any constant formats to check.
  */
 void strbuf_addftime(struct strbuf *sb, const char *fmt,
 		    const struct tm *tm, int tz_offset,
-- 
2.32.0-dev

