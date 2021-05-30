Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B7CC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 08:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51757611AC
	for <git@archiver.kernel.org>; Sun, 30 May 2021 08:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhE3IbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3IbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 04:31:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87512C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 01:29:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x8so7589484wrq.9
        for <git@vger.kernel.org>; Sun, 30 May 2021 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Zj6y2tx69KPI9cnJmJb0lW5fbtXK8OxNOiC95C+0FqA=;
        b=ahpqsyHblvS/71Rux1Tf1EWaXYXzeZykzj/7f8fnuJMfqmYQIRP4ShH5FphOoqc2J3
         3JuFeopGCU1mJkoPlD4EAtt5kHlDPHnJKAxH14zsGZMwmJDVVcwqzZ5pNfGBX1DU+E0I
         uYOqiKcNWeEOILVmNIvRIZzeLk/WCYLithj6Q7cbPzXSz4MQCZJAPK69NSF7Wl4h9czD
         88HoMJNJOgNO5iMPnBOQTBFYT5eXWasf+1wmlHWBzJGBsX4ihTJYAApluqK7qTlfVE5/
         AUHSFSE0gK3594dmipn1lXZmXTP6YSwZR4XUby3YPkUq1255Otq3VkkXx/HGyDdKkVyP
         ga+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zj6y2tx69KPI9cnJmJb0lW5fbtXK8OxNOiC95C+0FqA=;
        b=aWqNyyr7/5mIOB7MVuj0pB0Uw8shF/c0SL9n26/87bNDvod7hKqf+CDVefpnjY/eLA
         ym9NbPFBgABPHMpf9Il5IEXMeIWTH+sCOSxPw/E6RRqiJXebW1B09GW68PDTCM2jj7wT
         xHNz9mH9+F81i6lpNEmQoE7iRKWUc7uCNGQW7XJkNVBfsnBUOcRX1FwFfCJgNR3ljEOI
         NIMtA/ORpD5lG2EcWSiWdpLWTe+7mzZJdI5mfKKNwQgjGfNB7q9SRoDQo9x5coFeyCAi
         uEC48V6BmMBBaGJwPLq+Ma6X1Lw1I2JA+PtgcbLtsywGI2tfCK28i1fpSlmPeON+xRsn
         E5BA==
X-Gm-Message-State: AOAM533fMCpkmKUo5nCZFaohhA3apBCKewl9ASnkGKe7VBaOsVBbyvXx
        6L57m9uNBDAN9cVCt8DtYFLmJ++S4OY=
X-Google-Smtp-Source: ABdhPJysomn05o6FrUnYwP/JXKxlHYm2voln/sYEC4BfEzphK435buYk5yAfJJx0H3qKHVhLPsvK1A==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr16710083wrx.153.1622363367603;
        Sun, 30 May 2021 01:29:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm17727677wmq.16.2021.05.30.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:29:27 -0700 (PDT)
Message-Id: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 May 2021 08:29:26 +0000
Subject: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use `--batch` with no atoms formatting and use
`--batch-all-objects` at the same time (e.g.
`git cat-file --batch="batman" --batch-all-objects`),
Git will exit and report "object xxx changed type!?".

This is because we have a format string which does not
contain any atoms, so skip_object_info option will be
set if we also use --batch-all-objects, and then
`oid_object_info_extended()` will be skipped in
`batch_object_write()`, it cause object type to not be
collected. Therefore, it reported object type has changed.

So avoid checking changes in type and size when all_objects
and skip_object_info options are set at the same time.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] cat-file: fix --batch report changed-type bug
    
    "git cat-file --batch-all-objects --batch=batman" will trigger a bug:
    "fatal: object xxx changed type!?"
    
    Although we will replace the logic here in the future, this patch can
    help the old git maintain its functionality.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-965%2Fadlternative%2Fcat-file-batch-bug-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-965/adlternative/cat-file-batch-bug-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/965

 builtin/cat-file.c  | 11 ++++++-----
 t/t1006-cat-file.sh |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e83..5f9578f9b86b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -345,11 +345,12 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		contents = read_object_file(oid, &type, &size);
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
-		if (type != data->type)
-			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
-			die("object %s changed size!?", oid_to_hex(oid));
-
+		if (!(opt->all_objects && data->skip_object_info)) {
+			if (type != data->type)
+				die("object %s changed type!?", oid_to_hex(oid));
+			if (data->info.sizep && size != data->size)
+				die("object %s changed size!?", oid_to_hex(oid));
+		}
 		batch_write(opt, contents, size);
 		free(contents);
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5d2dc99b74ad..9b0f1ae5ef8b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -586,4 +586,10 @@ test_expect_success 'cat-file --unordered works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cat-file --batch="batman" with --batch-all-objects will work' '
+	git -C all-two cat-file --batch-all-objects --batch="%(objectname)" | wc -l >expect &&
+	git -C all-two cat-file --batch-all-objects --batch="batman" | wc -l >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 5d5b1473453400224ebb126bf3947e0a3276bdf5
-- 
gitgitgadget
