Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9057C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C60720719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9wD3ONT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCWVn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:43:58 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:51399 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCWVn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:43:58 -0400
Received: by mail-pj1-f73.google.com with SMTP id gx19so897833pjb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1D1XhCEQSedVnIAfF/cOlhdZAMyLLlkKrXaZl+LH0W0=;
        b=t9wD3ONTc4s79KBEXzVllxSLSaythSSoF4buAAUO7aFVy48qDa4c4g5hurpMv5EedY
         i9tjq8ECXbSBtZLALHl2KkEh1z9KmH/Hj/hk0d7GvKfiwuFFw83UNjI+BiPel72aQM2o
         rHjwlWzsG4wQc7MvIkodGdL4+BnAZikNaWx4GaRAI/rbGqEzUFl1zqm2QImF41a2z2gl
         KHoG5p0PaNc/yUrVOnn8JV0yXsoxrRbYw/Epv1VVkEhHJnzFND9/1/vPWLB2WK5IW1TW
         lP3o0bvs8qFQznyAzSzdJaqkWDCFYSzwI9mUKK1hpF4CYA5yUt0TF9C56yjxRuZsncTV
         dLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1D1XhCEQSedVnIAfF/cOlhdZAMyLLlkKrXaZl+LH0W0=;
        b=nlh39auEaxBObIyKdHLwM2qaOeomueA4pHALr7RiYXbCmfTXtSfrT2X1Fxun+W7BOR
         jqUTU76Y/J/s8rTV9+Xca0UrYkBZF46saElKA2QhC+Kx324bQUiL0F5yqOJwuZnvysJK
         MEnSyEhrZB3Q/b4g1HRhIX5pxhoj2j/2ItZ19JPXRK+sR4BJBUuwp3Xse9iN19rWIbRF
         NZ9icubXbYWWvyzh9Ga9Z04BIAWYU5IynwT8UbcPFF522/K6p/uMotZV6GAuVX1RKviI
         /Hn16uZ6I/3VU26GGywzgG7qlTXhjMD4UBqa1gKInaZkESYYwGYyoE5zjEdVYh51MSmJ
         MOeQ==
X-Gm-Message-State: ANhLgQ3IDqY4jSBOqp+JnuM4jAuawWTZ7JUZMnRgryQVNXUHsMQgJAYd
        ooOIm7fgfY44AsUlnR3mjTNthGyP7zQVflnv/BtfgAPrSx2rhuvvGx1kTvntjj2ixSoxWGB1Gqs
        FnapE+EPSnR1ljb5EBxKqe6Xf13vVf9SWtFEHN8/TjFo2lvYhoILjOBvicYaW8lfOa+UsBWClWg
        ==
X-Google-Smtp-Source: ADFU+vs3xAJEYgoVIU+i7AcKoiV2xrWc/UkYd3acVeqoek+kumQ5hewexrpPebcnbLjRFqZC+a8YyuUO6OsIR08fECU=
X-Received: by 2002:a17:90b:1257:: with SMTP id gx23mr1584772pjb.14.1584999836712;
 Mon, 23 Mar 2020 14:43:56 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:43:39 -0700
In-Reply-To: <20200323214340.182724-1-emilyshaffer@google.com>
Message-Id: <20200323214340.182724-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200323214340.182724-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v10 4/5] bugreport: add uname info
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

