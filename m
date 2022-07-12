Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD93AC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiGLQHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiGLQGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 12:06:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963DECB442
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:06:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 72so8032117pge.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVNAQ+ZfOMv2yKI1iHlzflyugwyXQWFM6NDBeidxkPg=;
        b=Vzix40OPA+/09+orxMoKzuPHq5MHUVCIoKrHATq4+1ENqtaeYqxEd+2/V4ezZfywmp
         3QXCUzpUmz5st/EFbWoOczmObqQAHnTS1dTsDi4NFaPQEAxX53xC4l+z5HNNpa1TsGj1
         kilEyCOOC+ORWlaB7daoFCf+RB34IiTlONbNE9YwU6MahY3vDMSH302vWQXFi/37FBxN
         ga8BKxJbkRq+Ge0lYu8jRazyLTiK85C+dD4x4jGAPgDh9jOIaFpl+a157bAQKu9hBqEZ
         Zu2baEWvg9sIIQsZxkt1/u5E4D0Ba3q+gffAqDhU9QMQHcRKuqjN2r68daDQIGQZ3f5W
         mctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVNAQ+ZfOMv2yKI1iHlzflyugwyXQWFM6NDBeidxkPg=;
        b=mmhE2JjB23C+S0svTmiwGZZskUxKuLT0JwqmQRJXfhJkrUz+Jt1QOl3sSDcxehElwe
         LsJ5mlLy+0vhjCP8YeYA5LOS+7KNdNXmBD2iEo9j1iPyE4FhKEkHfWt+neeg+1uL14Ap
         H1JFT0WPG/2U/k2/fFFZxou4/lSIT+po05FhPaWS3Dwm1kxeHBzfFOJPmEkJHyQRkbVf
         Um2/wvT+QDdOm2I+W3z74Cem64z3jbvMIHe/NlLJ87PUaP6QTatDkX6q1NvmojA3cNbA
         FZZx/BGmKd648cegVIVN2ZkbP4vSOdEncgTSuPcC3YsjbBcrz2YvJgSP+YPLC3iPakXA
         AEeA==
X-Gm-Message-State: AJIora9b9ZLyszeaF2PudOsVd+w6ck9d7ov7UDowjGO5BcTB6ILQZBmt
        gmtmCbSbAOgfuRpuA7QDU+RPpvKxvFnDiDio
X-Google-Smtp-Source: AGRyM1s/I61GRxh8hZpaHt/mLd7cAN5I6p/EkGOBLHNXpFiPtt52j6m2mPQtCBSCdjcPUgeP+uCeLg==
X-Received: by 2002:a63:d14b:0:b0:419:57b9:d444 with SMTP id c11-20020a63d14b000000b0041957b9d444mr3920430pgj.619.1657642010604;
        Tue, 12 Jul 2022 09:06:50 -0700 (PDT)
Received: from HB2.. ([223.230.62.254])
        by smtp.gmail.com with ESMTPSA id u188-20020a6260c5000000b0050dc7628183sm7232376pfb.93.2022.07.12.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:06:49 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 1/4] revision: improve commit_rewrite_person()
Date:   Tue, 12 Jul 2022 21:36:31 +0530
Message-Id: <20220712160634.213956-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220712160634.213956-1-siddharthasthana31@gmail.com>
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-1-siddharthasthana31@gmail.com>
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

