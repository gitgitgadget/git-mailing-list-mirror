Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652DC43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 07:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiGPHlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPHlR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 03:41:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3111055F
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso9615440pjz.0
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCmC8i8ashrRnHfFoSvLmXY456g/qnefS1Bfp7aVcsc=;
        b=MI6EcxKUnNeQ3RFNHFkKpjHSHDKrL72hEbpTiTxqesTYBG+DjPqMq3qX6aLgqphEKr
         ohZNUOElqqQtGSjY7HI63K+8owVGSGXgXUHkcdBTu1lNMpELjauVG9j0Muw3ar82aq3d
         GY6geghETUw5JOYAMhyTorHt6lm3bNz6HfomRM7tS4q9pMOZtWhd9KiTN1vJYtvZOBkd
         FzH01Z8N1mHegYjA0AfDtmKNOiYx0TILpq1yuaskNbTMBJgY9bHW/yaIt9Cg5kfLOz1C
         ybM2GPwkFqAehathTiugr6f3rdSHL8uOtE4sGDOH3tU/BT0A778OLtRsqWbPK7r8ofrs
         aX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCmC8i8ashrRnHfFoSvLmXY456g/qnefS1Bfp7aVcsc=;
        b=vWjyWBRvE9fgkrcno69XpVHG63L0tutqarVkkHz40l5sP1nbs/ks4KFi9vFBMFMAh9
         V6ngZvKTNfGRHj/cEmfiBylowIC6ufPVfJcYb959GqDr2fTkWp3bsgyHmWCOD9VGRPiB
         DAJxtqoLZckxhcIeYG5p4jfM4doEZ8aWgcF0TBFgy7NJWe3ZJblRQWC5gaBe3lAQU+mb
         Y+ePX6RmdztSbAfYfLFSkwKcPp+h0iKjKmbFRgPgDM4AimzonXz6GssyJq1RxdiF2/Ea
         r9JYj/+OSiu5iKcMEJhPPTd2lG2Q+9TaiPLHh8cVUCxWWCNeNYPd5tVQb0apH0lzKFWw
         3Buw==
X-Gm-Message-State: AJIora9qgpWKA2OidJFQbXanaMabZA5k8kz32oSR9c1qBEvGnSxrqcfC
        n0NbbCSQWQ522srKSoa3TVwaRs8HccGL8KV5
X-Google-Smtp-Source: AGRyM1uKFi4Yxh2ZX6x5ZoTlJ/7a5S5wuvuSFd1evZoOnTmOf++ryPGPOOsDIRp0didxA6gRY+0tEQ==
X-Received: by 2002:a17:90b:33cd:b0:1f0:3655:17a8 with SMTP id lk13-20020a17090b33cd00b001f0365517a8mr20117838pjb.33.1657957275710;
        Sat, 16 Jul 2022 00:41:15 -0700 (PDT)
Received: from HB2.. ([110.225.168.189])
        by smtp.gmail.com with ESMTPSA id i27-20020a63541b000000b004161e62a3a5sm4325923pgb.78.2022.07.16.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 00:41:15 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 1/4] revision: improve commit_rewrite_person()
Date:   Sat, 16 Jul 2022 13:10:52 +0530
Message-Id: <20220716074055.1786231-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g001f220fb8
In-Reply-To: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
References: <20220712160634.213956-1-siddharthasthana31@gmail.com>
 <20220716074055.1786231-1-siddharthasthana31@gmail.com>
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
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 revision.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 211352795c..9909da928e 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,19 +3755,18 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+/*
+ * Returns the difference between the new and old length of the ident line.
+ */
+static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
+								  struct string_list *mailmap)
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
@@ -3784,6 +3783,7 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 
 	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
 		struct strbuf namemail = STRBUF_INIT;
+		size_t newlen;
 
 		strbuf_addf(&namemail, "%.*s <%.*s>",
 			    (int)namelen, name, (int)maillen, mail);
@@ -3792,14 +3792,44 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
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
 
+static void commit_rewrite_person(struct strbuf *buf, const char **header,
+								  struct string_list *mailmap)
+{
+	size_t buf_offset = 0;
+
+	if (!mailmap)
+		return;
+
+	for (;;) {
+		const char *person, *line;
+		size_t i;
+
+		line = buf->buf + buf_offset;
+		if (!*line || *line == '\n')
+			return; /* End of header */
+
+		for (i = 0; header[i]; i++)
+			if (skip_prefix(line, header[i], &person)) {
+				rewrite_ident_line(person, buf, mailmap);
+				break;
+			}
+
+		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
+		if (buf->buf[buf_offset] == '\n')
+			++buf_offset;
+	}
+}
+
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
@@ -3832,11 +3862,12 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
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
2.37.1.120.g001f220fb8

