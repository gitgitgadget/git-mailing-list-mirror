Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCCFC77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 09:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345526AbjD1JYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbjD1JX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 05:23:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7F49E1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso6756453b3a.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682673836; x=1685265836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML6J1lQAN7PCv6OAMZrFzhp4NSsYmaYu4Jgfios8sB8=;
        b=Q+Povm+HVH2U7W4d+dZkL6Pe4kI4ll9gYlsv9F/nu/L097td7WkWgtwHgKX1iL3W+7
         7yHrpWa0/9TyC0Vi6uTB4vLNhNFtZrip8+xb4/bh5isqmhPnGA9syK4cKCbPZ130pVJh
         oQ5aKmHGH+T4b50JZlhdl3D+WPK047cb82iAQ22CUmZjsHk0fR9oyIRktBBqj4nKey9h
         xZs7g4UDOLQPS0kBFDuYmQKW/b15pYk4z/GgiRpzNKJLY/CujhVK1rrWaSEnn2LdrkXH
         5OSayI9PAQQdi2ynR6p8R74hA9A5K/uVPdMfx2KrbZzMJxEQEPk6E8lgf8ALj/hQ/Tiu
         qWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682673836; x=1685265836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML6J1lQAN7PCv6OAMZrFzhp4NSsYmaYu4Jgfios8sB8=;
        b=KwUzEoUJXOtoB8xxBlXZTuLVLUiBWzCWR6QH348VPJYjbJYOJPmciLsHX2KQHesbS2
         ZUDOzn1jPEkqVM7l7t2cVCSYmXNOQ/rbeW5ahDtSwHvnRLdWLgCvpBj43mIj3oG0qBb5
         Y115T2wBsXWiAS6p4ztNW7c13QzH1ZuT7ifAJT1ufzvbmcg+/xzv0Bin1kMZoS8DR2GI
         OTs/EAe4vDN9McyBidGI9rAGorzQ5m7NzjUpGmofzcKuHxZDWdoAO/P2PkBZZxWrxT0L
         0wY49PCN7YwxFcdf05wjisCC23sOqcYVoteCFVZ46QaMSvDb9BNSPs374xma9n1HyXYa
         YfRg==
X-Gm-Message-State: AC+VfDyjGCQiGZPRYe4hm5/JykcmiFHyDWp4Q7TGhZA4SdbnHxoKpwuP
        MYjq5P65+YYC3wyPdxe6uas=
X-Google-Smtp-Source: ACHHUZ4x4Ri1jUQ4olPVbnxfE3nUKFSkri5BMntP9hZvLLnHqn4i8j6k5GUJ1Kfv88ojxzFhheA31g==
X-Received: by 2002:a05:6a00:a0e:b0:63d:47ab:65ed with SMTP id p14-20020a056a000a0e00b0063d47ab65edmr7177681pfh.7.1682673835968;
        Fri, 28 Apr 2023 02:23:55 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm15107078pfu.93.2023.04.28.02.23.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 02:23:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v9 5/6] notes.c: append separator instead of insert by pos
Date:   Fri, 28 Apr 2023 17:23:33 +0800
Message-ID: <eea2246f44a3adfc4888db93975854448271032b.1682671758.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g2947072e.dirty
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
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
 builtin/notes.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3215bce1..e32f2453 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -229,12 +229,12 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
-static void insert_separator(struct strbuf *message, size_t pos)
+static void append_separator(struct strbuf *message)
 {
 	if (separator[strlen(separator) - 1] == '\n')
 		strbuf_addstr(message, separator);
 	else
-		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+		strbuf_addf(message, "%s%s", separator, "\n");
 }
 
 static void concat_messages(struct note_data *d)
@@ -244,7 +244,7 @@ static void concat_messages(struct note_data *d)
 	size_t i;
 	for (i = 0; i < d->msg_nr ; i++) {
 		if (d->buf.len)
-			insert_separator(&d->buf, d->buf.len);
+			append_separator(&d->buf);
 		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
 		strbuf_addbuf(&d->buf, &msg);
 		if (d->messages[i]->stripspace)
@@ -679,14 +679,17 @@ static int append_edit(int argc, const char **argv, const char *prefix)
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
2.40.0.358.g2947072e.dirty

