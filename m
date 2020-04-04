Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42763C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A73E20787
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1M05W5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgDDBMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:25 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46338 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgDDBMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:23 -0400
Received: by mail-qv1-f65.google.com with SMTP id bu9so4574740qvb.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y3JpD1BmGlEgxfNhigHedIBI5YZ1431gBF8qqQU816M=;
        b=q1M05W5+ZPyxwEs2CAwUMdYonBSe83Th+gflSB846XvdgelJPz7m0X2DOQDK8JC7LY
         gjPFU3qu6JTLPpNnUC/MTJzekOTHMAVXwUg8LtA8xcvCtz/JmpqG2l+xZdV/kAahz93a
         jKrDtecdGOQZkxMXC/hMKP7eiJ3vOpDyIgSvThDsLLa/NXzz4gXw0c3ss3aUdhDnntZ2
         RJAtE+bQ/A/MnhzwnQeEc7DSPnE/777Xv9qNmtzh4/TKQ3Syj0h3ZjTZRLPDMFWiv8gk
         WVpRip4szhZA2LFoe9IG95kZGkyRwwzDjoBYs5e+Kca3kkE1P4lXKjbnnuIG7djrXh1W
         CAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3JpD1BmGlEgxfNhigHedIBI5YZ1431gBF8qqQU816M=;
        b=kX00MfFCCy/9poWcuAi1Eqmf7jTIjpsJtlW4NtsMkRqnmw/4Mn2TslDr3dsX5W7CNr
         M1chtTRYX9YF5+E1teKfPUiyJ0CdgsDtJiANmrXjqeXsjUr/xnJGUTjtxtuZCNPlq4Bk
         75M+DBUI2zUqd5m6GLERl6dcKUCCB/utHSx+hzH/+dEVA4SXwaoLgpRPPbsRFhJtCq/8
         TZJGfKlNru7z0F0+3arV4Iz/pGSKHqIU9lLuEBB+PJUPasp1JdGYCtyAGZVOWw/3e9uI
         OmlW7gZYmC1LWaW/kRU5gx2u1r8JI+eEKWQxKG2hIz7LRGi/2XqVpx/m0YThnRBFB6OC
         QqgA==
X-Gm-Message-State: AGi0Pual+uyF94ODoBlRqjSUW85fAyA3Z9sCwzJ+NRyA8NOpUSBqZWnd
        zFLr2JAWtxGgLi5gdv+OiKNkPJ5f
X-Google-Smtp-Source: APiQypILVaMO44g35dnaREs/IBwZTdQtuVlqYmrm+r4UuOWBEQE0CIvX/IWvPIk0UK7E5EVDF/DPnA==
X-Received: by 2002:a05:6214:1e5:: with SMTP id c5mr11172489qvu.233.1585962742200;
        Fri, 03 Apr 2020 18:12:22 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:21 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 22/23] t5520: make test_pull_autostash() accept expect_parent_num
Date:   Fri,  3 Apr 2020 21:11:35 -0400
Message-Id: <f1e54622fbd9e7a3e94fa97d758e39c01b97b1bc.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, test_pull_autostash() was hardcoded to run
`test_cmp_rev HEAD^ copy` to test that a rebase happened. However, in a
future patch, we plan on testing merging as well. Make
test_pull_autostash() accept a parent number as an argument so that, in
the future, we can test if a merge happened in addition to a rebase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 2f86fca042..f610dc14de 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -10,11 +10,13 @@ modify () {
 }
 
 test_pull_autostash () {
+	expect_parent_num="$1" &&
+	shift &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
 	git pull "$@" . copy &&
-	test_cmp_rev HEAD^ copy &&
+	test_cmp_rev HEAD^"$expect_parent_num" copy &&
 	echo dirty >expect &&
 	test_cmp expect new_file &&
 	echo "modified again" >expect &&
@@ -369,22 +371,22 @@ test_expect_success '--rebase fails with multiple branches' '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase
+	test_pull_autostash 1 --rebase
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
@@ -422,7 +424,7 @@ test_expect_success 'pull.rebase' '
 
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
-	test_pull_autostash --autostash
+	test_pull_autostash 1 --autostash
 '
 
 test_expect_success 'pull --no-autostash & pull.rebase=true' '
-- 
2.26.0.159.g23e2136ad0

