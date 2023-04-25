Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BEEC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjDYNfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjDYNfY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1174C13FA3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso6978209b3a.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682429693; x=1685021693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKMb/Mpcdsoap7lNBDcuwwGPmjHlfJMt7IdzlVpsUaY=;
        b=Pkqnl/t+0AnNEkaeRe+a5Z7Z9mt8AanH003qTmqBZ/MIBjOKnSG8sL7smbaXsl//ut
         BwZg013+7DwL/IsmhJ/8OjB53cVeygxwS3YaDnBQvQ+jcobg/0ej93YcUlAJdt3o9grN
         AqC+K7f+KZrj4yq6buYSiLNQSSdJp/GNs4ZkzIv3+r/JVwVOXVncWfrCJxB6pY2rmOMf
         WErAeGxF9H8zlJogWfcoGvr7Gzd7D5TDta/H2qLaKt+rpYjI70snntJy549wNWBA9wGk
         RbJqnHNVL23279q8S0jEa9r6NWu4U10BMcMRlI0G6sJtVRRCfVbqpnFfef+nnd5dGa1s
         kigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429693; x=1685021693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKMb/Mpcdsoap7lNBDcuwwGPmjHlfJMt7IdzlVpsUaY=;
        b=PZUEmauQzdBBMKfKzxRiLdw5Sxi1HN+fgXFlpTfZbPWBm/fUcpJTjJvm1b5F5J8tCc
         4KL3xzLWlu1b1M2oWy4VfPUbuhMnjom4pRME8R0XwkMI6/kn3VGwHOfQnmItNbkMyYpM
         BSCMNlSCMJ/Tec2KwfT1M7I1Sz5EQ12LUmnkqHVRs6IqLjgwwjj/p52N1uP+PrB2ldbW
         2Dd1K5bSda/EA4QRk1QfQU7u86V9m5H4VGPUzN8jYwl2cXnvGpWLw7s466EutpqWDrYz
         MkvuZ+CZ0/LiZ+TzrQkhLuSZIAKysSzNp4bFeE/eBq8Z8L/nGapQ3xWCp+F2EHwmZiv8
         95FA==
X-Gm-Message-State: AAQBX9cVU/U/rUaIV1t4mHHVUBjvaKl6poCnQIfSdPoBrhohElSS3o1G
        Qt72CpR3tNpQ4fKSsiB+xeFgE1GZOdjci8P9
X-Google-Smtp-Source: AKy350aSze1C4fPf47+E+0xuiRKNq7C/DaOLWBRXCOYfqto6S1n8ydFajx6q/Noe7CW9bsz7n8mIeg==
X-Received: by 2002:a05:6a00:1a86:b0:63b:8eeb:77b8 with SMTP id e6-20020a056a001a8600b0063b8eeb77b8mr21690945pfv.13.1682429693306;
        Tue, 25 Apr 2023 06:34:53 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b0063d44634d8csm9243469pfc.71.2023.04.25.06.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:34:53 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 2/6] notes.c: use designated initializers for clarity
Date:   Tue, 25 Apr 2023 21:34:37 +0800
Message-ID: <4ad7840584191d6bbb3fcba72887aa569c797a15.1682429602.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g931d6dc6
In-Reply-To: <cover.1682429602.git.dyroneteng@gmail.com>
References: <cover.1682429602.git.dyroneteng@gmail.com>
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
2.40.0.358.g931d6dc6

