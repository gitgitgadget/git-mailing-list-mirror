Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE0C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 12:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjERMCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjERMCa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 08:02:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A0FE
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso414792b3a.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684411349; x=1687003349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XQTaH+LflmzkJp6Eb70FB5YRg/xxwCc9JOFrQmK1Ak=;
        b=fStYNM+Hr6k2ly9dsqsa8GJKRT4IylGpZhoC9Qixy4TrkUnEVl9IJtplBDQPALgGc6
         JyY+ZYGy+EBNt2K6W5njC8SA1GcOha/+dtk9FApJTEg+OyXLnLRwdeVY8Z3MPAlh4n6n
         0mQXqkmozDJMoXb/hiZZPdkkMZxPzcEu8Ut4W1b4HZe3jowQ3cyW9rplYqVZ3P9+ETty
         VkfanBk79V8ftecxHgdRFX90culWQrSOZ8vLjOiqL6TbMvYGz1p0Q4Jvj4S3Ov0KgP/Y
         l/LBVxWcUG+rR8DoIe3kHixs+8S6klzB2xBGjLHyc4okcaWnkDKzyumQWPK+WhgQEaoR
         csPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411349; x=1687003349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XQTaH+LflmzkJp6Eb70FB5YRg/xxwCc9JOFrQmK1Ak=;
        b=IlCz/E+JSySWme7FuF1fYEcs2FZ0nPs7T9Hm6m6jGASd58lFFFqXqbP53XiYRY/Avq
         OeQeSf6hS+aEpd2fZhoQQAuMhA827ANfTrpdCNu9DiPT0ZBm944nD88VnHYhQ90uMICR
         sMOIwnKqMAsO7y1gmY6Jsk5zQtXhKEpPvIIDjB9HADL+Gje30uQWh/kqg9aShRK27r7S
         yawqZ+V6qQM7PUTjnnzoButz9bqPbDPU145EMaM5K0kq97cFp+Go6wAKbShuQmDA7CCJ
         YaSsSeOMZ/JaL7Lnen9kcdW54L8NXS+ttzlWCf0W49k2CGVY33rQFkZ6aXmyqyP3rhx4
         d4dg==
X-Gm-Message-State: AC+VfDz5Sgr2Y9lvooJ65lFmrzFrIdM9T1MudioqnZE80OG4mlOOwil5
        oDbGYEDLTGgxJSsYYNLQ3Ck=
X-Google-Smtp-Source: ACHHUZ4EgiF3FYJHa2JHD7TMmwqbACqgN8V7J2Yd11efwbbu2uaAnyLoFYC7vNCHBwiUy7Pyg6OfqA==
X-Received: by 2002:a17:902:7fc9:b0:1ac:8062:4f31 with SMTP id t9-20020a1709027fc900b001ac80624f31mr1954755plb.37.1684411348809;
        Thu, 18 May 2023 05:02:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001960706141fsm1264203plb.149.2023.05.18.05.02.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 05:02:28 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v10 2/6] notes.c: use designated initializers for clarity
Date:   Thu, 18 May 2023 20:02:07 +0800
Message-ID: <4ad7840584191d6bbb3fcba72887aa569c797a15.1684411136.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com>
References: <cover.1684411136.git.dyroneteng@gmail.com>
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
2.40.0.356.g67a1c1d0

