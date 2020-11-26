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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC37BC64E7A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D7A221F9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D53v+t5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404649AbgKZTmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404516AbgKZTml (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503DC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a3so3480140wmb.5
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=undKgM7TlFUHg4aVh5lQOHw423Y0GZJfqf13qvwRkmg=;
        b=D53v+t5yWtZDg4OPqFkreuBZjyhhq1QRYO+9ah3msSoP7TX3M04Fm8TBzKXtP55pbI
         +x2NE1L26k2DBy9iSSLCzmDYUmz+gmyUCY1aml2D67WcHO16WbAe5z9p++PHp2yJSwhM
         hYVY+z9oFqqtm59QjAmOit4O4m0zrKlHZ5Q5lxuxd5cXLTM/TQGuBIeRZpfjBPWNpyVr
         C46hRczZLiDNlVE1kK+8KzAqoCCgwBmCYLuqLk3HymPmiDSnLwm0CAs4zFR9EUEtlLKx
         Aj69yftkKLO6+Y3dKnQVDAY3FtJ7xJHmDwHhrqY4h8a30GbDLISsit7qfJGXOiJSPJV6
         sZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=undKgM7TlFUHg4aVh5lQOHw423Y0GZJfqf13qvwRkmg=;
        b=G72l9jRo6UhkvACBq4+3nskZILoAVM8FjEv1jWaHjFhMKiWdNMtsAuZoIx1bwa7PQ+
         wv7g3+cdRkkZBFOxOb42p6XgZQ0IRXRbIkRPf0Da4wxFdiZyV9z/KuONJ+395gmum94P
         MA77asROo/jqi3M6UDr/RKHegJ1rsOrg/wJGyANsvcg6DxrB8hNXvGgrQA878dA+Lppv
         Nr1yLI1Umez8lPRBXxRzXyRmv5cvzP5UlReF+TAWVrMv3i7Z6xQDN02inaBhlXg3NZ8N
         3ZaYuYSVLRYtL4fMfLoSGf9yG2bRjCwA4mHRemdQQFNcGK8VQsAuSIxaXgf9LIG0SpTg
         FHYQ==
X-Gm-Message-State: AOAM5314TCsMw1Y4C1R4jmQM8DyJ/ySNUIkkUUmU0imF29FUCnR2xqVb
        HvaDvOF9ofDTLhR01tu6zeLCNN0N8zo=
X-Google-Smtp-Source: ABdhPJyGHUoXqDb3o7lpMIbUVz2yjkDSGyd8f22CM7NOl0qj6qyhlk/3BPNCIu7yBHmH4fW7BV6pLQ==
X-Received: by 2002:a05:600c:218a:: with SMTP id e10mr5211508wme.73.1606419757847;
        Thu, 26 Nov 2020 11:42:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm9546180wmh.33.2020.11.26.11.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:37 -0800 (PST)
Message-Id: <2aa30f536fb7ce5501d1ecf0315cbcb1c1c5ce38.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:19 +0000
Subject: [PATCH v3 04/16] reftable: add error related functionality
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
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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
 reftable/error.c          | 39 ++++++++++++++++++++++++
 reftable/reftable-error.h | 62 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 reftable/error.c
 create mode 100644 reftable/reftable-error.h

diff --git a/reftable/error.c b/reftable/error.c
new file mode 100644
index 0000000000..1d60137ea7
--- /dev/null
+++ b/reftable/error.c
@@ -0,0 +1,39 @@
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
index 0000000000..7e55a16aac
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
+ Errors in reftable calls are signaled with negative integer return values. 0
+ means success.
+*/
+enum reftable_error {
+	/* Unexpected file system behavior */
+	REFTABLE_IO_ERROR = -2,
+
+	/* Format inconsistency on reading data
+	 */
+	REFTABLE_FORMAT_ERROR = -3,
+
+	/* File does not exist. Returned from block_source_from_file(),  because
+	   it needs special handling in stack.
+	*/
+	REFTABLE_NOT_EXIST_ERROR = -4,
+
+	/* Trying to write out-of-date data. */
+	REFTABLE_LOCK_ERROR = -5,
+
+	/* Misuse of the API:
+	   - on writing a record with NULL refname.
+	   - on writing a reftable_ref_record outside the table limits
+	   - on writing a ref or log record before the stack's next_update_index
+	   - on writing a log record with multiline message with
+	   exact_log_message unset
+	   - on reading a reftable_ref_record from log iterator, or vice versa.
+
+	  When a call misuses the API, the internal state of the library is kept
+	  unchanged.
+	*/
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
+	/* Illegal ref name. */
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

