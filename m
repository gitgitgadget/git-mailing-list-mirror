Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C84B1FCA5
	for <e@80x24.org>; Fri, 30 Dec 2016 00:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbcL3AsA (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 19:48:00 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36048 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbcL3Ar7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 19:47:59 -0500
Received: by mail-pg0-f46.google.com with SMTP id f188so171431624pgc.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hoI9u/p51NOWGKXr8ch6jnCPPpPDawsgHrJjr32aNac=;
        b=vQ2IT2yBzQ+hYB9J0O+1SytSLOb0JG5UKMtDyyoBQ5xCcJhe/BVfJvK8MEGB2Px7hD
         WN0+yWDg8VqxoeBW5qohW2BPtUpnS7gJaXI4FB0xIkUKgKmVu4uAiIW1cdOdxepR86c1
         m5rj5ftISbywBvDu7NV61Zz8ZP1NaRJwVXci2bcDjmDPLpiZwF8X2rCEgU5tcXB76rhj
         r/C+BD76jRn8Pb97lJyWM6u/Nk5DeLCjCiiqz/Qfk77twgs5BtyOMo42YvWFd+GtQu36
         zfCQikUOTJew7PsIU9qCg7++xQUWtvOQ537/AqKJhiRr3k4wboREtOhtPD9AujzZdY72
         VLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hoI9u/p51NOWGKXr8ch6jnCPPpPDawsgHrJjr32aNac=;
        b=EVyUG2UeSGCgUYqOiZqK8VXOiMAktcz6n+7nEumWeGo2Dm7YOXfAzy1edmLStF3fUR
         PV1sDBknMSAr6duuQlDgdjIzzR686e1JdjTqNOyIuyBJ6sCKSNRnYQ9U9DQcVs3dG76t
         fWmLHQhQCd1eDScnPi1Ek61to29mr+xiANaJar7eHULzPtFiipeKqy34bCWOqhHoxi+1
         p503zO4NbaiBPi0NhX0/Ow2QWXRTZCSMhhRSR601oOZfFrZpjKi7JGlWxwcD9T7SDizv
         Tz5BSqu8uv5hIPOVkcTGrnakCu6Kwjf0VivLeqXD39Zl7FF6dQp3ZB7SVtcAXMfkzNjz
         nbBQ==
X-Gm-Message-State: AIkVDXL0GnKgrjdbXQkBreusApGWRxD4dCCg87dMXvSr8w1NBBpggJDpb+6+uhjYfTXmGAv+
X-Received: by 10.84.206.37 with SMTP id f34mr93889774ple.35.1483058878515;
        Thu, 29 Dec 2016 16:47:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:e48f:d6d6:5f8:3115])
        by smtp.gmail.com with ESMTPSA id y200sm107462255pfb.16.2016.12.29.16.47.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 16:47:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule.c: use GIT_DIR_ENVIRONMENT consistently
Date:   Thu, 29 Dec 2016 16:47:39 -0800
Message-Id: <20161230004739.19144-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.ga95e92af08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In C code we have the luxury of having constants for all the important
things that are hard coded. This is the only place in C, that hard codes
the git directory environment variable, so fix it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
  Signed-off-by-the-format-patch-config ;)
  
  This is the only occurrence for "GIT_DIR=" in C, but what about ".git"
  git grep "\.git\"" *.c finds some places, which we may want to convert
  to DEFAULT_GIT_DIR_ENVIRONMENT?
  (mainly things that are newer if I can judge the places correctly
  lots of submodules, worktrees and the no data in ".git" bug AFAICT)
  
  Thanks,
  Stefan

 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index ece17315d6..973b9f3f96 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1333,5 +1333,6 @@ void prepare_submodule_repo_env(struct argv_array *out)
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
 			argv_array_push(out, *var);
 	}
-	argv_array_push(out, "GIT_DIR=.git");
+	argv_array_push(out, "%s=%s", GIT_DIR_ENVIRONMENT,
+		DEFAULT_GIT_DIR_ENVIRONMENT);
 }
-- 
2.11.0.259.ga95e92af08.dirty

