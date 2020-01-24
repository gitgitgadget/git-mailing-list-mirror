Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C327C35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC44022522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmPv22p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgAXDfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:23 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52453 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXDfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:22 -0500
Received: by mail-pg1-f202.google.com with SMTP id w21so564655pgf.19
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FwPvDDx5s/e0Cs6fgauUA9tC1FV9pA2MPKvMDI8L53o=;
        b=AmPv22p6xNfLITPTNBXNHrPDLISxCDqnqoRn+ovJ2xszURWQBSWSiOquu1394YrYNO
         qsxCXzQWsebszgtC25w/KMynk8OCVMCgqcnYkSCJAK6jdpXrHUFhN0b1opRGzcqZHDgI
         wthCqL5ymfBMvyXQzwIBCk449WZ60+rXnQfduHKxIv4Jgm5n01ln6+b4Cenloa2ia+8T
         qOxN9URjE7wpfqOzXiPB6+x8BcBWVtLAv2fjjwkwUJy3YatMGGCaL2uyNrsJ4dMxtPJ8
         Qm3VRHeDo2Qa52QQoB5LH9SRf9zNdA2fYipcIqHn9HP3Xf0zHAxWVDLSbcqqoaoTafTP
         +NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FwPvDDx5s/e0Cs6fgauUA9tC1FV9pA2MPKvMDI8L53o=;
        b=k0icHq3/tyQq4w7lDz/AFa25eZ5sjoU2E260Qtb4ziYmGSr0gX9hO76Jnu5q3hxLO6
         Kb8jrtmfi7QCZvV2PDKDnFG7FHFK5jSo1h07e47xYlojEG5rngifbKgUhZ4RSiRwTV6P
         2IJDB97tDnv8eQbHn6YDrm7ya1hTio2nysvqTlzJQPI59aLX9D/ErCG9Qq1xcQtPpQRh
         RLFx7/ITpnf+PXpF13QJCdF0wjdgBLacWALLBaeNk1Oe4G5TpUszbWgCdYgqUu6yeizH
         h9xqSeHCKVdEujmldJWxkDp+gEJyui72yKiNrFrTpFOQEoJRk+40L6FOn3+jXjmcyRp+
         yE0g==
X-Gm-Message-State: APjAAAXr2ElJAbEI7NwuPfGRhJWyjfkLKRQEQdtY5CSKDW3gpfTpBFcU
        9Bc9q6yH/A39Rv+rY+Qqy4MT8UGDJjH5wdtWWeLFePtsLche33ROhTmT3LTYCZ1YOnjGLNvOYoo
        XbUXyJBV9iG3MpB4jiRv75hsUPBl1pv9lsXPZsoCWConcuRAlNoPdjRwoeHnNlFXnoVNVeVANXg
        ==
X-Google-Smtp-Source: APXvYqycRo8TblfCyWT84Szi6oI6TkmWjvVIKNu4n5r0QFloDEbw2T0d4JJIeEIRfoPUSUFMWDHRBaJm3WqcntlZo08=
X-Received: by 2002:a63:149:: with SMTP id 70mr97968pgb.206.1579836921709;
 Thu, 23 Jan 2020 19:35:21 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:26 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 05/15] bugreport: add uname info
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

The contents of uname() can give us some insight into what sort of
system the user is running on, and help us replicate their setup if need
be. The domainname field is not guaranteed to be available, so don't
collect it.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index b1a5a279ac..720c91e1bd 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -8,12 +8,24 @@
 static void get_system_info(struct strbuf *sys_info)
 {
 	struct strbuf version_info = STRBUF_INIT;
+	struct utsname uname_info;
 
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, "git version:\n");
 	get_version_info(&version_info, 1);
 	strbuf_addbuf(sys_info, &version_info);
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

