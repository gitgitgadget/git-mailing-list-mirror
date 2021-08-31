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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53CDC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BE860200
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhHaP4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 11:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhHaP4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 11:56:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6210C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:55:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2982051wma.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Sp4BQgYCM1lCLOHRRf7wm0phxQ8pdP3xhDyqfhUyU2Q=;
        b=D/wRswTlyjCPwVDKCJskHFE9p8EVmo5ucd1hupyeYDj/XBnIyNSdvxHAFfG9hhDV/Q
         ulwGjXONpby/Og6OQ6/QQloojllfsc4AbETbTONkt/pHvMc4go/S+MUoDvqsDn73YZkk
         XW97qDdkhFmHU4Dye63QADn3EhDtQIscGJq9K5W8FHoOxqtTyoaIRMst/nIHEyWdP1Bu
         Fx4iUpOY8Jd/5pAHDygAPRYWW5R0kQvnmGNM1Fqr1GMqzB5CV35McXrQDgqq9NGGAYJK
         Br6nNi8tbO0iBx3xauGaypoMVQJT9QLZfYfzed2vasMVW7wMmc+UyLpbe4cWmKgvYVk9
         87Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sp4BQgYCM1lCLOHRRf7wm0phxQ8pdP3xhDyqfhUyU2Q=;
        b=njQc0twZ+dAxgVByP8Rii3HrLEdUOMP4xME4tanu/HNm790W0RaVRW+k4/5Pte0q5o
         MDUwr95EgLcyWoV4QliNCPJKmvzrwuZkDqVGcXQDk3plJxlvm2J3NSvyTW/KWjjnKJXe
         1KZ9++pKLCbOBMj8F1qc3osd+4XJcsElDQB2ckjr88xO+g8YZ0PIHY4537Ob/GKRduqn
         M4sJTy3PKMNbKKzvXT1cHx+f5JNdE0abD263cmc7XnGHwGnZUngfXQesdS92IdjNxbKp
         6ai9M635I4wghxRx0xaSv9pKc6EzYuWEex/hrOtCvKpnryKN1doH54anrwfe5wisH/zG
         UO7Q==
X-Gm-Message-State: AOAM531W3tl5LWi+P2yQbndIi8rZZSvhObpKsA0sQhUyjG5/L1qLyxXS
        H5fOOXTyZ/IqUlTX6p7QSCFhLW+N8dc=
X-Google-Smtp-Source: ABdhPJwdBsFTqqKMS5J9bi94Vdu5t5bzPBrFZVGJ0B/nxeQWT4+3fIeByvBfS/PyRKhUCB2UD0rH0g==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr4929648wmh.145.1630425355603;
        Tue, 31 Aug 2021 08:55:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm2753394wmc.19.2021.08.31.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 08:55:55 -0700 (PDT)
Message-Id: <pull.1030.git.1630425354496.gitgitgadget@gmail.com>
From:   "Tal Kelrich via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 15:55:54 +0000
Subject: [PATCH] fast-export: fix anonymized tag using original length
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tal Kelrich <hasturkun@gmail.com>,
        Tal Kelrich <hasturkun@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tal Kelrich <hasturkun@gmail.com>

Commit 7f4075949686 (fast-export: tighten anonymize_mem() interface to
handle only strings, 2020-06-23) changed the interface used in anonymizing
strings, but failed to update the size of annotated tag messages to match
the new anonymized string.

As a result, exporting tags having messages longer than 13 characters
would create output that couldn't be parsed by fast-import,
as the data length indicated was larger than the data output.

Reset the message size when anonymizing, and add a tag with a "long"
message to the test.

Signed-off-by: Tal Kelrich <hasturkun@gmail.com>
---
    fast-export: fix anonymized tag using original length
    
    Fixes an issue with fast-export anonymization, where any original
    annotated tag message longer than 13 characters would make the output
    unimportable by fast-import (as the data length indicated the original
    length).
    
    This also resolves a more minor issue, where if the original message was
    short, the anonymized tag message would be truncated.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1030%2Fhasturkun%2Ffast-export-tag-length-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1030/hasturkun/fast-export-tag-length-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1030

 builtin/fast-export.c            |  1 +
 t/t9351-fast-export-anonymize.sh | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 3c20f164f0f..95e8e89e81f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -821,6 +821,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			static struct hashmap tags;
 			message = anonymize_str(&tags, anonymize_tag,
 						message, message_size, NULL);
+			message_size = strlen(message);
 		}
 	}
 
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 1c6e6fcdaf3..77047e250dc 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -18,7 +18,8 @@ test_expect_success 'setup simple repo' '
 	git update-index --add --cacheinfo 160000,$fake_commit,link1 &&
 	git update-index --add --cacheinfo 160000,$fake_commit,link2 &&
 	git commit -m "add gitlink" &&
-	git tag -m "annotated tag" mytag
+	git tag -m "annotated tag" mytag &&
+	git tag -m "annotated tag with long message" longtag
 '
 
 test_expect_success 'export anonymized stream' '
@@ -55,7 +56,8 @@ test_expect_success 'stream retains other as refname' '
 
 test_expect_success 'stream omits other refnames' '
 	! grep main stream &&
-	! grep mytag stream
+	! grep mytag stream &&
+	! grep longtag stream
 '
 
 test_expect_success 'stream omits identities' '
@@ -118,9 +120,9 @@ test_expect_success 'identical gitlinks got identical oid' '
 	test_line_count = 1 commits
 '
 
-test_expect_success 'tag points to branch tip' '
+test_expect_success 'all tags point to branch tip' '
 	git rev-parse $other_branch >expect &&
-	git for-each-ref --format="%(*objectname)" | grep . >actual &&
+	git for-each-ref --format="%(*objectname)" | grep . | uniq >actual &&
 	test_cmp expect actual
 '
 

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
gitgitgadget
