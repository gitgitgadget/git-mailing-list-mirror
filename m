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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FEBC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5F56128A
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFKUak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhFKUag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 16:30:36 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD7C0617AF
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:28:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so7046127oig.12
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq9yk0jmqYNrNx4ATe87xSPxfngX+qVabCUcvhwwLeM=;
        b=gIUNAeWOEJbSMIb5yJAT7lEpehOwTYtt6M8RkdDqRi/FnB/W3Vd5Ud0TIdSjLocb8I
         mauolw/QFqTx9sj30l2BzJ3qASWX7cA554NbeP6UlgsCyN2q/EAIAy8oJpE/cAUZoLYM
         dJZUbEBrbStFLBKgBg5OcSDYzicLMW3IzT5KJyTDXKlUX8lBUZyfn+4NxMvLtDJHbfVS
         7WGSHgj3qou+6AkNWGvM+llvDiisqxPandCDba+CQzDxeVatXu6H7M5sYyLA1+yVuCel
         rViz2OfLv88s7LXXltiB0kJPA2ShtVjluTssBkQg1SXPR7DYtoY4VAEApfx0wAwmgB9r
         h5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq9yk0jmqYNrNx4ATe87xSPxfngX+qVabCUcvhwwLeM=;
        b=eujsPQmJ2CyGLUjJ6UtxSL6nw++mchPEf+rmFV66fiRh11vjCynFAflqUI2q6MdzGk
         5BhReUvOWwQswKIlYyXWRoSVnRqOPdqugGZ42gpffmfFrnetANcuD4p9saAorq5rT4Wq
         4n/sCbvJNU3WUb5UkWw2/4kx6PqmFG97PevlngEedLk6q2r/pG8mApACqNnpfiuWQlTj
         gHLHRd7wlgdjiPvvfyCCicVXka4jkpiWz9fF6MdEvMtkLAKYYo/zpzGngUkUH0B+/rcF
         Hvwrxc0LRB9hSvCljM3C/ElNACwfYVt7tOW/PRwwjVArER6uSPY7BGNSFWU7ybcDuKoW
         4WPA==
X-Gm-Message-State: AOAM533Y/dfLof7572b95Dcc6hYXlCXd5L8lV/5jgHJPlT/WA+P3L09n
        a3X/raxmcYuctv4+FJE9T+0fRAB3xq4G7Q==
X-Google-Smtp-Source: ABdhPJwJ0QVqHs40kzl7A4Z1r9NzCy8ANMDCse4dnwLVaNQNkSGMK12v2sNjeOVhXLdRXCyAYgjrlw==
X-Received: by 2002:a05:6808:9b2:: with SMTP id e18mr15427661oig.109.1623443302871;
        Fri, 11 Jun 2021 13:28:22 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k84sm1388028oia.8.2021.06.11.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:28:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] doc: avoid using the gender of other people
Date:   Fri, 11 Jun 2021 15:28:18 -0500
Message-Id: <20210611202819.47077-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611202819.47077-1-felipe.contreras@gmail.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some people have a problem with using a female reviewer or a female
developer as an example, and since this is an irrelevant detail, let's
say goodbye to our illustrative female colleagues.

Inspired-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/SubmittingPatches | 5 ++---
 Documentation/git-push.txt      | 4 ++--
 Documentation/user-manual.txt   | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 55287d72e0..3e215f4d80 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -373,9 +373,8 @@ If you like, you can put extra tags at the end:
 . `Acked-by:` says that the person who is more familiar with the area
   the patch attempts to modify liked the patch.
 . `Reviewed-by:`, unlike the other tags, can only be offered by the
-  reviewer and means that she is completely satisfied that the patch
-  is ready for application.  It is usually offered only after a
-  detailed review.
+  reviewers themselves when they are completely satisfied with the
+  patch after a detailed analysis.
 . `Tested-by:` is used to indicate that the person applied the patch
   and found it to have the desired effect.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c387..2f25aa3a29 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -244,8 +244,8 @@ Imagine that you have to rebase what you have already published.
 You will have to bypass the "must fast-forward" rule in order to
 replace the history you originally published with the rebased history.
 If somebody else built on top of your original history while you are
-rebasing, the tip of the branch at the remote may advance with her
-commit, and blindly pushing with `--force` will lose her work.
+rebasing, the tip of the branch at the remote may advance with their
+commit, and blindly pushing with `--force` will lose their work.
 +
 This option allows you to say that you expect the history you are
 updating is what you rebased and want to replace. If the remote ref
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f9e54b8674..96240598e3 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2792,7 +2792,7 @@ A fast-forward looks something like this:
 
 In some cases it is possible that the new head will *not* actually be
 a descendant of the old head.  For example, the developer may have
-realized she made a serious mistake, and decided to backtrack,
+realized a serious mistake was made and decided to backtrack,
 resulting in a situation like:
 
 ................................................
-- 
2.32.0

