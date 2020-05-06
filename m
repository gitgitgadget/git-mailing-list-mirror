Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8752C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91676208E4
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmu4mXyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgEFRLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgEFRLz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:11:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4248C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:11:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so770600plr.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXES6LnLl7XKlVQpdOcIbI1nsq1T/p8LTJ8xoAU1e6Y=;
        b=Tmu4mXyVOF8D2tTmkJQ7abKh+6VC8XYxOWkSAcx2ZWHrYlpqnyppUJS48rxDs1F/ej
         m8D1ssat3xj7AQBOisLXs/mEa5QeAB6muwAqNJPqTHjWaFyCPw3PFzfTTW9RzImfKzgP
         UuBJkvCQX6t9C5PGnpUd9qeeqk8uNzBupRtT5sebJFgd5nEsUnroRQWUw8igVvbc3S1N
         n2UjKoEBWermq+NglQdBubfPEf3/IJnHxbc1nIDgSt5KNE6F7opL4OgsKffyFK0GITcM
         RB7/NUQt/O7jXKcfqmZKcdnFkZ0FAlWgtw2U4KLrhR+O8J8NQ2JAHRSNZvJyHXlqseWQ
         +8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXES6LnLl7XKlVQpdOcIbI1nsq1T/p8LTJ8xoAU1e6Y=;
        b=tQ47rxwPD38N2OJF0uvC03JO9VEOvsyTxHnfrTa4qCWPyp37vPD+j6lWkApqRFfoOE
         ng6kFDeKRdb7VHgOkVk1v+E8I8fXUJgD9ZxPyUJ96ejdmHhoxAUqHcqmruAKZVwesSUG
         EK+cl0FOeEiQea+p/zd7sSl7zyicBwhSKNcdFtSBFGBxRtIIxui/TTB/OKaPKlbbNzOY
         mDJMspzVo6VKCchGXAb8xfkZgfrh0UMTz/S18rPWqXfITC0SDZs71g6X835aneAed1Qj
         mHlH0QHDoovRBN629ILOdAUpsOBu4AILvRqh/SJPF4lnkvcquPKkQghDxZiWjNR7SEOK
         0rVg==
X-Gm-Message-State: AGi0Pub9noJKJBC3IgRh0+xp+VA4U9ofxtLUIQR5CmckKnVfg/pvRnKj
        LZmgyG0Z9qJhEJezoTcHpfwPELkNr4v/8VKd
X-Google-Smtp-Source: APiQypJN0BhtvStiqVxx15eniaEUhIH5HOmGueZ12z/WuEc7UUlz9avwdkdtufqlkd7CMK8c4rYeOw==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr8733495pln.191.1588785113823;
        Wed, 06 May 2020 10:11:53 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id 6sm1961273pgw.47.2020.05.06.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:11:53 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v7 4/4] gitfaq: fetching and pulling a repository
Date:   Wed,  6 May 2020 22:41:10 +0530
Message-Id: <20200506171110.23124-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
References: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an issue in 'Common Issues' section which addresses the confusion
between performing a 'fetch' and a 'pull'.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Fixed a whitespace error pointed out by Elijah.

 Documentation/gitfaq.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 5a6c8fb07e..208e5e5b82 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -255,6 +255,14 @@ way of cloning it in lesser space?::
 	presumes that the user has an always-on network connection to the
 	original repository).  See linkgit:partial-clone[1].
 
+[[fetching-and-pulling]]
+How do I know if I want to do a fetch or a pull?::
+	A fetch stores a copy of the latest changes from the remote
+	repository, without modifying the working tree or current branch.
+	You can then at your leisure inspect, merge, rebase on top of, or
+	ignore the upstream changes.  A pull consists of a fetch followed
+	immediately by either a merge or rebase.  See linkgit:git-pull[1].
+
 Hooks
 -----
 
-- 
2.26.2

