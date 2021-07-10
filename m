Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2700FC07E9B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF31613D2
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhGJIu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhGJIuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:50:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947BC0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so15650330wri.4
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9IAfJxAvKAevjMJ9xP9BmAoNbgEfnRKTr1D8cnpKzM=;
        b=H2iQZw3aNZ26/9FvlI43PsdvfoI/u1AHwqy1096bZUB4zVDVpDud3LvSh4Via1HRE7
         80MXoLJzbBPlmsQBrlDw1AAkcGyftLuBqbM7mBrgv1FSt20xGTiaN1V3eMelhEMENng5
         VP3/nvHUh6WZoa1j5sK8fCZHTYe4LlG8f0pNXe2edRj793CmY+4HKMu1pQpBo3olr+O4
         JKFkKowlCNWBBKqoPrmnAEwi9qdzDeUr85U3ELoz/acLswyPpi8SKMyKseoUkU8uDtOI
         lPDUnvB5ZNQizyiAQjwPtcBV/iRPU+cwXjA8SLKxBd+I7iADgsrDGm6uvdEWC/tCG4NM
         yVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9IAfJxAvKAevjMJ9xP9BmAoNbgEfnRKTr1D8cnpKzM=;
        b=QOpFCuhNI3KI6HIXMW+ZJP1F3VKAVUBFQ+HtLBdS8zKKKDckpN96KD9tRokdGaT75W
         Yr1QnDuUY9xDUkX9HOQy74EpHgIKZ+jL3S3rKnDYCSz4tWZrYJEZsuMoZDBcQBK2AtsA
         m53jLO6LiulKalhKNaaNdRCjVk1gf2oIibLXhzz6rsGZK84tt1MssLBL40CZpKPyVUXt
         hVaPpcNssFwE/ckzTMcBOBdxr6plxiVZ8U9hQjczLnBWYiuHamUPIJCowr/W9fUEMkm0
         nlusOrMKT3lRyo37IPvI99AV1CaRNFSLsO/FKV2aG25Rm3ugVt8wV5nWFl2zrxO68Pw9
         SpEg==
X-Gm-Message-State: AOAM532KnNfo9eHvUum1doUyR7fKDmDMLz4slluwnsjBJDlXx225G/7r
        vYqtWyI5AHMGaGkMrbR4D7+HNVAPtoukjg==
X-Google-Smtp-Source: ABdhPJzVA2AFk7Agw9xwkI5sGl9enKPD7QLef6jkfa3T68wIKW5jTNMI1Nh8H/6+mThPER7hy/mlyw==
X-Received: by 2002:a5d:608b:: with SMTP id w11mr35805756wrt.100.1625906856497;
        Sat, 10 Jul 2021 01:47:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm165769wrt.93.2021.07.10.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:47:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] sequencer.c: move static function to avoid forward decl
Date:   Sat, 10 Jul 2021 10:47:28 +0200
Message-Id: <patch-2.6-9c1492b0069-20210710T084445Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
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
index 0bec01cf38e..c316d8374a7 100644
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
2.32.0.636.g43e71d69cff

