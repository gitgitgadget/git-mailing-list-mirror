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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0CAC2D0CA
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D220022527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU2jN1ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfLMII3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfLMIIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so5602091wrt.6
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=taGbAjju/CWGhORJ2etym7NKiySSVYEwpdGKW5i+xAY=;
        b=SU2jN1ql2OT6kjEbSuxy7+ahdCL0pHWPhdzh2nv0kRPQUgY4Q1axYD5EQWyTqoIXS9
         +J2hmRwW5SDffNHZzZrfGG8j/cVI16eBa1DHblTih5z2cYwP2bg26QzEmWohdSaKDc1h
         0tHzLt0QVw/Eg3kxfBZF7cxcydVnRp/W76AjP6GRvHw06+/Aau8Zzp9HBO1WBLRP7Zg+
         QsNdjcLJobMJ8CwK2PEbShsBHTCufqmP4PBYuF6eSJj7wb3By6S3iN6J9Mf5FiQhXmAB
         aCBupQmGP8HOob6cDtuOXATJVm3+MG21nCP7FumERwhdMsL6mB6eafu1TxQzDRU0VNms
         2z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=taGbAjju/CWGhORJ2etym7NKiySSVYEwpdGKW5i+xAY=;
        b=MRRmchEmNPeSOFYYAQoSk9UKM5HNLI11zuwYFuJ3Z7IYIQWVwKWEW5SN8uAN/LWOEW
         UYfu2G3ngUifpAyyyPG8Jw84TE8MN2ozEMekSFWV5ZB+kB1cAAeho+BPD1fMqSYD8AJD
         HbPijJNFpLtw6hv6domarRpu14cm5zWEc5fj+ggXgpEzzHDDPeCLWCvNJac6R3NaYLb4
         jTPu8ppReMYBkPiC3fhPBJfuZDL33/y9FofWK5gb4GAv8rafqcB14YuU2sXUeDHzH3no
         kji4GUmSXW7G5c38sVAshW1UqHAsMQDp2TVomOLjf1FYGJGaAkGIzJDAsOSFayi02SA+
         Qf8g==
X-Gm-Message-State: APjAAAWho44p6154t0xtgDI+jinTvGc6qy2L7rO2jCrw8ogDvJclzIDf
        y/9nd21551RnMmaCjo75TXwDJ2IF
X-Google-Smtp-Source: APXvYqxf3zbWpju35pyqWad48OgypOC2jMKZUe6kuyGyXJf3H9JTR8YjIDdtIX+VpImTiukrbwhSRQ==
X-Received: by 2002:adf:ef8b:: with SMTP id d11mr10735997wro.45.1576224502948;
        Fri, 13 Dec 2019 00:08:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm9389745wml.11.2019.12.13.00.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:22 -0800 (PST)
Message-Id: <a5bbd28d173bf84adf4f431abfd314633c805f92.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:08:06 +0000
Subject: [PATCH 19/19] built-in add -p: show helpful hint when nothing can be
 staged
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

This patch will make `git add -p` show "No changes." or "Only binary
files changed." in that case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 1eb0ab97bb..2c46fe5b33 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -44,7 +44,7 @@ struct add_p_state {
 		struct hunk head;
 		struct hunk *hunk;
 		size_t hunk_nr, hunk_alloc;
-		unsigned deleted:1, mode_change:1;
+		unsigned deleted:1, mode_change:1,binary:1;
 	} *file_diff;
 	size_t file_diff_nr;
 };
@@ -294,7 +294,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 				BUG("'new mode' does not immediately follow "
 				    "'old mode'?\n\n%.*s",
 				    (int)(eol - plain->buf), plain->buf);
-		}
+		} else if (hunk == &file_diff->head &&
+			   starts_with(p, "Binary files "))
+			file_diff->binary = 1;
 
 		if (file_diff->deleted && file_diff->mode_change)
 			BUG("diff contains delete *and* a mode change?!?\n%.*s",
@@ -1304,7 +1306,7 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
 	struct add_p_state s = {
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
-	size_t i;
+	size_t i, binary_count = 0;
 
 	init_add_i_state(&s.s, r);
 
@@ -1318,9 +1320,16 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
 	}
 
 	for (i = 0; i < s.file_diff_nr; i++)
-		if (patch_update_file(&s, s.file_diff + i))
+		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
+			binary_count++;
+		else if (patch_update_file(&s, s.file_diff + i))
 			break;
 
+	if (s.file_diff_nr == 0)
+		fprintf(stderr, _("No changes.\n"));
+	else if (binary_count == s.file_diff_nr)
+		fprintf(stderr, _("Only binary files changed.\n"));
+
 	strbuf_release(&s.answer);
 	strbuf_release(&s.buf);
 	strbuf_release(&s.plain);
-- 
gitgitgadget
