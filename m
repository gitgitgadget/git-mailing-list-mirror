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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCA4C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D7160E74
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhHDXvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhHDXvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC221C06179E
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:51:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so2444177wmb.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hoiRlzJZfKlM02prjvTE+U+5J4XabFbnNbVfxX0ySpA=;
        b=LNYD/ECIz7fexj6Fv0hVOZ+XanH3K8shRAK2O6I4bMbmQpAC+oxzPOkr/DfY9V/FBl
         6losXdJiFUihWhXhwHxAOPnifd0WdRG02ndZH1YkyoRbpf8vHBGrRN9EMFro6M9/5d6q
         s5RtVLxetHsebYraqCxG1+az5heEx0JRxL+uIK9c7wsylfPdEWo/h1yqyIKa9uUaE1IQ
         OsIu7JW1utyOJsqTVGWcL8g4YcM90xzTTiYCAmPyKXxRCBYfXEePJzi4Tkimi+tzEGNU
         Ao2lllg5Y+/n6XULegwYfgLvG8XHsrL+UpgvlnNbao9h9T0aPIjP8oa3gGDE3Xgjhql7
         J1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hoiRlzJZfKlM02prjvTE+U+5J4XabFbnNbVfxX0ySpA=;
        b=DsfX2wqo2t/hwTRPT7ZbA17kbsYdtCE+8qP3uAubrz949XD6h4Uw7V/pCXDbucjuXi
         cd307pyp4CWPUqYmc0ANji8q+U6XilDmRYVPO4P5SKqogWh85i+0kd/wx/lkqFG90Cji
         Z71+mjCHD5HhjoRWTTZt4Q9w6j7biX2fOQczmyV/EUTXXC6NrdJUH+TOGWHX4O5V5TSl
         mOJmuZHwUKYuRy/goctzwG6W8t1mqq5DcNnhwJmnPSFG78X+u5vuZKIB5c2y3fVCVT97
         Mm5vo1ASbpJ4zvFvdlxnBxI83Nx8JaWWdzls8qAgXAtCXMLQHA7qEmeFdDhShioGaGPu
         WbBA==
X-Gm-Message-State: AOAM530N22PkKfb94k3eRG5c/02EcUR9xGvcfgv8lMsXZP3SLQCTAgre
        pf0dfuLPy4gqtQUv/57/RNt83YursYE=
X-Google-Smtp-Source: ABdhPJzWn4f64QWxfWwYMfB/nR4mowW14lYhpJR/V/7y7+IaCJW+eV1fXhqWkkbcq6kQHdpLlP0t1Q==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr1833967wmj.44.1628121061323;
        Wed, 04 Aug 2021 16:51:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm3676837wme.6.2021.08.04.16.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:51:01 -0700 (PDT)
Message-Id: <032dcf7c18e4d14f8bb6b892cca6d554f5020d65.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:52 +0000
Subject: [PATCH v3 08/10] git-rebase.txt: correct out-of-date and misleading
 text about renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 58634dbff8 ("rebase: Allow merge strategies to be used when
rebasing", 2006-06-21) added the --merge option to git-rebase so that
renames could be detected (at least when using the `recursive` merge
backend).  However, git-am -3 gained that same ability in commit
579c9bb198 ("Use merge-recursive in git-am -3.", 2006-12-28).  As such,
the comment about being able to detect renames is not particularly
noteworthy.  Remove it.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index cecdcfff47a..73d49ec8d91 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -340,9 +340,7 @@ See also INCOMPATIBLE OPTIONS below.
 
 -m::
 --merge::
-	Use merging strategies to rebase.  When the recursive (default) merge
-	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.  This is the default.
+	Using merging strategies to rebase (default).
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
-- 
gitgitgadget

