Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA91C433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 15:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiBPPCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:02:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiBPPCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 10:02:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932729811
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so3955537wra.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=CVfjweJg6yMG3Wfiq8yvPIpYnGoNiZ0CasAcpqpZjJXxQrIsRFYMSUm2MPudAjMXmL
         Bg6Us0uV4cuAiZNalgblJ1A46g0lJnVfkoUX/RMbqoASW92a+PUZ6WplW0wX6f7khJ47
         9J2RNVva+ukM+flBvOsmZyVUg82RwuXRvodX0ZfE/0eyFyByBxLsYDysTamBlGYub1y0
         HZjsTL5aRMtMkE21eAkVwWUWz7NIi/gbMRaEHCqT1q/IW2JRLvVIfLejPzHquW1aD/x2
         ulauZrfnaCcTXYqiYUHiawbOiKfwoUhdUAlhPfkyZEWe4bY2zqojImVAn/XBvGIFzGJK
         4qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=qqCZsN6z7nx3GmhkuLHx4MR8ssEg4DeP1JrdIsDMy5Z2p1e3ZpAK/ws9e/6NtOWjq7
         OGOtsVFr6D4WkVm7hmi3bi/86EI8X9+XJ0VxcMyTj0Stjble0DEpQkucmrQ2DrkR18MN
         bHgoJouBRkZV25BiK5tDsfBTBT7SoYHIFRYs+qcfNptzrGwsnQud5DjALnneZ2fpxiOR
         2te8YpS6jlqmw3HIEwvwf9qCvozmsmTcEB/15mI3ub9oBqCSAyIqJ8FP56zH2N77aT8I
         GfQSygJcEYKRukfGlszbp9Mw3qSrTFMRaXiP552JSqB9sH6300plNII8wmGvJ5aS7OVu
         e2kg==
X-Gm-Message-State: AOAM533LS2XFaxkfoleDtpChnh1KO2WZNp2qn0DaEiC5G0tjmc2LOZYS
        6aMGY/jCD1ln+lB9Mii0FxErjxfT1jY=
X-Google-Smtp-Source: ABdhPJyg3U1WKgD9aub5usOmf2Kc3fS2f7fmvXLNKwQ1M4tgh3xGYhbThURwiRxf63BZXMizBWEbMw==
X-Received: by 2002:a05:6000:25a:b0:1e3:2010:4d14 with SMTP id m26-20020a056000025a00b001e320104d14mr2663199wrz.455.1645023743982;
        Wed, 16 Feb 2022 07:02:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm19061351wrm.3.2022.02.16.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:02:23 -0800 (PST)
Message-Id: <1a038097bfc1e0e7dc7737e4fb664e8f79a2da50.1645023740.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
References: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
        <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 15:02:18 +0000
Subject: [PATCH v8 2/4] cat-file: introduce batch_mode enum to replace
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

