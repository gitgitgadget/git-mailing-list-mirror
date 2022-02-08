Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E1C4167B
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387095AbiBHWZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386598AbiBHU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:58:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43274C0612B9
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:58:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k18so487590wrg.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S/Xz8fALiv61jRjpfZoA6oLd/UpDML+9bXWYzodTvqk=;
        b=cmxeiUxFCjDivO9PohvtIxfXsWKtEABVdiL8XFtpoEQEMAlnvapG/FmrK6NeNb2T2h
         Pt2R+T8Aa6O2OVFaTGn+YpUCZX0IyKPTEP3XBejnV1a6V/Sf75nDa9DfizOABVqacD1g
         myzITsbrEYVlPWbyONtj7OU5Yadal3EpaCEE+WcSkTYVcpmtqQP5FWZxOeoMmbo6d6O9
         1V1zvcVthksAfEthx417Y7e6SeI57XFTmwHXoGNtv33PrsspEtNSlKHHt4ScV51b/MSB
         n+ONiM0efdVyIXZ32QbYCxjca3RkLEyeXbLMpGp0lBZGHdLoNg1Mn2OLavFhgGuwLA8Y
         vZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S/Xz8fALiv61jRjpfZoA6oLd/UpDML+9bXWYzodTvqk=;
        b=Q3y58x8iLLTabyq2WCDhqgc28MbrJb6qvD/GwnczXL5EwZPBTERmy70u0rO+3R/s/p
         RUT4r33VpN98rdTvDyGC4vsBT8VQlCZ+hZoATz7g8UOgPx8eVWMpeKIRV22SkiejLdjD
         j7EjpO9kqJmKKttD4GYISu7q/0Wwg55pLzxVPgZS1tTeBto2TIKovOo660YQWUcvZc9f
         U3eDdOpnTpmOBVdERjsRv45Sl2fLvjdoEPE/dXyOHRncABmc2plbC2tqvtwTZ2hzNnvi
         c7j3Ndqim19TBKL2VFyzTePZz9nY6nxhx2l0YMLLr9Mvuos73pQiyV60xgdOXE/nBrDO
         +5eQ==
X-Gm-Message-State: AOAM531i9IPKE39WAR/VX3cDSpXOMaJ49Dq59f1BTBLFILkUgdkchnjw
        O6pqp44FH8Fl6Bn/Be0Iv56Tp/zbO1E=
X-Google-Smtp-Source: ABdhPJx91KT3Rtt0fLvFtolKi+OSmy8tKSq9EBQo/yRX9Jiduq2VxPKOH0xbW5HzTHw/7m2rDhFvDA==
X-Received: by 2002:a5d:4384:: with SMTP id i4mr4963339wrq.607.1644353887614;
        Tue, 08 Feb 2022 12:58:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm16001447wrx.114.2022.02.08.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:58:07 -0800 (PST)
Message-Id: <ae2dfa512a760446bf6d40c456cb4126e952db98.1644353884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:58:03 +0000
Subject: [PATCH v3 2/3] cat-file: introduce batch_command enum to replace
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
 builtin/cat-file.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5f015e71096..1c673385868 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,10 +17,15 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 
+enum batch_command {
+	BATCH_COMMAND_CONTENTS,
+	BATCH_COMMAND_INFO,
+};
+
 struct batch_options {
 	int enabled;
 	int follow_symlinks;
-	int print_contents;
+	enum batch_command command_mode;
 	int buffer_output;
 	int all_objects;
 	int unordered;
@@ -386,7 +391,7 @@ static void batch_object_write(const char *obj_name,
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
-	if (opt->print_contents) {
+	if (opt->command_mode == BATCH_COMMAND_CONTENTS) {
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
@@ -536,7 +541,7 @@ static int batch_objects(struct batch_options *opt)
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->print_contents)
+	if (opt->command_mode == BATCH_COMMAND_CONTENTS)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
@@ -635,7 +640,12 @@ static int batch_option_callback(const struct option *opt,
 	}
 
 	bo->enabled = 1;
-	bo->print_contents = !strcmp(opt->long_name, "batch");
+
+	if (!strcmp(opt->long_name, "batch"))
+		bo->command_mode = BATCH_COMMAND_CONTENTS;
+	if (!strcmp(opt->long_name, "batch-check"))
+		bo->command_mode = BATCH_COMMAND_INFO;
+
 	bo->format = arg;
 
 	return 0;
-- 
gitgitgadget

