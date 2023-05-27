Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC0C7EE23
	for <git@archiver.kernel.org>; Sat, 27 May 2023 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjE0H6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 03:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjE0H6R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 03:58:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F59D13A
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae8ecb4f9aso10390395ad.1
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685174295; x=1687766295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpYXsiqt088lZOJgZhTZ5Kd3lqo13aCD386khd6uI88=;
        b=A1GZY/R2QJK853fvv0J24cXDQKTLVUi8UNm84PxZDKsumQBIoK3HmfRHSXudDymKVo
         7ouFkVkWG6QLA6WxuklkF758Jnr7JkY4fLsJbv9VKjJMZTjq9b7kwvOhQjOvKhVIYkE/
         KonKR8ot1mu12fHd6Z54jBjVfwwJcABVHZpneDszKL0Q4vR63LhPXSS0Y8go/I3/XY58
         i96ZNLjlz2fd6aK+No2xBh04fwhKOhwmTK9TcDOEHXPtmQPDudZ1suTOD9NubWGAvPGQ
         cY2AOR/g+uY7RlaFK/2UHIM6k+YebmivgrPFuNviHEfEEsCORGDbsbAqvZ17TztzPY+y
         jA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685174295; x=1687766295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpYXsiqt088lZOJgZhTZ5Kd3lqo13aCD386khd6uI88=;
        b=FQYN+1XqjeIpsptTtTzShNzQ5h8tCxpaeOzumkJXv1HPOibm39XAy4v9v3CDB/3cNL
         QIhR5oSqiRXIsRwrnzplG1hvaAouwLa9JgViCScpCwFQNtQr/FRaFwrVxzUAXHgeUWs4
         fDA7wMHsL/HnSOu+rCYHBcCQvmokJcpPMpQasUSI0Zw/kfi+U4C9caISo12VM9d/k2UK
         cJxcLPVFsKGamAfJkkNYw86pTPRbwE9NYiIRuvEiMSmkYd6aijTWFeDVgTxyo7i+eNtD
         Iuf+8KWU+Nkd6bzpqDiEvbaDAmS8GYvOcAnOw0dqiYrIpe7K2ol2MBx6WNbtSlg40z79
         aqDw==
X-Gm-Message-State: AC+VfDyXy26MNxLa85qbPK81FYhi2fM3uXEjobDcKro08/pcgLdGkbQp
        VKp96/C7L89y1Jy5Yz3eH4Y=
X-Google-Smtp-Source: ACHHUZ6iWbmL0CuEF7XigcwgqJidrT1zcllp/UMBG4iqYj5uZsgb3F2btueaJ0fsXRI1T2hm8RBCXw==
X-Received: by 2002:a17:903:41cc:b0:1ab:675:3e0c with SMTP id u12-20020a17090341cc00b001ab06753e0cmr5993522ple.33.1685174294787;
        Sat, 27 May 2023 00:58:14 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm4355239plr.172.2023.05.27.00.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 00:58:14 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, code@khaugsbakk.name
Subject: [PATCH v11 5/7] notes.c: append separator instead of insert by pos
Date:   Sat, 27 May 2023 15:57:52 +0800
Message-ID: <4ba62a48ec56b43f859fce0eb0d88528f6873edb.1685174012.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <cover.1685174011.git.dyroneteng@gmail.com>
References: <cover.1685174011.git.dyroneteng@gmail.com>
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
index d8a39fe2..b2804479 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -229,13 +229,13 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
-static void insert_separator(struct strbuf *message, size_t pos)
+static void append_separator(struct strbuf *message)
 {
 	size_t sep_len = strlen(separator);
 	if (sep_len && separator[sep_len - 1] == '\n')
-		strbuf_insertstr(message, pos, separator);
+		strbuf_addstr(message, separator);
 	else
-		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+		strbuf_addf(message, "%s%s", separator, "\n");
 }
 
 static void concat_messages(struct note_data *d)
@@ -245,7 +245,7 @@ static void concat_messages(struct note_data *d)
 	size_t i;
 	for (i = 0; i < d->msg_nr ; i++) {
 		if (d->buf.len)
-			insert_separator(&d->buf, d->buf.len);
+			append_separator(&d->buf);
 		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
 		strbuf_addbuf(&d->buf, &msg);
 		if (d->messages[i]->stripspace)
@@ -680,14 +680,17 @@ static int append_edit(int argc, const char **argv, const char *prefix)
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
2.40.0.356.g367cb1d4

