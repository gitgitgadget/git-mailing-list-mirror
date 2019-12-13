Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F96C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D562253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6U+A+eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfLMAnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:41 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38822 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbfLMAnj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:39 -0500
Received: by mail-pg1-f201.google.com with SMTP id l13so351142pgt.5
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qBQm09bh4S6bFa+KGMXaVCUH33mTauwB38+9NuRoiiY=;
        b=Y6U+A+eb+7ML3hjQ4SomyKU8ngswbSEpbba+D+cBFFGzFtjg9C7taH55kYMlSNXDGb
         l0KqwDKYY7okkoXLkpbEn+Q+fLQS3a+PL3Rt3kHOWAuA/kVsE7R1KxAiyCwmg6e5Auce
         xLmESxrDYNzEnDyrYaV3hU8tEUCCw9dMk6zBsGyM1NN7OH7lQ0zHfRdMJTjRrmfHvYfY
         Rgpy6g7a+13kwnF/2G/+RkNhVk9w+Ji0LivdXvIVZB30OQle3jirb1gSYySrTDEOF6SB
         EZkNb5Wq8O9mMOpwdFMQhXM3KLdlfooHtewHseOTwObixhp5u4pMA+VlKVWZP+2uzAat
         38ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qBQm09bh4S6bFa+KGMXaVCUH33mTauwB38+9NuRoiiY=;
        b=LCmHtUsvs8pFdiAuDva7BkJ43ulkhnXfgQTISY+9Wcz5m1HFUZCzZtQsaWkPX0pP5W
         sE0mzWncP+OZooNcocTfkSY3pdvtPr8MFREllGS6GHIMAaZfj/unl2YGz7QhQcdP2D1O
         GDkGNLw7YI4pLAQ0cJ5rHwxi25hIq0T4VnLWlbBiAleDzVB7diKynYLxPnDueNVtXVNz
         RFd8AvOgl1zUCjxs4ogxxqJxDh5OZMjXRu/EdNx5CD8ZxOyneOKmUEbg3NDlqB2E5TSf
         CXHDgjhyxnd2Lh0v3XYqixXpxrbwbhEjUQptkv+CfgkpMD+VrQyQ0whbdYk7XlQfYr9u
         wjeQ==
X-Gm-Message-State: APjAAAUEo9V9K8u7zgsObY/nl5YzSKevZyLA88dQ1T3dASD4RgFNCuQ0
        tNqBEjcl+00UTMTLznNW44D0TxWeFizAUGWjOkLYq8Nge5P0xnS9twn1JDbjC1WQ/InVOybPqkp
        dsVqDMwIgaX7vc3POgve68rFF86wNa5/eFXdJCfLdGsdeqXWdHeSJKpkpfHJwRDJXq3l/I0L2RQ
        ==
X-Google-Smtp-Source: APXvYqyxJ2iTl5XlufBKiEvmUrT/Eqz8hm/fcP6MFan69V6nVst06eqmPNGsqWp+sVJISHzp560W9zISw487EmkGq4U=
X-Received: by 2002:a63:d705:: with SMTP id d5mr13651541pgg.24.1576197818442;
 Thu, 12 Dec 2019 16:43:38 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:02 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 05/15] bugreport: add uname info
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
 bugreport.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 59d8b5a3af..9c69e3fa34 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -8,12 +8,25 @@
 static void get_system_info(struct strbuf *sys_info)
 {
 	struct strbuf version_info = STRBUF_INIT;
+	struct utsname uname_info;
 
 	/* get git version from native cmd */
 	strbuf_addstr(sys_info, "git version:\n");
 	list_version_info(&version_info, 1);
 	strbuf_addbuf(sys_info, &version_info);
 	strbuf_complete_line(sys_info);
+
+	/* system call for other version info */
+	strbuf_addstr(sys_info, "uname -a: ");
+	if (uname(&uname_info))
+		strbuf_addf(sys_info, "uname() failed with code %d\n", errno);
+	else
+		strbuf_addf(sys_info, "%s %s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.nodename,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
 }
 
 static const char * const bugreport_usage[] = {
-- 
2.24.1.735.g03f4e72817-goog

