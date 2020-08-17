Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C2C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E5D2072E
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7FYQZ7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbgHQSLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731517AbgHQSKe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240EC061349
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so15892381wrs.8
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/3K3rLxxpmRR344POofiaEMr0WkE1QzMRZWO54dh4ts=;
        b=Z7FYQZ7RssfZLL6f2hKq2ok57KjQ/OES/rrwU0juRSfCXx3c6Pg0Dhtx7zvIRsILA2
         3GbvDksCDUh8oYeBezJVO00orZb4zRBDIC2Qt6ldLNAF+YAqZkSEnbXGVbR4fTP7yx9Z
         ciaI/LtMF8s9IcOSS8M2eGbn1FpI1m2D0aPWNVmIAHGfZtJQ9rdv05LsJmxCTFut4bKx
         33AH0+pvDCY3ADUUkyFZRGiazgOk04e2UO1ostS7bnonRKqsbxCEWjyX9iR1ydYXkL4u
         CTv90HztMMIH6/qqLd+Kb5DG5XKmU59OzgmYJituAnZiMEAMn4d6xCKvkJoaPX/jXhuy
         33Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/3K3rLxxpmRR344POofiaEMr0WkE1QzMRZWO54dh4ts=;
        b=qnK8ZkInZtV1HwO0WbQQjPwabXYUYOhFCexZtW1stugqPI7u6jPCDhrKKXBdtLAdrM
         09qoMuE6RVl4nJKaN2qnTcfxsrqPE3DQmPs7HCZTmDfHd7fAiJpC+vzpGgHKlhsQdO6R
         +DSUYR6TeXpFs6WhduXWXN+8ynzw3+NZuWhmMkzAb7CiFB7yzvFfE556EdiIb3nZHzJH
         Z1P7G5lBatCpK/5t14/0pxXnFg0YKp3TMx9HlIbtPNmISIfv9XICOlCb7q7EVE9rYJMR
         UHj+xOMGL/4TfBfnXPSFjSuXojXsJ8VQ028ivjmitG6JHiZ7HR6o0e9oAZo21Ryjy9ck
         uPEg==
X-Gm-Message-State: AOAM531NlhWtb/W7f71yx+t3bwNSfRtONm1ve5boTpNuX/IiZtVed+Jd
        TlmicEdoEwKB7sRavIveEQXcTs9Pcyo=
X-Google-Smtp-Source: ABdhPJzG1/L6K479uuVjmdRdav74YOGs4Mme9vrQm7Uw3bjovVmM9suF+fofc1Y+ntX/mHEAERZt3A==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr15523644wrp.44.1597687829295;
        Mon, 17 Aug 2020 11:10:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm35575778wrr.13.2020.08.17.11.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:28 -0700 (PDT)
Message-Id: <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:20 +0000
Subject: [PATCH v3 7/9] pretty: refactor `format_sanitized_subject()`
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

But this change isn't sufficient to reuse this function in
ref-filter.c because there exist tags with multiline subject.

It's wise to replace `\n` with ' ', if `format_sanitized_subject()`
encounters `\n` before end of subject line, just like `copy_subject()`.
Because we'll be only using `format_sanitized_subject()` for
"%(subject:sanitize)", instead of `copy_subject()` and
`format_sanitized_subject()` both. So, added the code:
```
if (char == '\n') /* never true if called inside pretty.c */
    char = ' ';
```

Now, it's ready to be reused in ref-filter.c

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 pretty.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/pretty.c b/pretty.c
index 2a3d46bf42..8d08e8278a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -839,24 +839,29 @@ static int istitlechar(char c)
 		(c >= '0' && c <= '9') || c == '.' || c == '_';
 }
 
-static void format_sanitized_subject(struct strbuf *sb, const char *msg)
+static void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
 {
+	char *r = xmemdupz(msg, len);
 	size_t trimlen;
 	size_t start_len = sb->len;
 	int space = 2;
+	int i;
 
-	for (; *msg && *msg != '\n'; msg++) {
-		if (istitlechar(*msg)) {
+	for (i = 0; i < len; i++) {
+		if (r[i] == '\n')
+			r[i] = ' ';
+		if (istitlechar(r[i])) {
 			if (space == 1)
 				strbuf_addch(sb, '-');
 			space = 0;
-			strbuf_addch(sb, *msg);
-			if (*msg == '.')
-				while (*(msg+1) == '.')
-					msg++;
+			strbuf_addch(sb, r[i]);
+			if (r[i] == '.')
+				while (r[i+1] == '.')
+					i++;
 		} else
 			space |= 1;
 	}
+	free(r);
 
 	/* trim any trailing '.' or '-' characters */
 	trimlen = 0;
@@ -1155,7 +1160,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
-	const char *arg;
+	const char *arg, *eol;
 	size_t res;
 	char **slot;
 
@@ -1405,7 +1410,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		format_subject(sb, msg + c->subject_off, " ");
 		return 1;
 	case 'f':	/* sanitized subject */
-		format_sanitized_subject(sb, msg + c->subject_off);
+		eol = strchrnul(msg + c->subject_off, '\n');
+		format_sanitized_subject(sb, msg + c->subject_off, eol - (msg + c->subject_off));
 		return 1;
 	case 'b':	/* body */
 		strbuf_addstr(sb, msg + c->body_off);
-- 
gitgitgadget

