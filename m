Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F82CC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiGGQQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiGGQQu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:16:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647A1E0
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:16:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 73so3976983pgb.10
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGmLHt+fwanfeVPAmwUHIHJo7iGKT9PG/C9ONk37DJI=;
        b=ox5vr0wlNs7xB/GSwnzDyFe97iEQPe8H23d3+kpzBWqhFGN74CEr93jLL26DlVaz50
         phYm1zOMiGmqEoSpHqtxW+mCA/BNAv8MjW+H0CLsc+5SslAk/A3frpL3ngimJDj6GgI0
         4SXc5xq/qRCJ/wcSgbwH9gW8Djv8k2RLrK1pO7wChBARPc3Dck6hhkWVmqeFC4rSB5MW
         CQjFOhOV2e6YxZ6MZhF/BgvQRLUqGeIQjJrZS7TfUfsdwR+Oz3ajA1bCa/3O8Guw4ycy
         rCWUK+oIzJfufCp6lVNe7qDkHQxOaXlbxKLl65S5AOcAF6aAj4z8+2OCI/EWX9/fA4jf
         7DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGmLHt+fwanfeVPAmwUHIHJo7iGKT9PG/C9ONk37DJI=;
        b=jiule9mfp7Ss2DI6oUCeoFQPE9iAY/WkUvXrpkvwcN1AVdGmLPC9pjCoVy6VERDkvp
         V3Z0OV+HlnKvLOR7VCGx/hPNTiUHdnrwp9eGEQZWTfl9Fj/t11aiyf8VB7dqJRqCrnLd
         5WJuHC8FhuHmY3MJGbE2IwGM1pgIyJqZHg1ATockIN3Y8etpJcuirseH9gkUU1xJaP/N
         Nbw9xzCmgbCOTUx0Lr3hwdhe7m/amHBNHONKhqgkvxP0NOciA9dwop5voKmYSS2F4dJT
         sPLysMm1/wsBu53msbFUFvvIYj/nj5RnzAALXSHtFdS8rKJEK8+CK4qPD/kS4/HokPow
         RM6w==
X-Gm-Message-State: AJIora8Qhp1zrjtxXZhAXe8AbltSNvGbd//gmvaDjIKZR13uVYFXgBd7
        chm1HKlHKtU6FVaJ43ZIPiTGtK27+8QNh/Qr
X-Google-Smtp-Source: AGRyM1vk1oEnNHzfP4f1qxjyR4YZVyZXJBzwhLJ79BRAIBMxhWkuuwr21H8vjaT/TOloEXrvyn/mDg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr6263620pjb.164.1657210608437;
        Thu, 07 Jul 2022 09:16:48 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b0015ee985999dsm27996199plr.97.2022.07.07.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:16:47 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: [PATCH v2 1/4] revision: improve commit_rewrite_person()
Date:   Thu,  7 Jul 2022 21:45:51 +0530
Message-Id: <20220707161554.6900-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.ga6a61a26c1.dirty
In-Reply-To: <20220707161554.6900-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function, commit_rewrite_person(), is designed to find and replace
an ident string in the header part, and the way it avoids a random
occuranace of "author A U Thor <author@example.com" in the text is by
insisting "author" to appear at the beginning of line by passing
"\nauthor " as "what".

The implementation also doesn't make any effort to limit itself to the
commit header by locating the blank line that appears after the header
part and stopping the search there. Also, the interface forces the
caller to make multiple calls if it wants to rewrite idents on multiple
headers. It shouldn't be the case.

To support the existing caller better, update commit_rewrite_person()
to:
- Make a single pass in the input buffer to locate headers named
  "author" and "committer" and replace idents on them.
- Stop at the end of the header, ensuring that nothing in the body of
  the commit object is modified.

The return type of the function commit_rewrite_person() has also been
changed from int to void. This has been done because the caller of the
function doesn't do anything with the return value of the function.

By simplyfying the interface of the commit_rewrite_person(), we also
intend to expose it as a public function. We will also be renaming the
function in a future commit to a different name which clearly tells that
the function replaces idents in the header of the commit buffer.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 revision.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 211352795c..83e68c1f97 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,19 +3755,17 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+/*
+ * Returns the difference between the new and old length of the ident line.
+ */
+static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
 {
-	char *person, *endp;
+	char *endp;
 	size_t len, namelen, maillen;
 	const char *name;
 	const char *mail;
 	struct ident_split ident;
 
-	person = strstr(buf->buf, what);
-	if (!person)
-		return 0;
-
-	person += strlen(what);
 	endp = strchr(person, '\n');
 	if (!endp)
 		return 0;
@@ -3784,6 +3782,7 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 
 	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
 		struct strbuf namemail = STRBUF_INIT;
+		size_t newlen;
 
 		strbuf_addf(&namemail, "%.*s <%.*s>",
 			    (int)namelen, name, (int)maillen, mail);
@@ -3792,14 +3791,39 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 			      ident.mail_end - ident.name_begin + 1,
 			      namemail.buf, namemail.len);
 
+		newlen = namemail.len;
+
 		strbuf_release(&namemail);
 
-		return 1;
+		return newlen - (ident.mail_end - ident.name_begin + 1);
 	}
 
 	return 0;
 }
 
+static void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
+{
+	size_t buf_offset = 0;
+
+	if (!mailmap)
+		return;
+
+	for (;;) {
+		const char *person, *line = buf->buf + buf_offset;
+		int i, linelen = strchrnul(line, '\n') - line + 1;
+
+		if (!linelen || linelen == 1)
+			/* End of header */
+			return;
+
+		buf_offset += linelen;
+
+		for (i = 0; headers[i]; i++)
+			if (skip_prefix(line, headers[i], &person))
+				buf_offset += rewrite_ident_line(person, buf, mailmap);
+	}
+}
+
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
@@ -3835,8 +3859,8 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
 
-		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
-		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
+		const char *commit_headers[] = { "author ", "committer ", NULL };
+		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
 	}
 
 	/* Append "fake" message parts as needed */
-- 
2.37.0.6.ga6a61a26c1.dirty

