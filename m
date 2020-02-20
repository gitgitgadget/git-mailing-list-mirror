Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA9C11D43
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1843D24656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUpfgkfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBTB7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:20 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46377 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBTB7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:19 -0500
Received: by mail-pl1-f202.google.com with SMTP id t17so1314760plr.13
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SpPiasmSu5nM5NYBdp5tPGkqhgk/t4aM+ow6hD0Pomw=;
        b=kUpfgkfwY2NLiKOu+O6TaW6eUWKSwk+C1Rxc8YkJ8Oc/iv31NhUkLvVwlaP3RPimzy
         RtuWAfyo89D0hkvFPsPngfz4JFmgb5Hs/+VX58jWv7PmKYEEvbgNq8PIAyyHFC472VjG
         yFsxV4bGLnyVtHe+7ilbYPXURJlFxiB2DOSqDFeGp8GYL+d3drF7jz9zg5vo22qQzjWY
         Qm7jsZG2327ZCmBTEjVspanPYbXWjowVDnHGRLFaEHkcYUXKoVxQVwya8ApGkiyIqD/f
         0edSdpvdpyoXkkh+OB+Hg25S0+Y58B70ekFqp+he/QMvPLpA23Ehf+xiJ676S4gbunIm
         f73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SpPiasmSu5nM5NYBdp5tPGkqhgk/t4aM+ow6hD0Pomw=;
        b=Hoe4Vsg4lixbpsBRzpeBuFCt2QZ/q+BPfIjnNma8UhHk3TvsnHqjZiB+i8WERJj9Em
         n9IBw++xaUqxt5wWXQa909jU7z9STvNxae47/9W/DU/S7boZpSX5x9qXTSSpXxah4znU
         +eeO/x3v1Z6rZc5noJaGHzAitz8/p1bW8PBMiTyzVQi3doQPMRx/Zjx6F4JWF8M/FAV8
         +Oq52V01Ucbfdt91oUXgzfFZab5j/Z5/OoMAhSDJrh5o0bIqQfd3JbnEUqQzFPGWnm/J
         /T8N0Tl3DBgfVemjJ0R/p72/mu8rqGjRb/igBRWpllQwY5XDXNVIUQ2SyhiKtOI9INXf
         jIgQ==
X-Gm-Message-State: APjAAAVKNum8NqKZ7zADsCc1ml+XS548CJmeTddMDEPUjn4rtarKuSoc
        CMUmbqs+P6YdwzpDa9e4jpcKJu+DsUapqhZhw0BcbZTuqNC4IlvqyUuhPAqKRIbRwzQIWWB48rQ
        zZJ0OYgsE/Fy6M7QD39f0mdxEDoOGQC5CVgGEI/v0dYGqAboysvpY11qCqzRxCKS3s0AHMj7VYA
        ==
X-Google-Smtp-Source: APXvYqywI8wL6ftFbAfpO3pNKEcxWnhLFW+HE+hGZ7H5Wp8+6FnGh2nb+m3gWSyMk4X+xaY+qFfLuaHdydrFbWBVAAU=
X-Received: by 2002:a63:ce03:: with SMTP id y3mr32003841pgf.427.1582163958259;
 Wed, 19 Feb 2020 17:59:18 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:48 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 05/15] bugreport: add uname info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The contents of uname() can give us some insight into what sort of
system the user is running on, and help us replicate their setup if need
be. The domainname field is not guaranteed to be available, so don't
collect it.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index f44ae8cbe7..17b0d14e8d 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -26,6 +26,7 @@ The following information is requested from the user:
 The following information is captured automatically:
 
  - 'git version --build-options'
+ - uname sysname, release, version, and machine strings
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 27f813643d..06a63cc283 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -7,10 +7,23 @@
 
 static void get_system_info(struct strbuf *sys_info)
 {
+	struct utsname uname_info;
+
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, "git version:\n");
 	get_version_info(sys_info, 1);
 	strbuf_complete_line(sys_info);
+
+	/* system call for other version info */
+	strbuf_addstr(sys_info, "uname -a: ");
+	if (uname(&uname_info))
+		strbuf_addf(sys_info, "uname() failed with code %d\n", errno);
+	else
+		strbuf_addf(sys_info, "%s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
 }
 
 static const char * const bugreport_usage[] = {
-- 
2.25.0.265.gbab2e86ba0-goog

