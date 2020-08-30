Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEECCC433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A682083E
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNqDOt35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgH3WBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgH3WB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 18:01:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A6C061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o21so3654281wmc.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+sxQi5RyQbr1LaPzgrl6im4HbxTga52BZnZeYJEv+0A=;
        b=ZNqDOt35oup5/KXxeYr5zhNHhHaCxy3WTymnKbMSMkby5qkl2QE1IcwPO0L9GGKYxZ
         SZbNiCPpvYQcRIAiZ3LF6+8W5uSBZFRO4bGtXHUAggUFV1zBuByiY54Ib+1TFNqwmBwS
         REfILeHi6kPFauTB+kM0ZATvTZDCL8cTK7EzVsQKD/de0RFpUeIVzU2/vlI12kTGI9We
         NPYhm4TauEXURwOL3sM+G0PywqqbiIMR1oiM/AMMVRxzrawERCGRLFLGJOXHBQfZGWbW
         Cl6BKMAl7hAz6myhYsSOXTeE7eAeok3vqAqCqNc8wGkD73/Azi5oO4ZycrBzA7fdt7n/
         2/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+sxQi5RyQbr1LaPzgrl6im4HbxTga52BZnZeYJEv+0A=;
        b=oAkgyO+gr9HnJYK1SRJObByz2hjVoOQbJmu8QkXyiHv9amXmEyNwfZaPZkF/dIO+Ib
         ZPWViX2UFYmylsKs510AOeZ+xRAqnzhV0vHG01pl5UqI653CjAOd446NhgbXizva0YX7
         3AE+2/wMc+3s4DAPklVsM1vHbxr90izEw95HOOtcGC8pRpt9SjjVWoa00nqjpFQcivOc
         g2uIq1YmUBOdaTrH0bqqy3w5anRiNytmAHmitab31vCxelt8/fqHsM8ktncbRG4xzswa
         /DwpPL+SVwhBgYKRezx2jLJ+7SY5OzwqHqskDMVeY7BKfLI9YDjObtunjrPFic1+83Jn
         +zug==
X-Gm-Message-State: AOAM530REaeNzHpkirBpSbf1Pe3/AytdIyaQonn+xFELJiPYlj+/sxbK
        IVZSJbrkEnMn9tMMi4UHpH61CKbot1A=
X-Google-Smtp-Source: ABdhPJws/sfda+RDigwZz01juOHk7enm1ixefcrBv8oLrnZsObloY5vmvdvaFnQEK9/BTyRq3zmc7Q==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr7185534wml.184.1598824884614;
        Sun, 30 Aug 2020 15:01:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm9398968wrb.12.2020.08.30.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 15:01:24 -0700 (PDT)
Message-Id: <2b12440045d926b194b90f16246d4f166f31442a.1598824880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.715.git.1598824880.gitgitgadget@gmail.com>
References: <pull.715.git.1598824880.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 Aug 2020 22:01:20 +0000
Subject: [PATCH 3/3] git-imap-send.txt: add note about localized Gmail folders
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The name of the "Special-Use Mailboxes" in Gmail are localized
using the user's localization settings. Add a note to that effect
in `git imap-send`'s documentation, to make it easier for users to
configure their account.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-imap-send.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 5e4d4d43b9..63cf498ce9 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -110,6 +110,10 @@ Using Gmail's IMAP interface:
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
 
+[NOTE]
+If your Gmail account is set to another language than English, the name of the "Drafts"
+folder will be localized.
+
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
-- 
gitgitgadget
