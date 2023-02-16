Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A138CC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 13:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBPNF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjBPNFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 08:05:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DD4A1DA
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k24so1817273pji.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnwLVElDdHY3yV8znSCV2c2Vhja1KA+ezDM11OeFvqA=;
        b=ENBtzKGU1Adx+t93KQUUUPtep1uHuksxVayHcABpuJvUuYe45Ws/NxK+H6Ep/Q2B0B
         C+vaoV/Gp7wMmjwUq8nRxQTrzcpzGB6lGZRhmulQn64GPhXRTuD9IJ+en1jSwy44ebSq
         yJ90t8b6CJyYXv+TQ1t9u3fDT8pt+ZZj8TBg7d4JVdy8kn+CTbeZti1u/BIWF6rV54ZR
         esxWinGwWpqEkGfUe5ZCmgjgxZl3G8efjHH5TdLbfKtNBRQoZ3mvyCESOtKGzuTdwnH9
         nbUJh/u+xRqKBHxL7r/gUUlWtt5ucR61FRXY8Wed+hyZjV9kZPmmEX9a4Dq0K013JDOj
         yasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnwLVElDdHY3yV8znSCV2c2Vhja1KA+ezDM11OeFvqA=;
        b=W6dt0dBFxOcssD/2r6k6bounuFVKT1Up9rCGNzJyGdycGJM9+TeVQL6Qm9tMxIJyMA
         LzFDHMkOP7CxZ3ebXnnmosytjVmiedZsSr0TrN8N4Bi6GP2fiKRi6NHGT2m8iu8WQ3SH
         D03YbzYrYtav3SuaizKvHLhi2z3RI4dPluUACptKixGK0tDwkmw6jMgIJBNB8Y9/hWQI
         HTlL0mgmcbxwl3w1przr1Ti9hrJEVIK/CO5sfmDnHJI3i7ZGZ/KneWyjYsCph/rHmK1s
         ED1fzEBOfL5KSI3dJ1vo2e6yNTHB5fvSwG7an25MfRTJkh5Gj+iOls/JmTedpFSMjyhh
         blcQ==
X-Gm-Message-State: AO0yUKXHHFY+d42KEcrWqLAcMafshWbW5XIazaRf7v8K6dxx1pD+V+Ub
        olrKqR+kzJW1fyyNLsG5T7g=
X-Google-Smtp-Source: AK7set+WiVsbn6bHIFIRh5aOlWSkKW1PpVh+mAujwo2SmFJrRMbp1S2XZ6Gbbl1H+3RjvHtU+AMnyg==
X-Received: by 2002:a17:902:f609:b0:19a:7d72:99c0 with SMTP id n9-20020a170902f60900b0019a7d7299c0mr1898119plg.14.1676552718397;
        Thu, 16 Feb 2023 05:05:18 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id jk3-20020a170903330300b0019a75ea08e5sm1274581plb.33.2023.02.16.05.05.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:05:18 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 2/3] notes.c: cleanup for "designated init"
Date:   Thu, 16 Feb 2023 21:05:04 +0800
Message-Id: <e7bc606005d8255f8951aa4f994f98b0c08d1d77.1676551077.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.g31d98a8e.dirty
In-Reply-To: <cover.1676551077.git.dyroneteng@gmail.com>
References: <cover.1676551077.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
replaced with designated init format.
---
 builtin/notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 23cb6f0d..553ae2bd 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -401,7 +401,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -567,7 +567,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-- 
2.39.2.459.g31d98a8e.dirty

