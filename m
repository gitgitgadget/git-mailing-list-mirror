Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E4CC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbiAEXAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbiAEXAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:00:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3436EC061212
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 15:00:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l4so650236wmq.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 15:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HB2c03CCxZ5FgROzUFd5AZGNunc73gFtHnlzGlbIXCk=;
        b=JkUzlSDW4LsgkrVgRj+hNJrqYvKWXvZsII40BfAqqFc3TfwMsfQjK3W3pnNDhe1FB4
         Qv5yJhvaTRaPp5yrizuzYU2p7HxTVQXTr9q3wNMacMj1cpylNFtmTw/JjyIATODDt1hd
         82gN82Ubdm+8B+m+joaaRElbIp5qtHpnZjTfgCSMpbuTOoKkBfHXyvcInVft9HYvqkio
         N5vsGDh+cbEya/377EO7dYXgIv6VT8zYbXrl1A1uM80rEPeZmwAUjA+WNHiFD7yIhsk2
         TcxeBDz7Bx/rX2YZV0PrWXsUrnRA4RzEwOhYzaQ3Kz7NsIZob9s3e6lamPnyxqztvaqc
         jqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HB2c03CCxZ5FgROzUFd5AZGNunc73gFtHnlzGlbIXCk=;
        b=x7MHBUvhI9tZSR9AIVL0SBLqnR9a1af+EmR8kT2ZGsbFdpQkwxLfGfZlstbFGL+KvQ
         BRxuX77TQtkl3P90RXI5qQiXkoorNBvIliQgEkBrAblLf0QhdblzGHs2/HGckNNx11Aq
         Q0gTL9lBmsmd9DWdtoQHwPVao8qaRg1KXDmIIqeQhIQ+GBO1HBWI7xFlAslgEaZcrU3t
         Ts0ZYLrucNMCXqv1ae5n6y3z8Ie/oGwRZ/4jOtQz3FoO096l3js/aBWzmw0CaQRjWz2q
         Zspx4qxaHqXlaqqUgu4oeco5MfLmnE2ks88MQQSxXJ36JPNJC51/q1p879MyUjmjE+55
         QRIQ==
X-Gm-Message-State: AOAM5322P0qhotQtRbxPc273rcyj3u+AsO1OPnhP/GSPYaCMCL8OFzJa
        opisCAZuYdXQw/UlVuFa2DWbqE9C6e0=
X-Google-Smtp-Source: ABdhPJzzQiPCUqr5ahIILho0kWJflUwPqgoW8LhCDNawsDtn3sI5JUnGdyXtlBiRMFHAToMhVwAlbQ==
X-Received: by 2002:a05:600c:3ba9:: with SMTP id n41mr4775244wms.180.1641423602656;
        Wed, 05 Jan 2022 15:00:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm295616wrw.11.2022.01.05.15.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 15:00:02 -0800 (PST)
Message-Id: <32ad96530b98d6def19c6871e30ad1774e55626a.1641423600.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
References: <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
        <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 23:00:00 +0000
Subject: [PATCH v6 2/2] name-rev.c: use strbuf_getline instead of limited size
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
index 4941cfb4340..7164b54cb79 100644
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
