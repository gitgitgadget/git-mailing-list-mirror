Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1417AC76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCXUys (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjCXUym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444415FF9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cn12so12711135edb.4
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTQxLyNjl4laCwmeKfpVSFxQ6sWy7Mb7svkCHfDZrMM=;
        b=Sj3t+igGmry8okDDE3br302aDMKQK9qoBvBuOUA2k/qtBH4bsmeZcb8D+GI3fQEBWo
         lmMKz5E830sZzU/3IZ8N+TTKPT+FdSs+WrsJZPGLTH6yTQ/yZPraWiLn/NQXZoWOgkjN
         +UTBDtUHUE78t7OdtTAbFEPIIppJUJCsqg1K7K+pCgHE8LnMXzguB2Y6fquajmAqBvIe
         Rxuz7Sez4vi2YzvPtFVzPXFmTR1TOmQoge0oOAgNSEuS0aIBURraonOtF3fgDa/T7gPT
         Mk12tXIQVLCg1VuyKWWpJloDOzDtpteJxtvWlzXRfloswb1BOBxd2OZrlpHdl6X3+rqx
         1jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTQxLyNjl4laCwmeKfpVSFxQ6sWy7Mb7svkCHfDZrMM=;
        b=H3wvd4/JvmgNp6rt7auYOuskUK5TtxOCjdFxDeWa+bdkWgQcvZ0OSn34P0kxOTWjjr
         Tk4THSxx3rkTyZmb3i85j/pp2gQFFiagnEq70oHBb99na+c+aRUjW5N82/ryy28wIQQW
         Ghy94nAqzdP45Inyilj6hdg6a0/S92IlWQjeJHnk5h8vGy+qFnT7j7f3EEQbwqLg15fg
         Oyit+pIqcwlXU/LbmI0u2LFsKW5JeD/WL10c0IQb+cqjfpSwsHuwzAgetCLGcqUNpl24
         DBqwbIKcDKy1fr7eXFP3CEyxqWg5keq9viZvVYN/v4mDfFkEQFb3NCoV/s+qAXY3HlQB
         6qyg==
X-Gm-Message-State: AAQBX9d/RNJ+VQ14l6AdFZol9nRUmzfN0vA2N41+VN6fPsFOBipkwEk7
        XvDiN0cQSkjGN1mUm/fvMimor6vqAjue4Rx5
X-Google-Smtp-Source: AKy350Y10UOnUy80CEABLIiVsqbmpNlbJW87ZyFUjY9WQwDW0LpEUHB05I07cdKFXsUeDVTWI2mCBQ==
X-Received: by 2002:aa7:cd12:0:b0:4fd:20ee:225d with SMTP id b18-20020aa7cd12000000b004fd20ee225dmr3821044edw.24.1679691279611;
        Fri, 24 Mar 2023 13:54:39 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:39 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/7] t1010: don't create unused files
Date:   Fri, 24 Mar 2023 21:54:30 +0100
Message-Id: <20230324205434.93754-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230324205434.93754-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Builtin "git mktree" writes the the object name of the tree object built
to the standard output.  Tests 'mktree refuses to read ls-tree -r output
(1)' and 'mktree refuses to read ls-tree -r output (2)' in
"t1010-mktree.sh" redirect output of "git mktree" to a file, but don't
use its contents in assertions.

Don't redirect output of "git mktree" to file "actual" in tests that
assert that an invocation of "git mktree" must fail.

Output of "git mktree" is empty when it refuses to build a tree object.
So, alternatively, the test could assert that the output is empty.
However, there isn't a good reason for the user to expect the command to
be silent in such cases, so we shouldn't enforce it.  The user shouldn't
use the output of a failing command anyway.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1010-mktree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 3c08194526..22875ba598 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -60,11 +60,11 @@ test_expect_success 'allow missing object with --missing' '
 '
 
 test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
-	test_must_fail git mktree <all >actual
+	test_must_fail git mktree <all
 '
 
 test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
-	test_must_fail git mktree <all.withsub >actual
+	test_must_fail git mktree <all.withsub
 '
 
 test_done
-- 
2.40.0

