Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5CC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C217C2166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OolPfQPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBFAlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:35 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33954 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBFAlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:35 -0500
Received: by mail-pl1-f201.google.com with SMTP id j8so2171553plk.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nJNkj4A/VbaQrOpNCNLsBz3dJqXhe+B0PfpbB72FC2U=;
        b=OolPfQPs5R4WNnd4lnXvbSE1NifGMFaAr1cqQkckM8sQqOQZXiRypx4vJ2/98LD6MU
         GK4Q7Wx18Z2Uoy0lKM9SYQl+ywOeaHo7hH7ziqLu1TbXEZAbM3T8OfxIiaEZTEeOKhnr
         2FVxOQO9Kjdjjk9qHFnWIFzOIctUBqu88CcGxA8gHP7T+6ig3nKAt4PISvHxsPGaOyWm
         890nfw0fMakbEHsEPIq7uhePdn138rV2XSPQSJB0ZpK2kRNWY5C5noTH5EgAKvQjhTAp
         lIgZ0uXa3GbViOSzSbVw3D2/X6ktyIZp+uyLT+pXCi9zAlxIF5+u+DJJaoZTI0gcDtzq
         8o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nJNkj4A/VbaQrOpNCNLsBz3dJqXhe+B0PfpbB72FC2U=;
        b=f5+U1b7roN21d+Zun+uxyuwAh2zkr1pUq0M4OS53viANgn/Oj1gYKVBAhQ0S45Zdi2
         9zDyYtqFDZn9dmzpqAghHMnRQ6dLqnl7lRWXqkKMiWPahDXNEHJdhUUHWj3oXtwmVsQm
         q0VSHrabHzSTMHPHuOWMXk9/FRXjHIRPtifafqL6Od5A1nKWp/sGPjMDoLhVXhUd1CE0
         XiLaE0cCgIGCcsV8TnhKTkT9Nj7O7wSEswh24bIhHCEO/OSaKxF/XC5/tB1uTq4lsZJJ
         lLjFkGNH9mlL5z1m72kGtm98HHWg0MF3wIrZ9JKOznPTFBcVnog/AgikQaRR0tBzHjgI
         T3Jg==
X-Gm-Message-State: APjAAAWGQljPnZaAa/OxJ7A9xByolCeAhX/TXyyaNztFV2T+vWE+4U5q
        Zy+wcY49KhjaGn4oFyvjBvpeQoR83ya0rFKPC7UXBly05zIYSB69SAUM77a6fMA4ofTkPXVTv2q
        wy7lDryJfiBeaQrXirGY4sWF7nELPdt2Ax9a/HBNFlG94EV7dhOk/pMa1kZDlRfytpPSPt6IOMQ
        ==
X-Google-Smtp-Source: APXvYqw7WaWCGymzfv8ep2tH7G0zfEwG2qrKfNv9r3ZC9GfmMF0MbkVXsDAoyGphmhfyEzHaT64wsyZuExRKn5ldP6E=
X-Received: by 2002:a63:7a0f:: with SMTP id v15mr629063pgc.139.1580949694024;
 Wed, 05 Feb 2020 16:41:34 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:40:58 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 05/15] bugreport: add uname info
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
index 6ce2ae2eff..4dd72c60f5 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -26,6 +26,7 @@ The following information is requested from the user:
 The following information is captured automatically:
 
  - 'git version --build-options'
+ - uname sysname, release, version, and machine strings
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index dd21be9d68..4c4b877ea1 100644
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
2.25.0.341.g760bfbb309-goog

