Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8223FC2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DB32253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV3HB30o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfLMApE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:45:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35310 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfLMApD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:45:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so464638plp.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4N1y7q3kDoklC+tR2JJYzqVGFkmW95SU3G6pYzp6stw=;
        b=iV3HB30oTGbrH/C1VCo7jX7NtwHak4RhMiyrvrDffKpHFfAbnBiS6rdw2X4SLnNKHD
         B4sZNJSttKKLzsogNvnu0oDHW4K1HkDBOZvRpYCpOebgQbPseZzoNeYZEJzwSIB5Hpsb
         BHVwMkpA/k5My0o/bLQd4EYxe4T/1XNzjtbYjjC2kZdUtMORl79CdB4OT1jzjrrIM6s4
         4+wy9gyLzRoyPWCaTUChuBfja8GQCag55xu3NrEzrYVk+/RokZ0PWAB7rkf26iEZVZ1r
         sKGMSCGuJs+Z+U0yR2pi2PZRXKtl7MQ7vo7r3CqVczS3eXTlXShCn8ysEwBfFIvUInqd
         2O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4N1y7q3kDoklC+tR2JJYzqVGFkmW95SU3G6pYzp6stw=;
        b=NSsHi6oL9EfPBxQrAalpZz7g2M2pF1RPVHbz1HiEkXIY3zjHo5wUYEjpWB9zg0svjx
         H+2hcwjQnxWj0LPEhxSO5QqLmAPYANky5cNdLdUOZcQX89MtgKQezWL7/tT2Y/5WBbAr
         lK2k0LQx83bBbzolKWVgQphtpyQVQEtvNMEEjE8uJkWYAD4Iub3gGTUGzYJeDSdIfQay
         LytKc8m5BHPM1TsNltiUnxyuSYis27s6Y2pMduaHg0lTTkV695AXv4mla6OBEDboFZqt
         a8AzQqna9M56FHE+sDMO8oUcjhhAGJZYkf7kizUXwLaxDc/T0sYgFxNH3NRURO+dKWPX
         KptA==
X-Gm-Message-State: APjAAAUFmk5YY3zbvzFvhVNUpTII1vCIys2gG2b+gU0iM5g6KlMSACdh
        aU7E+zz3gxMS8aJWsyogpAmR2tw0
X-Google-Smtp-Source: APXvYqzSTpEzOr18lfVafV0tS0a1jh7qPhfbss2KSEIE4mrikzyf4XmbS2jtX7Td9djI+9CRQkq00Q==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr13707747pjb.2.1576197902821;
        Thu, 12 Dec 2019 16:45:02 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id g17sm8995626pfb.180.2019.12.12.16.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 16:45:02 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Denton Liu <liu.denton@gmail.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 1/2] gitk: drop quotes in copysummary format
Date:   Thu, 12 Dec 2019 16:44:49 -0800
Message-Id: <75dc131f0575cbe5d885af8897cbde054f7c07cf.1576197846.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.664.g198078bb5a
In-Reply-To: <cover.1576197846.git.liu.denton@gmail.com>
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com> <cover.1576197846.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an earlier commit[1], git learned the 'reference' pretty format. This
format was very similar to the format that copysummary used but it omits
the quotes surrounding the commit's subject. Remove the quotes from the
format in copysummary in order to match the 'reference' pretty format.

It seems the consensus is that the unquoted form is used more often
anyway[2] so this change should be acceptable.

[These commits are in git.git.]
[1]: 1f0fc1db85 (pretty: implement 'reference' format, 2019-11-19)
[2]: fb2ffa77a6 (SubmittingPatches: remove dq from commit reference, 2019-11-19)

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index abe4805ade..d07e3302de 100755
--- a/gitk
+++ b/gitk
@@ -9429,7 +9429,7 @@ proc mktaggo {} {
 proc copysummary {} {
     global rowmenuid autosellen
 
-    set format "%h (\"%s\", %ad)"
+    set format "%h (%s, %ad)"
     set cmd [list git show -s --pretty=format:$format --date=short]
     if {$autosellen < 40} {
         lappend cmd --abbrev=$autosellen
-- 
2.24.1.664.g198078bb5a

