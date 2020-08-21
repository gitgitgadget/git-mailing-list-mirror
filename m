Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0510C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69E620724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByIXptHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHUVmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHUVmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:42:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91957C061575
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so2017558wmc.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y9gz+4QhZ13A2LGFwbS6ZAj9K7bkVoWByLN4SMbwILc=;
        b=ByIXptHYHTLStkAnfu5e+wGfyqZ3a0t/rnCJe1h1/fsvXqpqzStSRJsUYbsMSqFlpL
         YhOH2QpYAD0ZJxP/Em+MN4pgcTUXqC8NURkl0rQZZaK7pUpZZqqOfJNIPDrtXRsu/xDw
         G9QDqhGKEliBgMT5ZUnI9rU4sQV5upixbgoaaz4gCm0bIoeT5F9AbtqITOqmALgjFvXg
         bSbNTn4yacevR+HFIK/7eM6h4t901RDmJzF5rqfq5ldjWA5jcc8T1GoOU0zcIifIlXnp
         uXY59hbIjJs7xmfVXBUa3CJ4UfObeo/7KuBcRfpicBTxuwQPALa3ZHBWe0KzAKPKAtDk
         4+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y9gz+4QhZ13A2LGFwbS6ZAj9K7bkVoWByLN4SMbwILc=;
        b=PBw0uJnNQMYq4Z96xMHDvPh+5CCLWsrkoRXxwncmdZXVsBPX4n35EZbUDM36eiPyak
         dMnHzHOSoCZZxvZL44qA3JRxBBz1PtLrwhKdQHIJLckEdB7hVtxTjjHgytFx9ES2uhec
         l3U6UNkNtXbr+5JX2fe2aaqo5k3Y3SYKvpjEqSv9Yqfo0b3rk/jGXDYljmefxKasoANX
         nG6a1DS8rjSf7tOSEFrP+MRZeac/aXVsPwUuCVutfLiqOvyzfmy+AmVqYloi0fFVuIWu
         vpw/6ZkE7/+YcHMf5xeMqCRkirxwoPRQ3Sk43wPSiYqKZoxsJlqqybH9SzrYNMIxMk0/
         z0uA==
X-Gm-Message-State: AOAM531v7vwuLlaT+cz/fnjGoLS9xFVNVB1QVEcVAhLBTX4MvUjoW4A0
        KNuMZmYYGjVRcMQvLkKXtOyxLyUekHs=
X-Google-Smtp-Source: ABdhPJwWQ6vJnW4/1RhOcn/r6Yenss1EOmW/IqIjLEI2RmuldKfUL9ZegYtkNCkEMFXAGrZIY40zDA==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr5935859wmj.56.1598046118097;
        Fri, 21 Aug 2020 14:41:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm6594260wrm.62.2020.08.21.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:57 -0700 (PDT)
Message-Id: <6105046d96223bda40ab0f0177e4f0281376ba53.1598046110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:49 +0000
Subject: [PATCH v4 7/8] pretty: refactor `format_sanitized_subject()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

The function 'format_sanitized_subject()' is responsible for
sanitized subject line in pretty.c
e.g.
the subject line
the-sanitized-subject-line

It would be a nice enhancement to `subject` atom to have the
same feature. So in the later commits, we plan to add this feature
to ref-filter.

Refactor `format_sanitized_subject()`, so it can be reused in
ref-filter.c for adding new modifier `sanitize` to "subject" atom.

Currently, the loop inside `format_sanitized_subject()` runs
until `\n` is found. But now, we stored the first occurrence
of `\n` in a variable `eol` and passed it in
`format_sanitized_subject()`. And the loop runs upto `eol`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 pretty.c | 20 +++++++++++---------
 pretty.h |  3 +++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/pretty.c b/pretty.c
index 2a3d46bf42..7a7708a0ea 100644
--- a/pretty.c
+++ b/pretty.c
@@ -839,21 +839,22 @@ static int istitlechar(char c)
 		(c >= '0' && c <= '9') || c == '.' || c == '_';
 }
 
-static void format_sanitized_subject(struct strbuf *sb, const char *msg)
+void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
 {
 	size_t trimlen;
 	size_t start_len = sb->len;
 	int space = 2;
+	int i;
 
-	for (; *msg && *msg != '\n'; msg++) {
-		if (istitlechar(*msg)) {
+	for (i = 0; i < len; i++) {
+		if (istitlechar(msg[i])) {
 			if (space == 1)
 				strbuf_addch(sb, '-');
 			space = 0;
-			strbuf_addch(sb, *msg);
-			if (*msg == '.')
-				while (*(msg+1) == '.')
-					msg++;
+			strbuf_addch(sb, msg[i]);
+			if (msg[i] == '.')
+				while (msg[i+1] == '.')
+					i++;
 		} else
 			space |= 1;
 	}
@@ -1155,7 +1156,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
-	const char *arg;
+	const char *arg, *eol;
 	size_t res;
 	char **slot;
 
@@ -1405,7 +1406,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		format_subject(sb, msg + c->subject_off, " ");
 		return 1;
 	case 'f':	/* sanitized subject */
-		format_sanitized_subject(sb, msg + c->subject_off);
+		eol = strchrnul(msg + c->subject_off, '\n');
+		format_sanitized_subject(sb, msg + c->subject_off, eol - (msg + c->subject_off));
 		return 1;
 	case 'b':	/* body */
 		strbuf_addstr(sb, msg + c->body_off);
diff --git a/pretty.h b/pretty.h
index 071f2fb8e4..7ce6c0b437 100644
--- a/pretty.h
+++ b/pretty.h
@@ -139,4 +139,7 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 /* Check if "cmit_fmt" will produce an empty output. */
 int commit_format_is_empty(enum cmit_fmt);
 
+/* Make subject of commit message suitable for filename */
+void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len);
+
 #endif /* PRETTY_H */
-- 
gitgitgadget

