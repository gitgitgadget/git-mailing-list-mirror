Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEACC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B53610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhHBQx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhHBQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62FC06179C
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h13so8769644wrp.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cCEtgnI0jQA7qCA6yUWu3EmKTcFWr+2kEe8m8HQzJUg=;
        b=uVo7gOa05v8+Ab5xC60GMTowmaWKYwqBhkYRsELVSzOQcVybZPHuPaRYBYdG7ARPJ0
         CGC5z6C/VncsBVbJKbf9UrYGQ0XQwVGtUSFssITk2Zu7ZYIIrzpyiC8Afqlb1ZQ0/5ag
         6/KGmDJlEjTbbTre6xdimg7k8oiSvf0Z6Euz+3q5PnKEHymyx3peBdE3iDKW2xTTABk4
         9dsziH8MY5MocIXAL4+H4YOf56VLX+s1KVkpyx02u7jbeXOacPD358prCqVFpPMyy3tL
         N63q325+ST6yW7h1tbD5mxPoyn0W87sv15oX8cw1oP7mJnUH3Wj3QCYbfLe7uVmO+M8T
         Qm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cCEtgnI0jQA7qCA6yUWu3EmKTcFWr+2kEe8m8HQzJUg=;
        b=BtFSJwcfJ562iGWB3xP4o1U8iSKewgQPgNMZWtlToHTE7o6fTCHMxny8IHR5sjE1yN
         7kbCfNxXo7F7nroRIpu1z1ulMO0XXYq0R5PLtyeQqMc3SJMrn/O690adL8Q9G1o0NKJ1
         3xcH4nPFtxbncsVw5GKehH+jaT5Nu/dAHfVngjsLFFCCXW5/y7lKkOEvE1e0M3tk8ZwM
         lgTMx352AAdlvPvqGiOUHey5fvigbHOKC5mzO2uM72rueNfaG6YPAest9gzS2r2Ndpth
         GyUDvUoh3sR/5Zz/l8zvX26D+w8NHXM9EITO7x5womQU2qB8xsa7LlwhIDQ105MX9bnL
         0glg==
X-Gm-Message-State: AOAM530UzrpjbudC0dazfmqNXpBI0awLf16UpMXncsWj3SMWmAywLCpi
        bs+jnX0r0TyQ6EcuK9NL9P3HWV9eaaM=
X-Google-Smtp-Source: ABdhPJyJ1Rgtv/BkEAvq8wVKz3wCeu3QmR7ylkL9Ji0JtqAobjYd4fa7DvCpNvWFG/VjFJqhxdB67Q==
X-Received: by 2002:a5d:688e:: with SMTP id h14mr18353345wru.117.1627923222069;
        Mon, 02 Aug 2021 09:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm2162336wmi.13.2021.08.02.09.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:41 -0700 (PDT)
Message-Id: <5f9a01fd86aa52db48176ee347abdca394af5f14.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:32 +0000
Subject: [PATCH v3 07/11] t1405: mark test for 'git pack-refs' as REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The tests verifies that "pack-refs" causes loose refs to be packed. As both
loose and packed refs are concepts specific to the files backend, mark the test
as REFFILES.

Check the outcome of the pack-refs operation. This was apparently forgotten in
the commit introducing this test: 16feb99d (Mar 26 2017, "t1405: some basic
tests on main ref store").

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 92b04873247..49718b7ea7f 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -9,12 +9,18 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 RUN="test-tool ref-store main"
 
-test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
-	test_commit one &&
+
+test_expect_success 'setup' '
+	test_commit one
+'
+
+test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
 	N=`find .git/refs -type f | wc -l` &&
 	test "$N" != 0 &&
-	$RUN pack-refs 3 &&
-	N=`find .git/refs -type f | wc -l`
+	ALL_OR_PRUNE_FLAG=3 &&
+	$RUN pack-refs ${ALL_OR_PRUNE_FLAG} &&
+	N=`find .git/refs -type f` &&
+	test -z "$N"
 '
 
 test_expect_success 'create_symref(FOO, refs/heads/main)' '
-- 
gitgitgadget

