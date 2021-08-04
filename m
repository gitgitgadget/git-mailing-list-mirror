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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EAFC432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E0F60F10
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhHDF3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhHDF3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC10C061798
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:28:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so710590wmq.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ozz+Q6jIqdDXWdedQk8pgSDu4NYF2AUR0oe+dc6y6+A=;
        b=UjdQ+1fLvcXud5SmbqhdxoC6FKH7GU75rbZnqFJXPd88y0GhNOH267N8EhntMHw+DH
         BGMllIslMrgCVRIURB9mlbTkwWDDk+br1tOnJpF0Lcb7ulb5n2T9BHomLvaBx7DQw0yG
         S0CeEB+iAfVJsXqNh90guTTJn2seWudRXUxNMhkdtZmB4AsTESQt9FFe/bqWP+M2naYL
         MKwsDrCAXTPAphFtVhBse0PMzB/O0SCBrHefeJg7JlLvheOHRdjtsv4SG89lE0bSFFZL
         pTArOHAuD4cw/97IJUp3Xk6NLhiopfNnOpcfAk/GAGHS82Dv+XJSw4E2DkiOx10oy8AF
         sjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ozz+Q6jIqdDXWdedQk8pgSDu4NYF2AUR0oe+dc6y6+A=;
        b=fRnenKySHgC6CGl5wiKDeDH3u7/R1+Ime3wc0PoCoZRrceUgC2/1jArryhfpH9dBtk
         ZG23KBP/l1bK08sdfhaIVgNFDDJ750Q/IQtR/sLpqz0POFB9BtsTgkfwBNDgC/Xh0rGJ
         Que6yI5iTxPvPSlxo53wGrPMFEokfMAowINz0ua+7V5PRXLSU+2ujNS974nQg91N+emh
         pc3OKMPPvBO8Efb/2SX+gRg87O9FCjv9r+PS0J2cOGzhBjtQIs1GCPisZW9gf9Y02gr+
         JUuxxZ2IqRS0j/EIE5CCuuTKQ4kKx2ZqPuInOQ3IyHnFtBnpYjv5wBccy7X9paOycXeW
         YQmg==
X-Gm-Message-State: AOAM533/u4boMaBQBVcJToa1IR1zjYLfdGgSlGQL23NThYyWATJ9fYUp
        kSRGidf/dH3c2o+dx4kfH2mZtA2n8/E=
X-Google-Smtp-Source: ABdhPJzqyKSnHm7iqbzrTLeE2nvU7+xputvDh8B/zzXzPr9TmRhtqBmBKBqQUlSfKRunurWbcBUYAQ==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr7697234wmq.41.1628054938440;
        Tue, 03 Aug 2021 22:28:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm1071359wre.52.2021.08.03.22.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:28:58 -0700 (PDT)
Message-Id: <3435239716822c0ce01232d06bc9f0170fb2f946.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:46 +0000
Subject: [PATCH v2 01/10] git-rebase.txt: correct antiquated claims about
 --rebase-merges
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

When --rebase-merges was first introduced, it only worked with the
`recursive` strategy.  Some time later, it gained support for merges
using the `octopus` strategy.  The limitation of only supporting these
two strategies was documented in 25cff9f109 ("rebase -i --rebase-merges:
add a section to the man page", 2018-04-25) and lifted in e145d99347
("rebase -r: support merge strategies other than `recursive`",
2019-07-31).  However, when the limitation was lifted, the documentation
was not updated.  Update it now.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e2..8a67227846a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -1219,12 +1219,16 @@ successful merge so that the user can edit the message.
 If a `merge` command fails for any reason other than merge conflicts (i.e.
 when the merge operation did not even start), it is rescheduled immediately.
 
-At this time, the `merge` command will *always* use the `recursive`
-merge strategy for regular merges, and `octopus` for octopus merges,
-with no way to choose a different one. To work around
-this, an `exec` command can be used to call `git merge` explicitly,
-using the fact that the labels are worktree-local refs (the ref
-`refs/rewritten/onto` would correspond to the label `onto`, for example).
+By default, the `merge` command will use the `recursive` merge
+strategy for regular merges, and `octopus` for octopus merges.  One
+can specify a default strategy for all merges using the `--strategy`
+argument when invoking rebase, or can override specific merges in the
+interactive list of commands by using an `exec` command to call `git
+merge` explicitly with a `--strategy` argument.  Note that when
+calling `git merge` explicitly like this, you can make use of the fact
+that the labels are worktree-local refs (the ref `refs/rewritten/onto`
+would correspond to the label `onto`, for example) in order to refer
+to the branches you want to merge.
 
 Note: the first command (`label onto`) labels the revision onto which
 the commits are rebased; The name `onto` is just a convention, as a nod
-- 
gitgitgadget

