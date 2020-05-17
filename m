Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D22C433E1
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A32E20809
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQGwJuMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEQSwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgEQSwm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A72C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:42 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d22so6077967lfm.11
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wWZQakPEeDnzQU9pihMZL8Ee9K8pJXtTIG6pyxpCETE=;
        b=GQGwJuMw8TdosztcOQv7e+Lyh/4pYubBmpH9KrEPyzsUuI++eLxD3rvVeEugRvO4eT
         22RS1sPJQenCi9egsXCsZzbBLes2MBlcaVk/dGDa6Y8ca8pVqHpXWvwF7eYc6GmcLrH2
         t2mDRASxw+KvHqqbb8OxDB+aIdA26GMzD0ylIDspJj5hDSo48RpzSsxK+X2rOVWqgeRd
         g0lWwR4PnOm2vnnBZfSl5R044LF2zdY5QwKYFBD1ZwzF7awMlvnszNlaAgGAhgdxI2LO
         Zw+lYfgVDyIPETmFX71Qr8AAnrN4OTh6c+qDXf3exvlz8FtbLRARFGpKfHl2dJJHCgXQ
         FgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWZQakPEeDnzQU9pihMZL8Ee9K8pJXtTIG6pyxpCETE=;
        b=cptKINzW3pt5Os0WP+aPulnfoCZY5FO3XycchYE06axGg3Ky1pwbPwr8NrrI3wgAiM
         eYEHpOMnjMUqf+FotXbPu01qG7CvVKIhzR33HQy1du+pTxG4GCxGnn4Uwc54otz/TcIt
         mX9ExW8C09km0UwVo4/dVog33UEY3YwnaBW1tztxoeJ0L+0OsPKOULGFc1EAfpqbMq3b
         bpaE0K5zQw7nu2HkzC599/HSSHwNOe9To1/ua74HAlzkCfVB/aKbGo6rZCehLLrmbgQd
         npbTYIi+g05RBdbfAXPvtoD6/l2VAc2FjiI76m/qWU766Ggq8Ui375ff9vrTdob4OlYC
         vxng==
X-Gm-Message-State: AOAM5301SOxLqWFvJR94LgQWBeGv3B1rstbhSoWisV52k3nsEi2xFmVD
        xAyuHLvqxpSnW2ZafUtIJbN4ggDW
X-Google-Smtp-Source: ABdhPJzQSLNzg5ck9eJBoco9lEtLHMN99C/ESvMMu1Uj1KGvcpQV3VDzdiGVjqFMtTIw1jbOz5LBOA==
X-Received: by 2002:a19:bc4:: with SMTP id 187mr9177132lfl.211.1589741560741;
        Sun, 17 May 2020 11:52:40 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] git-sparse-checkout.txt: add missing '
Date:   Sun, 17 May 2020 20:52:21 +0200
Message-Id: <69faf4d317547143f455321c5a70575cb7b0b0ad.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <cover.1589739920.git.martin.agren@gmail.com>
References: <cover.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Where we explain the 'reapply' command, we don't properly wrap it in
single quote marks like we do with the other commands: We omit the
closing mark ("'reapply") and this ends up being rendered literally as
"'reapply". Add the missing "'".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 1a3ace6082..7c8943af7a 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,7 +70,7 @@ C-style quoted strings.
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
 	as directory names as in the 'set' subcommand.
 
-'reapply::
+'reapply'::
 	Reapply the sparsity pattern rules to paths in the working tree.
 	Commands like merge or rebase can materialize paths to do their
 	work (e.g. in order to show you a conflict), and other
-- 
2.27.0.rc0

