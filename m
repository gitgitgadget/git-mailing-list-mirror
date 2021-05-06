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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203FC43460
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB9461090
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhEFQxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbhEFQxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B07C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l13so6337630wru.11
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Se6om0d9PxlobWGzikWjFivknQIZP8jT5Pqjb7aF+sY=;
        b=tgL0T1SB03WeHnPg03Vi4jVuWwhLSSEByjq+TXT9pWOr8tpb6tlNeUmvss5UlxL1l2
         jfhVtHKDbgPFKotBnBg88ktBk/VnUmo9T7YGRwISR0SWy9NVcIqDl7PfdZrqL8stWbPe
         FOdW9QQxElvb++oJxTIcmzmOR/ds9eOwA/c9qI1H5dpmm7KhzUup7L/pWe+CRH1CBGY2
         zOkxx9TzaozbjNzp9XezzJURXcFQfHp/b5yD9/8OhCAL96Fz+eymm5CrKlxPy5gUONtE
         k+Lz7u7CehzGQZjB216OdzCQZLA6LqvcRPj1OOWKG+bwsu5T6XeomuP1zuSsc9uxa6P1
         KH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Se6om0d9PxlobWGzikWjFivknQIZP8jT5Pqjb7aF+sY=;
        b=gY4fgevTgb7OAnxZ2XneLUkzF6FpoJoYU/uRmferz2xwQoSWq6ow1wv3ZQO8mmmU9s
         pDEX7qWEnCUIfpcHnBuHjq2bjo7jSdwZHFfg5gkbvA/plnEeOK2Upk403+mGtb5IYY6I
         hPsNyL9Nsn+TiHJTHmk9uVShAJLlunzhIEdN8Ok9VyRxrvnD3x9jYaM6wa9YbUOA9g6R
         5QB+rxDxWQciHLQMq3Sk5IcRAfsElns1wf0zSasTscvhEiqyvhxtZX+DxboEik8pM/F8
         TEpqAnxWeOB/n0H2OsXDn6CtPJDEs7od7A5crM2BNJTyZxtLK6hK04cIWo8GT1BSAl21
         ObCg==
X-Gm-Message-State: AOAM530B/D45h8vlSu7R/4vwQersixG3/7F/suJLMhK7PV1Afb9HtMXe
        840mqOpSTb7ymv1PdqBwU7c=
X-Google-Smtp-Source: ABdhPJzxN9Cbm9PoO/7SWomD5oNYKQ2uoDGp+r9BBKI4RJyjP1E3lEB/3rppbyVfMn3+ASz+VROXKQ==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr6502910wro.293.1620319963815;
        Thu, 06 May 2021 09:52:43 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:43 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 4/8] format-patch: add the option --confirm-overwrite
Date:   Thu,  6 May 2021 18:50:58 +0200
Message-Id: <20210506165102.123739-5-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command line option acts in the same way as the configuration option
format.confirmOverwrite.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 builtin/log.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index ec9848da70..0ce8778338 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1776,6 +1776,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	const char *reroll_count = NULL;
 	char *cover_from_description_arg = NULL;
+	char *confirm_overwrite_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
@@ -1818,6 +1819,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
+		OPT_STRING(0, "confirm-overwrite", &confirm_overwrite_arg, N_("when"),
+			    N_("overwrite cover letter/patches with or without confirmation")),
 		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
@@ -1919,6 +1922,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
+	if (confirm_overwrite_arg)
+		confirm_overwrite = parse_confirm_overwrite(confirm_overwrite_arg);
+
 	if (reroll_count) {
 		struct strbuf sprefix = STRBUF_INIT;
 
-- 
2.31.1.449.g4a44fa8106

