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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B6C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C6F6135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbhDLT0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhDLT0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:26:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D64AC06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so6836094wmg.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oev4451zcfiJIRokI1RZPsQFi4LyNbqQe+VIWGZcV5k=;
        b=eQ6+U09Cmvai6fgj7hLPWPmrOWXwWRECOEFlmvGSdAnicjRo19CKOG7PdZkw/XgIVh
         PK8J/uCMCCw3aUMh/1ISeTodnTg/TCzMwKfEwnmMn5TU6HXN+oOd2ChXcAwMY21cCsk1
         s7ofjduICZ5KQyPGWi1cQWHjjJ/kOAmsMH0KLfnt8u+c+FUwm467YaAe1ihee2rcJeWH
         Snysn6SbU8zI58UbMbtRO7jf0UAXCrsADuYF6In6151MjxjikdrC7bJo/YL0jZSv8rzR
         zPoZZ1mZP8+ho2U6ngpc2ARvQ0OCG1mxmhxIxzurQZSP8aXEPybWVwH0Nmyb9Q3E6fdU
         Nnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oev4451zcfiJIRokI1RZPsQFi4LyNbqQe+VIWGZcV5k=;
        b=uCaZEzHE1ftnabC1hsJydTRCbydyjk7g9uRB/np/fqnQwfkaMcG7RZY8yn6d/bFkpG
         AIf31ClLp1IVUi7s8GFLsFWIdGNVbwnA58/bvmxWsoIG+knhA29ejVB9JaXIFwfQ8uDn
         qQfgmyh1NzEutmfZ23g4EQnWOobBKiM/TMFU138XS6e0t8X7ssyW4WjpfaGTzAnAs/ga
         uryt9TGrH2ln9XD/atsIUbQaLIbSGUyIElp2lgiYOJXpjbUmMEGYAFmPVAmGlZ6wwvqi
         k4NYuXb7aLHUc2H/gbZnf31dIadaJtl3tXNGpeQsZfnighJF0e34USZWuKtSrXs/wBsL
         2gUA==
X-Gm-Message-State: AOAM532RdxxkQa8MHEOI7LaA/pSVpKmN2HY29zSM4pI4RvBdgGBBS5fC
        vhhxCfx/SgnNGQvF62pM2BpvzS8fMsc=
X-Google-Smtp-Source: ABdhPJz87UIjF+PD4Y+bvnM+4jqt7svbcJBIgTIjNtCSp13VgzZ2f0on0/PIPJTRuhuG0DRmjsJRMw==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr617431wmo.68.1618255556903;
        Mon, 12 Apr 2021 12:25:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm20594529wrt.54.2021.04.12.12.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:25:56 -0700 (PDT)
Message-Id: <bffa33c012adcf15c8e8e96e8853cfd73f091560.1618255552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:25:35 +0000
Subject: [PATCH v6 03/20] reftable: add error related functionality
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 000000000000..f6f16def9214
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
index 000000000000..6f89bedf1a58
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

