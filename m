Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CF4C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 18:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357437AbiBNSX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:23:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357429AbiBNSXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 13:23:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E135DFB
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c192so10116205wma.4
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=TYGVX/pmYik0xmXk3sywcCyRFKg+RgDG43bs4pnecyQLmSdNWJaMqynj6kwEwiuczP
         e7i1oqPWfrXCqAaMKASFDsdFBdf/EznpggJ67cTMRilDwkXRIC14B9C7PhbLWdS+Kx47
         3VyGkZddso4Uy4hGIyoI1UegLBT+SggPa+TqDVzcPXOBSp+6ZtoyJI6INCLB0epHrZ9h
         bPpBp5PVPm5spOle/ANXQqXpxx6TTRtvufcGV9uEzfitgQ+hMcSEDdE/C8QCY0DWn7iD
         opiLNXD9XyevBnjJ9XfsnyRKKZJ86F1xaiJ9PXekDE7gzy5Fi787gP9cfYnAVqs9Bui4
         1BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=5GAbRao6WGRm49EkhkwCWo2soqbS6OzOGOwgFiIw2V2TirDefexEXigu3NxkgMwQ9d
         65SKwogV/OcbmW36rK+R1wjkQgFqxXbGEldr3EQtU06lL0Y9os/CBo9y5UGZs3Zeciav
         qxiY1XToR7UrSEnEVBuBjtI7Ss1Y6yg+EA6+56dHuLwHjq6P6L42JnbJf/UKjPxviaTX
         Y2kiJsfuWpD2tFlTMdCC3Pyti8XbP0/21zGqM302UQHGW2Qr1pPOSpZVtTvayWoXuM10
         oVDlb0thM8jQGLAg3rLVGHnRSMyFF5PuezaY1bARzVaLZRM58d40eTyZoXaJooO9N4ym
         twTA==
X-Gm-Message-State: AOAM533Zv8r9ccByH06wCdTKt9rNyL6H1CBjqiTj9FBsG40VPj831NFF
        1KkfnBIWPG/HQPJbtGkLXAWKzC1GT18=
X-Google-Smtp-Source: ABdhPJwHSZM4/0ZNu22MvJQ7KunnRRtlvBfkEd1MTcHtY4QJe8rAWKu3fVT/NoZKWkTIQtn08IqtRw==
X-Received: by 2002:a05:600c:4f14:b0:353:32b7:b47 with SMTP id l20-20020a05600c4f1400b0035332b70b47mr13346wmq.126.1644862992055;
        Mon, 14 Feb 2022 10:23:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm7346801wmq.33.2022.02.14.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:23:11 -0800 (PST)
Message-Id: <1a038097bfc1e0e7dc7737e4fb664e8f79a2da50.1644862988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
References: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
        <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 18:23:06 +0000
Subject: [PATCH v6 2/4] cat-file: introduce batch_mode enum to replace
 print_contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

A future patch introduces a new --batch-command flag. Including --batch
and --batch-check, we will have a total of three batch modes. print_contents
is the only boolean on the batch_options sturct used to distinguish
between the different modes. This makes the code harder to read.

To reduce potential confusion, replace print_contents with an enum to
help readability and clarity.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5f015e71096..5e38af82af1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,10 +17,15 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 
+enum batch_mode {
+	BATCH_MODE_CONTENTS,
+	BATCH_MODE_INFO,
+};
+
 struct batch_options {
 	int enabled;
 	int follow_symlinks;
-	int print_contents;
+	enum batch_mode batch_mode;
 	int buffer_output;
 	int all_objects;
 	int unordered;
@@ -386,7 +391,7 @@ static void batch_object_write(const char *obj_name,
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
-	if (opt->print_contents) {
+	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
@@ -536,7 +541,7 @@ static int batch_objects(struct batch_options *opt)
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->print_contents)
+	if (opt->batch_mode == BATCH_MODE_CONTENTS)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
@@ -635,7 +640,14 @@ static int batch_option_callback(const struct option *opt,
 	}
 
 	bo->enabled = 1;
-	bo->print_contents = !strcmp(opt->long_name, "batch");
+
+	if (!strcmp(opt->long_name, "batch"))
+		bo->batch_mode = BATCH_MODE_CONTENTS;
+	else if (!strcmp(opt->long_name, "batch-check"))
+		bo->batch_mode = BATCH_MODE_INFO;
+	else
+		BUG("%s given to batch-option-callback", opt->long_name);
+
 	bo->format = arg;
 
 	return 0;
-- 
gitgitgadget

