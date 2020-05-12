Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED9CC2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A7206F5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xvcx8eLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgELXmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 19:42:23 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F6C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 16:42:23 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s65so8892299qtd.21
        for <git@vger.kernel.org>; Tue, 12 May 2020 16:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MLov0GeZJkeHqrQGwYSe4mhCoGLxFC2V9Yn2um9qXu8=;
        b=Xvcx8eLx3jML2FoezI4T2EvioeCyIBtLFrHS7CIOOclfTxqgn0xB5wW+q0cu1dfepO
         mkZbmC/raMaLKifYBMFd4Ln8pvuC1pgpywuN8dbNqnsflit4XRw9dMSebzpRxQBpyQNc
         47B3XiMdh4bwWXR6cLJc/C2qxpWHRbaqOWn6X5L/tMX5Mb0viOVOMW6Bc12wPVnbFV7v
         waGkh174Kwsyy2W0qCYazxNHh6dxakmfmjWlTHfTbSZH6G/gbM0aYwlzxMU/HSLF7yKA
         G9I9EKRNIhAIcWtzBVY4TAUXIyQb6t9mx+nWWFmX9lVIlGXSNxDhPp/IH73IUw8LapCw
         WXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MLov0GeZJkeHqrQGwYSe4mhCoGLxFC2V9Yn2um9qXu8=;
        b=CXrDAqbdBQBmNaCLugHyu/+GkOvfSK4FLsIuDgewbIhu+FQlgGmuAHHXuCcl0nlWGr
         DZKQreeY8Fg5uLGj3p25dxgZZPNaSeFDFPO3fOimZHEaEMud7mBPbt0ELqn499/AIHkY
         pEvdeZsQ6g7ydAHAQXWVIyiMbiXQlNWWUEZS1yYcWxPMiHVn3MrWpbsEaFgSU0hrp7Ez
         e6753G0bRUpYVy8tzfXcZa2f97RAAlK0tNO1ik4gr7eZUWyjlwmcOSO7XS0G+tqoABjp
         Q7Kv5PqUQFooNy6PwjQquAGLI1PcXTS/prxJcHFXKl79SKnFEkspl3ndgY6RpBEz45He
         jnYw==
X-Gm-Message-State: AGi0PuYEQ4kXTZb7eD1Lj021DdmHf6OiyxfRzfQj36ilKKWxx25pgj6L
        qEOHHNFQ4tu10c+nVaMTgi5R1sAPqWvEg/IZhFJboRwIgyPHYZvRUrvB4doD721D/yqaDAd0Ne3
        BYph5mAU7/W/CbgWNcbrVQ+tYfDq5tfIfHbw9YbVpv1EGg9TO1T/64BZ4RkzZoheBjlD+pCepvQ
        ==
X-Google-Smtp-Source: APiQypJXDTEApOH8NTMdwj8xJK0FHnGUr0iM8bMw3WLnznVwITH00IMAuV/9cM2M1guSPJLCEmLr634XPPf/W7pVrGk=
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr23200039qvb.6.1589326942361;
 Tue, 12 May 2020 16:42:22 -0700 (PDT)
Date:   Tue, 12 May 2020 16:42:13 -0700
In-Reply-To: <20200512234213.63651-1-emilyshaffer@google.com>
Message-Id: <20200512234213.63651-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200512234213.63651-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 2/2] bugreport: include user interactive shell
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
 bugreport.c                     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 7fe9aef34e..4afc48c452 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -29,6 +29,7 @@ The following information is captured automatically:
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
  - A list of enabled hooks
+ - $SHELL
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index aa8a489c35..28f4568b01 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -9,6 +9,7 @@
 static void get_system_info(struct strbuf *sys_info)
 {
 	struct utsname uname_info;
+	char *shell = NULL;
 
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, _("git version:\n"));
@@ -29,8 +30,13 @@ static void get_system_info(struct strbuf *sys_info)
 
 	strbuf_addstr(sys_info, _("compiler info: "));
 	get_compiler_info(sys_info);
+
 	strbuf_addstr(sys_info, _("libc info: "));
 	get_libc_info(sys_info);
+
+	shell = getenv("SHELL");
+	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
+		    shell ? shell : "<unset>");
 }
 
 static void get_populated_hooks(struct strbuf *hook_info, int nongit)
-- 
2.26.2.645.ge9eca65c58-goog

