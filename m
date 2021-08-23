Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B731C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1CF613A8
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhHWMNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhHWMNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DDAC061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so25976154wrn.5
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j41437EWXIIEa0RTmJRXYnhOczr8VXWQZR8iYaC+/Jo=;
        b=L56aX8oqeWvgtX0Vf4P4VKF19oxz5qpY8BDEtsOclDtrcEOr9fx51zDzWTLqScJYho
         FWCa978cWvm9px4qvZnr2koNq/a9tDvcTyUCe299pHwEUUXtC5x0URolxrQaBq6ViE2f
         ib9r24h23vyUMzhRYaFjRIxxz+4EqnyHUnv2kqF2ekvCFpIe7x+k60lIqbmAwhGgDb3k
         e4XACSaKjgSF7hs1iGZh8jbhCZrtEDDzLONt8V7B/jrwDmaX73rkgnBDTnOmfbMEx/xJ
         6API1xhOn0YeZBN2VPEpAvgOEVQO0bpSJVngOERqPlb7XcNU7Jx7vA+RaPLcAOC87Q9G
         KtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j41437EWXIIEa0RTmJRXYnhOczr8VXWQZR8iYaC+/Jo=;
        b=aPhRcZtPiz4+LfJZliUAJ/tC0KvNjN4qNF8Ja4pqUUJhH+SoUE2m378THBRCrU5HpP
         MwCbhaQR2RRdnpaDXSymwUbalKDuNTnT+Dx89ZWQP3+osDgeaENI6UhcWlAeqXgwx8MX
         bJX5bVf+MDbY1G7j/kTlBMR84QPYrio8sFlTL54n4WaKL9UqCdYQw6lOHNfmA3txrHaP
         vPpGLBbSEBNZ3p6QYQWsWQAALoTrVRUz/Spyk0Wflg/zBEKG6nbMsyLzDe6H9M2WS69U
         gS8XyaiSz/LFvZOP2LhwKVzPOFtwXLf5+tP+6sNRCSRSYCVZL2jlyl90APUhUFna0XX6
         afLQ==
X-Gm-Message-State: AOAM530/7QscWSle+qLqDtCX/benXMnA7FnIqWj4KfLYSn5iPm6+pBAH
        fEkiqRB4O6V8YvcMkXH0JfhmtkqC6EBxA1G6
X-Google-Smtp-Source: ABdhPJwwI4oh+e9CbqP0jSNZ4hqGmCRNxdlUWS4CzSnPLyF21sCTsMepzjOMpBaxQO3b79QNAdJDTA==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr13572905wrt.30.1629720778401;
        Mon, 23 Aug 2021 05:12:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:12:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 04/28] reftable: add error related functionality
Date:   Mon, 23 Aug 2021 14:12:15 +0200
Message-Id: <patch-v4-04.28-a0686356c11-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.33.0.662.gbaddc25a55e

