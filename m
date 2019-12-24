Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848EEC2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCB820706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olmsvdfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXLFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:54 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43638 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLXLFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:52 -0500
Received: by mail-qt1-f176.google.com with SMTP id d18so15172398qtj.10
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zU/36mqyT+YjZcY2b2v+QdftOJ5deD3IJu6PHjUcp0A=;
        b=olmsvdfKC+Bj4PEzDx24CKhGmpDbbYvcIYrsddaDAkwLyk6gpvwj5oOi3lH9EoVijL
         0r912WyrlHeULXkdxmKd/HCNJBPFOzYzJMlQ8VNIsUtGtuKbZYWE796Z5KMwkhhR6/PL
         us11sraSDACzQavEFpG/OrNW+q4YZEEifnTkhh6TxKDQbElqYeABakr9JGKyCjPmg3ai
         J+vqRsCDM7s8pcfBPKKsOXAZOuqKYHGcMM73dbnIvafNgidlT3p0OC39MZKDX/fpw7zR
         ahXdc+UBP9J01T/+HLgSGL7Xe+PAEismRte+sBr6oGkIT8JOwEK/kHRPBlQgZkwlTpA0
         gsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zU/36mqyT+YjZcY2b2v+QdftOJ5deD3IJu6PHjUcp0A=;
        b=IG3irQLVbmA6SYnIiEc2ZC/RNusIysKjdKklexj7j5rs0c5WWLuX8Xfj4lTwZ9+bVt
         GtKE+j3erzz76mZa525fulwo9IvNlfwMKS3i8OFzB5fTbYumT/hAzxR6Vvmy3m4D8cRn
         mUMm/vF1M/rp1kZaWpusIwSPp4Qxzl1UQvIEn6AaWB+G1WEjxgMway3fK2VCT1Jd1EUz
         361/jAAy/SvNYUR4H2B3VN9xZGI45OtYX45xweMc4swWI/QYF5NsaxIwbHU5DomPdBwX
         Ky7/TlaSpfXWaX6IfsdNvy2ERHXfiv5Yed1mJaURJ4XXiybF0+1OR+mWF9t4SdaHjodw
         AVAg==
X-Gm-Message-State: APjAAAWHt57pVfjej2R07/j43D2WtYoAGJwSwV9rMwtUpw4EkdF94lEl
        Sh7FLSIyqBP0P7txBDQmCCa9UutD
X-Google-Smtp-Source: APXvYqwKclAeKeiwgbZdHXU7T7PLo9LKCppGdnz9Oo8a8rbJkWPM83T/RkS7klBok6LxLCOTl1o2vQ==
X-Received: by 2002:ac8:2ffa:: with SMTP id m55mr26612949qta.189.1577185551586;
        Tue, 24 Dec 2019 03:05:51 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:51 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 05/17] sequencer: make read_oneliner() extern
Date:   Tue, 24 Dec 2019 06:05:02 -0500
Message-Id: <819fb2203ba59df1fc446167d5648c6aae46ad17.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function read_oneliner() is a generally useful util function.
Instead of hiding it as a static function within sequencer.c, extern it
so that it can be reused by others.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 13 ++-----------
 sequencer.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 103cea1460..9ef9424f88 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -417,17 +417,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
-/*
- * Reads a file that was presumably written by a shell script, i.e. with an
- * end-of-line marker that needs to be stripped.
- *
- * Note that only the last end-of-line marker is stripped, consistent with the
- * behavior of "$(cat path)" in a shell script.
- *
- * Returns 1 if the file was read, 0 if it could not be read or does not exist.
- */
-static int read_oneliner(struct strbuf *buf, const char *path,
-			 int skip_if_empty, int warn_nonexistence)
+int read_oneliner(struct strbuf *buf, const char *path,
+		  int skip_if_empty, int warn_nonexistence)
 {
 	int ret = 0;
 	struct strbuf file_buf = STRBUF_INIT;
diff --git a/sequencer.h b/sequencer.h
index e9a0e03ea2..56cea80dd8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -202,6 +202,17 @@ void print_commit_summary(struct repository *repo,
 			  const struct object_id *oid,
 			  unsigned int flags);
 
+/*
+ * Reads a file that was presumably written by a shell script, i.e. with an
+ * end-of-line marker that needs to be stripped.
+ *
+ * Note that only the last end-of-line marker is stripped, consistent with the
+ * behavior of "$(cat path)" in a shell script.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read.
+ */
+int read_oneliner(struct strbuf *buf, const char *path,
+		  int skip_if_empty, int warn_nonexistence);
 int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
-- 
2.24.1.810.g65a2f617f4

