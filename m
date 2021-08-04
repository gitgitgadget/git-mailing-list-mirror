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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C48DC432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AF260F43
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhHDF31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhHDF3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B488C0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x17so442392wmc.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9DUYoJmmoO9lRFIK/tsA+MCTS+LcGZ2mbv/h2MARG4I=;
        b=YVZAaMxMPf4zmW8qWxhoIg+ATlJ+PEZElqPdkqJOp3xpw5nUELsOVAsvsNRZM0OqP4
         vBKxNE1TWCGJDBuFHhQIlLDa848BChrmXuitPy4LnkjqpiZXwJ2hpa8n5TAaG8CHIK3w
         vGntICw+JEeVYy5hG+cowznZTeYRltLmZBXdwn334h2rQMv1YEkXUu1bfx3vqiIbPudO
         tqCGqO3y/5fcn9F6c1+O66ac/EZ7aXNEByKiINfQVy8A6swydlMnF7oeek7YkfTQACXK
         0BV7NX2qS1LjstmdR4ehs7hFEM/RqND8li+c459atwJxN2uJxwBpd4OORqHnmNzV2tIM
         4Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9DUYoJmmoO9lRFIK/tsA+MCTS+LcGZ2mbv/h2MARG4I=;
        b=bA+Es1yZQdp2b3Yzv9bU5g8G7ELYzF3z+3gS1VRH66A+MA97TJ3KW10qiyuCnEDrZQ
         iAgBBUCN3Qy6eJh2B6ZgMnPb0kJWA8P9Qj65r45pmTQcxP5ZjXpgCzaxYSrtjBYSyPNq
         d/DfOmpGT6+5uF7XzdFaW9yzJMeN08qPeho0TthVvgflRji1RWp8d46Wll/WWhZ84fkZ
         3d1cvlXbK0kMsMQSEcI1MhpDOOpsyyWgx2yuJuvXkRIip44MFAcyaPm0CNjF9TQacbOA
         mNDg0vJUfleK4uUw9AzG+WMmk++bsBK1i3orDWJvso3PA8Lkqo14+6j3DPkw/LFb0way
         WQgw==
X-Gm-Message-State: AOAM5304KYtlfph1gk2d+aD58k0EUbVk7JNGHOZ9BieNf1YU3VnwpczG
        Dy4sWfNn+RnqflwMOHMmsx/vCxsqSxg=
X-Google-Smtp-Source: ABdhPJxJgS1Ca4B4mVAfqP0NGbj/PiELJqvMY2fjEBLq1l+MrwdGWoiDPA5vwj/x3Oyh0YkrkTUynQ==
X-Received: by 2002:a1c:980e:: with SMTP id a14mr25417589wme.123.1628054942671;
        Tue, 03 Aug 2021 22:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm4523955wmp.25.2021.08.03.22.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:29:02 -0700 (PDT)
Message-Id: <8978132397e95accee5676309d81832724aebba5.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:53 +0000
Subject: [PATCH v2 08/10] git-rebase.txt: correct out-of-date and misleading
 text about renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
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
noteworthy.  Remove it.  While tweaking this description, add a quick
comment about when --merge became the default.

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

