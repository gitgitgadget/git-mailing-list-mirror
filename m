Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D3C41621
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F020754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK+6+w/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgCVA4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33208 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgCVA4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so4252074plq.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4r5h7d5t7HeFYI+CcFzH9VHuXdX2rvucddR1DC5dXec=;
        b=lK+6+w/wkBP9Gsej/GlHbWJraPPIVwkC7AHwRrxzkf01HahClKQ9N44taxnjGNKADT
         BbhSkW2JycoGKYozYQOG17KNitii2uiNIle0GF0yIGU91ShzFUIo+D8vdFb14gAqEEnu
         NBk9xUSJ57LYPLCjz3uCI78lhqS8Cc93lBtFoReU3bxY+ncMYIdUMUlZ8abQ6RSykDl5
         HnjQJQMwoEk4fRzSxh21dB6DKSGc6vA7WvtW5hAbXLieFW2Vgz9Fm56RT04ye8yLspwj
         lTJBWoheqNWHfuIwt9emFKEm7t91XDqx7o14uUBsDcGE6IunQBMDLGQEdo7uiqmwKSVi
         hWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4r5h7d5t7HeFYI+CcFzH9VHuXdX2rvucddR1DC5dXec=;
        b=MluDW7EEbo76C9D3x0064w83Wj54ZNqV2ec9hHJELteMmMkx6mz9AYB9wQR/2XKDoO
         c5qGeYC4AjpO29MIKPCzayIh0c9oVsccd+ZZxGrw7Zaqo5J7s6Ab3AlOiczcwr+X8Fho
         FyVIlE6DxVjsuLpOjrsbgDQVLAkKF7nGRI1MickYKfh6PcNQlQfYWpZxshoiQLVF43et
         8cqqH2o9n/SJ6MNmH7jqcVfWRlz9is7WwoX2pTP7eHjqzztRUvPVBBlu07LLfffYbV7I
         /sZZCyjmyOxB5/hO7FG4O2Oz0v92bD8U0uBFJ+C33oochoAhglah1sr6UzLpnc2ed1Vs
         Tbxg==
X-Gm-Message-State: ANhLgQ0lWpB7PLxWl1oi65An1XsTQLMTbOoTOEMTyQFhQXrxDzDRuxAS
        ngvFZc2jx0C8w2X0dYZriQDuw/EU
X-Google-Smtp-Source: ADFU+vtpNezxUMPTDsUkUy9/KD5Old5vboyjpXN/Rda+Z9xmSrVInRSSO3DHIxOHfgKTgTiWGJuK1w==
X-Received: by 2002:a17:90a:2a06:: with SMTP id i6mr15590836pjd.99.1584838562468;
        Sat, 21 Mar 2020 17:56:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:01 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/8] test-lib-functions: test_cmp: eval $GIT_TEST_CMP
Date:   Sun, 22 Mar 2020 07:55:12 +0700
Message-Id: <9d3823e84971e7f96b4f502d1f5ff54c70c59144.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shell recognises first non-assignment token as command name.
With /bin/sh linked to either /bin/bash or /bin/dash,
`cd t/perf && ./p0000-perf-lib-sanity.sh -d -i -v` reports:

> test_cmp:1: command not found: diff -u

Using `eval` to unquote $GIT_TEST_CMP as same as precedence in `git_editor`.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52..ab0e47ae17 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -905,7 +905,7 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp() {
-	$GIT_TEST_CMP "$@"
+	eval "$GIT_TEST_CMP" '"$@"'
 }
 
 # Check that the given config key has the expected value.
-- 
2.26.0.rc2.310.g2932bb562d

