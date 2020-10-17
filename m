Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98691C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6133F2083B
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTSY0hGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437967AbgJQQCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437950AbgJQQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 12:02:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD0C0613CE
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 09:02:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so6809824wrq.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rcDNOFGcp20qROVpVlOEFRNDZaZz8wy/hzasJTBMWS0=;
        b=eTSY0hGv7ZzmMhGmdot2/PAwH2brhQ7WJcNQtO8ucQQloAGR7h1hhNIWKqT9NkWI5/
         vpEVJpG59woDPOwT4869yohYQKCcYDcLUvyZOiAHjOwqg4Darv58B18VyltTD4gwRZh+
         f3NiZp7lBtusKLW/aOefO9cXA7FRi21qHmb9pyGqh8mdIx/jvUqEtHl6qQ0NC4F1Rbi1
         fsSKwjxxDKaNaRRoV/1v1AUu+wychTa3AAp1IzdKl9Lgt0rlF4o7H3BTqfelO6rB8GW2
         Y/5DMj7MuerkAfhFxeaaqV2MlKnnMzEjc0KkoTnKfhehTOpivSixA3bbWqJwFbR5CrT2
         aWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rcDNOFGcp20qROVpVlOEFRNDZaZz8wy/hzasJTBMWS0=;
        b=DpmoBriDre+1LVqH6+ZOuBVNPXCs2kKQFv6Pch7InKcHOHhrWQePo8XkZjozf9tyFY
         6WqGNLpX91jTyRS764CRiG1d8wcr1+v3peyX1qt17mA8TislveuAcQI5NTvFmy/r0/hL
         Q+lnDIhvbl30cXqK/44ytsY3pNh+cGx5n51JzC8H9yDOZ2poiNJrmJoiLUNny4X2mroe
         KvKzBxwyGqoyop7ciD4QQQSGBVjiKzZN/M81aEsPWVlkAhX5KYwp8BufizFZlOKzTqZd
         9Q10I6eEx5UrqFlFo2XElstkxwy017SCyncolNTrAaWEMJeKv89fSlU9vQNmDZUU/LNt
         GRcQ==
X-Gm-Message-State: AOAM532+Mj9qmTjHXc13+w2uGhZkNSKbLsBSncXB6BzCe0qCOwPm2u00
        3S5o/clhJTdbQzPGzLM02S8M7EHYL20=
X-Google-Smtp-Source: ABdhPJwAdIBRWP4qU5fuTetRF4pVZeugvxsjNHuvAc7ZtUssY3PAJHKnGpG7sIDb4FhzxueIi8XWmA==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr10671389wrn.257.1602950554248;
        Sat, 17 Oct 2020 09:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm9721360wrn.81.2020.10.17.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 09:02:33 -0700 (PDT)
Message-Id: <fc2da014a62c387009e2175435286afef64d6598.1602950552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
From:   "Amanda Shafack via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 16:02:31 +0000
Subject: [PATCH 1/2] t9832,t2200: avoid using pipes in git commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Amanda Shafack <shafack.likhene@gmail.com>

When the upstream of a pipe throws an error, the downstream still
executes normally. This happens because the exit code of the upstream
in a pipe is ignored. This behavior can make debugging very hard
incase a test fails. Also, pipes are prone to deadlocks. If the
upstream gets full, the commands downstream will never start.

Write out the output of the git command to a file, so as to test the
exit codes of both commands.

Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) noticed that
the exit code of upstream in the pipe is ignored, thus using pipes
should be avoided.

Signed-off-by: Amanda Shafack <shafack.likhene@gmail.com>
---
 t/t2200-add-update.sh | 5 ++++-
 t/t9832-unshelve.sh   | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index f764b7e3f5..2d850bb372 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -179,7 +179,10 @@ test_expect_success 'add -u resolves unmerged paths' '
 
 test_expect_success '"add -u non-existent" should fail' '
 	test_must_fail git add -u non-existent &&
-	! (git ls-files | grep "non-existent")
+	! (
+		git ls-files >actual &&
+		grep "non-existent" actual
+	)
 '
 
 test_done
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 7194fb2855..6b3cb0414a 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -68,7 +68,8 @@ EOF
 		cd "$git" &&
 		change=$(last_shelved_change) &&
 		git p4 unshelve $change &&
-		git show refs/remotes/p4-unshelved/$change | grep -q "Further description" &&
+		git show refs/remotes/p4-unshelved/$change >actual &&
+		grep -q "Further description" actual &&
 		git cherry-pick refs/remotes/p4-unshelved/$change &&
 		test_path_is_file file2 &&
 		test_cmp file1 "$cli"/file1 &&
-- 
gitgitgadget

