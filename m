Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2346C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D51A64DED
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhBIHaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhBIH3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:29:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72249C061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fa16so1071451pjb.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HKMN71wmGmq9slNxE+amiaOwcu+ls8b82iXnJPWlUg=;
        b=TLeO/NdpW/UA6ppuf/gLDcVZAuc6bnViYP6rQvg8n4pC7g6rxo+8I6Oq1yI1ylX7Fv
         V19MT0irm3MjPrWRV9YjIpzFWpx2d1mh1mY+dNTfLdqoJT8vp/wFcaT5o+LDeusr90et
         ATCm4o6QKhrVaxaX9sN547fgwems/bXzoHHSuXyCj2GIvX92BEnL6I+OI+/hmY6fW42V
         fsiSKjOYo2UlHIqdhmbhRLqpBUcVKrymQ8X5B0OT079uaVm54Elxy2FspxLATyF4aqMa
         QSIgv5evXAjT+oJudsNM9MZR1yCFFa4Bn6OiGLCkLejAyYDIqWEuvG44syDwKn5jb2AG
         25dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HKMN71wmGmq9slNxE+amiaOwcu+ls8b82iXnJPWlUg=;
        b=OJn7S57m4TptzbQkeACUxBYzlBRdULkqopkGnor8pN0OxIFM8Mb+oVkkYvEdMWeUTH
         IOQyRxKY0leFL65shP9j+cwZUwi1rOkS7EPbFHrWBKQamJQwgaSag1jM5YcQEOvBzm7P
         0/GowrCwfdIAjZYYJ8F6o2FL/M25uLWBE2HF6ZkbRrcZIVPedBUIaeAOO+dCxx7ftGxK
         WWCpwSiFckWVhmo5ZhHhRH9M+FD9+VR+SCiXAm+T/QD5VRZ0d0GEkBt7J+TI7K5keW60
         CJRHadfjpaAGGliBgO67QzezslHZLGLc9S+m2ghm5q/KzHoDfv8FYQv5HO8bK05QkvV2
         iy4A==
X-Gm-Message-State: AOAM530dH3Mz1+iCYJGK2Ph3OHPu33r+hnrXCbkaV0O3ebVITGyp8L2X
        JdSIIppLKpd3xejg1i/jYUdYIl9nnfU=
X-Google-Smtp-Source: ABdhPJyZ5uu0tflfNq9e4R279+A2F/PBiAWqqAtywaacdpYc2ifdxP58QYXYRXM7oa7J48Wejansiw==
X-Received: by 2002:a17:90a:5ae6:: with SMTP id n93mr2868438pji.146.1612855752837;
        Mon, 08 Feb 2021 23:29:12 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:12 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/9] git-stash.txt: be explicit about subcommand options
Date:   Mon,  8 Feb 2021 23:28:47 -0800
Message-Id: <5697f14f1c67abbb529b450c8f2a02f2bc59963f.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the options for the `list` and `show` subcommands are just
listed as `<options>`. This seems to imply, from a cursory glance at the
summary, that they take the stash options listed below. However, reading
more carefully, we see that they take log options and diff options
respectively.

Make it more obvious that they take log and diff options by explicitly
stating this in the subcommand summary.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 31f1beb65b..04e55eb826 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -67,7 +67,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 	Instead, all non-option arguments are concatenated to form the stash
 	message.
 
-list [<options>]::
+list [<log-options>]::
 
 	List the stash entries that you currently have.  Each 'stash entry' is
 	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
@@ -83,7 +83,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<options>] [<stash>]::
+show [<diff-options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
-- 
2.30.0.478.g8a0d178c01

