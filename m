Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCD3C2D0BF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415DA22527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmFwsDZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLMIIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51739 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLMIIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so5271151wmd.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EmNEX5sLXUgDTtw4uuhLNsmq52UU9EShJfNBHXccmds=;
        b=JmFwsDZrQI9Z5WtoaGvEHIO/dGrFfHiuf5UHV0xU3CyyVE8MjMeIR1gp3NywBddg1i
         04/04Ivo493so3zVeCiRSdte11pzGuRj2gIFZLlGX3aw69lrTcRGxIwDHMF0SHkoZ0YQ
         jEMG1koSk+X1WK0VoH64/k6Mqxw9T98Mcb1RJ5EJtI4jjP0r5BjWJj0D7N2C3FMTB+oC
         DBU9wepRD6vUVZmUdVjwzkM8xLuzlcZVrzf3waImF1+wM2UoMIDQFKkqtFbURdV7IGs8
         t0k+vbWU88n6OFsUpyIgT/Uj/QRyefbEI4RquwUF4HIxf9Tn3Hd2LUMT1h0RR84dewN8
         krQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EmNEX5sLXUgDTtw4uuhLNsmq52UU9EShJfNBHXccmds=;
        b=bNxwWw/EnFmEYAbwMxEq3mFY8YZmgUlV6wrpOGQ7R8/91TGFQ1iVj5bhdvD+E/31Hi
         ENBOF56CHG0O46nfdprO3BsL7R524DSRNUxTdnvhLFGxbTOwWMa0GvYIQdttVYTgj28n
         I2+bow4586GiZw2fKShUKLyihF+2CIBylqqGk3q7prl99ULS09ysUWaUf8LtJq2vJ/Dv
         p6exV28+L9FeCcsH9SQLbGHVPKmsfNxgK2oReBTNVQPmgtiZqSw+0QxsHq0jQDGtmn3O
         O7ny62aYxoTjuCm3VvpL/rKJhCizDNHgIKmct+tW2BjamWGbdhRow1NF+LVtMoJ1e+HD
         JpoQ==
X-Gm-Message-State: APjAAAVRNvTxDXGMHOtU6MGELFgdYOCGZwNWp0M9hHlFDeu1nJ+Mgu8K
        X9d+IC3SJ0b5Y9w98bpQg1n253nG
X-Google-Smtp-Source: APXvYqygobC755x7Tp5xidazjswCh51nWaXm7BGqo6g2+v9ky8ibPnFbR9EFiqcJrW+8ov5Bx1MZdA==
X-Received: by 2002:a1c:3141:: with SMTP id x62mr11355316wmx.18.1576224494432;
        Fri, 13 Dec 2019 00:08:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm9017766wrq.61.2019.12.13.00.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:13 -0800 (PST)
Message-Id: <556604361d28377e4f453b851527293ae865c27a.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:55 +0000
Subject: [PATCH 08/19] built-in add -p: handle deleted empty files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This addresses the same problem as 24ab81ae4d (add-interactive: handle
deletion of empty files, 2009-10-27), although in a different way: we
not only stick the "deleted file" line into its own pseudo hunk, but
also the entire remainder (if any) of the same diff.

That way, we do not have to play any funny games with regards to
coalescing the diff after the user selected what (possibly pseudo-)hunks
to stage.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 7c1b3b3935..c32541f46d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -33,6 +33,7 @@ struct add_p_state {
 		struct hunk head;
 		struct hunk *hunk;
 		size_t hunk_nr, hunk_alloc;
+		unsigned deleted:1;
 	} *file_diff;
 	size_t file_diff_nr;
 };
@@ -180,6 +181,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	pend = p + plain->len;
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
+		const char *deleted = NULL;
+
 		if (!eol)
 			eol = pend;
 
@@ -196,7 +199,11 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		} else if (p == plain->buf)
 			BUG("diff starts with unexpected line:\n"
 			    "%.*s\n", (int)(eol - p), p);
-		else if (starts_with(p, "@@ ")) {
+		else if (file_diff->deleted)
+			; /* keep the rest of the file in a single "hunk" */
+		else if (starts_with(p, "@@ ") ||
+			 (hunk == &file_diff->head &&
+			  skip_prefix(p, "deleted file", &deleted))) {
 			file_diff->hunk_nr++;
 			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
 				   file_diff->hunk_alloc);
@@ -207,7 +214,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			if (colored)
 				hunk->colored_start = colored_p - colored->buf;
 
-			if (parse_hunk_header(s, hunk) < 0)
+			if (deleted)
+				file_diff->deleted = 1;
+			else if (parse_hunk_header(s, hunk) < 0)
 				return -1;
 		}
 
-- 
gitgitgadget

