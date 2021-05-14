Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39319C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0781E613F5
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhENMvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhENMvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:51:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D30C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:49:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s22so24019092pgk.6
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4g+KHQJP/T99yFrImqJdaLD/ZNHCoYWo4lnSocCRlM=;
        b=kmtmHY380U0CqWlaou+bAXJyDEviEwqvXhZJ2A1/G1In70PqPpDv6IEd3x6NjlyJCl
         RsQaSoXrFI6heziqHu4iwIyTyqDspCVVSTJRKFXnP/QhLacG5TtMWncphhNA/E2bU7Kh
         bZ8B0bwhmLupeEvbzripFCjPU4JUpB69iXoW5dCSlXbI4g2wUPFQ9BtPby6lX+IhSlZ8
         D/0vlZnjaDuW8MiB8Kii2lS0dN7j+7/T29VyN/mGkv5PvcT/1O5gTV8E+qbKs/qwBOch
         BdfL2dGgXOgMYdXPI2o0nX2Z7aXwC/sZHtl8pX6+2akssW9DXyE6rRfkrWNP4f50sh5V
         dJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4g+KHQJP/T99yFrImqJdaLD/ZNHCoYWo4lnSocCRlM=;
        b=WNZYrdi8AD+QHO3MRHj7vbqSKe7/zeQMnS2APf8wfa8wnD9G6yOFaAuZVv9Dj1mUyc
         BkiD/RFerTv6WXzcdM9W1Vz4CxPohxTydknzZvCLegkuRBQU/5MhTtcb4cTUaQ5Z4FDU
         Xy4kLImGjtnscuEkq2nIvV8u4XAUgvMUT5ZXmLgHH1FA/zOphtUTy5s+v9YRcHOlGQsz
         QA8IdqT/miKZlMqndbEFo2vjHaICcRNkdmsbwCZseYdjGH078LbJeYtm0/lZZV+uAsmk
         yyQIUYpaptQ5PZDWJy4mqJjOetkmxjr6N4ndanjUiy9NSCysczAmT+o3p2DZi3YtG80O
         vpNg==
X-Gm-Message-State: AOAM530UadeISc4RNCw2wsNo48ME+mmbqRFaipuswFzHUrmwVDj+Yh3q
        DhDM1E23HvoasvMYAAK0wxKRBhikHfsMhA==
X-Google-Smtp-Source: ABdhPJzhZYSwZ5A6J5RZKeo9seG4EOFliweQLylTxe3a5uNhXZ8ZEdk2Z2hvRT7bhXoKck+wetEVNA==
X-Received: by 2002:a63:d30e:: with SMTP id b14mr31460542pgg.237.1620996588337;
        Fri, 14 May 2021 05:49:48 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id x13sm4784851pjl.22.2021.05.14.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:49:47 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation/howto: tracking git.git
Date:   Fri, 14 May 2021 19:49:26 +0700
Message-Id: <20210514124925.39229-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document how to track git.git repository for Git development.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/Makefile                  |  1 +
 Documentation/howto/tracking-gitgit.txt | 79 +++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/howto/tracking-gitgit.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb..2b5b8b28b0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -84,6 +84,7 @@ SP_ARTICLES += howto/rebase-from-internal-branch
 SP_ARTICLES += howto/keep-canonical-history-correct
 SP_ARTICLES += howto/maintain-git
 SP_ARTICLES += howto/coordinate-embargoed-releases
+SP_ARTICLES += howto/tracking-gitgit
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 
diff --git a/Documentation/howto/tracking-gitgit.txt b/Documentation/howto/tracking-gitgit.txt
new file mode 100644
index 0000000000..61dbd2540b
--- /dev/null
+++ b/Documentation/howto/tracking-gitgit.txt
@@ -0,0 +1,79 @@
+From: Bagas Sanjaya <bagasdotme@gmail.com>
+Date: Fri, 14 May 2021 13:26:33 +0700
+Subject: Tracking git.git
+Abstract: How to track git.git repository for Git development
+Content-type: text/asciidoc
+
+Tracking git.git
+================
+
+This short document shows how to track git.git (source code repository
+for Git) for purposes of Git development.
+
+Available Branches
+------------------
+
+There are several branches on git.git with different purposes:
+
+master::
+This is the most stable branch. Changes (topics) that are merged
+to master should have been stabilized in next and suitable for
+production use. Feature releases (vX.Y.0) are cut from this
+branch.
+
+next::
+This is where topics that haven't been yet merged to master are
+stabilized and tested for breakage and regressions. It gives
+a summary forecast of what next batch of topics that will be
+merged to master looks like.
+
+seen::
+This is the most bleeding edge branch where all excited
+developments happened. All proposed topics are queued in seen
+by the maintainer. However, these may be buggy (have breakage or
+regressions). When topics queued are deemed good and ready for
+inclusion, they are graduated to next for stabilization.
+
+maint::
+This branch is used for preparing maintenance releases. Bugfixes
+for feature release (vX.Y.0) are accumulated in maint. Then at
+some point, the tip of the branch is tagged with vX.Y.Z.
+
+todo::
+This contains helper tools written by the maintainer to ease
+maintaining Git. Also, "What's cooking in Git" messages are
+prepared in todo before being sent to the mailing list.
+
+Tracking
+--------
+
+If you don't have git.git clone handy, you can obtain one by:
+
+----
+$ git clone https://github.com/git/git.git git
+----
+
+Now you can start hacking your topics. Don't forget to read
+`Documentation/SubmittingPatches` for instructions on patch
+submission.
+
+After some time, there will be updates to git.git. First, fetch them:
+
+----
+$ git fetch origin
+----
+
+Then pull the updates.
+
+ - For `master`, `next`, `maint`, and `todo`, you can do fast-forward
+   pull:
+
+ $ git pull --ff-only
+
+ - For `seen`, DO NOT pull with `git pull`. This is because seen is
+   in constant flux, and most often your local seen is divergent from
+   the origin, caused by force-push from the maintainer. Attempting
+   to pull either via merge or rebase will most likely end in
+   conflict. Instead, pull by resetting the local seen to the origin:
+
+ $ git reset --hard origin/seen

base-commit: df6c4f722c94641d5a9ea5496511f7043433abc2
-- 
2.25.1

