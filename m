Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A242C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA38B22527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQxs3xe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfLMApF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:45:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43682 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbfLMApE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:45:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so444536pli.10
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4z0GR/yASPvwbcxKex1C2iPKXZBBoD7dtW055fp7Ry0=;
        b=AQxs3xe0+UUKyWsPIIpptDPhCktlEjqPeB4/2cHuHJRMg+/v5iM+kw2eEpQBXNvh4P
         Cd3X2fhJ4fG5Cqab8uE9ruyob/HiPBjPg4J9NV2uVACJILKdZKnWM8w9tHmqO/943hOf
         tVu5aVmWu1OvxubiN7kS2rumSFBjPmGmDrXjiH1+f8To5xZepIvT3BJiJNY32iNRSazR
         Hco55SkWaJkpEPve/fMFBkAMpKpY1r+MlaPe/8bWVPm6gAIo9QCt4WAAshs7telAjsGT
         UXIWQPLi5SVpC/F/rmt+1XO7PYMbazHlUN4quJZxO94zbSABHMT6ZeV/SAYEmgHEIZ7k
         3MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4z0GR/yASPvwbcxKex1C2iPKXZBBoD7dtW055fp7Ry0=;
        b=cQgv2atz09L92aHuuwvOgGziBvuitZdaCwI/EpZsqL6RtTXaThbL2ncvUxSv14W8UH
         QlFWJ43XX/VYFfrrY1lHjBRJxj+KOqyQ3H91XtUSdlvRial0oviuZ9qXHLAoaa6B4V8T
         i3XUdOPnNTMzsVALlqRdLKZXTjT+zURV1XB/cp4x+wY8kUXm/eVxjhZ/K05AyDnZtcEz
         ErFlu1lnww/276xhobO3/LvOGYIcSW276CwlYdNFjkSr6gZYbJv1xxSJe19xg6C5adzT
         Yui1vhEnM4+gfQ+ygr0Nm0On8Bh0Kc7xC8lsMzBnEe85curw8HMiyUS2PgYtHlWwIygM
         gC3Q==
X-Gm-Message-State: APjAAAWFIcDdtn0BTMEgd9MMSuMojrbDnE8sdevDJwyD61bbL8HJXbRr
        0EPYnVBhC1eK3gAVPzKVLwleHbPe
X-Google-Smtp-Source: APXvYqxUcsAybN3meoZTQIlMlfmE2llbkYV9Vi0yYu2hVaBatQtpkgyhmrsRbUXg0bji3rWJH471hg==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr13480733pjp.114.1576197903687;
        Thu, 12 Dec 2019 16:45:03 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id g17sm8995626pfb.180.2019.12.12.16.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 16:45:03 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Denton Liu <liu.denton@gmail.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 2/2] gitk: rename "commit summary" to "commit reference"
Date:   Thu, 12 Dec 2019 16:44:50 -0800
Message-Id: <8691ed2b84f7ee6b7c12d04d57a541bf22660333.1576197846.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.664.g198078bb5a
In-Reply-To: <cover.1576197846.git.liu.denton@gmail.com>
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com> <cover.1576197846.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Beat Bolli <dev+git@drbeat.li>

Now that the commit reference format has a canonical name, let's use this
name in gitk's UI and implementation.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
[dl: based the patch on gitk's tree]
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 gitk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index d07e3302de..17346b4c5c 100755
--- a/gitk
+++ b/gitk
@@ -2640,7 +2640,7 @@ proc makewindow {} {
 	{mc "Diff selected -> this" command {diffvssel 1}}
 	{mc "Make patch" command mkpatch}
 	{mc "Create tag" command mktag}
-	{mc "Copy commit summary" command copysummary}
+	{mc "Copy commit reference" command copyreference}
 	{mc "Write commit to file" command writecommit}
 	{mc "Create new branch" command mkbranch}
 	{mc "Cherry-pick this commit" command cherrypick}
@@ -9426,7 +9426,7 @@ proc mktaggo {} {
     mktagcan
 }
 
-proc copysummary {} {
+proc copyreference {} {
     global rowmenuid autosellen
 
     set format "%h (%s, %ad)"
@@ -9434,10 +9434,10 @@ proc copysummary {} {
     if {$autosellen < 40} {
         lappend cmd --abbrev=$autosellen
     }
-    set summary [eval exec $cmd $rowmenuid]
+    set reference [eval exec $cmd $rowmenuid]
 
     clipboard clear
-    clipboard append $summary
+    clipboard append $reference
 }
 
 proc writecommit {} {
-- 
2.24.1.664.g198078bb5a

