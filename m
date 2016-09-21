Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437EC1F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbcIULaV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:30:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36814 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932289AbcIULaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:30:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id n24so2285042pfb.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5nqyQjDvJuA2dAFnnMrEzPeQeKuWM325Rnk/aWGwvw=;
        b=O+UKnTzdz8c+sW1UO7S8LHr1DhQDUpEnVmrC+krVuSJCvtB4y7IkMXBAJ25aFa6195
         SpLK3zhqDs8yRr1di139W6u2cASYTlV62nmqx+RAgFjKd+OXKMWBck0eVJVYMplMKjDA
         BHempQeLyQvQoVNMCKum1g3ikKSohrlu2xAiyhnL1Ja4QebEVwi2+ukZ0mJlDpMCSlby
         IO8H2dpTFgUx76ALLtHK8vRaXb+pVZpg6nzgUI2/HHXBNrOdbf4jg5MMzMq3lS8rJm+o
         Okiq0WB8/rneu1KtQNTEV23LVcaBA9FVNJ2Ef4j4AyrseynTWaBkqtZCQ962g6b1/04a
         YAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5nqyQjDvJuA2dAFnnMrEzPeQeKuWM325Rnk/aWGwvw=;
        b=Ab4NxAMZWuRPXaqSq2/bTXUMfkxIzXLbYgMKCyU57U+hp1OSASiD9mr6Mgs0Y/azSo
         9d+ySShIk5BejK9Z0u6unOETVxVd43RvxFwQC0N6cWQcq0rE2yrdVhDHP4tlcWQA3LBU
         jHaH9/5qm8ksMVq4IHPUnN4nlO7EJ0GfX1cV/pTi8nWK775U5hWFcc+roH652MsqHasX
         YHYfPId/yx2y3Mrj4K0UzqC2W7+imsuHQV+Me1G+HqmsgNQHpn/i3w5SfRatf92i98Oy
         k/l0iDXsFpD7zwZ481ne/n1wd5x8CFE99i0poWbNq9WQ5HqwEYBLfiDE6NxOp0FPEsy5
         hyYw==
X-Gm-Message-State: AE9vXwN1UxlwBqzoUK7cZ/P5LGyzgpDGKinAczvNAOjra+G8UK5GIcEsp4FrVTbypV+HaQ==
X-Received: by 10.98.67.139 with SMTP id l11mr47558145pfi.16.1474457420256;
        Wed, 21 Sep 2016 04:30:20 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id i78sm53714442pfj.67.2016.09.21.04.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 04:30:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 21 Sep 2016 18:30:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/3] init: reuse original_git_dir in set_git_dir_init()
Date:   Wed, 21 Sep 2016 18:29:39 +0700
Message-Id: <20160921112939.3444-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160921112939.3444-1-pclouds@gmail.com>
References: <20160908134719.27955-1-pclouds@gmail.com>
 <20160921112939.3444-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since original_git_dir is a copy of real_path(git_dir), let's reuse it
and avoid calling real_path() more than necessary.

The xstrdup() is removed too because original_git_dir is already a copy,
and we're not going to free git_link in this code probably forever.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0d5cc76..d70fc45 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -330,11 +330,11 @@ int set_git_dir_init(const char *git_dir, const char *real_git_dir,
 		 * make sure symlinks are resolved because we'll be
 		 * moving the target repo later on in separate_git_dir()
 		 */
-		git_link = xstrdup(real_path(git_dir));
+		git_link = original_git_dir;
 		set_git_dir(real_path(real_git_dir));
 	}
 	else {
-		set_git_dir(real_path(git_dir));
+		set_git_dir(original_git_dir);
 		git_link = NULL;
 	}
 	startup_info->have_repository = 1;
-- 
2.8.2.524.g6ff3d78

