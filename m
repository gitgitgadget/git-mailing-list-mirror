Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0AC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A48861166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhDSLjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbhDSLif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C94C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g9so17634544wrx.0
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oev4451zcfiJIRokI1RZPsQFi4LyNbqQe+VIWGZcV5k=;
        b=YG3quMyf/IQ5UzDikWAdKbQ/er5jNTpSSydBUnA6x00rxpMLtv/JOb7iK6kCqYqgvm
         eBsMXmIxNDWvuRfZkh1FPbBy+yIpxU/k3uj2MLluhvxxBwPjUTltAn2Zbb/45fa/nKwu
         Q4XvZwlfYNwThJ3jB14/ikegkVVM1+/iBdIFs3QUBf7shuNokMkTHSGUlK/nphTCUjP8
         0u+cJqJTgVBGjVBHQAuOuXtXJM+aTzd7/lrtANhjYsprvB+XrPvHANPW+BgNtIzjp2lS
         Whz1VoL1Tp+desc7W6V0rD/rXCqpSGGtl2dbrHO9ZqJ/9aVWZfbt3Q+vlIZsWD3PSMJw
         30IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oev4451zcfiJIRokI1RZPsQFi4LyNbqQe+VIWGZcV5k=;
        b=syWdtkzIyYsQ2x6u5AsKu/bXeld3Vq1oVNW5TnQZ6jJJNCvZ45axBFZPZB9BPg4Usi
         Jo/ckI5No2IzldjpKLM9RfPi9RhfChej7Xy+CeMHAgiMF0LjyEHflejYzuHsXq1rLjBQ
         jQOtA+vT6wp04k0yffzoo3tl2WLcRbxt+XLdO8Ub9SC3OgA4HztDTba2jk1sy2mJG6xJ
         BvPwN73DvQI//3wpBZP99dlQewDWTztYu09JdSZe6Z3/spMttkFLfLMcgu0ZXo6YgYx4
         U+6tfCN9xgPVH7P+C8oL4VIPJmkTVdsLTlvJCYmFa4zoimMiR7lDxeBs4MY0EM2THdVe
         iEjg==
X-Gm-Message-State: AOAM531B1uARsV26yCfWwAtQ1KGjSAnxuhnEHRVkyaZPD12A8ZdmwsEb
        nZ8viOZ7NDYhjydsmKBLfcKG4KAWxOQ=
X-Google-Smtp-Source: ABdhPJygOsWWsGvd2dXgVRK8pWIK2h5GPu1Gmk2erbVncY9EMkCCgQEdy9sT8KPO7tFsGgepZdIiOg==
X-Received: by 2002:adf:d0cc:: with SMTP id z12mr14142689wrh.18.1618832284196;
        Mon, 19 Apr 2021 04:38:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm22374358wmb.32.2021.04.19.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:03 -0700 (PDT)
Message-Id: <5177919a3fd2f85cdf28ecf745361ae4ea75a7b8.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:35 +0000
Subject: [PATCH v7 07/28] reftable: add error related functionality
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
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

