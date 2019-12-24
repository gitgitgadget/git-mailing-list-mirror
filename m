Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C74C3F68F
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F6820643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq35PQXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXLFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37236 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfLXLFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so17881812qtk.4
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gc3wctujx0pytxtJt0GHE/bW2ail+olVBf+H6OYuszA=;
        b=aq35PQXcpzXT/Rdbc23jdqvSGcCFhkx94NqYcDlNT6Soiehw/Wj9+2w44qqnw64OLg
         ZvfFzeSlDXZfvUCU+utGVWqATJ46SCs0/1qVQgPxtNd8fMTxZJAuC+wtu08Dm0F6gbjj
         d60oQSsGk4ogNBZ3U8Lg9iXpl2xw8mdU+WXfYolKLYHUceyZYkwsXg31DtU7UWjAPiLW
         AcV6w/UpefYoC+C1ShDga2Ay+lwzFjV6/gvkOrQY05+JYCY+7Bi6uRb6MrF0tackZXQn
         HIgIGzAj3v1/9RZ64qIQylapXgK5xHD2UM3yzmbg8UHHdIU/Zkfs3MSmVMVk5XA1eWMS
         f3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gc3wctujx0pytxtJt0GHE/bW2ail+olVBf+H6OYuszA=;
        b=Q3UUEN26QTdPsPq8bKYxN6HzTLbt+tbKg095IP1SAnHrjpqGj03pdNyCEoEJ3h+T8Q
         iU9m5igGf9dcQ7XgskU4LyEOhRRjAet1EuwKyTwb5+UTf045RjIsSB0R2PpvdGyr56d2
         1tH3SlMzF7GeduRx4kNIoNh6dS1M/VuslsKuAzZIzPJo+6uY23cnEvYtAhggd4d7lBO9
         6G9HXp/Ka8dU5ksL0a0SdO++GPsUB+pSc6QxWNqEE6CP3pMSH4FRLfEqdPIihbZ+VbrH
         YaPXP4NFfP4cbeWjqYcXfE+gWvMZQHVKLSyoIVlbv7LpyW4raNcSOmcEDgZF280SJTfV
         kcFA==
X-Gm-Message-State: APjAAAXlct/cm/eQ/UszR6LdK3CYjgXYFkejl+/8ofZiGmFRb/xMUjNC
        L10lk7KdruR7NKBxWEFeqL0k5khn
X-Google-Smtp-Source: APXvYqy1ydJ0AgVxUPvLc8bOT51lyZlfItodCbv3PcxNIJ9unkrNf9Tn+K5oAPQIQ29ocFflIaoq7A==
X-Received: by 2002:ac8:784:: with SMTP id l4mr26156735qth.286.1577185549752;
        Tue, 24 Dec 2019 03:05:49 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:49 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 03/17] sequencer: use file strbuf for read_oneliner()
Date:   Tue, 24 Dec 2019 06:05:00 -0500
Message-Id: <de79e27c17af27395401e0c2280d90a7d8bdef14.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original read_oneliner logic, we duplicated the logic for
strbuf_trim_trailing_newline() with one exception: instead of preventing
buffer accesses below index 0, it would prevent buffer accesses below
index `orig_len`. Although this is correct, it isn't worth having the
duplicated logic around.

Add a second strbuf to which files are read and run
strbuf_trim_trailing_newline() directly on this strbuf then concatenate
this strbuf with the argument strbuf at the end of the function. The
function's external behaviour is unchanged.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 763ccbbc45..5ba8b4383f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -429,26 +429,28 @@ static int write_message(const void *buf, size_t len, const char *filename,
 static int read_oneliner(struct strbuf *buf,
 	const char *path, int skip_if_empty)
 {
-	int orig_len = buf->len;
+	int ret = 0;
+	struct strbuf file_buf = STRBUF_INIT;
 
 	if (!file_exists(path))
 		return 0;
 
-	if (strbuf_read_file(buf, path, 0) < 0) {
+	if (strbuf_read_file(&file_buf, path, 0) < 0) {
 		warning_errno(_("could not read '%s'"), path);
-		return 0;
+		goto done;
 	}
 
-	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
-		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
-			--buf->len;
-		buf->buf[buf->len] = '\0';
-	}
+	strbuf_trim_trailing_newline(&file_buf);
 
-	if (skip_if_empty && buf->len == orig_len)
-		return 0;
+	if (skip_if_empty && !file_buf.len)
+		goto done;
 
-	return 1;
+	strbuf_addbuf(buf, &file_buf);
+	ret = 1;
+
+done:
+	strbuf_release(&file_buf);
+	return ret;
 }
 
 static struct tree *empty_tree(struct repository *r)
-- 
2.24.1.810.g65a2f617f4

