Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93FB62023D
	for <e@80x24.org>; Thu, 18 May 2017 08:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbdERIWZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 04:22:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33965 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbdERIWV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 04:22:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id l39so4797425qtb.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YOq8W4k/LmFDsjele7XvWL6haDRCfY5e3vWtVtml0bU=;
        b=UUtM02HLaOO5M7fa8b/rmDQcjZlghQ/LS/CU+YhPe4k8Z3UHzT5DYNyiXW2XcMy9lN
         m3clBvVcf+gKyCbpAfvRMo5xlX/E2wx4d9iCN+CCXQLMb6y+/3jnHAQw0bzagmgSX1Fm
         9WDYf7lV6JxsbCEwsm5aUFoYXpIVH7QOV2eRi3pNdLuOIvfj4i1ZoyYZYeReSmZjCLpP
         pDRTgiJoY9VroC19Wpo+Ez9miFc2YqnzNA4thX6CxP2e6ZHmYRw2ltj/L3UVljCkZZz6
         H9eFM1nDpReWy4sqNX+vtmDPMpDsvorUyGAHTIWE1ZnKcmZDjZqYDMhRsp1ohuH1MwI8
         jcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YOq8W4k/LmFDsjele7XvWL6haDRCfY5e3vWtVtml0bU=;
        b=rOb70IslJxMOzZ3X0mVvfRnsCNmYuyOmF5m40ldTh7a2JBGsy/ayvbsluQFc4fxS9Z
         D/TgJMPIKDQrU04QgTGaGFXtIsc72YTjPJU893WcHy+HV8WqloiERoUpOiygd/GpZhjD
         WyBKM9xJj2rgBN4jzGAGIgP4a4Y2Cl/8qDADYLvqcJ7kA0Fa/OgjcdyzuAUa1cqWgBpp
         Yg+YLhFfkUvWNDGp6O5oreIErmyW3jtMkRAVqlIyhNu48j8dSHTvfYTtOCjEHoUTj73n
         UCtS3kgQrTOVqRMXp11OGnuFt7InzUwTJ7Wk5ZqGyfwTdfju4dYNelFmp+3fVtj+rTOs
         UO6g==
X-Gm-Message-State: AODbwcAOL1PYILCQMswutmqwqvTNnJ9MsAkqfaei2doGeaEVzSDqwBl9
        wblY2mlQFca+iA==
X-Received: by 10.200.4.29 with SMTP id v29mr2945346qtg.82.1495095730500;
        Thu, 18 May 2017 01:22:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id k36sm2999604qte.65.2017.05.18.01.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 01:22:09 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 3/6] dir: recurse into untracked dirs for ignored files
Date:   Thu, 18 May 2017 04:21:51 -0400
Message-Id: <20170518082154.28643-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We consider directories containing only untracked and ignored files to
be themselves untracked, which in the usual case means we don't have to
search these directories. This is problematic when we want to collect
ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
read_directory_recursive() to recurse into untracked directories to find
the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
has the side effect of also collecting all untracked files in untracked
directories as well.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48..68cf6e47c 100644
--- a/dir.c
+++ b/dir.c
@@ -1784,7 +1784,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
-		if (state == path_recurse) {
+		if ((state == path_recurse) ||
+			((state == path_untracked) &&
+			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+			 (get_dtype(cdir.de, path.buf, path.len) == DT_DIR))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
-- 
2.13.0

