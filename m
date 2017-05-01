Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34571F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbdEASBN (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:01:13 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34107 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdEASBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:01:10 -0400
Received: by mail-pg0-f53.google.com with SMTP id v1so48102359pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pt9/nOTcfinSSuGg90ddFR2HkrpDqx/AqESMVgrqKpM=;
        b=O6fXscwh8jJg28wl/jApajQbBIMQ/L9QQtvCXqTleQhpJb3kg8S0JMp/tCa69s6/Ls
         BXdbaatAvkdfHNes/yY2DWOFUCoq/W+YbZc/NdjS4vt4vzfrKuj//TzJLgV3rS06FUul
         H/z/l0drHwm1PgbjJDGQCtjKfHRLvHxCsNkBhe+k4Bm8nt9c2+5dsSDTNWNXgy0aXT5Y
         zsynimi+kRgfOm25kbpXToPTcY8IDGifsDDA4zZJ9XMX2ZcdbXhzKIZFOnVBQDC6O3ef
         DPTJsVDWXmJq3hjIomoR8kxFAi29S33OtlYQNi1Eu0OowP6LX/ZottIJ2qFZx89hWbBB
         Rjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pt9/nOTcfinSSuGg90ddFR2HkrpDqx/AqESMVgrqKpM=;
        b=mTlUSibCHftp67V8qvq6Bg27EqD0DA9JPcRIRziIusSJ7UQVdxSS8HrmGVpOcbanRu
         /Z2gMnB4KhfY01atTrzUeXAzCgBAvUmpKD00abe9n67TLKmTfll14oQkOxA0UxTSxwLj
         Vm5G604SxfNHitpWh8gZ429/G2kbwvScl8kfoDkLtrBTK54JXcH3JnBrKsMpc1kNY15Q
         3M+Gsj0H0aZLwsUX/OLut2ZaqYzJb0Op6QNQWTQl2TPlqJc+GM+l2qrmALqD895NGVlk
         fl/o4uJbW5pZPC60vJU+43WXfY8fPRuqadSul/rrzKCozn9E7J6fUQHpyq29DZ/REaDK
         2glw==
X-Gm-Message-State: AN3rC/6nH1UREYCJWFlh1H8UIKDo84+dR7vJIHJFWfY2fP6qBTCGCjWw
        jhtkZqBPf0kwziEc
X-Received: by 10.84.215.23 with SMTP id k23mr35209044pli.104.1493661669856;
        Mon, 01 May 2017 11:01:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id x2sm25436735pfi.80.2017.05.01.11.01.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:01:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] submodule: avoid auto-discovery in new working tree manipulator code
Date:   Mon,  1 May 2017 11:00:56 -0700
Message-Id: <20170501180058.8063-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501180058.8063-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All commands that are run in a submodule, are run in a correct setup,
there is no need to prepare the environment without setting the GIT_DIR
variable. By setting the GIT_DIR variable we fix issues as discussed in
10f5c52656 (submodule: avoid auto-discovery in
prepare_submodule_repo_env(), 2016-09-01)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index c7a7a33916..df03691199 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1363,7 +1363,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env_array);
 
 	cp.git_cmd = 1;
 	argv_array_pushl(&cp.args, "diff-index", "--quiet",
@@ -1380,7 +1380,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 static void submodule_reset_index(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env_array);
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
@@ -1438,7 +1438,7 @@ int submodule_move_head(const char *path,
 		}
 	}
 
-	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env_array);
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-- 
2.13.0.rc1.1.gbc33f0f778

