Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E302C352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C4A20848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgbTuakU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgBNByV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:21 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:39922 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgBNByN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:13 -0500
Received: by mail-yb1-f201.google.com with SMTP id y123so6535710yby.6
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/khBfeqMsFSzVsQmvZgWwvtD4WlIt5dmIasVZVck7D0=;
        b=cgbTuakUbyjRZBbpxC+zuIu/FzA2/xFOEJcovBRo5g0IiujieuLIfC9MqjjyqmlRjx
         SEJrDyDMJXUXEweVl5Q5/cWfxw2Ijq0Sb2hcqqPSCRjPFjXs9gpVo7xs7sar6BVuKQOo
         VOAeAyvOaHaxEFOVu4x15CqL+lmOkXQlc2Glgwv1swz5aRMFYjjwMxieUefZYEj2YqOg
         40JC6gbk9zxsa5lTMggNaJBjvX063ER7QkZqPemYQbTqNBuAKJy2a4uBTVDPmyhpxa7k
         teb2TobzV0xV8/2UUOr2Uhm1gwIqYxIhY1FvBxmUAfawLEr1V6jyrT0SY9ieDld7r8rU
         0NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/khBfeqMsFSzVsQmvZgWwvtD4WlIt5dmIasVZVck7D0=;
        b=b5WXeQR5MIi75Tn0lvD+dW2mXlxrwj6qpA+Vr2+H56r+Fbo4V1IzuTVJkZBgCTq2cJ
         5iv9ujNOjgAt/ppFbyt5UExGwEz8ma/uUc2pAexqyuv2phrmJK9HhUhXEGWt7PwvD5ft
         HMO/09CMV+LAFam5qSPen9EXS9i4IrldTWwO9hOq9VpOx2PTA5nmEiSCumvuV6iJifUG
         74nHRQWrsjj4X7yblryixI1omeQXa+HFliZ5/0USXhu/7OTBOS/QgNzp0rlRRDT/D9h9
         0Rmhtl4qaMGD+xxN94NsgzTyEJ4W9/temB7qmWBLXIKh+a+D64WG5hKuhgNVpd8wG2jP
         M/Fg==
X-Gm-Message-State: APjAAAVV8zolB0IeOjTq3/jt15UagxmMycqlNqNaTz90PW4vLz+RfApM
        4MVqVZEEO3H6zHnblG25U9QNHgLSU4rc8L0mFoYf8ZKi9SBa7GlJEkuJ9JBVj/j7Ut5ACJui7UP
        F6m5ZI8/H4SABvxS0j2l6O/0vWrMdxwt2bPpkupJ1emuO1nqrkxL8ap0eQPtnX3oL0PltMyAnvw
        ==
X-Google-Smtp-Source: APXvYqy/77rjyC8bDjBb5rAucZn47xqZzlsSV2akABB4mGhIis7efko/csip7bjLV+/6KJU4J6TTI8qhuWd9aifVRvY=
X-Received: by 2002:a25:8041:: with SMTP id a1mr608697ybn.420.1581645250665;
 Thu, 13 Feb 2020 17:54:10 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:36 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 08/15] bugreport: include user interactive shell
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
index bfdff33368..c1475601bf 100644
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

