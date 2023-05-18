Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C939C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 12:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjERMCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjERMCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 08:02:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D645810DD
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso20319805ad.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684411356; x=1687003356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sXmmxz2eTSnJS31oJFcTKwGVwKTek9x3Ra8DQzhzaw=;
        b=UHBQyJtGhuEHPSP3N7b3L6MCzGLlEoBZH/6q6tNbHEtoV1TbV/xBpVriF1uwooAv1D
         vQu+70KEZfY3ptDz0CUBndZpobtnptqApqUnJcVF2e9yDe3rYiIdaDkOgLRCG4XRkaKL
         LAc8x+euvdBzXTXHLgBN9nWylirrThyVFtWYZYTveC8nBHf4R6PHJ1+0pFJg/XoQMLUs
         ftSDcwPqW67km0tWxGRSltO6yxxL27Cy6jvWFVHavsV673eGX+w9oT6MVRVhtd1vgaWp
         Dt2A+JR/01qye9BVexB0IOPEHGYdaCWqODD1ArS4K634XaXZRJXab7Zkzl2VYzdI9jmv
         BmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411356; x=1687003356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sXmmxz2eTSnJS31oJFcTKwGVwKTek9x3Ra8DQzhzaw=;
        b=LjuLTEBDJz7rBGYUWTYOI+2R0mVHo3J+dLYTleluhQzvdJO5+QHqhrWV/uJY5wfnms
         pcCysLNWqdKseQHWw9Vz4WKJ3yUrtm2S3lU4a64r9oiOw9EHV/X+fInRqJl75ioHQHgu
         T93hAvCmFVs7Ss10RkXgyDpPS9HuB1sbDC4CE82lyUqqYbT32Pk4YjsXrbk+3yp6R+4l
         OHiEOLu7kOSLAAmYpxdfn+D8o/wxNLzLJDtzSljXDupoZxcpsAoyPcmep6roKFGTCixP
         UVMnsuuKSc4a4rV7HMVCvlJCW7AsH3dr5pGtsDhwjelmshDW5koJxdTNq8ujdO82QjVo
         tOjw==
X-Gm-Message-State: AC+VfDxrqpFZxWbsX691jdi6y2p27qCMz6xIJwqJDGm657r+g/ylNAPv
        ehxucAyURnI4fbSm1tzKvD0=
X-Google-Smtp-Source: ACHHUZ5PwpSwhqfgT3UmIyadFl1/Zw5/mhTI4Tww7rLfSU6QPDFEwu0SBVI2WePhm0qt3U09oobGhw==
X-Received: by 2002:a17:902:daca:b0:1ae:5752:aa51 with SMTP id q10-20020a170902daca00b001ae5752aa51mr2843952plx.36.1684411356209;
        Thu, 18 May 2023 05:02:36 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001960706141fsm1264203plb.149.2023.05.18.05.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 05:02:35 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v10 5/6] notes.c: append separator instead of insert by pos
Date:   Thu, 18 May 2023 20:02:10 +0800
Message-ID: <76c93f192cd2040eab39353afba0eaa32a07dab8.1684411136.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com>
References: <cover.1684411136.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Rename "insert_separator" to "append_separator" and also remove the
"postion" argument, this serves two purpose:

The first is that when specifying more than one "-m" ( like "-F", etc)
to "git notes add" or "git notes append", the order of them matters,
which means we need to append the each separator and message in turn,
so we don't have to make the caller specify the position, the "append"
operation is enough and clear.

The second is that when we execute the "git notes append" subcommand,
we need to combine the "prev_note" and "current_note" to get the
final result. Before, we inserted a newline character at the beginning
of "current_note". Now, we will append a newline to the end of
"prev_note" instead, this will give the consisitent results.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 7aa2f923..84c010fe 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -229,14 +229,14 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
-static void insert_separator(struct strbuf *message, size_t pos)
+static void append_separator(struct strbuf *message)
 {
 	if (!separator)
 		return;
 	else if (separator[strlen(separator) - 1] == '\n')
-		strbuf_insertstr(message, pos, separator);
+		strbuf_addstr(message, separator);
 	else
-		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+		strbuf_addf(message, "%s%s", separator, "\n");
 }
 
 static void concat_messages(struct note_data *d)
@@ -246,7 +246,7 @@ static void concat_messages(struct note_data *d)
 
 	for (i = 0; i < d->msg_nr ; i++) {
 		if (d->buf.len)
-			insert_separator(&d->buf, d->buf.len);
+			append_separator(&d->buf);
 		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
 		strbuf_addbuf(&d->buf, &msg);
 		if (d->messages[i]->stripspace)
@@ -695,14 +695,17 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
-		char *prev_buf = repo_read_object_file(the_repository, note,
-						       &type, &size);
+		struct strbuf buf = STRBUF_INIT;
+		char *prev_buf = repo_read_object_file(the_repository, note, &type, &size);
 
-		if (d.buf.len && prev_buf && size)
-			insert_separator(&d.buf, 0);
 		if (prev_buf && size)
-			strbuf_insert(&d.buf, 0, prev_buf, size);
+			strbuf_add(&buf, prev_buf, size);
+		if (d.buf.len && prev_buf && size)
+			append_separator(&buf);
+		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
+
 		free(prev_buf);
+		strbuf_release(&buf);
 	}
 
 	if (d.buf.len || allow_empty) {
-- 
2.40.0.356.g67a1c1d0

