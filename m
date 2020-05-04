Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43133C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221B620721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4RghITJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgEDPtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEDPtt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 11:49:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD57C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 08:49:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e6so1906pjt.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrZL/0/rqA+MzhK8jn5ukYdLZY6pA1v4f1daiwJByh8=;
        b=Y4RghITJiJ4u4Owwgd/pTr1JFZYtiwVFw4ECdYkH5de+pYvJg3R3+wkeXw82/mVsT9
         Pp/HYTqzamH6bry6NLFITRRiFjtlDHviDIxMegHDTHkEOt7ske9OZTghn9YAaacR9JY2
         D9JrnV4/cFwgvo3SFMfN3NpWjJoiFVUW2z6ZxVpGkiWMYpM6smoSJmf6XYIVp3CdZTrT
         xErFuGCOEfJid4UBFJHJepuRaLu4RVXHaVKik4VUewGilt5SW1CRLY3qYyZcu0Px+72Y
         M3/HUEuJDav1XfhsY8o4azXHPcG3+iIqBSg6cBokT3LT2187yTHZLbpBO6mytNrfXmad
         HLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrZL/0/rqA+MzhK8jn5ukYdLZY6pA1v4f1daiwJByh8=;
        b=oTYnOGDFlUoIAXxDx45Y4ITmWX1OCHEuVeFytpflzpYqXoe0OeCeSQMgHcXlhVGDZM
         1eKP+NSwmHpUEMXmtMggBL2k+6yR00KgBsQzTXVX5mTnPipJ8DI+XpnCGSrY+ULE+9Ah
         DMgNffM3y3aH5P/xk9+oK88NqbfZPHyQLat0DCryHBKeZL6G91IPsGJvb5/Aww6rgr3u
         vK+d6Z7teD5nHm0F3feFxfvi4IYocf8fHPfmxLhbHCNgUr9LGbkxnitApqWr8k3s5j1e
         LWTDSFaM1ObWniqmg+SCtPLIFrYp/8/Fq22umxheqOvG3w/JJMEEWibqiw/7f3mGrNPb
         jgUQ==
X-Gm-Message-State: AGi0Pubj/zTQHfLRbu6A7FZUOZHKj/RWACjai/MNBXNu/nERZVd2adLF
        V10uegZ5DYIkY0mSTEgpdOoCcOnT
X-Google-Smtp-Source: APiQypKzehzhsuBsTEO/4jhLhXLRpEsD/2S5Cik5bE8nlIV/5Az8hjtqeoe+/KtC8lVXMJmkacEeFw==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr18364851plt.149.1588607388898;
        Mon, 04 May 2020 08:49:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id x63sm9319513pfc.56.2020.05.04.08.49.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 08:49:48 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] SubmittingPatches: advertise GitHub Actions CI
Date:   Mon,  4 May 2020 22:49:32 +0700
Message-Id: <24a8fefe5add61d557a29f070bd2ca0d0f43d844.1588607262.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1588607262.git.congdanhqx@gmail.com>
References: <20200504150105.GB11373@coredump.intra.peff.net> <cover.1588607262.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 889cacb689 (ci: configure GitHub Actions for CI/PR, 2020-04-11),
GitHub Actions was introduced as an alternative CI system for Git
project.

Let's advertise it to Git's contributors to help them test Git on
various platforms before submitting to Git.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/SubmittingPatches | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 4515cab519..741867dfe3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -78,6 +78,11 @@ on open source projects), you can use their Travis CI integration to
 test your changes on Linux, Mac (and hopefully soon Windows).  See
 GitHub-Travis CI hints section for details.
 
+Alternately, you can use GitHub Actions (which supports testing your changes
+on Linux, macOS, and Windows) by pushing into a branch whose name starts
+with "for-ci/" or opening a GitHub's Pull Request against
+https://github.com/git/git.git
+
 Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
 well (try the Documentation/doc-diff script).
-- 
2.26.2.672.g232c24e857

