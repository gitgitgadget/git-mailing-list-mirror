Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C8C33CA2
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 20:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588972073A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 20:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk0KZSKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAHUJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:09:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44000 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgAHUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 15:09:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so4628158ljm.10
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgoJPPOM2dsVPtBXiaEBzSCE0i/dPDEF8SeGTno9h3o=;
        b=Tk0KZSKLIu7ZpAWfnUBlqeoY/3dlQMCTnV3HdHnHIqdx1oZytdBWHymtcnKRG5fFFs
         NV+CIj9cS3fuXB7dE8zlkc+KxFhtf2JgWwF7MWBlyyNiP6neCqwjWOD5I7N9ks+O3Xfn
         4I0xa45envfUS+LESfnVKGKutmBlamLA06FmkJf+2IuqNdkTqRFgbE53zldwfSn1mjTc
         Jloi7WH4Oijz0m6NUvmiErx6Co7JgtsjNMJherbNTzdSSVJxumIiG9m2qMF7lCEhzDZl
         jvLVXVEcbLv1BeVd8419kslcXacMQv9JbNYP8FiInESanKEdCtkLtiiLI7Vnpt+LyFS2
         Mr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgoJPPOM2dsVPtBXiaEBzSCE0i/dPDEF8SeGTno9h3o=;
        b=ndxN4NgoDSBZemiMyPfd9BWUPYM5P2sLnJQ1PantvNqCMtWOxbhSiKmPBDaV2nQGK6
         r/aG4GQH75/+1HDL9yxhwLKlDJGIWTQV9mu8MJihZWquZInQ9MIlGJWjNt3dJ9xsQfQa
         eUF3v5OdbRTRaKGvIkSRC9hGRT+6gSkg/VHBQ6aZhIIOfRqDzISVFyCJnTc8T90c2xMP
         Sp7IY0l8fOp5xlPRJSK3BANXmappFhjDKQqrtys2JEmESoyJ+SBdR7jH22aN0jCq1Al6
         r+hS0E/O/lg4oOEXleaM1udQpZ3t9T1MyoD1ljhsPrq8HI8z4FtCrU2IKR96r0xNHrOY
         CBaw==
X-Gm-Message-State: APjAAAWIalyHFxw04XBReNNd8jhc/I7ABoZfOESlEFN0vbwtA8Q/RcXA
        ecGwDhyNJgR+q5fu5M5Wz5lHD4re
X-Google-Smtp-Source: APXvYqw1FFpYOGdDl9jKsINhqH/j2y35RSXNdgrcbD7IHk3OiYyxcuHHS+EvgLlD1zkSNXCFdB/6Gw==
X-Received: by 2002:a2e:8544:: with SMTP id u4mr3916768ljj.70.1578514196568;
        Wed, 08 Jan 2020 12:09:56 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x29sm2188249lfg.45.2020.01.08.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:09:55 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] config/advice.txt: fix description list separator
Date:   Wed,  8 Jan 2020 21:08:44 +0100
Message-Id: <20200108200844.30803-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The whole submoduleAlternateErrorStrategyDie item is interpreted as
being part of the supporting content of the preceding item. This is
because we don't give a double-colon "::" for the separator, but just a
single colon, ":". Let's fix that.

There are a few other matches for [^:]:\s*$ in Documentation/config, but
I didn't spot any similar bugs among them.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This was the only thing that stood out at me while going through
 `./doc-diff v2.24.0 origin/master`. This is obviously a non-critical,
 purely cosmetic issue.

 Documentation/config/advice.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index d4e698cd3f..4be93f8ad9 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -107,7 +107,7 @@ advice.*::
 		editor input from the user.
 	nestedTag::
 		Advice shown if a user attempts to recursively tag a tag object.
-	submoduleAlternateErrorStrategyDie:
+	submoduleAlternateErrorStrategyDie::
 		Advice shown when a submodule.alternateErrorStrategy option
 		configured to "die" causes a fatal error.
 --
-- 
2.25.0.rc1.19.g042ed3e048

