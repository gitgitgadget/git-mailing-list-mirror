Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F2C04A6A
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 14:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjHPO0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbjHPO0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 10:26:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FF1999
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:26:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff93a7f230so614667e87.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692195961; x=1692800761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF145ZkJ8xrwcFh3xC/qm37Cjfgo1z6s+bcvnNcKx/Q=;
        b=T//je2EpgEYhvK4HGPJevig5ACCRM8s23Iz/f3Al3a1WkVXs1HIlbJtJezaQYSOsDq
         YVH96DKtGldWuOqwUSG53vzNpO726B2L9OeLhf0pydXSVdSBVGROUwZpc40RK79ehsZB
         MZsbqw8Xcgz9q7rWYS+bwXxTR6aDvVsWT17aoZngpyZg8mJEJpNZPVCkxxg7LhQ98hSf
         lBUy3L5pCMt0DwmNN6K6m9Lkr/CgKiiH9C5rjEELaEwD8dJeRvCrP3vfRIvR1fpI5StE
         OGQuNSt+1xYBkM87XslJS/z37K82ZsLhuDanxLrbY077zcRXWeN1KTMpuZaIA2N5IHbZ
         pgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195961; x=1692800761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF145ZkJ8xrwcFh3xC/qm37Cjfgo1z6s+bcvnNcKx/Q=;
        b=hrGDE5qNjkzmqKj15UI9u65fADMcRmqTh9Utt3jkG8v2GT+KH5QxA0VNOuwwj7VbCw
         iZOJO0Yt+E2Mra/YIafO8ga4j5hnX6usipJzIcVt3R/6rf7wEeRE+0FR2qb3RifenVcv
         U4lciT8CqsAOKVBh9ynvrEHMr1RYMSPe9E+S7IYmz8w4IhYoxe0QrLRM3UfRzixEe64N
         8pTqoI9J21miQwBvYB9dOP1X1NenEXgwQrva5SorAmRvk2Wav6Nsd2CdtHJiSRWP9CQV
         uBShE6Y1zXGIElZ57hhbUW/KjJIHhScHdup96EJt4Zb96EkZOjH9KKRwVZVSfvY6UD9v
         u9Rw==
X-Gm-Message-State: AOJu0YzkcZ25adEnPW7NHl43JeRBtXASAW0jGGq/GDcOtyhXJvh3yAMw
        BUxYn62BIAPhWuutyVlkqIUZxQrff9Y=
X-Google-Smtp-Source: AGHT+IHfTjoDI87/ptY8X6iXXvXg2yT8o0tBNWdTBm5ptEtD6gHEmQ6IfWs5/xoVpa8KTNpFOyi59Q==
X-Received: by 2002:ac2:4db6:0:b0:4fb:8ff3:1f74 with SMTP id h22-20020ac24db6000000b004fb8ff31f74mr834915lfe.20.1692195961253;
        Wed, 16 Aug 2023 07:26:01 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651221b200b004fe1c9ce61bsm2927925lft.116.2023.08.16.07.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:26:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Sean Allred <allred.sean@gmail.com>
Subject: [PATCH 3/4] show-ref doc: fix carets in monospace
Date:   Wed, 16 Aug 2023 16:24:35 +0200
Message-ID: <f52247af9027192d0a29b8ee049db20250314d74.1692194193.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.215.g538df5cf27
In-Reply-To: <cover.1692194193.git.martin.agren@gmail.com>
References: <cover.1692194193.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When commit 00bf685975 (show-ref doc: update for internal consistency,
2023-05-19) switched from double quotes to backticks around our {caret}
macro, we started rendering "{caret}" literally. Fix this by replacing
by a "^" character.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-show-ref.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 44c7387d78..2fe274b8fa 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -47,7 +47,7 @@ OPTIONS
 -d::
 --dereference::
 
-	Dereference tags into object IDs as well. They will be shown with `{caret}{}`
+	Dereference tags into object IDs as well. They will be shown with `^{}`
 	appended.
 
 -s::
@@ -78,7 +78,7 @@ OPTIONS
 	Make `git show-ref` act as a filter that reads refs from stdin of the
 	form `^(?:<anything>\s)?<refname>(?:\^{})?$`
 	and performs the following actions on each:
-	(1) strip `{caret}{}` at the end of line if any;
+	(1) strip `^{}` at the end of line if any;
 	(2) ignore if pattern is provided and does not head-match refname;
 	(3) warn if refname is not a well-formed refname and skip;
 	(4) ignore if refname is a ref that exists in the local repository;
-- 
2.42.0.rc2.215.g538df5cf27

