Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC64C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C90220B1F
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk3Ar1v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHNMWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:22:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5DCC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so9696588ljc.10
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5B2vz66G1bqnebgNJLoVE8Y2qzFWozqbZXtUALszOU=;
        b=Qk3Ar1v690iwowtkkNqK50SWlMzqmwsLpKM81nYTCLMeE9STA635q5KlhgX4j+iGNJ
         qlEZKq2NndGYSMsqabHW32vfpZ0C+ekCbr3fKpZsmcIsXRL9E4bWhQdqXunMEVD6a3QY
         J5+IYakRe8YQtQnaVUAZgdvXXbNcEZNSXHFvLpc+7KDmeV+wcHdcJX1sW6hEId76cEKT
         McxLY8vJ+JYADF9B1Vc9Um63JLqR8SQK6keUCzkbBkjlL2L5sXdaHA+qJuQeYN5etcRB
         hIcIcTVSTTi2nk1mFrO3MeiI6HY3juFY4XTB9p1ose9aeSqd7fE98OU/R4qugeFEiQoj
         WYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5B2vz66G1bqnebgNJLoVE8Y2qzFWozqbZXtUALszOU=;
        b=DF8K4eVryNzYzjYsoPaL5cdX4aEAPqP2ow+tKaoKUF4DS42ThVaj32nS7gONU/7JcZ
         E48ReYkqJ+pMiPBDNdTOwMJMGWRdQ+1m+HSueyi50sqIr3MePuvoK7rPVvgkoruNVSy9
         Hely/w0nlxgzdAl1cz9MGppsDwLK/3HRE4xzAB4cK1IC2K0aLJEOUxAMUkkAJUmNrm4p
         PkZVU6rfeH13MD5mMvQmP9GsMjJbdHDy5BcwwIBhBK71C5RXFlOUpnYWo636a11S9Vyv
         HHou7fLw/04m2oLSTVSBvWF2iJWcbNqk49cWTJ3LSUU3NfuDh6tiST0OxWP7+KgwPBm9
         H7EA==
X-Gm-Message-State: AOAM532XrQelxA8+hYWavFGKVJvcNo/tbAeK8QGVWmi0axLfZrnMFgK8
        onaHM8txEEUp2tYW98FYaUk=
X-Google-Smtp-Source: ABdhPJzChDsMZfspQqD8U9tmDfecRGQ0emAmXEildekaExzYQCcJkVcwpEdE8zK4V4cNHHcByKsZxQ==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr1244448ljj.88.1597407722695;
        Fri, 14 Aug 2020 05:22:02 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o2sm1847407lfi.50.2020.08.14.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:22:02 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] http-protocol.txt: document SHA-256 "want"/"have" format
Date:   Fri, 14 Aug 2020 14:21:42 +0200
Message-Id: <5590a68c5ba7081cd7e64c708b5c25db23f5e95b.1597406877.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1597406877.git.martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net> <cover.1597406877.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document that in SHA-1 repositories, we use SHA-1 for "want"s and
"have"s, and in SHA-256 repositories, we use SHA-256.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/http-protocol.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 51a79e63de..507f28f9b3 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -401,8 +401,9 @@ at all in the request stream:
 The stream is terminated by a pkt-line flush (`0000`).
 
 A single "want" or "have" command MUST have one hex formatted
-SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
-multiple commands.
+object name as its value.  Multiple object names MUST be sent by sending
+multiple commands. (An object name is a SHA-1 hash in a SHA-1 repo
+and a SHA-256 hash in a SHA-256 repo.)
 
 The `have` list is created by popping the first 32 commits
 from `c_pending`.  Less can be supplied if `c_pending` empties.
-- 
2.28.0.277.g9b3c35fffd

