Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F11CC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 04:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D732207A8
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 04:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAHESD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 23:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbhAHESD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 23:18:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1EC0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 20:17:22 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q7so4933797pgm.5
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 20:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQ/RPvsH4haoiAjWPbeswL5zl4X4/zhsWhb2dcBHAbk=;
        b=E6yv3JcQF1kCI1YyNV1cMPMbgVoeKINYwdsMME140z6vCIzxJ9LJVOEMSQWgEDO5oR
         6OHQ6xhHJxZJ0jhk8CUmeDDc9CfbR/GA+m2YxiKQpqfVnyNFuvpnHEcFjuAU6tgsRR9I
         AuMPbzSr5mTrgn+XL83IqYOmeeAw0Cf3l59+WUzpf171eom+FwopORNFXKkhzWCGtryB
         pdWRywnH8YHOJHCT87RTzJL07fNhWZwUTCgKl/8lUrzFjjKF2DCo3imfeJ9FxKoMWEXg
         05eC+8e/akJLcBYxOl1dQu0OmrxarqC56zdNEBQhuorOomiI7v0SCkI0VXs2PKM1HbxZ
         JjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQ/RPvsH4haoiAjWPbeswL5zl4X4/zhsWhb2dcBHAbk=;
        b=W80oOWYek3RQEpqOWnncK9XlJTNbWejjrgXwB2Cckeiv/fSHF+y029Z8gQhdw1crzp
         +LEgXC3YsQ13In4M0isTO9USiUoV4/XanmLEkcCg6bvXkiyoxWMmZcb5ZNweer/0/uiG
         7AVJ3MclG2t+y4GQV8rlJKZGJC0gSpKX4ZtUgYHVYzxjixb3bt3P3/bDUBEmKCR/N521
         4hGMvH6LktpQ0eiNO47w3e9VutHo782CYfEcyRh4Rp+2ad9jSAdSk5qSPXJiY+G3/btY
         nl9qKRfcRPSS358S/p5fJ2MCvkcdCnRdmNSNxOSbhOCToAk1x3yON9WUq/lE08z+dZc0
         HLVA==
X-Gm-Message-State: AOAM530h6gyIWHP3LeRooS85lKkMGvGgC2XXZWQsf5GCouXoZTpC9bBY
        9l6KWMXOVzhUCbDjAwk3UTIfeAT01hk=
X-Google-Smtp-Source: ABdhPJxDsOVpWfYOXD9BCQJzCMyMFosjpvlV1XbcN5aJzZ7OR2IM5jT5pYpUxaBBIT/Y1O7ADX9/dA==
X-Received: by 2002:a63:2c93:: with SMTP id s141mr5193502pgs.150.1610079442129;
        Thu, 07 Jan 2021 20:17:22 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id m4sm7574928pgv.16.2021.01.07.20.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 20:17:21 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Vasyl Vavrychuk <vvavrychuk@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] git-send-email.txt: mention less secure app access with Gmail
Date:   Thu,  7 Jan 2021 20:17:17 -0800
Message-Id: <4303fab303fb59b67b8fda036256ae61a528dfc1.1610079311.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vasyl Vavrychuk <vvavrychuk@gmail.com>

Google may have changed Gmail security and now less secure app access
needs to be explicitly enabled if two-factor authentication is not in
place, otherwise send-email fails with:

	5.7.8 Username and Password not accepted. Learn more at
	5.7.8  https://support.google.com/mail/?p=BadCredentials

Document steps required to make this work.

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
[dl: Clean up commit message and incorporate suggestions into patch.]
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Range-diff against v3:
1:  274475559a ! 1:  4303fab303 git-send-email.txt: mention less secure app access with Gmail
    @@
      ## Metadata ##
    -Author: Denton Liu <liu.denton@gmail.com>
    +Author: Vasyl Vavrychuk <vvavrychuk@gmail.com>
     
      ## Commit message ##
         git-send-email.txt: mention less secure app access with Gmail
    @@ Commit message
     
         Document steps required to make this work.
     
    -    Original-patch-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
    +    Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    [dl: Clean up commit message and incorporate suggestions into patch.]
     
      ## Documentation/git-send-email.txt ##
     @@ Documentation/git-send-email.txt: edit ~/.gitconfig to specify your account settings:

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
2.30.0.284.gd98b1dd5ea

