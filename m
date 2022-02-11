Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C203C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353083AbiBKUBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:01:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348047AbiBKUBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A3C51
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:01:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s10so3476422wrb.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cycmnRx6L/+2c+ek8092pDjU8L2pP0oYYftw3CXd8kk=;
        b=VF6hGMbEQg8IV07zfuwb8q37BvZ+ML8dktuVHhCYqfe0566wkcR+8ChhswwZ8tCd8o
         v7LpWnpscJ/ZSVEFd9AS3C+XiQCILDXvegPJAY0qp30soc8b/gpph1Hm1S6v7+slOcDd
         Jpl+sL/RaeuqmKAMj+ODWhCuuvhxA9VKWFGU+xZAvo6OpUIdOY/50KirSJCPYnaaZ5jf
         y5Rr9MNVDzC9CtEj5pp1KhbryTB/kjQcP6dO0z6Oz96AauHQldwO/sOAZ7Vlj9GALr39
         6RYftrZ/PM/f4+ErDr6IiUS6mSkM9GAySAS8n3t7ywJ+l8PkQEI14yLJNP93JtYXVXx+
         2fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cycmnRx6L/+2c+ek8092pDjU8L2pP0oYYftw3CXd8kk=;
        b=nrd4HoHZIK7odvD4L1BelUym/gQ1ZNuTBR8W6Pap1OAaQbMsANDTVB3Kr1xtrBkssD
         WamF2OJzD3WssrnmoRAG8+NyVNcdurPbYpTOAMF2PeopsP+28GmxKKb07rk3oixP+i4b
         F15kaHAf/GNSReFupjxdGBfi99B5HW1uCA+vwnAzNc8CzhoCBjxNtwmYOluWCMsWL7Jt
         Agm+WTRKguuEDPlBiqOM3s/aB/D/Wujso1+IPf/9bQ5TthW6Y9TbJfVywJcPEzJnn4uL
         O/NJcpjr64Gn3Wxz/uE689fBtTL/bitn9o2QllF66EErhh7nJ0s3YGVWV75T1wEKo1/o
         P7QA==
X-Gm-Message-State: AOAM533hbq/fKlka8YSI3+diU53tHBwE43e3uBQSvR+PD2QFdlKe6C3N
        n0lRI2CvAYVs+kQyMevp1c36/qCtja8=
X-Google-Smtp-Source: ABdhPJx+578krTA+3Sg6IY2a8w4/LWMCjyvg7KHdqhkJdplftrTktEh4lY9zYLtb7zoZM9B3S6mzVQ==
X-Received: by 2002:adf:fecf:: with SMTP id q15mr2517193wrs.104.1644609688476;
        Fri, 11 Feb 2022 12:01:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm24763939wrr.16.2022.02.11.12.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:28 -0800 (PST)
Message-Id: <5e0d1161df46b0cb9417db1cd2a82dd8325db9eb.1644609683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
References: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
        <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:01:22 +0000
Subject: [PATCH v5 2/3] cat-file: introduce batch_mode enum to replace
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

The next patch introduces a new --batch-command flag. Including --batch
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

