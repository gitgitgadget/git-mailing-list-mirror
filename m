Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670F1FA373E
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiJYSYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJYSYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 14:24:34 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E667923E8F
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:24:33 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 63so1514661iov.8
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1BYp/cZWJgrUwpX9zZXa9Rhu0jJBg9rL2jtlZTEUJw=;
        b=wv5xjEK4D7FHmnVdUJxXXUPAx2Q7Py6DpWbtB1ve2ydamcjGi61y+dO3/5MwYzmD6Y
         ClwMErZqyeSikMsOQcagS2UaZhrlh/KZCFKi4x2qMrghyMUMy1HHo2cTmtMcfFMizH54
         PZdHf1BQLJkGTGM8ny8YdguGbmRReGJDF8whgCncQnSyzR/WNnhEawSVtOVz5YI8UKZW
         Q8WdDUIdspdZYj4S9O5JRRffQ1wBGkuAeU7SsTSnvd1FIXCtp7EKKYOJ4iH+wui2wkzb
         SXg81afpX2xDEqZ8dxzTn8m7ebkLncNJOHK5YapgDCl4Lna6jrlEU/vjPDW8bqFEOIIG
         uq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1BYp/cZWJgrUwpX9zZXa9Rhu0jJBg9rL2jtlZTEUJw=;
        b=0gzjmit0WS0HdMc2yubNqi9e+XlV+NAyOEZBSXZvij71NtQOmMpDgzmDuXtKycVWzI
         8WLvggYfYIS6NRzYZUr9MrGj1MlHAVh8IjjuGkMWyhO7OnJmstw402UQG/lFFHc327JK
         UoOx59i0hotqq4HO6rE7oAJYb28DeXCkn3s3qWCZjydHAkoIcqeF6qe6nds9HHlzqbBs
         zAbyqapdrbRgsyvGsn+V4p18eKmZ3jeO9lz2kw9V2eZlwsg60PLbamPvaoxlfesWsxJh
         zzkbLDZqElk3pHbjPDoFnuCb/YXA1pouvJfVrnww/LtF8X7H/mm/B01EpkYlcpOqHkjJ
         +5lA==
X-Gm-Message-State: ACrzQf1n3awYXD7QoBy7OhzoGDT2ZPkkhdMuu1bT8AtazRScT3qOGqD3
        Nx7DtC3NDyukT6CKPwDLRXAMhbzamrZZyCn8
X-Google-Smtp-Source: AMsMyM4emyflOopLczUo6/nAkqHKe0VHwxJkGqaqkGznctWRHwe7WIh+OjisKIZ8DHd/xp6JNOzsnw==
X-Received: by 2002:a05:6638:2513:b0:364:11d7:a96a with SMTP id v19-20020a056638251300b0036411d7a96amr25881781jat.35.1666722273080;
        Tue, 25 Oct 2022 11:24:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 2-20020a056e0220c200b002ffa449535asm1232879ilq.74.2022.10.25.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:24:32 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:24:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?7KCV7J6s7Jqw?= <thebound7@gmail.com>
Subject: [PATCH] apply: reject patches larger than ~1 GiB
Message-ID: <70f5763834dff373a5573a99ec4cdfa36cadf34c.1666722251.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The apply code is not prepared to handle extremely large files. It uses
"int" in some places, and "unsigned long" in others.

This combination leads to unfortunate problems when switching between
the two types. Using "int" prevents us from handling large files, since
large offsets will wrap around and spill into small negative values,
which can result in wrong behavior (like accessing the patch buffer with
a negative offset).

Converting from "unsigned long" to "int" also has truncation problems
even on LLP64 platforms where "long" is the same size as "int", since
the former is unsigned but the latter is not.

To avoid potential overflow and truncation issues in `git apply`, apply
similar treatment as in dcd1742e56 (xdiff: reject files larger than
~1GB, 2015-09-24), where the xdiff code was taught to reject large
files for similar reasons.

The maximum size was chosen somewhat arbitrarily, but picking a value
just shy of a gigabyte allows us to double it without overflowing 2^31-1
(after which point our value would wrap around to a negative number).
To give ourselves a bit of extra margin, the maximum patch size is a MiB
smaller than a full GiB, which gives us some slop in case we allocate
"(records + 1) * sizeof(int)" or similar.

Luckily, the security implications of these conversion issues are
relatively uninteresting, because a victim needs to be convinced to
apply a malicious patch.

Reported-by: 정재우 <thebound7@gmail.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 apply.c                    | 12 +++++++++++-
 t/t4141-apply-too-large.sh | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100755 t/t4141-apply-too-large.sh

diff --git a/apply.c b/apply.c
index 2b7cd930ef..850604c191 100644
--- a/apply.c
+++ b/apply.c
@@ -386,9 +386,19 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
 
 #define SLOP (16)
 
+/*
+ * apply.c isn't equipped to handle arbitrarily large patches, because
+ * it intermingles `unsigned long` with `int` for the type used to store
+ * buffer lengths.
+ *
+ * Only process patches that are just shy of 1 GiB large in order to
+ * avoid any truncation or overflow issues.
+ */
+#define MAX_APPLY_SIZE (1024UL * 1024 * 1023)
+
 static int read_patch_file(struct strbuf *sb, int fd)
 {
-	if (strbuf_read(sb, fd, 0) < 0)
+	if (strbuf_read(sb, fd, 0) < 0 || sb->len >= MAX_APPLY_SIZE)
 		return error_errno("git apply: failed to read");
 
 	/*
diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
new file mode 100755
index 0000000000..58742d4fc5
--- /dev/null
+++ b/t/t4141-apply-too-large.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='git apply with too-large patch'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
+	sz=$((1024 * 1024 * 1023)) &&
+	{
+		cat <<-\EOF &&
+		diff --git a/file b/file
+		new file mode 100644
+		--- /dev/null
+		+++ b/file
+		@@ -0,0 +1 @@
+		EOF
+		test-tool genzeros
+	} | test_copy_bytes $sz | test_must_fail git apply 2>err &&
+	grep "git apply: failed to read" err
+'
+
+test_done
-- 
2.38.0.16.g393fd4c6db
