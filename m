Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF1C433E3
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5772074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEqxJ3su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgG0UnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgG0UnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:43:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1840FC0619D2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so16158311wrh.10
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SvG1GpUTv+SNejtbI1AKIXOTWjCgm3D1aOQc8ZWYtBY=;
        b=CEqxJ3su2kXxIYHhTFBewjx/MRpQq0qN+cYtW2+rjvt4O98w9WbuPixGqt91aLbYvU
         2J58/i59zz9RsgXIgPlHnIcDhk5kTvJ0w01WMJCwUsbqfIaiIvh2oQ5m6CNFqJtr2bd+
         dR5KlAGSJl42EKxkPH08YowQmpt60eFMVzoVnrwVUFBP9XJ92+ZENWLxv9xf538OurVi
         i/iAVKv33S2+ytO4ne92pVrCAVcaIktYcUrLNju84hIJVNd6kDAG1FKstBCy+DYsdRN9
         r1apzWlOQVmArPVu6oMTKqQQ7VANayK/PpELk6jvbEoyJwhW5Z/FjQkGIK8jWV8E/DCk
         5Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SvG1GpUTv+SNejtbI1AKIXOTWjCgm3D1aOQc8ZWYtBY=;
        b=dZP/QlV45YbyMdSDUbhollg9VnBBNabRhfVmNfZIdS1f6usEt1CVcTY1RFTXeI3Dr2
         5JFDt4SdrsU9bhXXysbATrpzIaTw+QN4ZYUDyuEaxr83Nws4N88RSVqXjMesZlL3LUOJ
         o9FFD5zgc/W7KyoBBPUHXH5bwf7zcMZqupUdxsRu+JaQ2FSAuzLjylXjWqhWhimENMnN
         rFbzJjOk8gwfDTJBw/w5+y0lJFMP9tBxI+v0gCqqNbUhScPOnT6JgtPINwJis1Y8iaES
         b3hWqpiiIhngImdTi53I8sqVMtG24Nb65r6UmywZybAA7sVALPl5g0EZkjD5/ASDTc4y
         xqvA==
X-Gm-Message-State: AOAM533Gm9R7y9tVFCUJiY+nZdrwNqdUYo5T9sEjXqnfKK0mUgL4DfIq
        vDF63QAEGrSHCc8Rs+Tz1zYhz1wZ
X-Google-Smtp-Source: ABdhPJyP+Be3oksQVTG5sY4AADz1UHziT+GYGZuAXVlg6cWGew2JLvy6Wz0hiOyVb5lU6xiUGXvrNQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr22026713wrw.155.1595882592742;
        Mon, 27 Jul 2020 13:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm14062611wro.57.2020.07.27.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:43:12 -0700 (PDT)
Message-Id: <69b9d221c01144b72f731a1a8901789929b4e6f9.1595882588.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.git.1595882588.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 20:43:06 +0000
Subject: [PATCH 3/5] pretty: refactor `format_sanitized_subject()`
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

This commit refactors `format_sanitized_subject()` in the
hope to use same logic in ref-filter.c

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

