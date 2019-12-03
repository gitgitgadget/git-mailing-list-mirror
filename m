Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B2C43141
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC7C20684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBLqO/4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLCOC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfLCOCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so3883247wrq.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HjSBzc0rGvd4vC7CgPBj9hyIis2u+fMfIGl4JldqIGg=;
        b=XBLqO/4YwdWR9ThEKPklxMevitqKooo/yY46FbLySXQPYo3PRU6lTCfh2s7NCnSxDA
         cUildRWeL8jIX1eJ8mSR+Bkd0i3XIzcHAxbDACs+S3qMhXhx/12DPf8qnTkS2mD5e3LR
         wzNzx8Hf7hRSpTIwhpYFPw2HxN7Nm570V+99w4LGXK3cjN2ff9jx0ahlFIEmAYhoz94j
         jdMWm4rEQ/bDm0IHwGxjp76n4fNxB/mHMKUbObnRY3lZPjiMwTkD6jpIA4q6qHXsOf4W
         JbeaJfYkr0RPVmg/RaQ1jD30n6vYb1FE0vRmFHMJTH5FFJ/9juFyQaVaeLc/Im83qe0o
         PPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HjSBzc0rGvd4vC7CgPBj9hyIis2u+fMfIGl4JldqIGg=;
        b=bdm9IL7DWvrpkYD7Jv6BYUg2huGRlsBsuwFqRD6OzsZFO8ZtDeHzVm1ZH5BoTr3LA5
         04jfzJD/+EaQIoXvMrLv3Z+7e7KX0tVOAqIJ5Md4zYmBi/v7FYGZV5wKn5dwtaGrCv8z
         z6vXXJUvvpaDJ5cvzYYo/mIQZRfCRGXw2ZFmshoV+3GmwgjaG6GOlcAX5+NhfbthGoLJ
         S4tLdkCvX10vQOoZQEa9Skmof7RM3mCnghHj9L2WlqlFhiXtreZxdwrsA6nFOtV3eLMq
         dE0fHC0H/7u2A5efHVlYq3kj6nj5DKBwBfHeprwNh8lwByxhvljuf1I7U7V7hCaKnwjc
         FBnw==
X-Gm-Message-State: APjAAAVTBPvzQ6+KueRd3ox64uEr6eFhZfF20PVQ4MB/dpIG4FNGKzbr
        hqn4Fd5oY2ddTIN4QUKvrs33nGO/
X-Google-Smtp-Source: APXvYqyxjUgoZdEuBUy8lg2C/jgd4g8+RY5JOcVolVqRajVgHKPmi+N3l9QMlfrpzD4rCDfl87VZbA==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr5222048wrs.242.1575381741975;
        Tue, 03 Dec 2019 06:02:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm3715014wrv.40.2019.12.03.06.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:21 -0800 (PST)
Message-Id: <fea64dfbf9085b45192f91aaaabd6143ae9469bc.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:07 +0000
Subject: [PATCH v4 02/13] pathspec: add new function to parse file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This will be used to support the new option '--pathspec-from-file' in
`git add`, `git-commit`, `git reset` etc.

Note also that we specifically handle CR/LF line endings to support
Windows better.

To simplify code, file is first parsed into `argv_array`. This allows
to avoid refactoring `parse_pathspec()`.

I considered adding `nul_term_line` to `flags` instead, but decided
that it doesn't fit there.

The new code is mostly taken from `cmd_update_index()` and
`split_mail_conv()`.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 pathspec.c | 38 ++++++++++++++++++++++++++++++++++++++
 pathspec.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 12c2b322b3..128f27fcb7 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -3,6 +3,8 @@
 #include "dir.h"
 #include "pathspec.h"
 #include "attr.h"
+#include "argv-array.h"
+#include "quote.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -613,6 +615,42 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 }
 
+void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
+			 unsigned flags, const char *prefix,
+			 const char *file, int nul_term_line)
+{
+	struct argv_array parsed_file = ARGV_ARRAY_INIT;
+	strbuf_getline_fn getline_fn = nul_term_line ? strbuf_getline_nul :
+						       strbuf_getline;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf unquoted = STRBUF_INIT;
+	FILE *in;
+
+	if (!strcmp(file, "-"))
+		in = stdin;
+	else
+		in = xfopen(file, "r");
+
+	while (getline_fn(&buf, in) != EOF) {
+		if (!nul_term_line && buf.buf[0] == '"') {
+			strbuf_reset(&unquoted);
+			if (unquote_c_style(&unquoted, buf.buf, NULL))
+				die(_("line is badly quoted: %s"), buf.buf);
+			strbuf_swap(&buf, &unquoted);
+		}
+		argv_array_push(&parsed_file, buf.buf);
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&unquoted);
+	strbuf_release(&buf);
+	if (in != stdin)
+		fclose(in);
+
+	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.argv);
+	argv_array_clear(&parsed_file);
+}
+
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	int i, j;
diff --git a/pathspec.h b/pathspec.h
index 1c18a2c90c..a27dc81ba2 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -85,6 +85,16 @@ void parse_pathspec(struct pathspec *pathspec,
 		    unsigned flags,
 		    const char *prefix,
 		    const char **args);
+/*
+ * Same as parse_pathspec() but uses file as input.
+ * When 'file' is exactly "-" it uses 'stdin' instead.
+ */
+void parse_pathspec_file(struct pathspec *pathspec,
+			 unsigned magic_mask,
+			 unsigned flags,
+			 const char *prefix,
+			 const char *file,
+			 int nul_term_line);
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
 void clear_pathspec(struct pathspec *);
 
-- 
gitgitgadget

