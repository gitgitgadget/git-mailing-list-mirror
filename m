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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20958C43462
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E890C6101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhDSKxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhDSKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C91C06138A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so8331932wmq.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bp5AIwcRTPdgJs69D4au2FynlT9u6XNqahdftzLfIZI=;
        b=Q97lVIfG30Hosp/IXHe4Vtktf19q/LrNnIR/G/HdHVFQixAsGNA9iDZkZJPc/LiDP/
         jI+F+8ZEq9nL2Tpaxc3xjLI2/Z2x3N03IyozwG5zPaXyIZfTX6MRK3mpsliEsaHkWL+5
         fq/DdHl63IK9bkcNTX3kCTPcZLFb1w8ExZg6tAsA/k31Kay9x2s2dVArGm3Ptp5jnYWC
         EIBDJu18MgncMGGhcEwxi1+dOE2Epg2vymaxkMcyLVQ8ltUP5PqtG2VuueuH0ms0UjxR
         qVI5Ic9CyBnyxwxpFJzwxF8JuME+8+ATJEeuy/5L7XmC2iJMSSTJC4U+2qR/QPX4IV3W
         X9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Bp5AIwcRTPdgJs69D4au2FynlT9u6XNqahdftzLfIZI=;
        b=Q3X4j+yXrGgDd4RJrMZReCmBFRvRouwAIqMuuxf76HNj5wADZOht32EYhCD/qS0tXB
         OzhpsPcWPso/2IOB3pbtt/AB3PZU2KHndd56r1ohh8N/HcqKmxMMyCEAhYI1vFvUebmZ
         4awKaQN8YSts43DO4GzYGgt4fIILINU8OoSBCjoziOvfGTOS7HHWIJR/eeWnQY3A4Yqk
         9Ch8Bt6ml3S+H0gRhtNXQk5KFtI1kljmXmYXfaJfvFkfjEq7tJ0gKpgHp9jaJpGQeICW
         lJnZs6TyupC9V8Rtl14V3k7GKPZFIBWTtStlp82GVp3JDJ/ppn5/19aaY6EH1pCV3yYT
         QNtw==
X-Gm-Message-State: AOAM532SEBxfakSZthrcs31GMjI9P5ZBGRGpHSPE40NUHqB5vexGaNSk
        m/N0lIzOhieUlYjaeP8fZfUSZfEfUd4=
X-Google-Smtp-Source: ABdhPJylsanjuhzeH6/5pNVxSxt3S0AGrLMvAS/5NCMyTTQYJ13pWfn/NwZTtOWcsKiabZw9AvRuSw==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr18988892wmj.111.1618829586851;
        Mon, 19 Apr 2021 03:53:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm22196905wmb.32.2021.04.19.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:06 -0700 (PDT)
Message-Id: <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:49 +0000
Subject: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1401-symbolic-ref.sh | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index a4ebb0b65fec..fd5980d3fb40 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -7,18 +7,13 @@ test_description='basic symbolic-ref tests'
 # the git repo, meaning that further tests will operate on
 # the surrounding git repo instead of the trash directory.
 reset_to_sane() {
-	echo ref: refs/heads/foo >.git/HEAD
+	git --git-dir .git symbolic-ref HEAD refs/heads/foo
 }
 
-test_expect_success 'symbolic-ref writes HEAD' '
-	git symbolic-ref HEAD refs/heads/foo &&
-	echo ref: refs/heads/foo >expect &&
-	test_cmp expect .git/HEAD
-'
-
-test_expect_success 'symbolic-ref reads HEAD' '
-	echo refs/heads/foo >expect &&
-	git symbolic-ref HEAD >actual &&
+test_expect_success 'symbolic-ref read/write roundtrip' '
+	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
+	echo refs/heads/read-write-roundtrip > expect &&
+	git symbolic-ref HEAD > actual &&
 	test_cmp expect actual
 '
 
@@ -42,16 +37,16 @@ reset_to_sane
 test_expect_success 'symbolic-ref can be deleted' '
 	git symbolic-ref NOTHEAD refs/heads/foo &&
 	git symbolic-ref -d NOTHEAD &&
-	test_path_is_file .git/refs/heads/foo &&
-	test_path_is_missing .git/NOTHEAD
+	git rev-parse refs/heads/foo &&
+	! git symbolic-ref NOTHEAD
 '
 reset_to_sane
 
 test_expect_success 'symbolic-ref can delete dangling symref' '
 	git symbolic-ref NOTHEAD refs/heads/missing &&
 	git symbolic-ref -d NOTHEAD &&
-	test_path_is_missing .git/refs/heads/missing &&
-	test_path_is_missing .git/NOTHEAD
+	! git rev-parse refs/heads/missing &&
+	! git symbolic-ref NOTHEAD
 '
 reset_to_sane
 
-- 
gitgitgadget

