Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C16C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC69E64E38
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhB1T4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhB1Tz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE2FC061794
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so17975212ede.0
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHkeNJfkkFOHAcMKOT5k6gihFN2GVPOJDBxsQt8hTlw=;
        b=RYWYDC67qDNEJTYxSvwiR3xxL100SDgpbQpPkYBhHcUQUWq+MY5pQ5KcwnI5GBFcSG
         xFE/uB7NyO/VKb7jnKHNmF3EgFrFSxzwAhX1J0DPvzwSl7/lXz4DDyUolGoNgN8Qmusa
         R8DhQkXCIhq7L4AMICsAIkudT0so78Po+DBWfWxtoMmsrFBsnC3+52g6fjd/o4Xkt/df
         uyA0omphDOn6tWDXHMMz89QpA86+tdnioTRuzFrsMXMT32Phi5cuNBb4SbBuoIBS6klA
         cWWlXRZJatha5RJjv1hZ28OiVVIKSDV40Gb21H/ul2PPhiUTW6jPjpv6S0DQeHURy2Cs
         N9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHkeNJfkkFOHAcMKOT5k6gihFN2GVPOJDBxsQt8hTlw=;
        b=aFCaYL7ceBrCDaTCiPZpkEd4Nv72s+Y+uNqGXfBVQPl4BsGEVYQj0d8un/F6a3AXVq
         8/gl3pmfUF28ySalMbrf+har0OInXSFiNERfQ3IbL6C8NbN2y3rwgrnK0p4df8LfosG1
         I7W6ATdU65GmgWaGnbJyTsruii3drYI9Mr1x2sdGa4kwIO2FD8dLS+UkKTs1N+ysiYs+
         Q0POjLkVJlgs/fVxB3cFkMq3GiGFZDJSokEtsZYePyeJEZheruejMFuoqTnsxPPlCyr0
         lC7xlb+Ypx75gHdbQXChfdgWcL7CyoTP8VyE8SMxokPBGr5JnNujZ02NBgAf96jvXMWM
         D/MA==
X-Gm-Message-State: AOAM530VEDMi1w6QgJvDrvhWpTL0p47hzRmTwr1lVjgT5zDnqcatPIk0
        BKV2DK9pLQ+ivzu0JrmK9XDLMTboFdSU2A==
X-Google-Smtp-Source: ABdhPJyowtZGNanRZ0hd4606hQ+zxe7OyE0ZwA8hAPQHgKw90tZU+Ff8lrtXvR82ZcRHlMGRAw1IcQ==
X-Received: by 2002:a05:6402:445:: with SMTP id p5mr13511483edw.20.1614542080395;
        Sun, 28 Feb 2021 11:54:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] svn tests: remove legacy re-setup from init-clone test
Date:   Sun, 28 Feb 2021 20:54:12 +0100
Message-Id: <20210228195414.21372-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the immediate "rm -rf .git" from the start of this test. This
was added back in 41337e22f0 (git-svn: add tests for command-line
usage of init and clone commands, 2007-11-17) when there was a "trash"
directory shared by all the tests, but ever since abc5d372ec (Enable
parallel tests, 2008-08-08) we've had per-test trash directories.

So this setup can simply be removed. We could use
TEST_NO_CREATE_REPO=true, but I don't think it's worth the effort to
go out of our way to be different. It doesn't matter that we now have
a redundant .git at the top-level.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9117-git-svn-init-clone.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 044f65e916..62de819a44 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -7,12 +7,6 @@ test_description='git svn init/clone tests'
 
 . ./lib-git-svn.sh
 
-# setup, run inside tmp so we don't have any conflicts with $svnrepo
-set -e
-rm -r .git
-mkdir tmp
-cd tmp
-
 test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-- 
2.31.0.rc0.116.g45ec00aa00

