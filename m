Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E83C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 15:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGIPmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIPma (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 11:42:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3232A732
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 08:42:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so4534891pjr.4
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVNAQ+ZfOMv2yKI1iHlzflyugwyXQWFM6NDBeidxkPg=;
        b=VpWkTVbUn+IUQy1jjkbP+mQ4SdlqYdl6JDpj1MD0JhkEYHIJQpu1Hl183qRkXIXrrW
         xGVAm+P9iPhWiFEoMUkpx+iDV5FWD8dx+cr6CJr4D7PUEnLpYe07y9uZLAIYgOGUOQ+1
         IzSVi7oXn8ek7TrcP3FwpFI+mMsT7uwYgieu6pk9ggn/W/yHpsiiUQFRki88DJSdvtCm
         MlVZVxHeJgJT/gzG7+Cy2FtMcdanYxXCLpXo+eY58lcB8P2j/wkykqBW7vBwgeFYBC0X
         rsUh3jQLDqUyaQkxW6ZhlfMOToNNC+uwhnd8MwD7ofCIHjSvOvNekmRQtXWOv+qpJgt9
         RVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVNAQ+ZfOMv2yKI1iHlzflyugwyXQWFM6NDBeidxkPg=;
        b=bYLf+/txDHbGCWNwUS6tLosdA9Hsmm8FttFptvDkIIEjL1UThFcvSiX4+6gm+bG80Q
         XQ58aISZNPxua4AeW4Gd4zNFl+RuWexUVpYU5MY58B+k9rf5Kg6oXXqhXYnifwtI3aBw
         UQBFDgbwElrxMosPbtHRXoRfBp93lmESm5mxkAn3GoG8Jok06AnwnkZsF/AFbmiWayhR
         gqBJXy9mz7qMUryC0ZIm0hGsVz0PLEurf0Oklj42H774KgmlrAEMuhqvBqvJjjgGDDig
         Igu0c8MsJc6egV85eWp6CPzH+o96Q6z8PnxSuX4GpK9AJWRn3TOaM5ORBX14W4tRWULe
         ZYIg==
X-Gm-Message-State: AJIora+Y0g/unTXYLYzmCUGz3e9WWeNsn3skR3WccVTm2oJbdAfhMW89
        54DCtcRV6+X44vDHmWGUZ/7ax27ZTaJmdKfY
X-Google-Smtp-Source: AGRyM1uz4hO0Pxdo+rN4vpYiGPeY7pWEkjap+b7rYGqdV6Sf2YFQPqOjNBSiEaYaeAKRI/+kIfrS3g==
X-Received: by 2002:a17:90a:2f46:b0:1ef:a785:dd2a with SMTP id s64-20020a17090a2f4600b001efa785dd2amr6762661pjd.238.1657381348524;
        Sat, 09 Jul 2022 08:42:28 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016be4d78792sm1473833plb.257.2022.07.09.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:42:28 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 1/4] revision: improve commit_rewrite_person()
Date:   Sat,  9 Jul 2022 21:11:46 +0530
Message-Id: <20220709154149.165524-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220709154149.165524-1-siddharthasthana31@gmail.com>
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
 <20220709154149.165524-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function, commit_rewrite_person(), is designed to find and replace
an ident string in the header part, and the way it avoids a random
occurrence of "author A U Thor <author@example.com" in the text is by
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

By simplifying the interface of the commit_rewrite_person(), we also
intend to expose it as a public function. We will also be renaming the
function in a future commit to a different name which clearly tells that
the function replaces idents in the header of the commit buffer.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 revision.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 211352795c..1939c56c67 100644
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
@@ -3792,14 +3791,42 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
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
+		const char *person, *line;
+		size_t i, linelen;
+
+		line = buf->buf + buf_offset;
+		linelen = strchrnul(line, '\n') - line + 1;
+
+		if (linelen <= 1)
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
@@ -3832,11 +3859,12 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		strbuf_addstr(&buf, message);
 
 	if (opt->grep_filter.header_list && opt->mailmap) {
+		const char *commit_headers[] = { "author ", "committer ", NULL };
+
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
 
-		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
-		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
+		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
 	}
 
 	/* Append "fake" message parts as needed */
-- 
2.37.0.6.g69b7ad898b

