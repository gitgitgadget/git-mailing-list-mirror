Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25863C2BA80
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC90F20768
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4QZ+2+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDFWpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:45:44 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:57063 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDFWpo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 18:45:44 -0400
Received: by mail-pj1-f73.google.com with SMTP id f94so940296pjg.6
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DOU5MCoYa4zauj6NBGHDdbNf1kW7bolvbPlGx6zsZ8E=;
        b=k4QZ+2+s6s02Ugx3e6T5EeHw1+Fm0R38mE9axqJboockHzkFs43NTSWwCIVUxsRTN5
         ocMgtHZcOCvPI3oZAMv1N8FRK2K3dm71cQxCOm3I255JiKKd9lRJbdNHThU4dbP3+IIe
         jXCUrOkIYX3dPA2EQsvrRUKP8qZfYCRfCQnHU+feQcSRI5ujxqAoXdVYPf1Q6junVGPj
         gxIeeWIzWpGyKr4/UFzE7oqVDKxnP0tmyka6U8lmh3y1RoTZxJyenSUc/kQ0HxqahXup
         hNFVZvKST+jepCWDx2XdLXz05sV/DU+2C6EbGTwnTAaRsUGYtXCAsZuqdJ1InkQBgiwQ
         j6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DOU5MCoYa4zauj6NBGHDdbNf1kW7bolvbPlGx6zsZ8E=;
        b=e+zV2huBIsIY/G6AFKG1YhuIqBX+QrMTxwLf7orgcN8ISnvZeJ2V/9oFnp2My9r1rG
         ptQWaCdw04NX+2N1Ul4KtttO1jPlJfbZ3wB4fmeEF3jX9fBPgeP6NSS2gtCuUhSkbOea
         XLfPzSukpahBh+USjTkyP0tqC0DkBjlNWM119dAQHjl/pVhIrr/l5wv3mcEj9aDHZmiB
         TNtiQywIXxS3/fGNlsLSPYx/g/hpFxa9t1iKNI33TqXQnFxgEW8XaA8ZjpsfqnpFTgyP
         z5X/Lytr7CcLTwm3sSY9dg6BRwJ6fvk0oxf0TbvQehkI7XrG7hjPZ7zk7x/JSo71lATd
         9N3w==
X-Gm-Message-State: AGi0PuarGwK+i2D97ZOcZ9VqgULAaTyrmJyurTWypogq8iZesu5XKLiV
        KJSsjC8kZM9qjGQ25Pg/yfk0gzT6OrkU6xRcuTw89R7v1cIOPt2YTt33dK1YWxdx0lRDBYaFg8/
        RTTKi1S3ahhSuXHGy52I3eP9SHfLBpPQyyqnd0LfHvt1I5TEPNO8uVbMDsyaQg+ARp09ZEjceBw
        ==
X-Google-Smtp-Source: APiQypKpUqalEhoEdBuahB4l8oA70hC8VuY2jTFXuSJuksQwVlF+TPKbd74PAseOCUdF5bBZ0FGx7+gJ+WMHmEceKCk=
X-Received: by 2002:a17:90b:2394:: with SMTP id mr20mr1610638pjb.79.1586213142822;
 Mon, 06 Apr 2020 15:45:42 -0700 (PDT)
Date:   Mon,  6 Apr 2020 15:45:25 -0700
In-Reply-To: <20200406224526.256074-1-emilyshaffer@google.com>
Message-Id: <20200406224526.256074-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200406224526.256074-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v12 4/5] bugreport: add uname info
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
index 4cdb58bbaa..1a3172bcec 100644
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
2.26.0.292.g33ef6b2f38-goog

