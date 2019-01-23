Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3915B1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfAWUCN (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:02:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46524 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWUCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:02:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so1817029qkf.13
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rkhm+hB7kJDWTi12Z318Z5WdcZu4zQ/Jm4sBckPMJVc=;
        b=FbTF63dD4UkvSbmSrRXpFZK2YZ2Q5fIfYPXv0O26lRZX1skANYe5x0Zmc4XxRJTwZl
         hi2vHQVHXtAD7xl3YzosN0mgZD/nFU6DGBIw93Dhb+J4mDottSBTDkgsp0WydMir79Dp
         bMDhaL1tm48a4oqbmy4qEErOH0I1B7xIgbi7cyWzCvxPmcx7qgoAHDgB+S1DqPEHetyP
         r4+KjHQuVn06ArLRaZEzQT8FOBMs5ph+Y+86DUt0mkG5sYIDw58vM3muROMOxTTPln4o
         sQOl0afs2c4ULkJPSK9zBM7WymIZwn6fgFmrpZBjL9M/IE4K0N5K8Fjgn8I6wdn3n98K
         OwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rkhm+hB7kJDWTi12Z318Z5WdcZu4zQ/Jm4sBckPMJVc=;
        b=PQGO9LrrCcScPczMyeV7kuUZti1VcQ5sb6aQbXLQAZfKM61pC/1V2WGeasRdbQzM+i
         l74llr28ZDczD0RgMsmuPgRjQDTWCGTKaRoIPlOtjDzZOp+Icc1DkXk3PqB4127vOwub
         oFe1LI75RejlJgODIJqr4gGfqBuphnm+7E6tDDpK2kFLYUnF0BhExjsD72gEQVSRGj7Z
         Hqwj1rAORf9LjXcvnbb3ulqnPRIHHwy4HHgKTNY+9+VM6HHvUZ+oUt5zCIhdJ1sFh6xW
         yztb8dEhUegxt9cVnCMt/I4emTQ7jInsRbG+juFAM/vOYTG0Kk8zItRotP1ZBdlVUCN1
         NR9A==
X-Gm-Message-State: AJcUukcPa9NMVTew3MIBOSOT+ruOq7/ebUWGb3RsSfAHcSHsbnqLYy5F
        ApQkNoZbffVPywElWuC7ndIQvY7fOHo=
X-Google-Smtp-Source: ALg8bN4151Ki0Rk3I/65zEGGUXVxt9UxCob+//uI+xQvf4zy13454xoWnHVKIOogKcVKKj+ltEU2pA==
X-Received: by 2002:a37:ccc2:: with SMTP id n63mr2972704qkl.82.1548273731314;
        Wed, 23 Jan 2019 12:02:11 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o2sm55252042qtp.48.2019.01.23.12.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:02:10 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     asottile@umich.edu, benpeart@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com, peartben@gmail.com
Subject: [PATCH v3 1/2] checkout: add test demonstrating regression with checkout -b on initial commit
Date:   Wed, 23 Jan 2019 15:02:00 -0500
Message-Id: <20190123200201.7396-2-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190123200201.7396-1-peartben@gmail.com>
References: <20190118185558.17688-1-peartben@gmail.com>
 <20190123200201.7396-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Commit fa655d8411 (checkout: optimize "git checkout -b <new_branch>",
2018-08-16) introduced an unintentional change in behavior for 'checkout -b'
after doing 'clone --no-checkout'.  Add a test to demonstrate the changed
behavior to be used in a later patch to verify the fix.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t2018-checkout-branch.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 2131fb2a56..6da2d4e68f 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -198,4 +198,13 @@ test_expect_success 'checkout -B to the current branch works' '
 	test_dirty_mergeable
 '
 
+test_expect_failure 'checkout -b after clone --no-checkout does a checkout of HEAD' '
+	git init src &&
+	test_commit -C src a &&
+	rev="$(git -C src rev-parse HEAD)" &&
+	git clone --no-checkout src dest &&
+	git -C dest checkout "$rev" -b branch &&
+	test_path_is_file dest/a.t
+'
+
 test_done
-- 
2.19.1.gvfs.1.16.g9d1374d

