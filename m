Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A1FC7EE23
	for <git@archiver.kernel.org>; Sat, 27 May 2023 07:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjE0H6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0H6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 03:58:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338CB2
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae615d5018so11098815ad.1
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685174288; x=1687766288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRtZhiOscnHYIF+GSWIRgKUMfl3a8JNIZfaVTNPVpd4=;
        b=meUoC0Ek5yob1BYul0i9LFsYO9zVsIylLwBMJhr3Su4B/SlnH0wAapQWkT/yqOfbgF
         EClJp06b3TSw1v9Rg+Nv7LFtuOdodBgbBsiBlc3Alk0jC5sS//kwgs6Al2paW49pXrQf
         ZpAOh52CpXiMQ2egIcF87GQGHKE6ID22syLajuMgzEP6qY1Z6GiuB5qZoYr1n4T+6GoI
         wSHIAV1yfds6X1ngZRAiRKwIkxvPLAL9QnJS0RYluBJdr/3ffjYWRj2JQk7SQfqyob6M
         FfBovm6eVnmB2YE7kRLK+xI5Y3finjFava9HgR0yBJFEiF/QoNqAvXKxLW3fmD5tE8Lg
         S3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685174288; x=1687766288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRtZhiOscnHYIF+GSWIRgKUMfl3a8JNIZfaVTNPVpd4=;
        b=GZdcRxO3cZpzPsb2BqjZh41PjfhN0cKNttoLr5ixGnVjp0Sx1rDJggsxMSUdTKt8dN
         sVhDMsUVI0u7HYqkyN+Q2YPNio1u+C/TNvOzPbc9nl5TTiFGSF8M0Dd1peKRNj3zuuZT
         KPaAy9Kr+6Uq1ZTV8fKvUTegMiSZ9PAt+i83eQliGIOiMXNSr7Qhu+DKT4LN/nvsZTaP
         PPvfUbUnBoXxgjJDsk25h0cMT0QlPgeoxa9CqOhoB8stODbjgWPFHEir+TGvtIOL8OqN
         OF0DOItUpXelCMtkIgIngM0SiDstjZYUxKk1VCAYMLz8FumsTV2KJHdzswHfjkJ+vten
         EI1g==
X-Gm-Message-State: AC+VfDyu/qHMhzumiPhA6SWFFc6Ix+7oUQmL7lO/AAU8+mNBdFnfMGJ1
        4tvkfpA14wzuAT1hEzyEXbA=
X-Google-Smtp-Source: ACHHUZ64rI5qz9OAuCAjarfZB7sM3jVkW4lTUCzExuE+FJ+4cZJG36BPkbCKyDrrcolUUvPzioT94g==
X-Received: by 2002:a17:902:f551:b0:1ae:e84:268d with SMTP id h17-20020a170902f55100b001ae0e84268dmr6616245plf.25.1685174287676;
        Sat, 27 May 2023 00:58:07 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm4355239plr.172.2023.05.27.00.58.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 00:58:07 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, code@khaugsbakk.name
Subject: [PATCH v11 2/7] notes.c: use designated initializers for clarity
Date:   Sat, 27 May 2023 15:57:49 +0800
Message-ID: <4ad7840584191d6bbb3fcba72887aa569c797a15.1685174012.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <cover.1685174011.git.dyroneteng@gmail.com>
References: <cover.1685174011.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
replaced with designated initializer for clarity.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index c501c6ee..9d8ca795 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -405,7 +405,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -571,7 +571,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-- 
2.40.0.356.g367cb1d4

