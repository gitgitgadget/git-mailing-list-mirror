Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD48CC3F2D7
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39B421739
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lL+JeGpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCBXES (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:04:18 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53416 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 18:04:18 -0500
Received: by mail-pf1-f202.google.com with SMTP id c17so617469pfi.20
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 15:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O8ANs7twFvdaz2j1puYgi2ZFbPsFwdSmhVbUBL9jo+w=;
        b=lL+JeGpZB5PtH7gjaRyV3oN/10nzFfVBMVJ9MoPd1YfZl4ORpEP83XxeUb+0Ons+CY
         5//D8wlafBCiaiNdSAhTT84DemWZQqIpT6O0q2BJaQ2PZr+EjavWtVgtlthtufIg+H9w
         vUxDIOkqXhYmul144R9zNSLd+unigRnUzRAaadpdA51Q4Ew+wTrjt4N9mfONLqFcCPBV
         5pntpFRRrHsEniZdIbu2zyezOprw35HrflWKdF59j1I9cr7OARIr5aGYqVReVvl+iOOs
         OBEqx/I1hvz+8cMUU3FagpePdkAlJr9C8ZFpTTZsw+MRfiuEmxzTufYpYD2SnrVWZJsf
         MmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O8ANs7twFvdaz2j1puYgi2ZFbPsFwdSmhVbUBL9jo+w=;
        b=jCh3Tv71S8l5jhB/4hsrqqu8ekFFPmdjnSsZ/lDhBEBGzuz3JrU982qDcP9Oe37CAG
         kSUDFC4yMIllYzb2/6ljSe3AqhJ1WapxebG1UYlcJWy0UY/g1Y54e//v6HZuuRhgszQT
         caT2H7+xRx1Y1xVcKcBhf3DCRPecX9Hs1YsEIETvmxRKOWL4Us9+PQIZcnkIMe0A49ih
         59Ov/ZnQHUD9CvflsE1vULpl7eC3v46MZL/zwJwVjHepukhD847gJHwD5cIwKnEEq3IP
         Kn1hGwhbr7U/ErRMl88C7yU5QZA4kRHpZwWA9JnfwNCeoha/Xnrbuwo8QU5dRmckuCHj
         oH0g==
X-Gm-Message-State: ANhLgQ3tgLgm0rPPhTiZlFU7nUXYCe60bzJdqkY/sIrbSvWG0CHbeJdi
        bzBjUL2YFtLH0nzUD4GL6mV7dCwlAf7e+cuEr87JPFiGbBMV0es/2+l25wdk0BMyedWk/UR/NvZ
        tFyaMK3fza+KbsELXjlo19jKCi3YH/O8CITzXrXlFACRfE81kRU/pYpnJv18kdMXJkQ+PR9bAbQ
        ==
X-Google-Smtp-Source: ADFU+vsGtOLuAQkhJJ4F6lMenfYhPSvGawwC+N1ULMle6KlZnJ+byVSNgH7STg3cNJS1yK8Ppl8nZyK1M6fGf4D8cL4=
X-Received: by 2002:a63:b047:: with SMTP id z7mr1115835pgo.431.1583190257211;
 Mon, 02 Mar 2020 15:04:17 -0800 (PST)
Date:   Mon,  2 Mar 2020 15:03:59 -0800
In-Reply-To: <20200302230400.107428-1-emilyshaffer@google.com>
Message-Id: <20200302230400.107428-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200302230400.107428-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 4/5] bugreport: add uname info
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
 bugreport.c                     | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index c20437dc6a..857b4f712c 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -7,10 +7,24 @@
 
 static void get_system_info(struct strbuf *sys_info)
 {
+	struct utsname uname_info;
+
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, _("git version:\n"));
 	get_version_info(sys_info, 1);
-	strbuf_complete_line(sys_info);
+
+	/* system call for other version info */
+	strbuf_addstr(sys_info, "uname: ");
+	if (uname(&uname_info))
+		strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
+			    strerror(errno),
+			    errno);
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

