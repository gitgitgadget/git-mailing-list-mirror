Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0904CC4332F
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E737B61100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbhIIStD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbhIISs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F9C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so3937126wrc.7
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Izbl9wexLtHbO918dhEysjpUsFaAvsDqZEji3I0p88=;
        b=UsvHFXPJ/GC6aCd6ijXllYLhznoxGaXvN8thoR7JWZ4uoYvR/u6whjkCpwW9sk6Wts
         HvMQdqYk6JkG6N4uAG2h25IBmJJASA73sCIoSiVsM7XtHt9JSF8dzZb0E2dNu5x0trni
         Z/81Dm6nIPC4cugnCNT/5BlhdUTfZurnZWuH0hle/iYjTdpGH2mubEbJoY84Z9Yh7q6N
         G+U9eWrXDSJLJBUbnsZPHqoOWGgj2cqicPbo3Us7z5diVDdY21KmeTYSE2uUORPXK6Hg
         1zrlULVyNBrBd7xgJ1Gtt863bBi5+H5tMlD1/Y00Z3JkPVlsXJFlb0Pk9oPnvxqdOwTd
         r5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Izbl9wexLtHbO918dhEysjpUsFaAvsDqZEji3I0p88=;
        b=uLTRisF6V5qBIGBfUIniOiLCP3UMkhRkMK06K2I9XHUaaNNqrj0p0AlmBUgwxo4gmn
         Yp1XcFkb5cHmh+Q1rkRH7zmcYf5vQCbNS8hXwl/wYjCmCxRQk9H1VSo7MqM0HDY62e0+
         XCuiefpVNXjwh/OVtzylZqTFBiFwIn0ufbSdn/NsZ79ac8/BqR23lkKLRCQ+WB6UYEG2
         PHnTRVCacN/x+yaIMHC6IRT6CaS3GcsLKLSQ96+UzidcozsD6dfDsb/OdnM3YmDXDyEh
         MmcigAm4E7uecEkhACFYEPsOZzL4JVDjLhuak3Jb/R/mgdCrIpQ/3dFc0SDEEo53Mq/U
         4RDg==
X-Gm-Message-State: AOAM532M4eJ2erfcoG5QKkThNS8TTTyTeAukVmQiMlMpibC+2mntM+lL
        Hav9bz1SiM3sXapsSvlTFvGj3KpZ32g=
X-Google-Smtp-Source: ABdhPJxeWh1bRuCLknJ+YwAPUM78Vza0xVPfSS07w+Hl2mEn9XGqU4/D7hnXY/rlZbmL5sIDki9cig==
X-Received: by 2002:adf:b748:: with SMTP id n8mr5393819wre.133.1631213268116;
        Thu, 09 Sep 2021 11:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm2518106wrr.70.2021.09.09.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:47 -0700 (PDT)
Message-Id: <84c8b396df53c23daeeb0ef4c6ef263724413a9e.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:28 +0000
Subject: [PATCH v2 03/19] reftable: add error related functionality
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable/ directory is structured as a library, so it cannot
crash on misuse. Instead, it returns an error codes.

In addition, the error code can be used to signal conditions from lower levels
of the library to be handled by higher levels of the library. For example, a
transaction might legitimately write an empty reftable file, but in that case,
we'd want to shortcut the transaction overhead.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/error.c          | 41 ++++++++++++++++++++++++++
 reftable/reftable-error.h | 62 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 reftable/error.c
 create mode 100644 reftable/reftable-error.h

diff --git a/reftable/error.c b/reftable/error.c
new file mode 100644
index 00000000000..f6f16def921
--- /dev/null
+++ b/reftable/error.c
@@ -0,0 +1,41 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable-error.h"
+
+#include <stdio.h>
+
+const char *reftable_error_str(int err)
+{
+	static char buf[250];
+	switch (err) {
+	case REFTABLE_IO_ERROR:
+		return "I/O error";
+	case REFTABLE_FORMAT_ERROR:
+		return "corrupt reftable file";
+	case REFTABLE_NOT_EXIST_ERROR:
+		return "file does not exist";
+	case REFTABLE_LOCK_ERROR:
+		return "data is outdated";
+	case REFTABLE_API_ERROR:
+		return "misuse of the reftable API";
+	case REFTABLE_ZLIB_ERROR:
+		return "zlib failure";
+	case REFTABLE_NAME_CONFLICT:
+		return "file/directory conflict";
+	case REFTABLE_EMPTY_TABLE_ERROR:
+		return "wrote empty table";
+	case REFTABLE_REFNAME_ERROR:
+		return "invalid refname";
+	case -1:
+		return "general error";
+	default:
+		snprintf(buf, sizeof(buf), "unknown error code %d", err);
+		return buf;
+	}
+}
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
new file mode 100644
index 00000000000..6f89bedf1a5
--- /dev/null
+++ b/reftable/reftable-error.h
@@ -0,0 +1,62 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_ERROR_H
+#define REFTABLE_ERROR_H
+
+/*
+ * Errors in reftable calls are signaled with negative integer return values. 0
+ * means success.
+ */
+enum reftable_error {
+	/* Unexpected file system behavior */
+	REFTABLE_IO_ERROR = -2,
+
+	/* Format inconsistency on reading data */
+	REFTABLE_FORMAT_ERROR = -3,
+
+	/* File does not exist. Returned from block_source_from_file(), because
+	 * it needs special handling in stack.
+	 */
+	REFTABLE_NOT_EXIST_ERROR = -4,
+
+	/* Trying to write out-of-date data. */
+	REFTABLE_LOCK_ERROR = -5,
+
+	/* Misuse of the API:
+	 *  - on writing a record with NULL refname.
+	 *  - on writing a reftable_ref_record outside the table limits
+	 *  - on writing a ref or log record before the stack's
+	 * next_update_inde*x
+	 *  - on writing a log record with multiline message with
+	 *  exact_log_message unset
+	 *  - on reading a reftable_ref_record from log iterator, or vice versa.
+	 *
+	 * When a call misuses the API, the internal state of the library is
+	 * kept unchanged.
+	 */
+	REFTABLE_API_ERROR = -6,
+
+	/* Decompression error */
+	REFTABLE_ZLIB_ERROR = -7,
+
+	/* Wrote a table without blocks. */
+	REFTABLE_EMPTY_TABLE_ERROR = -8,
+
+	/* Dir/file conflict. */
+	REFTABLE_NAME_CONFLICT = -9,
+
+	/* Invalid ref name. */
+	REFTABLE_REFNAME_ERROR = -10,
+};
+
+/* convert the numeric error code to a string. The string should not be
+ * deallocated. */
+const char *reftable_error_str(int err);
+
+#endif
-- 
gitgitgadget

