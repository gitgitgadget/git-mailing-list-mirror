Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E64EC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6771A61205
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhIKLTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhIKLTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 07:19:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40E8C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so2389595wmh.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5HCiHpeQZ49V5miwIkorHOuQElq0vl4DcKXh4bDMMI=;
        b=CVsiaAlSkTEXIgL7es4OWtwJC0qcYjPmAEI1hVUeB+mu1g1cIwhkkHdiqT0vtdz1K1
         YJvnQdj7qnLUPFlo6LL6wHve38mGweb2EbmuexmN7xPkNyFCrB4oh4IolRKH+aDHe98p
         atx8eJd3tDD7lAW3tlOesPVoHho/Wi4F6AkLC4Eh8TvB/tx8QU1a0Fd7Im6hZtiOC52j
         Px6zlwy8ZR9yFsru70QnfmnTihPkN2fIKdv/JdrIBm1bGSj31rpvLatxS3rEi3khTkv7
         TTo0fZZLkENdc86M+2OmB5og0UnVnEjUZ154GP/6Js1uOL05okKoqmDh6bjOnJn0QB02
         AMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5HCiHpeQZ49V5miwIkorHOuQElq0vl4DcKXh4bDMMI=;
        b=NG0bQtHyZjEye9stWIzHHjdLqi69xD9c6WQWTM+JpD8JbSHAmCJ4i0vXrLuOLtLu8Y
         XiiMNTk7/NKnx4CFBXyb8uBweTRbuzW7lR9et11IzPqKDSrzt3BKCoKRSxHWTxuMxDnO
         OrXvDEaDuEiXDP+WopdVqPFxyGtzqhaeM4xAnsep8Ba9QqSgWPV3OHV25lypSlzBD4Q8
         Bag+Ao5VM3SEgZm/51l8warESIJuxAMTwFAsCWPOXZclV7RUOACq8jgczDq51+0z4YEy
         dwSsZfdeR36dKf69Oo3stS9pxCmGd/16RED3o/m/wOFn4pB+bEs4WgzVHEGjVhW8vfGp
         L1NQ==
X-Gm-Message-State: AOAM5330H7SMTEcKIWhxPlmTKfIUV9YbmIleKCxphK89g4dtAURW7gjt
        QPbhFJvZrmqozm4BRo7nNNvWTS3cB+au8Q==
X-Google-Smtp-Source: ABdhPJxS2d8Z+A6bH9WRdZDxP6KfqCOjMCzJ+4Pu5nn37K4lDtHq6HB/bcBm06m+SEguV5PYZZBu4w==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr2367506wmf.22.1631359075254;
        Sat, 11 Sep 2021 04:17:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm1549731wrd.25.2021.09.11.04.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 04:17:54 -0700 (PDT)
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
Subject: [PATCH v3 2/4] git-sh-setup: remove unused "pull with rebase" message
Date:   Sat, 11 Sep 2021 13:17:49 +0200
Message-Id: <patch-v3-2.4-db7223741ec-20210911T111435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "pull with rebase" message previously used by the
git-pull.sh script, which was removed in 49eb8d39c78 (Remove
contrib/examples/*, 2018-03-25).

Even if some out-of-tree user copy/pasted the old git-pull.sh code,
and relied on passing it a "pull with rebase" argument, we'll fall
back on the "*" case here, they just won't get the "pull with rebase"
part of their message translated.

I don't think it's likely that anyone out-of-tree relied on that, but
I'm being conservative here per the discussion that can be found
upthread of [1].

1. https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 10d97641856..cee053cdc38 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -223,9 +223,6 @@ require_clean_work_tree () {
 		"rewrite branches")
 			gettextln "Cannot rewrite branches: You have unstaged changes." >&2
 			;;
-		"pull with rebase")
-			gettextln "Cannot pull with rebase: You have unstaged changes." >&2
-			;;
 		*)
 			eval_gettextln "Cannot \$action: You have unstaged changes." >&2
 			;;
@@ -242,9 +239,6 @@ require_clean_work_tree () {
 			rebase)
 				gettextln "Cannot rebase: Your index contains uncommitted changes." >&2
 				;;
-			"pull with rebase")
-				gettextln "Cannot pull with rebase: Your index contains uncommitted changes." >&2
-				;;
 			*)
 				eval_gettextln "Cannot \$action: Your index contains uncommitted changes." >&2
 				;;
-- 
2.33.0.984.gea2c3555113

