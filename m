Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD85AC636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 23:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBOXO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOXO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 18:14:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0B43BD96
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:14:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so251392wmb.5
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGyry+gRoV+IicrLG9/7ONZknLUAgd4JqkNcprZRDSE=;
        b=OnZ28yQ8xgjZhZYZTstIYwgZaKAR84oLY++a2MlqmxJfEK5woxM9GtUT9ybRXGRtsT
         Y+rU+u+M+iPZF7yi7BRMhYX1tl1NP4Lwmg6W+OL4DuKViQzAzcLnJfhBcB0GedjFPFFd
         TPBri/x939uddfG/zYmUYzd1q3wG+PzToQqa+6Q9uuD5C6XkhSGl6VqpiuPiB5ZKgZrM
         7FUc+KGznxmenV63FLbI7IbEZ3r8gHio86YfR2jmr8eD+XfOCho9gnucEoeUv5Rwn7zi
         blsXMyPM9dbY+NMUWH3um2AGWeiOfX3WTfkYDSKc7J5Yx6DUxVofUsF3Wfg9bWQDnUt9
         ZVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGyry+gRoV+IicrLG9/7ONZknLUAgd4JqkNcprZRDSE=;
        b=C9fR9oQvYU3yrZbbmLzYCAIErZkagJuIZsbKgbqphEdCUAm4juX3NVqTKr5EGX9m0i
         oTPbr3F+f31r+SVwyKxYhBf8aqTsk5X3oS+tKNrcd8c4CZVvTjtR5z4a+d+uazDqzuRZ
         LKf313lPSvNdu+auGf4Z71mmmGsZgkUU1QPkHd0j4hqYUe8LY1qsoR5zg59xutOXcoP9
         RMGww0QbMAzTkcGOGnviL8JmfB9aO0rJqaGno2iKi6FIJX9aGMIrdhnVpm/eJMMJKY33
         8Oy6fiAsc/z6r80DYcuZ4Oh3Kqs4DON/xLKLOtg4NJM8wmfXhOXi3SVuI74ySTruQmHj
         mv4Q==
X-Gm-Message-State: AO0yUKV6BROIV1+paomKwuWM4ZAto83uZpxl8NQ9AvyqxT7NeYuPtJjK
        wXzrDrCKBrCTBowTt4DS0AiFgw+HsZo=
X-Google-Smtp-Source: AK7set80zifnJIN9uaIFnfVkvVqUC3EmWQmCDHfFU4mjDa3yjYuXyL5X71qFIDBnRglDdmVDP3yDIg==
X-Received: by 2002:a05:600c:4393:b0:3e2:8f1:7684 with SMTP id e19-20020a05600c439300b003e208f17684mr1227201wmn.33.1676502895572;
        Wed, 15 Feb 2023 15:14:55 -0800 (PST)
Received: from localhost.localdomain ([41.109.184.71])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003dc1a525f22sm3876927wmn.25.2023.02.15.15.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:14:55 -0800 (PST)
From:   Idriss Fekir <mcsm224@gmail.com>
To:     git@vger.kernel.org
Cc:     idriss fekir <mcsm224@gmail.com>, gitster@pobox.com,
        cheskaqiqi@gmail.com
Subject: [PATCH 1/1] trace.c, git.c: remove unnecessary parameter to trace_repo_setup
Date:   Thu, 16 Feb 2023 00:14:28 +0100
Message-Id: <20230215231428.68040-1-mcsm224@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230215104246.8919-1-mcsm224@gmail.com>
References: <20230215104246.8919-1-mcsm224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: idriss fekir <mcsm224@gmail.com>

trace_repo_setup of trace.c is called with the argument 'prefix' from
only one location, run_builtin of git.c, which sets 'prefix' to
the return value of setup_git_directory or setup_git_directory_gently
(a wrapper of the former).

Now that "prefix" is in startup_info there is no need for the parameter
of trace_repo_setup because setup_git_directory sets
"startup_info->prefix" to the same value it returns. It would be less
confusing to use "prefix" from startup_info instead of passing it as
a parameter.

Signed-off-by: Idriss Fekir <mcsm224@gmail.com>
---
Thank you very much, Shuqi Liang and Junio C Hamano for your valuable critique and suggestions.

 git.c   | 2 +-
 trace.c | 7 +++----
 trace.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 96b0a2837d..6171fd6769 100644
--- a/git.c
+++ b/git.c
@@ -430,7 +430,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
 		/* get_git_dir() may set up repo, avoid that */
-		trace_repo_setup(prefix);
+		trace_repo_setup();
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
diff --git a/trace.c b/trace.c
index 794a087c21..efa4e2d8e0 100644
--- a/trace.c
+++ b/trace.c
@@ -291,10 +291,9 @@ static const char *quote_crnl(const char *path)
 	return new_path.buf;
 }
 
-/* FIXME: move prefix to startup_info struct and get rid of this arg */
-void trace_repo_setup(const char *prefix)
+void trace_repo_setup(void)
 {
-	const char *git_work_tree;
+	const char *git_work_tree, *prefix = startup_info->prefix;
 	char *cwd;
 
 	if (!trace_want(&trace_setup_key))
@@ -305,7 +304,7 @@ void trace_repo_setup(const char *prefix)
 	if (!(git_work_tree = get_git_work_tree()))
 		git_work_tree = "(null)";
 
-	if (!prefix)
+	if (!startup_info->prefix)
 		prefix = "(null)";
 
 	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
diff --git a/trace.h b/trace.h
index 4e771f86ac..b6e35b9470 100644
--- a/trace.h
+++ b/trace.h
@@ -93,7 +93,7 @@ extern struct trace_key trace_default_key;
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
-void trace_repo_setup(const char *prefix);
+void trace_repo_setup(void);
 
 /**
  * Checks whether the trace key is enabled. Used to prevent expensive
-- 
2.39.2

