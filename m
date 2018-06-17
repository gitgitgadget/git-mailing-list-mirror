Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7CA41F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFQF7R (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33369 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754055AbeFQF7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:10 -0400
Received: by mail-oi0-f65.google.com with SMTP id c6-v6so12198937oiy.0
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZH/1xiMpMfJwkuCsOrgsLPHHKMJD34QC228loPMIdUQ=;
        b=CxcCsX/MMEWOEEuHzscOBdi/+cqJu92bRZ2hmN/lMqxcJQynqEg/8EB7IkmvgvnrF7
         w/wKOjmb+out+vMS+s6rXeCPIAE6ko6CZGhI5/+YgDCrZKj4Lh/p1VCZT6wS8ZQ99l0a
         WRVfauEE9nM5L5OlrqSG3OT7TEKL/XfiJIDxoc/RUMS+rjOtttL3eXtVvQcLz5GT5cHW
         4KF941NGUTkRh7YbxjjBuzt2ABizOnOvRWswOmpKmX5KhHanyk2NkI3T8cvKJ/9257NK
         1sY4V/tTeL1I2F7lEyqsPYNA/TKZc3OmzctF6d6zaCsdp2LCnIcUTYUqIfj8iPunn2bC
         F4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZH/1xiMpMfJwkuCsOrgsLPHHKMJD34QC228loPMIdUQ=;
        b=LwFPr+LzPKYvVQ5iQCTP7JJhC1wNbnpZX4xW/YBiVQ8Mc/4c7W7Sgo79EgQD5d5d2w
         /QmgpT7TAtoIwu+WHoUDg01oQKWLn4/7+p0lKaJDUEcgKzkOEqQgXvCVN35xVRmBZxYc
         qDEXW6nZTVpTKMeG55NQA088483G0U+t/N81Np4lrP1JsIdXV2I8vCzEV+BFP03ERHhe
         Nk9ZCrgInV4dzo1CmROqKerf05Xajd/keaBeT9dUFV/535CsKgToeVZdDy/rDz16mq5w
         ik3TrnQYqOFmiqkWyAUckfFnxTrpYTMQDyXAWuSLkXbOG71JVs9Xfxi5tdnMDY64seqz
         8vpA==
X-Gm-Message-State: APt69E1Ml4iX/ZgoAkYVNpGTgmHMtrClqu1rzzhxzzHFelFo0uGfaxdZ
        VB4cpeWxPSIUF1b5HDqfZF4khA==
X-Google-Smtp-Source: ADUXVKI5cIs4nCroQfNmaoupTmCM6SttYQ7o7xbFL2DjGh0z7kj/VCHgFcpf5d1RhmnSpLv9G8h+7w==
X-Received: by 2002:aca:fcc8:: with SMTP id a191-v6mr4662465oii.34.1529215149386;
        Sat, 16 Jun 2018 22:59:09 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 5/7] git-rebase.txt: document behavioral inconsistencies between modes
Date:   Sat, 16 Jun 2018 22:58:54 -0700
Message-Id: <20180617055856.22838-6-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a variety of aspects that are common to all rebases regardless
of which backend is in use; however, the behavior for these different
aspects varies in ways that could surprise users.  (In fact, it's not
clear -- to me at least -- that these differences were even desirable or
intentional.)  Document these differences.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index adccc15284..0dbfab06d0 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -555,6 +555,63 @@ Other incompatible flag pairs:
  * --preserve-merges && --rebase-merges
  * --rebase-merges && --strategy
 
+BEHAVIORAL INCONSISTENCIES
+--------------------------
+
+  * --no-ff vs. --force-rebase
+
+    These options are actually identical, though their description
+    leads people to believe they might not be.
+
+ * empty commits:
+
+    am-based rebase will drop any "empty" commits, whether the
+    commit started empty (had no changes relative to its parent to
+    start with) or ended empty (all changes were already applied
+    upstream in other commits).
+
+    merge-based rebase does the same.
+
+    interactive-based rebase will by default drop commits that
+    started empty and halt if it hits a commit that ended up empty.
+    The --keep-empty option exists for interactive rebases to allow
+    it to keep commits that started empty.
+
+  * empty commit messages:
+
+    am-based rebase will silently apply commits with empty commit
+    messages.
+
+    merge-based and interactive-based rebases will by default halt
+    on any such commits.  The --allow-empty-message option exists to
+    allow interactive-based rebases to apply such commits without
+    halting.
+
+  * directory rename detection:
+
+    merge-based and interactive-based rebases work fine with
+    directory rename detection.  am-based rebases sometimes do not.
+
+    git-am tries to avoid a full three way merge, instead calling
+    git-apply.  That prevents us from detecting renames at all,
+    which may defeat the directory rename detection.  There is a
+    fallback, though; if the initial git-apply fails and the user
+    has specified the -3 option, git-am will fall back to a three
+    way merge.  However, git-am lacks the necessary information to
+    do a "real" three way merge.  Instead, it has to use
+    build_fake_ancestor() to get a merge base that is missing files
+    whose rename may have been important to detect for directory
+    rename detection to function.
+
+    Since am-based rebases work by first generating a bunch of
+    patches (which no longer record what the original commits were
+    and thus don't have the necessary info from which we can find a
+    real merge-base), and then calling git-am, this implies that
+    am-based rebases will not always successfully detect directory
+    renames either.  merged-based rebases (rebase -m) and
+    cherry-pick-based rebases (rebase -i) are not affected by this
+    shortcoming.
+
 include::merge-strategies.txt[]
 
 NOTES
-- 
2.18.0.rc2.1.g5453d3f70b.dirty

