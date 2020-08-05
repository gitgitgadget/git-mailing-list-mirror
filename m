Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32CBC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81913206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6AoF8J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHEVwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHEVv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E82C06179E
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so5232203wmd.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/3K3rLxxpmRR344POofiaEMr0WkE1QzMRZWO54dh4ts=;
        b=I6AoF8J3SIXjNSQGCwvkGlsn4AQcV/sZXhSrR4cP28Fa+lPh3BdT0mthoaHk85xN/H
         G8tGD73x4XZoJcK+GSwHaoDkfRqQUxnTmweI+6ejxetK5/eztJ+fh4BxpdQ8xHBMheXl
         KLfzeWPEt1JAX0Jo2oRPgXW9WKZtNcA8BeIaDS0WINGy35cjMwDlVubH2oigvsT3Lz7Z
         hA2+53+5G5nmXVDCUyatfaujfiJl4jiayQ50wZQhD1SCvQRw1gbd68+qgK0vPizkX1Ek
         5BD9O0LXhGA9waUWt+slmEYd/k8kdwZIz+QRBXN/sW521UDmqlx5/o62P6jNS317fsKh
         ++FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/3K3rLxxpmRR344POofiaEMr0WkE1QzMRZWO54dh4ts=;
        b=ubBttjAN9aWvdI8VXsVuLVFXT83Ck8/3bDTYMHJLnMoy53J3lRXiAk/hru0WzG2hMo
         Ex1dhg0Omoewhg9icILmxzIayk0VxKpP1JYL+Er/zmn4bMGWnD8zE5UlUKCAdrw10URC
         /1URAieaY7SZwJB8hS82XoKh5fGV7qhdgH1GR+gbQcllSLlRbG/7ILZv0F1xx652uhK/
         cJ4poOLCLHgvPIwXauHa+8pdn48XpX2susc89Lr0FPj4NxmEUrwhGLEWqWgJCr/SAC1v
         EXHfwZffWiI9G8cSMdg+I/zsQNC4N59V4i3S+4ZQDIiaWVGMZQM8QhZ7zi9+zWTTaeXa
         YHjA==
X-Gm-Message-State: AOAM531WRhcVbU7kvZ3temYCsEMyMHTYZd70p1PEh5i4IFAG7lBUi+7/
        RX4TDQhtUku9m3KXhNHRwMHKV7bM
X-Google-Smtp-Source: ABdhPJzJUqhSpAoIu+c5SCSaQXm0cTwG2X/4+CbClP924UB+BWt9m/QHiS0a9lHCMh7YSFPL23ZyAQ==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr4941224wml.35.1596664314545;
        Wed, 05 Aug 2020 14:51:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm3807786wro.34.2020.08.05.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:53 -0700 (PDT)
Message-Id: <95035765a00b4d553c2c43773bc1ab65c3c2ede9.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:43 +0000
Subject: [PATCH v2 7/9] pretty: refactor `format_sanitized_subject()`
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

