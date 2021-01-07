Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCE4C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F83216FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbhAGLMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbhAGLMo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 06:12:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF7C0612F6
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 03:12:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id be12so3316772plb.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 03:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ef9H3ZMEsGCEGicGAf4xYY5lCA5k4FSOfe18H4MFMQU=;
        b=isL+rQU7gl8Jj3w1DZTPE7RBRnq21/jvd28OuXsqpTG4rgVyLBh5tFVKs4cJfJJcpL
         hD168OCHDrGyiMpORfHAmOmL7xC6IytHXFNRNkSFU5KcVnLIK/yiq7ANjedSDjrRMbkT
         ADbj8645jtagweF2FsqlCA8U/3wmBg4RLjyPWcK4yOaHyzdF+abP/iQ43PZ7vZSW/CsD
         AQWCaz62Iou76wCKo6j50WY7+frLvT1rWD/bLBp+GjRV+LMNgjzGT7nxVx63akokS3YO
         sA9a8Q/NdwqhScIT7kuGyUPq99bcus27Yq6XavjWg3fIJerLsuIUiO4J4xPTrXl2QmvC
         f1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ef9H3ZMEsGCEGicGAf4xYY5lCA5k4FSOfe18H4MFMQU=;
        b=s8yeT/zWS4Ky0Yp+J4UvnIP8zdmc0wIlc2m/9zUbMl+jwG9kanTUxwhite2ZxUl37R
         sawv5hBDqLMlxo+E3XtvJHD9vM8UvPv9l01BCu380E70jauQAsuCIR8hyYlTxXwfC9vF
         ygLRkelzXb3Lxw9FBKrTUEvDWbth81kpLdbIQXo2XXFUt5NqgkLA3sXX9LIhVkj/EyFR
         WGwNo/jQH5iGbomzmPlj//38y+H7+qXmGDZwX+Ixjdmlo4UWLWw/Y+VuJXrxWOaD6mpV
         teqL/Rb2GR12MBOgvFkKtGdERw8dxiIROU5a0v9U7sPpU906UOP24v01p7yt2pN4K2Yk
         X06g==
X-Gm-Message-State: AOAM531iOat6j6PzHhRt0+wH+2s5oj0C+cP6MmaDaxnLxe6yPiX0hNrn
        6uSiKM8Dv2HzLlTwEvSVmXDfsvlqdZA=
X-Google-Smtp-Source: ABdhPJzgttpN6QX6Zty+4IiPUARWenpYbevAUZEB5JS6WI00Tr0NOYEYM+sLQzxw5yd23LpTdhAlQA==
X-Received: by 2002:a17:90a:8d84:: with SMTP id d4mr8875235pjo.56.1610017923144;
        Thu, 07 Jan 2021 03:12:03 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id p8sm1869999pjf.11.2021.01.07.03.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 03:12:02 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Vasyl Vavrychuk <vvavrychuk@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] git-send-email.txt: mention less secure app access with Gmail
Date:   Thu,  7 Jan 2021 03:11:49 -0800
Message-Id: <274475559a6de9c95c9c6cd30b5d056a31cc2853.1610017875.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20200829153920.17155-1-vvavrychuk@gmail.com>
References: <20200829153920.17155-1-vvavrychuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Google may have changed Gmail security and now less secure app access
needs to be explicitly enabled if two-factor authentication is not in
place, otherwise send-email fails with:

	5.7.8 Username and Password not accepted. Learn more at
	5.7.8  https://support.google.com/mail/?p=BadCredentials

Document steps required to make this work.

Original-patch-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Range-diff against v2:
1:  2bcfd1403f < -:  ---------- Documentation/git-send-email.txt: Mention less secure app access might need to enable.
-:  ---------- > 1:  274475559a git-send-email.txt: mention less secure app access with Gmail

 Documentation/git-send-email.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0a69810147..0db0783f2f 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -494,10 +494,14 @@ edit ~/.gitconfig to specify your account settings:
 	smtpServerPort = 587
 ----
 
-If you have multifactor authentication setup on your gmail account, you will
+If you have multi-factor authentication set up on your Gmail account, you will
 need to generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
+If you do not have multi-factor authentication set up on your Gmail account,
+you will need to allow less secure app access. Visit
+https://myaccount.google.com/lesssecureapps to enable it.
+
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
 
-- 
2.30.0

