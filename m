Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB9C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiBJEB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:01:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBJEBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:01:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF7F24585
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:01:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k18so7208727wrg.11
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fl4wC27YFJsi/vH9SdqQZI7frSoMqIY/nMCZT5pK5B8=;
        b=GeLe4Dcsl/wZH4umjFhmf1SD17seOjNOhcOKE/yufdLHvOIK69FLDzdPe4VnwvHZnZ
         x7+zeEAlO5evUwrexD+RUErjO2N7yFWnOXA+h+0zDtQjQwx+W/bt6JwHSXtS7chi9JU2
         Ikdq3wc/hWQa7fDfcR73B86ebvWhHsVF4Sf7EoF4klJBH79EEEz7oIC71UC4yuenB7Lt
         zD+Melm3uTJZ6fYIv6jCqPOmMWjyY9IEDpMi0r/EMEdq8UccF2EMuSjcABeNcMMkzt3I
         oCehyA6/5wc31wpe0lAgxSJrbOAIqcjnG/cCWNynjbzb/HyjLJLaLPbAMTwgJpUeIQmJ
         CGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fl4wC27YFJsi/vH9SdqQZI7frSoMqIY/nMCZT5pK5B8=;
        b=qMlCIjaYAguztGakEqbssIE/b260DQk/vNdVGpJa9yGWvcGsCn65XW0Lob6p+7JYBC
         Yo8Vyfdy59BXoMgyyftMz5CsW10LgkWa52iyAuAUsELyTsGioslfCcRsuaxTYk24Div1
         hoK7YGoNitM757UeKZHyipBdBEMGLgEGzyEwCua0eP/p1YKntCd4hRc10Gc6QzTdtvyE
         64mfgZaDSHDVqh4m+UKaAIKq4j3fA39rFwQwaieBT2JJrvMUCGvGpVQvGtSXgyBVRymV
         re0+0jgiTkUOov8lj3TWg7XsRik14dAh4luWVf4WvkADb6jzR+5ASogNNNjC3CD7xhrV
         XZ2A==
X-Gm-Message-State: AOAM533YsarnWxNfa84RVGrrpgwp66qT9sYwRsWass92OFq4WaZ4vgdx
        3Xk2et0mcp1qvjftGys3ErNPsJ6J2WU=
X-Google-Smtp-Source: ABdhPJy+7Wk+CFFRWcAXvcEEkYo6qDMMCvUI1xFdaYWZN2G1dMf7t8tl9Ky2YoLiD9KZ2MMPma9q8w==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr4727740wrs.644.1644465709368;
        Wed, 09 Feb 2022 20:01:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm251429wms.24.2022.02.09.20.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:01:48 -0800 (PST)
Message-Id: <81bc5ae1fc1415b9bd751d93ba1ad305e31af4d6.1644465706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Feb 2022 04:01:45 +0000
Subject: [PATCH v4 2/3] cat-file: introduce batch_mode enum to replace
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
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The next patch introduces a new --batch-command flag. Including --batch
and --batch-check, we will have a total of three batch modes. Currently,
from the batch_options struct's perspective, print_options is the only
member used to distinguish between the different modes. This makes the
code harder to read.

To reduce potential confusion, replace print_contents with an enum to
help readability and clarity.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5f015e71096..709510c6564 100644
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
@@ -635,7 +640,15 @@ static int batch_option_callback(const struct option *opt,
 	}
 
 	bo->enabled = 1;
-	bo->print_contents = !strcmp(opt->long_name, "batch");
+
+	if (!strcmp(opt->long_name, "batch")) {
+		bo->batch_mode = BATCH_MODE_CONTENTS;
+	} else if (!strcmp(opt->long_name, "batch-check")) {
+		bo->batch_mode = BATCH_MODE_INFO;
+	} else {
+		BUG("%s given to batch-option-callback", opt->long_name);
+	}
+
 	bo->format = arg;
 
 	return 0;
-- 
gitgitgadget

