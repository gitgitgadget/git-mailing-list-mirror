Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA14C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920EC217BA
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNg2KUID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBFAlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:44 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:33754 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBFAlo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:44 -0500
Received: by mail-qv1-f73.google.com with SMTP id g6so2669283qvp.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LiqBU2NZJkFohItMVyTBnqvVVK4vvXjflKpGmKVrOC8=;
        b=NNg2KUIDLfPOEub34yu33KhTLZvnWM5jolTQWQmcw/Uizp3lphftWPdASJYMfPkqUr
         LKhxXBqLlZRUV+UE8b27Svc4kk7ON3lWHq78dHcJI4gsVZ+YBm7pN/WwnjvAO+cNzO8Z
         n+4Ape0I3KJdOqVGIktok70PrsuthVwwtw4vxNae8APyJr0bRUOtcmBIABVuM9W82tV3
         q8MfqFCFkOsIT657WbE9s2k20zVqjFqIswfq6b0FRQQlq6ghFD0+xMNuXTa1CgTeyo8a
         f3fBr05rE4r9xCPsNigz+x46FsBicF134CCmgXDbc0j6dzdk35mqVmkqtOOD+lXXFNnA
         2q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LiqBU2NZJkFohItMVyTBnqvVVK4vvXjflKpGmKVrOC8=;
        b=UAHqlQzt49RCOtEEEcKPJtiAKpg6LhsttdL7sz6xRprsIzbsP9c5ZsW93a85YgE7m9
         3TSqgIgTKiViJwl0EDSc0yIvEoQfTWyWbH38GBzFCKHlgTAVkrPyNQYcZS1m2gLUeEPM
         dqkt4Ybj9Jw7fhfN1N9AH18JNIUDKUNvbzYSwviTi1Hi7Wc77+VHHEa+xcaeyJKIhhHs
         wAJ4nUkhgAb8/huoRHZtBOjtY+rE33K06CfFFWiY1OHnz5QadbRXzIEOTx6ZuAvd1L5F
         7y9dlvAXVRgSHXvyi4utBiHkUL6jsuyT5KR39rculSIWHu7r4YMPxDwOuLRZPn0QNxpP
         ZSbg==
X-Gm-Message-State: APjAAAVWRkDfL9aCwscD9bAz7n7N3CT/tvRSvDPR1hMmIAzkXQGU+F9r
        yYM/9OUG1jfCRyL6ZRMdf+ACf9LjtPe1VB8UaNKFHB0NOdXj1yDcX6TAxmqfypXmkyjlIPTppz0
        fbep3aplOiTMBn7Bl8CXcJkPHTBLep79jtRSLyv8oWnyLFqrOLmsxuY4YA8KY1Q/kAq2xbkOaKQ
        ==
X-Google-Smtp-Source: APXvYqynZxYDoM0+hZLVwOPinmqY+CjpOJrZVBYlvcrhsKMT1fVq7kplFqvizHun0SaaZCuO2iau11XJu/BDD75L+bA=
X-Received: by 2002:a37:65c8:: with SMTP id z191mr394838qkb.176.1580949701476;
 Wed, 05 Feb 2020 16:41:41 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:01 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 08/15] bugreport: include user interactive shell
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
index 33df4dec7f..23265b0d74 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -29,6 +29,7 @@ The following information is captured automatically:
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
  - 'git remote-https --build-info'
+ - $SHELL
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index da5859c131..9b51250155 100644
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
2.25.0.341.g760bfbb309-goog

