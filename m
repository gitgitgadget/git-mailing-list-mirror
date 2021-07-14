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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19200C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0465261369
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhGNASo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbhGNASm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:18:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C414C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so1457004wmf.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/yQD5bmohKAz1wuNbjoW8d1gQY1+WGwVyQRmZ364Pw=;
        b=B2AG9JAW4GSqd/hf/QoKYKexhV/azNCosUPLFgZkZxXVR8ZinW8ekopkoOH+fbxBt/
         5jVUZSHc+pIpECpNKfGvUl/XfFz0vCWK9k3vRu30PtB+ynLvSLqrwi00dI4aQ6r7ga/h
         V9gOmVzLhWm/5gsW3JRi1nF3OEe5r65YmuJgqPUbHGCWo/L6plFqdZRQ41cPqVFVIksG
         wotlrQF5qIaIQ4YePT/WJ/VB08bjKWxiIqvknqkmPnEcS5589X+zvYUMHDyerhQ3MCSg
         I7FQVqFdMqPSfTXRROKzC42KDgVFjSEXXEKuxIvHpqJIV23QD3hWlABR2mqzKhxEw5fu
         /PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/yQD5bmohKAz1wuNbjoW8d1gQY1+WGwVyQRmZ364Pw=;
        b=GIWFBg8ibaFjWUjGjERMBJ54gM6MnMnHmrGrqR1/sqvcnCkmhfcCUtodLD0yVI/CGB
         ku0bLXbuyX1+wEBzA6Sn2SeNhSllX4AFUPbGLGqYxyCv13tzsESJCg7loBKfUrnueJB7
         mPCfrv8vUuw2kEvwkWrqUNAi1AuGf67TIhUzmLR/M3oUo0MNFTn5FbwF32t+kZssRHA6
         xadLOIaJqDF85XFxJ/6ZoEAKSOTADBu+dYwp3CYWsHjmuR9obUOv4D5GfEdyN2lYbo70
         7aNmIfQ/WiagvU8KtTGFkC5c3qgACNwYGebSoZbsJ/9ZV1+yOgmCVyNtcNYq9lX686zs
         YMGw==
X-Gm-Message-State: AOAM530mWqtZmgmirXktdPdhVANHOLcTgSTdkMP4A0AJa45DUG7vxaVX
        CVZO98zOdht0THeZGjly23/jdlHrBuPo06QM
X-Google-Smtp-Source: ABdhPJzhYJUc08K7Z+ttiEEzSR8KsElIJap+3SMsiGZCpzWGaXMPYSiG+ZSl6Y3TULH11p++N15U9Q==
X-Received: by 2002:a05:600c:3b92:: with SMTP id n18mr8029877wms.69.1626221748987;
        Tue, 13 Jul 2021 17:15:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm2876518wmc.7.2021.07.13.17.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:15:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] sequencer.c: move static function to avoid forward decl
Date:   Wed, 14 Jul 2021 02:15:41 +0200
Message-Id: <patch-2.5-9c1492b006-20210714T001433Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
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

