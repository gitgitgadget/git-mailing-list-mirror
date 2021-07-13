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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD0C11F66
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903B2611AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhGMIIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhGMIIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:08:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7BC0613EE
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w13so12998378wmc.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/yQD5bmohKAz1wuNbjoW8d1gQY1+WGwVyQRmZ364Pw=;
        b=Yniwd/Z1VC5OiqaxSA7WV/6Jr7n+HccTdUcJfLUO6yIkbWDq+nFtLHMUuqeGCHZiEF
         nPXzZhrqQC8YYZ5ZXbwqiMC7h/B5wO814nqCtuUtnpvil6UoetT30skLaHMFZH2VjvJH
         rqrXIVe2eHC+NIx/dkPa7ms5oV3t66nIxbAqMXXWRT5ER8v+E8JUlpt+TJcgyy9B94+c
         pV/emat7A064RvoMKx3f1GXvIqccCWH6Vd33ojGYI09Bp98xOXckwRSoDvZwGyZnn/K2
         3U2xmYd4LUPdVJh4BxHITc4dc8SO4wd+3rvJhBQ2V1YFK+q8xIEhY+UgfaRTpFd57nrB
         flmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/yQD5bmohKAz1wuNbjoW8d1gQY1+WGwVyQRmZ364Pw=;
        b=jNe+87cWph+Xo3g2WDjoBOuKotEf9eCsWm6NotswDt2MvHKBT8oO3VZC1koblTovIq
         PAcG3Qgrck8w8QV93+sp7q1e2mpW35djUoxBrdOnFY62UxMPs9H8oyCktJtaP67m7yt4
         RxY67dYfA0fnKKoU8MZI8HdISnOiakwMjjbHD+o2RJC4EFu+zlPYMheEjBOXAqOQ0SlF
         XXNY50235RcRqiJ+nVS1k6izg5RooHV2Bhplu7kgGIGjJPqgr+/cz3S00PvQ9KPQJ5GT
         qHltj066vNl9bEhWShlQm+UjRuY151/gz4vs3u4ozLiOSbZE/Mq5OopDq2w9Ry7G1Leo
         qhOA==
X-Gm-Message-State: AOAM53139WqtfoDPBLyRc8h5dJCRT7+3pJLn4TzD9wmkBCEjJVimqvCw
        wkmHC4BYnZJLhV+GJQm7I+M+JluYpGLxug==
X-Google-Smtp-Source: ABdhPJxGY5KtoCaiO1H16y2XlRrzm4cNBYlpu0N2UY6DEnMsPdtT6g6lCX/JbY18n4n+bDaeHQhagA==
X-Received: by 2002:a05:600c:364c:: with SMTP id y12mr18904117wmq.78.1626163525453;
        Tue, 13 Jul 2021 01:05:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z11sm17156772wru.65.2021.07.13.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:05:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] sequencer.c: move static function to avoid forward decl
Date:   Tue, 13 Jul 2021 10:05:17 +0200
Message-Id: <patch-2.6-9c1492b006-20210713T080411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com> <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the reflog_message() function added in
96e832a5fd6 (sequencer (rebase -i): refactor setting the reflog
message, 2017-01-02), it gained another user in
9055e401dd6 (sequencer: introduce new commands to reset the revision,
2018-04-25). Let's move it around and remove the forward declaration
added in the latter commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..c316d8374a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3599,7 +3599,25 @@ static int do_label(struct repository *r, const char *name, int len)
 }
 
 static const char *reflog_message(struct replay_opts *opts,
-	const char *sub_action, const char *fmt, ...);
+	const char *sub_action, const char *fmt, ...)
+{
+	va_list ap;
+	static struct strbuf buf = STRBUF_INIT;
+	char *reflog_action = getenv(GIT_REFLOG_ACTION);
+
+	va_start(ap, fmt);
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
+	if (sub_action)
+		strbuf_addf(&buf, " (%s)", sub_action);
+	if (fmt) {
+		strbuf_addstr(&buf, ": ");
+		strbuf_vaddf(&buf, fmt, ap);
+	}
+	va_end(ap);
+
+	return buf.buf;
+}
 
 static int do_reset(struct repository *r,
 		    const char *name, int len,
@@ -4178,27 +4196,6 @@ int apply_autostash_oid(const char *stash_oid)
 	return apply_save_autostash_oid(stash_oid, 1);
 }
 
-static const char *reflog_message(struct replay_opts *opts,
-	const char *sub_action, const char *fmt, ...)
-{
-	va_list ap;
-	static struct strbuf buf = STRBUF_INIT;
-	char *reflog_action = getenv(GIT_REFLOG_ACTION);
-
-	va_start(ap, fmt);
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
-	if (sub_action)
-		strbuf_addf(&buf, " (%s)", sub_action);
-	if (fmt) {
-		strbuf_addstr(&buf, ": ");
-		strbuf_vaddf(&buf, fmt, ap);
-	}
-	va_end(ap);
-
-	return buf.buf;
-}
-
 static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 			    const char *commit, const char *action)
 {
-- 
2.32.0-dev

