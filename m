Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC2C07E9C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5831D61289
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGKAt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhGKAt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:49:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B4C0613E8
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso8094801wmc.1
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JCCMn1/EEzjadhEsi+kZDCLo5m3YGpIggmmLmW9FJV4=;
        b=g2JSlzcyCNJ8ljPh1WqlqPPWiHEgyLoX3XcBzMclquvg/GlUgpa/3bJwNPvbt4ieWK
         hy6Cu3Emc2Y+3kcLQxZ7lUh5+y2nw7U0J19rumiHVXknBFd2l5OpKD3iQR5GiZFmarzg
         bcmVMTpKtKJnEHrWbUHm8OjI6BGlw42NwF2qab1aCZcGDlcdT3AeGwXJtF0Q3gd76+bv
         6HViZ+1CQte2rUmYmxD4iijxQRoQYhek7EinmuFyLjVQH9ys6ShbnBSY86TaWbujCl1I
         pUhborvQtzCjD7V+A2nRmyJ1RmTMisUuTLxWqf0Uky6Ey5xa2jkANfVIXO0t4rvi9wkX
         xvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JCCMn1/EEzjadhEsi+kZDCLo5m3YGpIggmmLmW9FJV4=;
        b=dUI0xLsCXL+UO5bsi0Nq4Akehqgbjj0PrdwH0yx2zT/dIvejhkHKvegaUkHOugEUfE
         kPeKIqGnzKjsEA3dpHeeFy6RRmhwdAqTm5VV6nGGUrZrUGKl5rdyxvCuw+rwtbsYPVt5
         WIZu47yKEfAIW1CLwbjDaqBD5c5ZLUAAYXb13+hvFfh8alj1emsyf/B2cWRCRkV+e3SQ
         MEitfcIusU4g4u5lZIwJvHWa9g8K90jyYQQswZgzb/x3/x2DxxKAvWNbLoB0A55hvpHR
         grBOSIbIdFIsOmP55mWIMRbesrEdRumi6UamFsR3VhTrw77FVBzEVB9P7Vt4qYWgfW8O
         6zYw==
X-Gm-Message-State: AOAM530hoZlC5NgYRnaRcX1Hs9V+UYgG/Ji4nt9RioC4gM6vg4GnZQi/
        k0ZR8U7xmw+W0pCy5ZhE7X/iO6IEnvQ=
X-Google-Smtp-Source: ABdhPJzLoEu6wWAT3HL9OvYeWaWnsAv2+tWiN1Kta6wLmjP++Z73Ui+DM9t3455Epv1P8+/WSR76rQ==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr18156731wma.178.1625964401182;
        Sat, 10 Jul 2021 17:46:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm3881651wrj.66.2021.07.10.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:46:40 -0700 (PDT)
Message-Id: <ee0969429cba837ba6d79712706c899d5b231798.1625964399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:46:37 +0000
Subject: [PATCH 2/3] doc: document the special handling of -l0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in commit 89973554b52c (diffcore-rename: make diff-tree -l0
mean -l<large>, 2017-11-29), -l0 has had a magical special "large"
historical value associated with it.  Document this value, particularly
since it is not large enough for some uses -- see commit 9f7e4bfa3b6d
(diff: remove silent clamp of renameLimit, 2017-11-13).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-options.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b5682b83956..17c8455b908 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -595,6 +595,9 @@ of a delete/create pair.
 	specified number.  Defaults to diff.renameLimit, or if that is
 	also unspecified, to 400.
 
+	Note that for backward compatibility reasons, a value of 0 is treated
+	the same as if 32767 was passed.
+
 ifndef::git-format-patch[]
 --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
 	Select only files that are Added (`A`), Copied (`C`),
-- 
gitgitgadget

