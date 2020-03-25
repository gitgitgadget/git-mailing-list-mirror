Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A368C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A4920737
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqnyPPP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCYVZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:25:25 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50654 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCYVZW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:25:22 -0400
Received: by mail-pf1-f201.google.com with SMTP id r13so3273265pfr.17
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1D1XhCEQSedVnIAfF/cOlhdZAMyLLlkKrXaZl+LH0W0=;
        b=JqnyPPP1n/HGv3jGc+pGqhE9DOLoAZVlQV2DpZ9rtn6h6SKe2peTf59uAplglHFura
         SxU78FpHQ+MarfMoRafjuTsmH8FzU+Fo45akG4v51p92Bj2WmyX9B889RropZDP112E/
         JKKCkcm/RP7PhBNoO4+NiaMtKYIK88NvPRht6LZLemmC8/IVBuRRLEtk+QMKaTDJ5uSn
         tUMFzE9eHxoiFYFmuTZwleMzYkHc5IRlG1agMo/0Ig9MwaYuB3Mby2Ui7KZgckv8BnT6
         dMzWD33+5FIpwjCKjydIu5I/wQZzZhXkLHG+ihKGRb5SOuuARj/QxXjr5RfUkAK3AoAC
         wsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1D1XhCEQSedVnIAfF/cOlhdZAMyLLlkKrXaZl+LH0W0=;
        b=PV8oWQKTwi5tbcNnR6YDZQTIcNlV5Stpx/nGkJNMQf+Y/eCUeUCiTwbkNaZDYBXRZ4
         zjuHVT2Eu5s+l4pRMvtc/zyhAfDcaehQrMmckHQIl1ZaRdsYm478CfodBVGR8ZOR5Ju6
         p1dOQ5Scyj+hHcdUNboqGKz8gI7320BQKCPJeamtJyghiMqbutyqdsIvDAgLE0tkHBkh
         nZqInJbOWE7eytoKPf4oAKOsOr6O3whawkCVERgIpWe+wRkBD5P3InVuDc01nv0oEU3m
         lDy5MKkVFPODBr/dAdY6p7jdFWPZv3B2XfA9eIj4uSTB/pCe6i21xx0ii9C7sc2CggDz
         kmvQ==
X-Gm-Message-State: ANhLgQ0bDCAsQiMHaJp796KTy15YOw0WH6OytJIQG9kXFlw/p35K97RX
        ZjcPm5W2KMCUH0PY1MA+VJh5hRwWe6m9WfbxLlqJB35OjwFsLpJL1iij9oHbeFEI1vCKTGcvwKM
        V5f5OT9gCHNHDSg7ii9/ndHIhIImbKCZ6jGIE9j0Ztty284ZgKcKiZXrB5POsukhNGjSVaMe0cA
        ==
X-Google-Smtp-Source: ADFU+vssJsZbKrfRjHL8ook5RoTlTewyhiQmjVqRYzb/bGriOMLTx8aeThUBuwrMi5j5kiL8IxP1NQTMwxFLWeK33BE=
X-Received: by 2002:a17:90a:c257:: with SMTP id d23mr6032150pjx.192.1585171521777;
 Wed, 25 Mar 2020 14:25:21 -0700 (PDT)
Date:   Wed, 25 Mar 2020 14:24:59 -0700
In-Reply-To: <20200325212500.135046-1-emilyshaffer@google.com>
Message-Id: <20200325212500.135046-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200325212500.135046-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v11 4/5] bugreport: add uname info
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
2.25.1.696.g5e7596f4ac-goog

