Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F17E20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeLMVXK (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:23:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38093 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMVXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:23:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so3912146qtl.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvcHjR6uv5s48Mq1lv4ARXg/Ttrd3VQhcUKmNT61iWU=;
        b=MmxVNutp7GLulRGlNoWJ3LDb6bs4NzjzIsehT50fOEY48PB4tXS5xCNQgdvQ/Nx2C/
         6tA2Sk72ownSwwaF256rQUsttG79wpa1piKsZxSYnvtOUHl+JJ83HoHw6FGhNWTyVK6i
         D1odqkLpWWkYcbyFYYh+qxyHgmWYr++Ia77EsMXvTt/i8D1x0poBA6/LNUgw5NTedy6f
         1ckep9PL4HKljtgUOR1p6ldVMH5WU/wiolDhTDpra+Z3UpzrKAaVCQAyvd9k4JjNLmrW
         zkQgQ/GX/S7GwUu9WXl/M5fJfRbVKfsNFGkQS8ZARcjl7diBcPwSZP05tF70L2RaqW0q
         byFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvcHjR6uv5s48Mq1lv4ARXg/Ttrd3VQhcUKmNT61iWU=;
        b=m/cSgeFMgdyiUqSmj/lIdx6XOs7OHhPWUfwtihRVXpoEomxaiMf5d1J0Amt0IPAI0s
         OlnD2hyoaYfe7ZJrcr1b69t54C1myHf+X769Km1qcYlmSuI2w56zR3mjwTvJPwAZSXag
         drQtFZATrp4do7SzgtvtpENHUuynjXdwLcEwX37vyoN2pMk2bbL2nG8w0j4PRyg5/Thf
         nbur6OIqUB6z8nBP+iiTxbuRxGPa8ud/4PCvPfFRKrN/jMR8jsh4BIgvqw9GCLL/tOuT
         6ExW5npR2Ylrli2IFR+ZItoJkBGN34iQnY/gA6w/mmTfOoVb/HV8323fetzXZoac61ea
         oZvA==
X-Gm-Message-State: AA+aEWYgv/dBr2D5TSBqvZzgErKQDSnWjUXLr8mu3V4BFE52RUzwOcVP
        wjU+huXdpTOUx219bsCi5TZ/Zu6a
X-Google-Smtp-Source: AFSGD/UcHLFDGuP6GBZrsi379w8YB8VsxegAVDzNPrCyI2F93mSkUwO8kJSC9WksAiG5Psa69dE21g==
X-Received: by 2002:a05:6214:18e:: with SMTP id q14mr393337qvr.173.1544736188342;
        Thu, 13 Dec 2018 13:23:08 -0800 (PST)
Received: from localhost.localdomain ([142.154.219.74])
        by smtp.gmail.com with ESMTPSA id f13sm1552840qkm.52.2018.12.13.13.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 13:23:07 -0800 (PST)
From:   John Passaro <john.a.passaro@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, alex.crezoff@gmail.com, peff@peff.net,
        mgorny@gentoo.org, John Passaro <john.a.passaro@gmail.com>
Subject: [PATCH 1/4] pretty: expose raw commit signature
Date:   Thu, 13 Dec 2018 16:22:53 -0500
Message-Id: <20181213212256.48122-2-john.a.passaro@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213212256.48122-1-john.a.passaro@gmail.com>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new pretty-format placeholders %GR and %G+ to support inspecting
gpgsig commit header in pretty format, even if GPG is not available.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 Documentation/pretty-formats.txt |  2 ++
 pretty.c                         | 36 ++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 417b638cd8..582454a4f7 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -142,6 +142,8 @@ The placeholders are:
 ifndef::git-rev-list[]
 - '%N': commit notes
 endif::git-rev-list[]
+- '%GR': contents of the commits signature (blank when unsigned)
+- '%G+': "Y" if the commit is signed, "N" otherwise
 - '%GG': raw verification message from GPG for a signed commit
 - '%G?': show "G" for a good (valid) signature,
   "B" for a bad signature,
diff --git a/pretty.c b/pretty.c
index b83a3ecd23..d142b457b5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -768,6 +768,9 @@ struct format_commit_context {
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
 	struct signature_check signature_check;
+	unsigned signature_checked:2;
+	struct strbuf signature;
+	struct strbuf signature_payload;
 	enum flush_type flush_type;
 	enum trunc_type truncate;
 	const char *message;
@@ -1228,8 +1231,30 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	}
 
 	if (placeholder[0] == 'G') {
-		if (!c->signature_check.result)
-			check_commit_signature(c->commit, &(c->signature_check));
+		if (!c->signature_checked) {
+			parse_signed_commit(c->commit, &(c->signature_payload), &(c->signature));
+			c->signature_checked = 1;
+		}
+		switch (placeholder[1]) {
+		case 'R':
+			strbuf_addbuf(sb, &(c->signature));
+			break;
+		case '+':
+			strbuf_addch(sb, c->signature.len ? 'Y' : 'N');
+			break;
+		default:
+			goto do_signature_check;
+		}
+		return 2;
+
+do_signature_check:
+		if (c->signature_checked < 2) {
+			if (c->signature.len)
+				check_signature(c->signature_payload.buf, c->signature_payload.len,
+						c->signature.buf, c->signature.len,
+						&(c->signature_check));
+			c->signature_checked = 2;
+		}
 		switch (placeholder[1]) {
 		case 'G':
 			if (c->signature_check.gpg_output)
@@ -1246,6 +1271,9 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			case 'Y':
 			case 'R':
 				strbuf_addch(sb, c->signature_check.result);
+				break;
+			case 0: // i.e. no signature so we never ran the check
+				strbuf_addch(sb, 'N');
 			}
 			break;
 		case 'S':
@@ -1527,6 +1555,8 @@ void format_commit_message(const struct commit *commit,
 	context.commit = commit;
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
+	strbuf_init(&context.signature, 0);
+	strbuf_init(&context.signature_payload, 0);
 	/*
 	 * convert a commit message to UTF-8 first
 	 * as far as 'format_commit_item' assumes it in UTF-8
@@ -1556,6 +1586,8 @@ void format_commit_message(const struct commit *commit,
 			strbuf_attach(sb, out, outsz, outsz + 1);
 	}
 
+	strbuf_release(&context.signature);
+	strbuf_release(&context.signature_payload);
 	free(context.commit_encoding);
 	unuse_commit_buffer(commit, context.message);
 }
-- 
2.19.1

