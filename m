Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FABC11D41
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A0421D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDYW+K6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBTB70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:26 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55784 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgBTB70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:26 -0500
Received: by mail-pl1-f201.google.com with SMTP id w11so1296759plp.22
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4fAfY9ZuFVJkqi21nOKHqeSxjD/1TQgAIkoaLZ5gj2o=;
        b=LDYW+K6IY5InamqauYcOGzA6vs3vSaoJmlxGGFk3WD00rqvNLDBbA9VggveI+zhlp8
         NtSG9KdmUevIEF4+wUbx0hbpnDKlevZbgZLLvFx/blZOvT7HifGm/Jza+UHbJcKu3xo1
         S4V7cUcWGB9mnE/dr9vZwZrN1sdgdJ0wq+2iYjqprt7AGbHTY6ZOi+130WT3fImYYSHz
         pAzq+arMCsdrQy9yhoYl2OLs9a+ybLwbKRnOCh0J0duRWXuS6lmH5lsRw5ciu4QE8tFy
         xGJB/CSV2zoXT+ZZq0JGACy3AEiRMDMeHJpJY7vjVaoKotnG6TJVSzmMYd51PzKWXFC3
         qVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4fAfY9ZuFVJkqi21nOKHqeSxjD/1TQgAIkoaLZ5gj2o=;
        b=JQpXbw9F2Bq9Tk45/M/wRKF5/dF1NdheoOgG0VVIgT1j82lFACQbf7ZqgO3edX30Ut
         iRXc3VeHeVv+UbpNxwjGcqMjNSO1m2NZUHe0uNqodTCNb0yzj38EsYTf/OAz4WSrXE2U
         otlSkLvwqmfN6XS56Hxn3rhzuQUEzwnBZ+l1SKmRrQVfZP1VOonhoIm+t0MNPjCaVGoD
         UYterAMXFipehoaRfkJP7DNmeuYmb31VsAzjjWfuRhnCNZX02LRz4Qmx1ta6S0HKvhe9
         LEuNVB973YBbIbVa25JFLOxReGbABm780CXJOT9Uh7DykuRcVUmIf3dMQ8GoyBv47KYW
         +puw==
X-Gm-Message-State: APjAAAXUSIuL/7/ktXRw6IzMvZxHweUO+pZspt0Soq78Vsq0Biov8onM
        5lAskmvtgl2bRa4naWlSJphOoBhooiDiT+ho+y13zOPlzAONxB9J49A6VPoK5n2xzf3oVTgn76M
        U+PRkCF0mu1uvcqsM4w6POlN1kn95uIAbvmiD3c4LUPXERIOzZm1Xrv2yMROeiNyP/211/RAzqg
        ==
X-Google-Smtp-Source: APXvYqzZgWC0ob2puEt1wl1BmBjDaOZJySdZJEMCMRGwMoe9ewnOQVr9gHUSedfoaa1WeSC5twEzQtK0HN/qimdQOt0=
X-Received: by 2002:a63:5fcf:: with SMTP id t198mr30369113pgb.383.1582163965286;
 Wed, 19 Feb 2020 17:59:25 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:51 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 08/15] bugreport: include user interactive shell
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible a user may complain about the way that Git interacts with
their interactive shell, e.g. autocompletion or shell prompt. In that
case, it's useful for us to know which shell they're using
interactively.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt | 1 +
 bugreport.c                     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 8c7cb9a5d4..f7a13c0374 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -29,6 +29,7 @@ The following information is captured automatically:
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
  - 'git remote-https --build-info'
+ - $SHELL
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index fb2adfdf14..f143b9a8f8 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -21,6 +21,7 @@ static void get_git_remote_https_version_info(struct strbuf *version_info)
 static void get_system_info(struct strbuf *sys_info)
 {
 	struct utsname uname_info;
+	char *shell = NULL;
 
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, "git version:\n");
@@ -42,6 +43,10 @@ static void get_system_info(struct strbuf *sys_info)
 	get_compiler_info(sys_info);
 	strbuf_complete_line(sys_info);
 
+	shell = getenv("SHELL");
+	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
+		    shell ? shell : "<unset>");
+
 	strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
 	get_git_remote_https_version_info(sys_info);
 	strbuf_complete_line(sys_info);
-- 
2.25.0.265.gbab2e86ba0-goog

