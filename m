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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60700C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430E061051
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhHJJc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbhHJJcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1394C0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c9so25309554wri.8
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5eauvRzKXs+QohIxCKuhe2Cg3rOlP7zCo/M+3cntNo0=;
        b=D/5hFwtlY0VhDys4s6E3feCJU8C5G4ns7VP8t+bn2jdGUK1eKRuEwnl/FV12pC3CO9
         QmhuK4zcANMnNP9WDbGEcb7stEJPsUaqveHWQZJE+x9z+FkYtJuaqWIwK6A3J8uB6xKc
         NBjJPVuDDPaoPVmd6qkOhXgGrypBZaq0hGDs2D7iW7gepR4/C7PVyzPGaFN955jE788u
         lrTtZeT6CDDZKqQT2RP8lvj2cHHCcPaUbsx0Ge2CkSsD2R9E0n0zKOueqJ4wEI/sAffo
         xnGk/7YVu1TfW8O0SbFsGo6m/XoWNDGrAPwHgz1jU8C9Lw5JqkMYWScpsk83unTDPaXf
         v6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5eauvRzKXs+QohIxCKuhe2Cg3rOlP7zCo/M+3cntNo0=;
        b=p5BAsk5wOn5VXk4tLZ+mesAw8qztxWxMTGrvJ++uHHDgb8QQv09r3RpQoH8DKgzoh+
         +MixrTfnhLPh51/YHF98bDrZ9JMs1cMrj45T0M4DFSr7go9xhZxqwTgOXrPDCd0Lec4t
         5ngIZb7pm5DWhzk+w92Z+mca+NsLf966Dk243AxFyy6juMEsDRcKx6GCszsVpAz6Zgb6
         fxeirBIz8bpnBjaAgIrQXFRDv+5DkR+VtNfjlPqU768mOezBQlcKLhVAz8GE+hkNs94j
         EqI6WN6QlDab6ZOvq62zg8JZqj/lx7H2AvL97QFRPtBlnCBogNE09I22NFYdSK92Y8Ky
         ZwGQ==
X-Gm-Message-State: AOAM532hZ4IemvGh0ZZVibwMmgbwRZ4QQ98wBHzvhztMg6aYEaMOcmHL
        DiuRv4BH7BJ9GzS73d1yqlBUUX/+lQ4=
X-Google-Smtp-Source: ABdhPJwfD7veObq5TDL/IxxDcR7EbJl1OCN4SP8GWqQt73+iVMJ80AAC0OYbh47MT4MpzsUl5tk88A==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr2107731wru.313.1628587921369;
        Tue, 10 Aug 2021 02:32:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm23031542wrv.65.2021.08.10.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:01 -0700 (PDT)
Message-Id: <f7722dab21dafb73e64754b1286913eaa826f865.1628587917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 09:31:56 +0000
Subject: [PATCH 2/3] rebase --apply: restore some tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victor Gambier <vgambier@excilys.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

980b482d28 ("rebase tests: mark tests specific to the am-backend with
--am", 2020-02-15) sought to prepare tests testing the "apply" backend
in preparation for 2ac0d6273f ("rebase: change the default backend
from "am" to "merge"", 2020-02-15). However some tests seem to have
been missed leading to us testing the "merge" backend twice. This
patch fixes some cases that I noticed while adding tests to these
files, I have not audited all the other rebase test files.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3403-rebase-skip.sh     | 2 +-
 t/t3418-rebase-continue.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 6365c5af2f7..a44e68d0ffb 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -52,7 +52,7 @@ test_expect_success setup '
 	'
 
 test_expect_success 'rebase with git am -3 (default)' '
-	test_must_fail git rebase main
+	test_must_fail git rebase --apply main
 '
 
 test_expect_success 'rebase --skip can not be used with other options' '
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index f4c2ee02bc9..e4cb8be0418 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -36,7 +36,7 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	git reset --hard &&
 	git checkout main &&
 
-	test_must_fail git rebase --onto main main topic &&
+	test_must_fail git rebase --apply --onto main main topic &&
 	echo "Resolved" >F2 &&
 	git add F2 &&
 	test-tool chmtime =-60 F1 &&
@@ -254,7 +254,7 @@ test_rerere_autoupdate () {
 	'
 }
 
-test_rerere_autoupdate
+test_rerere_autoupdate --apply
 test_rerere_autoupdate -m
 GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
 test_rerere_autoupdate -i
-- 
gitgitgadget

