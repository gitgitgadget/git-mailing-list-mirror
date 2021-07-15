Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1CFC1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64305613D2
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhGOCf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGOCf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:35:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1364C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:32:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v5so5640491wrt.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cBXAr4C9PhS8HT7XeRkrKFLUcx/iLJNZS1aFIEbfMs4=;
        b=eAmNir1nQGLrJU0ZlHGRPImMWJsTMhbHQdYM9r4HcnPteyeqfBnThCkiD6IiMEf57a
         D6iUhHPoHdCheB9m91aNmSWSufXl+DjRZj5r070GeSoYwzivtVxfB8wjGJnDlP1E4Esu
         sHGmri1+Pg/KfS6tL4mWHnkEtPULdTVGI9uWH0kYVXPdK4C1toKYZskyQtghUlZKKBi6
         fDdD3jhArY/4BHbaNNdjuQV5vUidJjpiiWhiBShBACqnggQcXUgNPByWrQSnNwzvSoyg
         BqHF4WKSXQwhW0kezNNz/H69Vz/2ZFgTeON5qEnA+TxgbFPgR9mtPW8adEgA2T5CWW/f
         jsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cBXAr4C9PhS8HT7XeRkrKFLUcx/iLJNZS1aFIEbfMs4=;
        b=QztDPFeIvm/u2UX+db38YJnBTvXT7Dyvi4SnxxejO2huhoQuxJdBo8gCAtMDNHAvPd
         OgFmxiY1RQZ8TEUH9PGvyPY9zqPivN7cwBsEjlXYrTvl/zxF4pJyOnklMwkgkia3kdMz
         Z0ATS1aObO2h93C558M5pdcyQVOu+7rYXiTPmo5kJEVWyiK63can9TfbdSl7Pw3zviHp
         uB2mQ1F6fErrkC+6ls8VpyH+tpgjzmauZiC0DKOudmbtYZSKQzwBpxvI33bC4npoVO7+
         yven1BHXBsZQrbo7hTXKUgdq6kA7jAyDnKOKVxxOSqj1uTjIknGP6kWKOARflq8r3bz2
         a23Q==
X-Gm-Message-State: AOAM5322OKs73Q7A9iRvRsQ/CorpL5bM/eyPb9eeOJUJZFrPFzkvS58m
        K1gxaT2XQKDZrHZn/1ZixC3etZ4aC5s=
X-Google-Smtp-Source: ABdhPJyMA3TST0BOWsgoGIbzAFJvKgO7MV8SmMu0LsSr8S6CzINpat9VDHTqiGkhiyH4prk5BrvEnA==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr1657633wro.279.1626316353320;
        Wed, 14 Jul 2021 19:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f130sm4346770wmf.23.2021.07.14.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:32:32 -0700 (PDT)
Message-Id: <5618933279dadf48ba51b79fc11beec8c163820e.1626316350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v4.git.1626316350.gitgitgadget@gmail.com>
References: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
        <pull.992.v4.git.1626316350.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:32:28 +0000
Subject: [PATCH v4 1/3] t2400: clean up '"add" worktree with lock' test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Manz <smanz@alum.mit.edu>

- remove unneeded `git rev-parse` which must have come from a copy-paste
  of another test
- unlock the worktree with test_when_finished

Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
---
 t/t2400-worktree-add.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 96dfca15542..93d3795cab9 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -67,8 +67,8 @@ test_expect_success '"add" worktree' '
 '
 
 test_expect_success '"add" worktree with lock' '
-	git rev-parse HEAD >expect &&
 	git worktree add --detach --lock here-with-lock main &&
+	test_when_finished "git worktree unlock here-with-lock || :" &&
 	test -f .git/worktrees/here-with-lock/locked
 '
 
-- 
gitgitgadget

