Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0948C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC0D64EE4
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhBBJex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhBBJe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:34:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80282C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:33:47 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y10so7886674plk.7
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QT02VIMAM8UX072iG0VP9UA3J9ck5MTLRQXakDA1lIA=;
        b=XKV/0FtCfBdNddD6QnLibH6pXuf9ivKRzMmJF54GVy4LMvI2/grwYp2qDipYNh5eR/
         6D3YOVQ977U8SsqC7+qqubukRhiVcunFzlns56Uy3BLKIW2Xi6/sQcT7FPt0xvPLH8Ge
         r9QziHgVxBDaPzhHKNruiZC5u32jIp1N+BLN78Okzq7eNkvjOe00TlqLmkz1VfBN27l+
         s5mLudu2urQgKJRnnRVNmfaQa6LElNlhU7d3gAIRtvHIqnlCpjLcX2apNetpD54r9Vrm
         3gdhhNatO/v8eF6LWLkoiR5MwQPyJzzVka4bDeUHxciFd7uD2ftiicgRiPNU7kwBwezG
         6JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QT02VIMAM8UX072iG0VP9UA3J9ck5MTLRQXakDA1lIA=;
        b=H4Bzq8NnNTD8DnFSgkvn5LzVlTD4IYudxRqPMEaRhjxAbvbjqkp2e/GV/y5LI9+Icx
         6F4y7lYLFDkYblpeDsmfOgG7vrdDQNHshghpxEcLwmytDnNuUmLZUSbwAMGKOrjyqXkE
         /cLx3+SYIAsfcYnaA2UdzRc+RZFCQf6C9jehN1n9gNZ/s/uxZeSxg+bYEciiUFd+0LaT
         Rsf8wP6CSAIPBotumEBX2MLQR9W2DPGJVikDRny31vAvdZfkadrwvxcLOzrpR3g2BQhz
         GhZGRkIkV8oUC+BgOlJ75nFExGwhnujnTj9p0dbHrcqd8x4c9wUIJHmt4SfWlju5tdzG
         ulJw==
X-Gm-Message-State: AOAM531fkbkYumosUIQbS/XHD/zy0h+j1+QBrrJJC3Fjgy/hVED2NNN3
        cZ3AdDNOyuw4n/hTCXRgsznZ5b2E3qs=
X-Google-Smtp-Source: ABdhPJzH4HdUNY2VrSPeOWmPGKGeDl9EoCW41Z1/Tvtd+Fica0pG10N6wRsBE//jK0PH92aBUQWSBA==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr3400708pje.126.1612258426912;
        Tue, 02 Feb 2021 01:33:46 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.33.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:33:38 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/9] git-stash.txt: be explicit about subcommand options
Date:   Tue,  2 Feb 2021 01:33:18 -0800
Message-Id: <17675b9e4c0c50e6bfd5219c933b5ba1148ab86c.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
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
index 31f1beb65b..46ee37b35a 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -67,7 +67,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 	Instead, all non-option arguments are concatenated to form the stash
 	message.
 
-list [<options>]::
+list [<log options>]::
 
 	List the stash entries that you currently have.  Each 'stash entry' is
 	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
@@ -83,7 +83,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<options>] [<stash>]::
+show [<diff options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
-- 
2.30.0.478.g8a0d178c01

