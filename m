Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99367C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787D02089D
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMgYU8Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgFQRYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 13:24:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C51CC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:24:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so3232714wro.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AKUraeZXL5sCvmMZwjq1RL1fpoKfdpyZad+ozCPIYsM=;
        b=cMgYU8PvwPzjDcxFGa4J3fJZ7OjbVda8z/JIhRfQgaGZFtqTGQetBGN/sgB1lzxa8j
         JlSjT3EmrnXmQLm71urLY2mfjMBAvgp0/IQqIYvvDhGEuYJlglM/6Yz/B8BtqNiTCC5I
         35BwyNwAWqXj6/CK7/Km7MDX7WG6pPJzx4XXinUKEe2+tvx+yKmZD58Olv76UmOoU+iT
         Ge0UugJu3qRHK2Q42im9POIvH8/VqnhzX9Qasio0WPfSpVwIElXoqKVdaja5RB+1yvT5
         nh528bE4vNnTFBZHF3sqOIbGW0f8f1NIROEliff2hs/GEDyoTTY5lCiJ2OX6A9dXrV+4
         zJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AKUraeZXL5sCvmMZwjq1RL1fpoKfdpyZad+ozCPIYsM=;
        b=p4h1no9rruOLITH4Mh9T93IP5EwekotdnHjtmN2r3H/UUWnsHnL9XBszdGPWrPqNRB
         Cd5a8dG8o0uq/Fa1WZlUtGLNDOEhpuf2UiZHvKN8KpsRsN43p0M9brgub1GPavCSIhiN
         qqVAj7VtSkk/r05XenG2WRjCWwt1soVIjjILSXxaa147Uy4LILfyuibq+DWNJN6kDB84
         2mHadFoR5op5wJUFV4u9F/88CaplMjJrKrM+KOJZZ36bCzBStEcQ14/mRuzErb4f5L5Z
         pGiXKZQ/nwVBeRha7xuZhnRuUM1nuxqEy29b4F0mylBPdylGObSMX5ZL/uwNwJLTDdlx
         hn7A==
X-Gm-Message-State: AOAM533sKQUlf+1158GH72vi/HvkW/ydwU85kyOZEw2LtcyFJSIbxBw7
        PRADrgWYoGeJ+W9Omw0mB6lQK7F/
X-Google-Smtp-Source: ABdhPJyHvU4Xjup1w1O20AfIZ4qfTHDR6gYHOXt8TfzUtMvMp0Ebh3o4s2XComiBcVuU11V6/4FvsA==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr373833wrt.158.1592414672675;
        Wed, 17 Jun 2020 10:24:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x66sm436777wmb.40.2020.06.17.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:24:32 -0700 (PDT)
Message-Id: <8f7fd8f5941426c3ed7fc28c6e4afd62bcd4bb8d.1592414670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.664.git.1592414670.gitgitgadget@gmail.com>
References: <pull.664.git.1592414670.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Jun 2020 17:24:28 +0000
Subject: [PATCH 1/2] commit-reach: create repo_is_descendant_of()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, avarab@gmail.com,
        abhishekkumar8222@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The next change will make repo_in_merge_bases() depend on the logic in
is_descendant_of(), but we need to make the method independent of
the_repository first.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 4ca7e706a18..13722430aa5 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -283,7 +283,9 @@ struct commit_list *repo_get_merge_bases(struct repository *r,
 /*
  * Is "commit" a descendant of one of the elements on the "with_commit" list?
  */
-int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
+static int repo_is_descendant_of(struct repository *r,
+				 struct commit *commit,
+				 struct commit_list *with_commit)
 {
 	if (!with_commit)
 		return 1;
@@ -301,13 +303,18 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 
 			other = with_commit->item;
 			with_commit = with_commit->next;
-			if (in_merge_bases(other, commit))
+			if (repo_in_merge_bases(r, other, commit))
 				return 1;
 		}
 		return 0;
 	}
 }
 
+int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
+{
+	return repo_is_descendant_of(the_repository, commit, with_commit);
+}
+
 /*
  * Is "commit" an ancestor of one of the "references"?
  */
-- 
gitgitgadget

