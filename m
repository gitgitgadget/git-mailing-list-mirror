Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB598C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 19:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350009AbhLWT36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350021AbhLWT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 14:29:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C3C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso3751362wme.1
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pdB5xQGyorcAri59V4lghFluUPi/rjRam04Db3If6Fc=;
        b=e1lf62VIOSzL6jFvJmLAYKOt0Kvl9h45WMO1YviIptO0Z/GPSGXPvILLYOqFbim+bw
         6m1VbNQ++j3LVLIT4b9Mi6sPqj1zPlalU485S/e9jkRiZZ1+xJ6aERZi2DS67h7iiBlH
         Kl+r23xO48moP8SqoU2TG9bYjy3e05gpaskJg/b4ctSOAVnZ3z3ni43obneMzm9QHOXg
         yYKsQvoZvr0HJmEXOaf/AW0FIRe7NkHtOAvvKJU/+SMwveKaMD8bwCImm/Hn23JQMnyf
         CUoGsHX/2tgXm3B2wIz5ghAKzVdrLp5nd1W57mK8VDEdVO9WTd5cipsBWNL1IJuJJrRl
         KDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pdB5xQGyorcAri59V4lghFluUPi/rjRam04Db3If6Fc=;
        b=EbwDRZcw4U6tzT45AnH+c89OCNrEw7zwkkN7T5ultf8JDD5YrAaPQkoli/a+NuapEf
         dvF8UYRehwasdejMppkqbaNS3qkWcffyibck14U7UWDd6Mys5dmEr0yhi3TgoTrSDrWL
         LrxCULgtM8/7JIgmkCcs/W7oKNZXMsSWsr43VnQ7UQveR2F77s6fGZxQQUNOsirnRkAo
         jA2xXG1Bsze/OYdjXPj/X8i8MMyphXeK8FT4dhDtqr3VFC1pSKt730CwJovaDQ87sF8r
         gYC3/j+Qok7PO9Sxior+siJ/KJrTnqFZDodkUapqNYHQlpQW0YzgNT591cNc3SFAh89M
         JGbA==
X-Gm-Message-State: AOAM530CDJzo2B7/Ukov6t0VLtEP9/2S5Lyndo79k+5YO2Y7Kcj/+ADS
        /e+SDlm7bW3/Eg3BB1bzcPrHhcOqX6g=
X-Google-Smtp-Source: ABdhPJxDtJvAwwhkNss/kTjOr3enblItPnV3PJSGyItUBdOPiColxsQQOLBpxoNkH8oLpeF0mkm/MA==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr2731247wml.0.1640287792907;
        Thu, 23 Dec 2021 11:29:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm9882734wmq.11.2021.12.23.11.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 11:29:52 -0800 (PST)
Message-Id: <53c1519525ff170bcc086de66cd82294d43bc69e.1640287790.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Dec 2021 19:29:49 +0000
Subject: [PATCH 2/3] reftable: signal overflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

reflog entries have unbounded size. In theory, each log ('g') block in reftable
can have an arbitrary size, so the format allows for arbitrarily sized reflog
messages. However, in the implementation, we are not scaling the log blocks up
with the message, and writing a large message fails.

This triggers a failure for reftable in t7006-pager.sh.

Until this is fixed more structurally, report an error from within the reftable
library for easier debugging.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/error.c          |  2 ++
 reftable/readwrite_test.c | 35 +++++++++++++++++++++++++++++++++++
 reftable/reftable-error.h |  4 ++++
 reftable/writer.c         |  3 +++
 4 files changed, 44 insertions(+)

diff --git a/reftable/error.c b/reftable/error.c
index f6f16def921..93941f21457 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -32,6 +32,8 @@ const char *reftable_error_str(int err)
 		return "wrote empty table";
 	case REFTABLE_REFNAME_ERROR:
 		return "invalid refname";
+	case REFTABLE_ENTRY_TOO_BIG_ERROR:
+		return "entry too large";
 	case -1:
 		return "general error";
 	default:
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 5f6bcc2f775..70c7aedba2c 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -155,6 +155,40 @@ static void test_log_buffer_size(void)
 	strbuf_release(&buf);
 }
 
+static void test_log_overflow(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char msg[256] = { 0 };
+	struct reftable_write_options opts = {
+		.block_size = ARRAY_SIZE(msg),
+	};
+	int err;
+	struct reftable_log_record
+		log = { .refname = "refs/heads/master",
+			.update_index = 0xa,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value = { .update = {
+					   .name = "Han-Wen Nienhuys",
+					   .email = "hanwen@google.com",
+					   .tz_offset = 100,
+					   .time = 0x5e430672,
+					   .message = msg,
+				   } } };
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+
+	uint8_t hash1[GIT_SHA1_RAWSZ]  = {1}, hash2[GIT_SHA1_RAWSZ] = { 2 };
+
+	memset(msg, 'x', sizeof(msg) - 1);
+	log.value.update.old_hash = hash1;
+	log.value.update.new_hash = hash2;
+	reftable_writer_set_limits(w, update_index, update_index);
+	err = reftable_writer_add_log(w, &log);
+	EXPECT(err == REFTABLE_ENTRY_TOO_BIG_ERROR);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
 static void test_log_write_read(void)
 {
 	int N = 2;
@@ -648,5 +682,6 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_table_refs_for_no_index);
 	RUN_TEST(test_table_refs_for_obj_index);
 	RUN_TEST(test_write_empty_table);
+	RUN_TEST(test_log_overflow);
 	return 0;
 }
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index 6f89bedf1a5..4c457aaaf89 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -53,6 +53,10 @@ enum reftable_error {
 
 	/* Invalid ref name. */
 	REFTABLE_REFNAME_ERROR = -10,
+
+	/* Entry does not fit. This can happen when writing outsize reflog
+	   messages. */
+	REFTABLE_ENTRY_TOO_BIG_ERROR = -11,
 };
 
 /* convert the numeric error code to a string. The string should not be
diff --git a/reftable/writer.c b/reftable/writer.c
index 3ca721e9f64..35c8649c9b7 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -239,6 +239,9 @@ static int writer_add_record(struct reftable_writer *w,
 	writer_reinit_block_writer(w, reftable_record_type(rec));
 	err = block_writer_add(w->block_writer, rec);
 	if (err < 0) {
+		/* we are writing into memory, so an error can only mean it
+		 * doesn't fit. */
+		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
 		goto done;
 	}
 
-- 
gitgitgadget

