Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE702C4332F
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0F261213
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhIKLTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhIKLTI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 07:19:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A4C061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so3274799wmq.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlDfm+S4r9jEmtIx4YrIPa0oY63pkQXSh2iijVbY4Os=;
        b=D1c2KQnb8bewK9cgRW0a8rH8tu1QAbyiwm1fMojKHeAWdRIlvJ1Lr8I+EcKagPPftU
         RvBQiAPTMRHyjB7cWhLl0qPQd0b3iGFt2DpUKls3vvt2OLHuxbbMzCY8iRl3jVAHEKrZ
         63fgMcRi3vpBFgx4r4oe4R0Dh8z8AqpVFfW8StJKQiF3nYuYKqQ9IZfAJ/GVIIcwSJCY
         lqpiJRtet+Lvu0PyVsTHejRAntzyZPFHx9h1KOcHeIDUx2UFmQIkZdnKTn9AifOCFQj7
         KDsoXGQ5nJ5q1UWc3UySeK4eBl8Ja8J/mD3ZlprMhvVzp3lQaHEwIHehiDD9qQKoixBH
         5/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlDfm+S4r9jEmtIx4YrIPa0oY63pkQXSh2iijVbY4Os=;
        b=xPKHyno9qmWcQssfg2LWQczcx7w4fcDfhhjRQ5RpXakZ7cDctrR6FkJebw1HInJxEG
         UhfS0PscGU16fKnWh30molw+ToZeiRiRwlYRRsB57iCPKbVaNULnjAzuOlJfa00Hb8sg
         po0hxwYG28jqwYghMvZy9RqQtMb+yNV9fSe+amj8DB8Ecghpx6KG0O55bE9wPCoFcTcu
         hoHWlW3qeelFqNDJVd2Sh1QCwjAFuc6YDt4qhZalMRawt08KDPGP2N+KuDLpFB1hwYrt
         Iq4GEsHBU4SPdXiSVKsFQK81LrQIcgX33Fp8/CTnUCHO4hywFosTOpl7jF/D29nuwSSr
         k2SA==
X-Gm-Message-State: AOAM530ApY0bYEYqCjCgJdd5cuN9rssXnQ6U4d20ZnCzjVmkhrBtwuwO
        XTc/5e6GKZt7A994LpurVx3Buk7v2O2Oug==
X-Google-Smtp-Source: ABdhPJw2DBcwRV/MXK25xI6LcxN1i15joRiUM0flYDhCc42cjhq6T2GK4qVpgRh2Gj0YB0lwW+b8IQ==
X-Received: by 2002:a05:600c:4ba2:: with SMTP id e34mr2407693wmp.50.1631359074310;
        Sat, 11 Sep 2021 04:17:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm1549731wrd.25.2021.09.11.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 04:17:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] git-submodule: remove unused is_zero_oid() function
Date:   Sat, 11 Sep 2021 13:17:48 +0200
Message-Id: <patch-v3-1.4-62b3a5881c9-20210911T111435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_zero_oid() function in git-submodule.sh has not been used since
e83e3333b57 (submodule: port submodule subcommand 'summary' from shell
to C, 2020-08-13), so we can remove it.

This was the last user of the sane_egrep() function in
git-sh-setup.sh. I'm not removing it in case some out-of-tree user
relied on it. Per the discussion that can be found upthread of [1].

1. https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index dbd2ec20503..aeb96c58243 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -63,11 +63,6 @@ isnumber()
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
-# Given a full hex object ID, is this the zero OID?
-is_zero_oid () {
-	echo "$1" | sane_egrep '^0+$' >/dev/null 2>&1
-}
-
 # Sanitize the local git environment for use within a submodule. We
 # can't simply use clear_local_git_env since we want to preserve some
 # of the settings from GIT_CONFIG_PARAMETERS.
-- 
2.33.0.984.gea2c3555113

