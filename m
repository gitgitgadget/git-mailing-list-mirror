Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCF7C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiCQSKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiCQSKP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF2114351
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h16so3033269wmd.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0ehVm2WXO0/ROC62XXLkfU/b6lpqMUbe8LHopB/tPc=;
        b=AE7ob5wwKTG+B/LDi9P7HCGIrzTBZOBU8TPj0o05pEiHrakni6dFBt959vIF/SXBMS
         EVu/goErqHonIBZjV+ktsJ4Q79s+sXabhKsnmET5A7ytFVfUaHQnvIGk+M1ecsZQ+6Of
         i/zXl0oaUhT/WOxJDyAuboJRAQhY+HC3tH+o+9js8ezvEoENmZBGQRCtc7j2CCbubzxx
         Qb7d6cVaEZpSVB+csBDZPmXuusZr9VqkMWC+p6srCMj7Pyq/2NdPJ2+ZU3XwoidMVO19
         SNZXrTEdvL7FsN+bBA6LvnNyfg5fY4SzRq03wEcvGO4xilf7VybRd++yrKcFZmT9IHU6
         15+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0ehVm2WXO0/ROC62XXLkfU/b6lpqMUbe8LHopB/tPc=;
        b=T72BT0TRB17sgAeIMYlNd84aYFWdxzjqaGRbCosDrRRhXIQk3f9DTOC+8D5MFTAcdP
         H8/N4wGhju/jbpqcYCVL6ucAqD9jssEObplJDqCcAYLr9EUDiWZ6pmNnDK8za2Yi4E5/
         /ZvPBk6+tdcKHaYamIUiO//O/uDP6+pFb+gHBcwnkqe/hiKMeP+kOKlH2f4/4YsAdo7+
         SCezA7y7sC67EtAQKALILs+Fk5fAafRVo3KDEle8LWSJFU8zg3/QwqrzQmIMpt/Pyj5X
         t1+L46lh8vQzrOUrDl49dQvLKzhGxfvBFIOjGfNsRE1JLxbRBEpMaA0wsVi+awiIwNuL
         CdJA==
X-Gm-Message-State: AOAM532r96frBR5mOmpTN+fOiZ2kPf8tmsP9omEyNvkIQ8Fi2G/FvFpW
        CFatvb/HtGxeuP00ibqdUCi17vBYY1foZw==
X-Google-Smtp-Source: ABdhPJwc/BuKSgldtYParvkWYgt6/gRGCSB2dxaiUqRReOXGBpFUv71mrORLbNk++VRzNLjOE0pIvg==
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id 13-20020a05600c22cd00b00389c99a45a4mr5081510wmg.38.1647540536347;
        Thu, 17 Mar 2022 11:08:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:08:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] reflog: refactor cmd_reflog() to "if" branches
Date:   Thu, 17 Mar 2022 19:08:34 +0100
Message-Id: <patch-2.8-8bff6976334-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the "if" branches in cmd_reflog() to use "else if" instead,
and remove the whitespace between them.

As with 92f480909f7 (multi-pack-index: refactor "goto usage" pattern,
2021-08-23) this makes this code more consistent with how
builtin/{bundle,stash,commit-graph,multi-pack-index}.c look and
behave. Their top-level commands are all similar sub-command routing
functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9407f835cb6..c864f276308 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -384,14 +384,11 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(argv[1], "show"))
 		return cmd_log_reflog(argc - 1, argv + 1, prefix);
-
-	if (!strcmp(argv[1], "expire"))
+	else if (!strcmp(argv[1], "expire"))
 		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
-
-	if (!strcmp(argv[1], "delete"))
+	else if (!strcmp(argv[1], "delete"))
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
-
-	if (!strcmp(argv[1], "exists"))
+	else if (!strcmp(argv[1], "exists"))
 		return cmd_reflog_exists(argc - 1, argv + 1, prefix);
 
 	return cmd_log_reflog(argc, argv, prefix);
-- 
2.35.1.1384.g7d2906948a1

