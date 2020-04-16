Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD298C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6231221F4
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYIA9dRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgDPVS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729283AbgDPVS1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:18:27 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7AC061A0F
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:27 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q57so90771qte.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qrpJTHHFiNdCKtGrX5QcOu6SRNlpkXP+w4r4LTZUAPg=;
        b=aYIA9dRA5UbD4qwIHfKCajSQkoraY6wffgS61I7WV9BNgd5/7jQOy2QeB8/h82b+mB
         T4VOVuJVSNPpFASUnT3Hm0oL8rx7rknPJJxq2xkIQIq3swqLiGIm/303CMfJBFdrCPV1
         DDR+ZkQDdwLr5K3ymPzeD5IA6CTCxDINsdIMRdlma6lil0SEBcAG4xHrw2lsyhVnxZBL
         q1WPtBDSgw7UY1XOdUAqtcXIF10CNueBhfZw1Hrj8Sn/OGhvrfLInF7vgpTzd3k3uVRQ
         +KpFaDLPD74qIHvhqBD+oDkxm8HExyJ3vsI6FW8ESVhG+tai444oUw1ifxrN+XXkasE6
         RNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qrpJTHHFiNdCKtGrX5QcOu6SRNlpkXP+w4r4LTZUAPg=;
        b=i0YbaFsh3lZTbE11RSXc0mAkDLvU4eZNm5SfhvCPTb5Y7tTbgKWTryyC1suKCUntaR
         6O755QZ+4ubYnowKs0FzC+a+3zJYvGt5xzmydPGfmti96kpVxIduAU490RJ7tLXJYmvx
         /1MR9iCFWtb98Us4dGIaVmQsmXB4sSTn8FLRrdtyXbCZO3g3B0xgwFxa+DKvF1rDW6/m
         HugIZNzXrfVAUZdiSXXe4PbG4QW7j0BO0o6cHfxWp/nArHs77BFnJ4auUtw654wmtIOz
         ZMCK6h1uV/AdVAuzf+tzVqHhWo7BvXKE9TrgEjYu5cZcH0gTZIbYKxFNx0tdcdQzrwiM
         GFhw==
X-Gm-Message-State: AGi0PuZfn2fvOoukmRJshJpjgAnoDcGcaNRPJCqfRohiO1agmp6ILDMw
        Sz8PtEezdRs0rFr7W0oqYZdmdOuyRbePlXyp/CjIiAZx8+y2eOIjgNOc7Bl814zp7iU31qv5FIi
        vdRe4J2BfNl5MZptIz2p+MC8uW0fipr1y7q5k42Ef9H2F1bZu7fS9zjCykrgNzhlu4VBJz4bDjA
        ==
X-Google-Smtp-Source: APiQypLdj4bc1p1UVtw4bHtseNm+MgiraD/mB5hPZCXh26CYXcSobOBfFGropz7tZ/mwvvhGf3/7H1o4upJbjPLrdeg=
X-Received: by 2002:ac8:514d:: with SMTP id h13mr28633990qtn.226.1587071906417;
 Thu, 16 Apr 2020 14:18:26 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:18:06 -0700
In-Reply-To: <20200416211807.60811-1-emilyshaffer@google.com>
Message-Id: <20200416211807.60811-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200416211807.60811-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v13 4/5] bugreport: add uname info
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
2.26.1.301.g55bc3eb7cb9-goog

