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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E081C4320E
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA6960F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhHPUSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhHPUR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:17:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D38C0613CF
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q10so25324038wro.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Izbl9wexLtHbO918dhEysjpUsFaAvsDqZEji3I0p88=;
        b=eKMp2uDaB/LQuw/zUEclKBBBo4dcfHXL7dg4H8M7ksqK25dcwvM1iz4wNQ5ptnbK++
         A7L2y0jiOJ8n1hK+OKGZXhuOPId+zCGvl7fhnLLQaO9wvFWc7u7KTIlM85w7I6ADuGZv
         sIG5mtmAg8owKg34/Sw/oPeE+Uajm+V8R2P32BcoRjgc6iFDJvt78F0ddOkBM8NPLo3w
         ETsCwlMuywIc/oMSAMcmu2Snd8BQabFhWBCr1dwzmbj+hpdCvfAb/MoCJWyaXoFEyDNk
         /xiYQGVNckN3xwtvVqt9okEGjZg6c2mpbu5pn4134SJe4vk/XGiveTCz9LRbWyLCzT0r
         3AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Izbl9wexLtHbO918dhEysjpUsFaAvsDqZEji3I0p88=;
        b=ki0aoXtQ7B8ukC13lerWF+cPNBMvEJykT1q/Xf+DGkxwy3u4PIXzKSH1jDWTxCHcUE
         qyDltOUYcS9y+oKoF2gm9SV98uqT/esuAiWF8YxuiuEMjarxXd4P/HXIa8g6XC3mHp6T
         lAIVQojkEqy8GGLbf9Ct+KIORANr2tuQNRkmQY8zSEn779S4YfSakvRpaQRx0eClEV/b
         CQz7BBC6S3Uriv4EAJL0r0E1/HqXSh40kUcD3sVBMQD/v0bFBJ+JysdaDjsByAaMrpLR
         Y7lr1Dny3TA4T+0jnvNODAFPGPiixPBTg/WSj2jutKHcv7JTHoD6nkhRhiSV2j+5Igr2
         vC0A==
X-Gm-Message-State: AOAM5307tEyB/WNu626K32YuFTjlgzZM/tfHVaUMGI7plyaZpnUVfDPZ
        kCQsjFZ6sxtQ7M70vam7lle1+wOnmHQ=
X-Google-Smtp-Source: ABdhPJzgbaaCqCTtW7SYMV7TTssMPDiMsP+Pq0R0AUJYUwnRmBscvK9ZVX5nIUAtH7a17K9MqvgR6w==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr276469wrq.58.1629145043387;
        Mon, 16 Aug 2021 13:17:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm256348wrr.21.2021.08.16.13.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:22 -0700 (PDT)
Message-Id: <75864034af2b2671697cad92f10a3335dc841b1e.1629145036.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:16:55 +0000
Subject: [PATCH v2 04/25] reftable: add error related functionality
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

