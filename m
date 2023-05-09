Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F9C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjEIRyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjEIRyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649540F5
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3079d2afedbso1540806f8f.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654855; x=1686246855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KRdiFfMhZS9fiMj4CCEK897McKTQ1Kpn1H9x226O3c=;
        b=ih+jDINHx+D5GCAYMpUkj4nZvzq5DvXL+ATV0JEs+csA8Cm6MX9tmKdNlo9rxJqGNC
         4ASm2vZG0ZinKUGBpMya20HdZ/U5jxF4TvVyK1UDvZNfYvbP3/b/S13uh2YWWpeJul45
         oTx6KHImI5qYVoBbNIdnSGKkelwkDNHcbHsBX8lClddpGjX2xgNVt+jvBVxRtsgOJGVm
         AULuDjPN7QTUWbGxQ0opXFzTrViK72Q/wrdlMJVJ+VPKtZPk4QKd8a47CNWrfZ2ELvnV
         HNh6NMC/MFVo3364bRf2tceLKuIeyU4MfwFm5RE25fYabOuMnUme4Ko0kLXF84Hkm3Vv
         8+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654855; x=1686246855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KRdiFfMhZS9fiMj4CCEK897McKTQ1Kpn1H9x226O3c=;
        b=ViHHBzbA7QI7LeyJ05EDKp9BcOj/OMmURiwnJ4DvDgIF5Su5yMIhvNsmDcgsewCqu9
         448hhB82ILZRO9D5h9SzjIIGxpo6W5BhvKQZ2rlD+rbQhzx48LcMrB1yb4+fKy9viGz5
         vFzrjl5waDpkrgXcLhQhFzeTTJLu5XZHuDIYIpTABSceqQ8mhACGnb5qB3rw4a0rsgPE
         mzF4NLIt7wiG6YG+WrT561WydjdcaNLCwfwqM5IH359YiMXlKIZKT86SWNZQRonI1e3l
         qtmwNF4BotIuXeEYUfVa5PEn9oQNBwJpIKizpBYdySX8qVGaVUOqLInt3RGK2kccpmLo
         hNSg==
X-Gm-Message-State: AC+VfDwPL/XGalu91rg1FMDjKW2G40UMuRqA+DmeOkDqbpP99w03ZpYN
        gIWYbA4cKYBSKSr7FKNx4sS9LS3XVlg=
X-Google-Smtp-Source: ACHHUZ7PpDMlKNPJf8boGjDTQkIxOknardxPIp37DM8jIZT//P6xlhNUsJouFLFinN+qW/LO6JPGLQ==
X-Received: by 2002:adf:e342:0:b0:307:7d1a:20ea with SMTP id n2-20020adfe342000000b003077d1a20eamr9563223wrj.42.1683654855337;
        Tue, 09 May 2023 10:54:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:14 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 04/15] replay: die() instead of failing assert()
Date:   Tue,  9 May 2023 19:53:36 +0200
Message-ID: <20230509175347.1714141-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

It's not a good idea for regular Git commands to use an assert() to
check for things that could happen but are not supported.

Let's die() with an explanation of the issue instead.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 4644bee3cf..366ea8ef08 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -177,7 +177,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
-		assert(commit->parents && !commit->parents->next);
+
+		if (!commit->parents)
+			die(_("replaying down to root commit is not supported yet!"));
+		if (commit->parents->next)
+			die(_("replaying merge commits is not supported yet!"));
+
 		base = commit->parents->item;
 
 		next_tree = repo_get_commit_tree(the_repository, commit);
-- 
2.40.1.491.gdff9a222ea

