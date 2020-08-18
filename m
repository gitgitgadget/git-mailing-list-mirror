Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615AC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 05:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411072076E
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 05:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHzZC/Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHRFVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHRFVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 01:21:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BB4C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 22:21:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 128so9213505pgd.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQcHWeOzgc1KEpRQqPSKQk+hd4JQcxqTBsMNJ2wQ/ok=;
        b=ZHzZC/ZxXJ46RcGxShUo7BuUhmW4MnOUkkYMUEn42kS64d6Ko1AAAfliHLi4t28Nf0
         a02WHsV+ezU0qZjuS3GMbTrcdwlOXhwbflntJo6nK2u/CHF4XodaRDk8jVnCpaGsu7RA
         pJB1B1mLNAha0QDRaPgqU7rl7uSlvA8fbv5uIIdnyjV1y8qs4LV0CBGCmdMSzSklHCXS
         muFOCM8FxyYKQm648mB+5yfIIAdipjgKm4EhqBRs9TJyrX4kc8txlBPe0gtV4pLfKGBu
         0/J8cg1e2h5OSzsstvNK+wSjsgktxqCzU/EA+I22jz3hn0vMut8fPoXYyM/29rkeJgmC
         Sesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQcHWeOzgc1KEpRQqPSKQk+hd4JQcxqTBsMNJ2wQ/ok=;
        b=Ue4VyV/+XL8xvF1fQZ5Oi8BAZW9QZmBgMxYtXXL1SXbp0NO/JoZdeK9PMkVDr6m0Bo
         6dcrUGDBWRL0/s+qVPvlOXbwYPZ1vbPKo8LOciEE04/B7fzv2DRlqRyOZu7jmAUGkywh
         LDCbGFCmUUBTNNxaqhrxrz3w1Oa5ay3hIqwiqXJgUNLXFv5SeKRXkJj1OfyMOCL4FeMK
         8yFpu/ole/YnJqlfUEgT+coiI9IdX8M9XtK5IPZSbUhVEeNj3hOVEGqqnyV6Kq1xCPMf
         6QCA31z4HkohoaOznUYFeOJP5q5cmEG4eFkojwluHNJsLT5m6uOyrhuzJ8fWcg5to+k5
         E72A==
X-Gm-Message-State: AOAM532/So/ZGSjPddNozTusY3PiZ//wkED4dfleH02n8I3PYMzxV4sy
        iVvIjRVG/QEvljc5Ieo6MhA=
X-Google-Smtp-Source: ABdhPJxt7KpTgST8F6BNEk/grZ/Od5QjQwVF7CEqP5fAdsdmZWumrNKhFL6Z6mTBbBMVyZX+vfyFjg==
X-Received: by 2002:a63:d1f:: with SMTP id c31mr11712826pgl.27.1597728105970;
        Mon, 17 Aug 2020 22:21:45 -0700 (PDT)
Received: from localhost.localdomain (36-225-225-45.dynamic-ip.hinet.net. [36.225.225.45])
        by smtp.gmail.com with ESMTPSA id k12sm19798786pjp.38.2020.08.17.22.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 22:21:45 -0700 (PDT)
From:   Danny Lin <danny0838@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git develop <git@vger.kernel.org>, Danny Lin <danny0838@gmail.com>
Subject: [PATCH] contrib/subtree: fix "unsure" for --message in the document
Date:   Tue, 18 Aug 2020 13:21:10 +0800
Message-Id: <20200818052109.1817-1-danny0838@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <xmqq4kp143u0.fsf@gitster.c.googlers.com>
References: <xmqq4kp143u0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revise the documentation and remove previous "unsure" after making sure
that --message supports only 'add', 'merge', 'pull', and 'split --rejoin'.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 352deda69d..9ccd431c7f 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -139,7 +139,7 @@ OPTIONS
 
 -m <message>::
 --message=<message>::
-	This option is only valid for add, merge and pull (unsure).
+	This option is only valid for add, merge, pull, and split --rejoin.
 	Specify <message> as the commit message for the merge commit.
 
 
-- 
2.28.0.windows.1

