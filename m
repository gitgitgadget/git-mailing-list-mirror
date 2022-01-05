Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68932C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiAEX3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245418AbiAEX3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:29:36 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9FC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 15:29:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t26so1314793wrb.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 15:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k4glPmQdbO7Ari9J1wAqL+G52Kr3txiH9p6CXP6irsA=;
        b=TbC6Uwf1tbY7pVf644rj6jMVB7N+eqYpIdSpZEj2R4h1qnF1gqqzPhOv1FqjeOv8+4
         0iLFPX2mbjG3nt4hhmxjb8hoVHpxHAuoL50w/+hILvvSXVNQhaczV5I8EbeHfToJh/DT
         TilzFFSYBS0Meg8DoFQX1ygmQTGYkVm+QJrzMQ/63FwQrZPYtubH1MRC22pvrBxJcblh
         ZpRjH9Pv9huf3NGrpWnYS8R9rSHyyapZfSXFCJz5M2oos9JVYWXLs04I092KN+YREEsc
         9EttzwVhA+TXCKqQQZVXKDVyv0Cf8tWaPbXEZJJkVHcDL8tUf1xVGW1JRlS6GFYw39EN
         24ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k4glPmQdbO7Ari9J1wAqL+G52Kr3txiH9p6CXP6irsA=;
        b=hxjtHKJlln7sWWlj+PEF/qGE/lnxi7/5uvCoOakiVt3ZrhgTEZuqPV3l4xzVRxLAQy
         o1MWNdYLZR5T/GkIudCi+NUJiG8MpfWttbHg37VJEh6QuuJf9ngVOKsLuQAdlm4oTj02
         ONvSiZeac65RDodmEMsuH2kRAqTsr1neAvmU/31lHaR5LN3duooyIv3eDHhKC5ZW/3F7
         YMeZAzzRmfK8qgDqdxsBI2yjq0JNOZa+0iptPEjmiunYTx2SFhbTASIKg2PYJcIJSkZI
         9uL8vFSoPgwVgC1wazG7edvgPcE1vq35O3Iiv8Tb9PZ2t8YkzydPpSOV2K+ypLP2NltH
         jyzQ==
X-Gm-Message-State: AOAM532vD4tULIlPsKwRFA7/40IPF4CqKY4rdOzQNAQHhILRD7km5BaQ
        wt84WtZiL82D7QV+qKwW0VRucC4Bh2w=
X-Google-Smtp-Source: ABdhPJxu/4I2x7jez5xVeuwg+pXLiRyTtcmAWj4wGpMeYNbtPm2YZ5PeRGGxN31DMm0a7/SUrWCCnA==
X-Received: by 2002:a5d:6d49:: with SMTP id k9mr40525922wri.530.1641425374915;
        Wed, 05 Jan 2022 15:29:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m35sm8105910wms.1.2022.01.05.15.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 15:29:34 -0800 (PST)
Message-Id: <19e7bf965574652840c5e0cde6f3dd188bec82b0.1641425372.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
        <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 23:29:32 +0000
Subject: [PATCH v7 2/2] name-rev.c: use strbuf_getline instead of limited size
 buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Using a buffer limited to 2048 is unnecessarily limiting. Switch to
using a string buffer to read in stdin for annotation.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/name-rev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 8baf5b52d0b..138e3c30a2b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -623,14 +623,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	name_tips();
 
 	if (annotate_stdin) {
-		char buffer[2048];
+		struct strbuf sb = STRBUF_INIT;
 
-		while (!feof(stdin)) {
-			char *p = fgets(buffer, sizeof(buffer), stdin);
-			if (!p)
-				break;
-			name_rev_line(p, &data);
+		while (strbuf_getline(&sb, stdin) != EOF) {
+			strbuf_addch(&sb, '\n');
+			name_rev_line(sb.buf, &data);
 		}
+		strbuf_release(&sb);
 	} else if (all) {
 		int i, max;
 
-- 
gitgitgadget
