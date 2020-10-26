Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683FC5DF9E
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876FA2085B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9Hi+RYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793302AbgJZTdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33226 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793180AbgJZTdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:33:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id b8so14089611wrn.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gCEsUnsq35tyokpp1i/5kDvTkvMw9U8I88ua8VJ0XHc=;
        b=f9Hi+RYRouM3LRBTEbtqWQxUIm7I4tzQ5Vq9KU49loJ2XVFCARXz54ZQfdlOv7NaUx
         oWsCfB7krdk1MWaBdBAkp7BsQD+TRLnAi95JebeREmaQbpNcLZtE/AWgtMu1cJScBOOS
         K1Varufa5ydm2SaazHfcT4rwQrNSg1SJWaA1dUrlJZ278tgglgkODN5V7oYw9J9N9RzD
         nHCYVb8bLjVXF4D7msYzr3d1NFUqMlxgp6pe8I9/Lpktf8nWqYGzJNyp3S/VJ4ma5os2
         gBxzbqlOdnzVcdHepLJ1gVYdBXVjf6Xs/KWjtj9y2AGzwbAFZEG5+Qb7kHxXBvA/4c7F
         NYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gCEsUnsq35tyokpp1i/5kDvTkvMw9U8I88ua8VJ0XHc=;
        b=IBAx0ph/1HYsanbsrCGYSLitXo0B9IBBklTJYOl6uQJRCbtODZYTnCJWM0RfjgbMav
         XLF/XDCj4j61JZiyCg/NCrBSb5XV/y9xZDtYIbJ0rvSK7zgUZ9OnUrCZAShs+pl8zvWY
         YmDkXnheNQqJSGF8xx+UPIjV7ti+at7U8bcGnLliJHXXvkwfpY7JO6XoL4cQvTcAHc+T
         1byNsRiaMVxRj6ba5F7MUBWfIQu7czL9rPqrYhUJEo5iK+DbYm2eTDwHV9I5JdElI+ES
         PxDL77qn/isTN5fF/r+XQrSHRIurxNLZlEgKyXSNJEnd3erONqNrg2ngRsCV3Y0wu980
         KhOw==
X-Gm-Message-State: AOAM531AzO3u9LkGbOgAsy4sApzS52rsnj2boiuCJLOqGuxv95guYhFg
        y6V5ql+39St7ar8t9N+kLFf8UVDKg3k=
X-Google-Smtp-Source: ABdhPJxKL/+JOsp0JilelLUWvCLupVioH0OEXCGDaP/LvGMy9Kda6bkXwHpeN631+H2IjE5B51d19Q==
X-Received: by 2002:adf:94c6:: with SMTP id 64mr19190557wrr.8.1603740778700;
        Mon, 26 Oct 2020 12:32:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 205sm23458481wme.38.2020.10.26.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:58 -0700 (PDT)
Message-Id: <02c2afcb96b7eded3a48cdffb60c5c17f3a7d61a.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:48 +0000
Subject: [PATCH 05/10] t/perf/fsmonitor: shorten DESC to basename
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

The full name is lengthy and makes it hard to read
Before:
7519.3: status (fsmonitor=/home/nipunn/src/server/.git/hooks/rs-git-fsmonitor) 0.02(0.01+0.00)

After
7519.3: status (fsmonitor=rs-git-fsmonitor) 0.03(0.02+0.00)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index aa6b82d756..2c817db1ae 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -141,7 +141,11 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite() {
-	DESC="fsmonitor=$INTEGRATION_SCRIPT"
+	if test -n "$INTEGRATION_SCRIPT"; then
+		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
+	else
+		DESC="fsmonitor=disabled"
+	fi
 
 	test_perf_w_drop_caches "status ($DESC)" '
 		git status
-- 
gitgitgadget

