Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4334DC43467
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F41208D5
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzYLNYus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgJLX0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgJLX0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 19:26:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596E0C0613D1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j136so19581956wmj.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T16sX8fBPoxz8IYCWDw0qPz47pxfSp1RT+oLd5fRm4Q=;
        b=hzYLNYus0t3/whA7MB1paYOfQwQAh3m9QZ3mjsITDzhLgq2sL2q9rNtwDTT6pvcIdH
         hjKMir6vWmnz8hX5dDKgXz/eN3PR+szT9zqmdSWUrTh1euJYPHZOoqL0keEtAAGnT4rv
         /LwmSJFGV3gMqbCxdLZSjmV9//AaGPyYesKsGZtRDokwVTZYhJKoEXeWnWOYGenVAkwX
         tK3qRzU5VTh9XL5YtqKCtTvjW3SU/En99ycobpn3Rp5/V0bdy2SVADKA8QWWsbpvnjzr
         iZpWAAd42HjGUOI4PNqApCv9pyLQ1zi+4cbYHiBv1uk+lfGTLEeIk/yHd4trrSlwRS5X
         Q3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T16sX8fBPoxz8IYCWDw0qPz47pxfSp1RT+oLd5fRm4Q=;
        b=Bn8AuWv+RDoBZP6eIRIYWED11RjxQH4QRe6rrSZBhl3VtNz/2CMySW1Igwq5Pmzg21
         lYN5EGMD0Wt474NV2APViisvvWdVL7iX8wOANoadWPqXBL53RluXrzIIFgCFDUwf3a3s
         WUc9tu7A2tpkT/VGT/MZHacAOwZ8EzQlSQ1rn1VH1OOdf3qvLVMaQti0GcQrhl6NRW5Y
         SD/mAVWHEYTZlPCewBP5i4COlrIM/a8pIQSkY5BUi8owHu5oFH7RTfJH4cwKdtVHyCHJ
         p/riACedN+6vAYV9Pxi0zKWuNYLMIwVhL+Wr8Q1HQROlvBoA4/tVhiyD1l3rtIcrJJUQ
         WGyg==
X-Gm-Message-State: AOAM5332alCF31kbPRIYdo5pn0gXv2hCL1x/pyuB5wP5mXJ6B68fPZIv
        6gRUcLNJ8cUgsDqWAl4DeEp4rMY+E1o=
X-Google-Smtp-Source: ABdhPJwRdKV+qld9EoSdXM/rONpKUyn/dBrwD3O9Ko6Zv8x97TcPB2KqF6lFYH6Jo9a4Uob1ak+YYQ==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr12948668wmb.139.1602545167925;
        Mon, 12 Oct 2020 16:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm14305146wrp.90.2020.10.12.16.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 16:26:07 -0700 (PDT)
Message-Id: <bb2317972a8faf0358aaad1247fdfd2af2ea142d.1602545164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 23:26:04 +0000
Subject: [PATCH 3/3] test-lib: reduce verbosity of skipped tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When using the --run flag to run just two or three tests from a test
file which contains several dozen tests, having every skipped test print
out dozens of lines of output for the test code for that skipped test
adds up to hundreds or thousands of lines of irrelevant output that make
it very hard to fish out the relevant results you were looking for.
Simplify the output for skipped tests down to just showing the one-line
descriptions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2aca398e1e..7602bbe9e9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1059,7 +1059,7 @@ test_skip () {
 				"      <skipped message=\"$message\" />"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
+		say_color skip >&3 "skipping test: $1"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
-- 
gitgitgadget
