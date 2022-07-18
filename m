Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13951C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiGRTvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiGRTvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:51:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019911D0CB
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r186so11559389pgr.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEbn6tqOY+nFz4lNvX5WR0D/0awwUgQFoQjJUrtaKa4=;
        b=pCiJW4cOWhNYlXs3M/AuJDSTRz2GAz6YO+mJ3KA2WH9AJJWy4ThfRb6pwPD4LqNVtJ
         irPyIMFtJxt9OSFJgDAQudNKD6knUxK/Hh1a8GSnQEYOd3Ino6KTSbBOrTLrY0B89qjv
         dlhHtftsSss8bAYWKY3Z7hcnwF1WflsjilKua5lHprvPtRtLPmcLUe24fe9TjaB9a8K/
         e9Zfsv1XCcOr+Tx/28qwf9qdo8q17Fp/z7sW5rvuz9EDy0wp9yJltuFCJYTalvyGF5bs
         MQTgDqW49uLwQ+6epVQ8rfCpnqlikp0CB1mmdGdShYCgzTN0KehqNR0wqIY3RX/wGMM8
         cxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEbn6tqOY+nFz4lNvX5WR0D/0awwUgQFoQjJUrtaKa4=;
        b=Vq0Coy3r+xh+PciFw0X5f9xK3srN3PoMrCYYW9RiuCzUqd+SWjOQQER1q7Lyhsk+Ie
         3aNQ4V+hyWlLMo2xWxNPxldSP7OdgaNGYb5qWzm8XbCn4n9r5LHnyIVZGGuUF8W7BQuP
         MVLTSzOJws6RB+w3vIMBwnudWS7bbYy+WTiHVle1dRymH4UIgJqBhx+7VuEgFma2Lezh
         3HaMmvOPkM6l0kbgZywRk1+T7fDAGvpL5bbsP/D/De91TClvUAtqkdWjDb8p9hz+dvIA
         COVVtNxXdBhOYORBqFJBa+2ayo5we5PkpNWEgk2f3zrinIRz769F049bOZoCO5fRtLgV
         w6Rg==
X-Gm-Message-State: AJIora+ixmQxa5iDFTLdR398q0O5x6gh0e1qLJ71ivorsLHUwhh5lgmQ
        O81dq6RtKAequiVXw9RzJwpLE0zbFQ17nQ==
X-Google-Smtp-Source: AGRyM1vD1ty/lFnWNQK5emXnEi4Aa7zJVQ/F4hQA6OdRSQ/DhPHPCHhjxm4i+Wdqt0u5VGde3W7ygQ==
X-Received: by 2002:aa7:954a:0:b0:52a:bd44:d15a with SMTP id w10-20020aa7954a000000b0052abd44d15amr29466060pfq.35.1658173878961;
        Mon, 18 Jul 2022 12:51:18 -0700 (PDT)
Received: from HB2.. ([106.212.244.137])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902b18d00b0016c35b21901sm9855838plr.195.2022.07.18.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:51:18 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 1/4] revision: improve commit_rewrite_person()
Date:   Tue, 19 Jul 2022 01:20:59 +0530
Message-Id: <20220718195102.66321-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g63d6f8c201
In-Reply-To: <20220718195102.66321-1-siddharthasthana31@gmail.com>
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
 <20220718195102.66321-1-siddharthasthana31@gmail.com>
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
 revision.c | 64 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/revision.c b/revision.c
index 211352795c..3418a1b7f1 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,25 +3755,18 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+/*
+ * Returns the difference between the new and old length of the ident line.
+ */
+static ssize_t rewrite_ident_line(const char *person, size_t len,
+				   struct strbuf *buf,
+				   struct string_list *mailmap)
 {
-	char *person, *endp;
-	size_t len, namelen, maillen;
+	size_t namelen, maillen;
 	const char *name;
 	const char *mail;
 	struct ident_split ident;
 
-	person = strstr(buf->buf, what);
-	if (!person)
-		return 0;
-
-	person += strlen(what);
-	endp = strchr(person, '\n');
-	if (!endp)
-		return 0;
-
-	len = endp - person;
-
 	if (split_ident_line(&ident, person, len))
 		return 0;
 
@@ -3784,6 +3777,7 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 
 	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
 		struct strbuf namemail = STRBUF_INIT;
+		size_t newlen;
 
 		strbuf_addf(&namemail, "%.*s <%.*s>",
 			    (int)namelen, name, (int)maillen, mail);
@@ -3791,15 +3785,50 @@ static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
 		strbuf_splice(buf, ident.name_begin - buf->buf,
 			      ident.mail_end - ident.name_begin + 1,
 			      namemail.buf, namemail.len);
+		newlen = namemail.len;
 
 		strbuf_release(&namemail);
 
-		return 1;
+		return newlen - (ident.mail_end - ident.name_begin);
 	}
 
 	return 0;
 }
 
+static void commit_rewrite_person(struct strbuf *buf, const char **header,
+				   struct string_list *mailmap)
+{
+	size_t buf_offset = 0;
+
+	if (!mailmap)
+		return;
+
+	for (;;) {
+		const char *person, *line;
+		size_t i;
+		int found_header = 0;
+
+		line = buf->buf + buf_offset;
+		if (!*line || *line == '\n')
+			return; /* End of headers */
+
+		for (i = 0; header[i]; i++)
+			if (skip_prefix(line, header[i], &person)) {
+				const char *endp = strchrnul(person, '\n');
+				found_header = 1;
+				buf_offset += endp - line;
+				buf_offset += rewrite_ident_line(person, endp - person, buf, mailmap);
+				break;
+			}
+
+		if (!found_header) {
+			buf_offset = strchrnul(line, '\n') - buf->buf;
+			if (buf->buf[buf_offset] == '\n')
+				buf_offset++;
+		}
+	}
+}
+
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
@@ -3832,11 +3861,12 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
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
2.37.1.120.g63d6f8c201

