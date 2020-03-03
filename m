Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DE6C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90CA20842
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usez8+T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgCCRIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:08:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46517 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgCCRIa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so5251199wrp.13
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDEDPwH7KXow9gsFIgMLxGthboCmgY0ch9POvjbe3ZE=;
        b=usez8+T3mqVOLyocNggT4cOfeulAb0AA7SYpNjrwJnOI89gcdmuq75g9X4gK2T9cNO
         CZZUnMLg5Tb++VAtYkH+sG7T8BgEg4YnXmbLsCYDwV+1EJDCCXLW4gs0a8x31BXV+1wx
         sKyIwxfAcP3lBdNvjcgSeDEq9OYs9X1wUO1Jp9Ad2f0zpj0Cjp4XirhJu1OmYN6whWog
         UL9wJra2wLgGv33LPyNNJIojQnPm2G7qKyyWFbjGsmwEQvZOAGCzCo62wS+FOS5rXMiK
         8Ti0NfOJMii52D30YHmWy14yUAZEKSH4JM8p6ShsWTQWsg9TIDcjV8n7WByt4bLO1nye
         xCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDEDPwH7KXow9gsFIgMLxGthboCmgY0ch9POvjbe3ZE=;
        b=rUUD4Wiw7/N3UdWGU1T5Gn/+yGYvgFIY4YyrL+ftzZOOZD7kRp0QubP8XlUEij7a49
         XeQRuCvkPdqHc2pCOZ+ZKBoPB+YCOva0HyRurOLYUdAwNw71qkAHY+WmaZq2vSPtGLVI
         OndxM/AgSbXrqzGgcutlBMEMtGmWeVfyjFaENcP81+lPpPnxnG5bVYKBMRrxbxapaiez
         Y+1f9y2AT4hNT2c0MTC0eNiZmvZh4oLyJH6BS3Xby8uTtJNVq59Go0sY8XTRx0pWgmDO
         4wNTJY2ZkDnOrDJGYuFCgeNts7FTtKt9kppkTZOiEXwZ0zVzXgsno/lY28fEYBvQMPiN
         Msuw==
X-Gm-Message-State: ANhLgQ2S5k8bFEZVcZYUsrPBQDw/i151kEQKplXxdFn1ivxXZ8DcgKxh
        8ysP+xrLg8Jyls0SEN/i+aB4UGEPpiI=
X-Google-Smtp-Source: ADFU+vu834ED/k+sBGoy7GgYglTMoeUTPEUCPPi+C7uoJMNNQf+PKZrbv79y1/jOdz29Xa4nYNaEmQ==
X-Received: by 2002:adf:fc07:: with SMTP id i7mr6928834wrr.158.1583255307889;
        Tue, 03 Mar 2020 09:08:27 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 16sm4746576wmi.0.2020.03.03.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:08:26 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 4/5] doc: be more precise on (fetch|push).recurseSubmodules
Date:   Tue,  3 Mar 2020 18:07:39 +0100
Message-Id: <20200303170740.1879432-5-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default value also depends on the value of submodule.recurse.

Also mention `fetch.recurseSubmodules` in fetch-options.txt. In
git-push.txt, `push.recurseSubmodules` is implicitly mentioned (by
explaining how to disable it), so no need to add it there.

Lastly add a link to `git-fetch` in `git-pull.txt` to explain the
meaning of `--recurse-submodules` there.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/fetch.txt  | 6 ++++--
 Documentation/config/push.txt   | 3 +++
 Documentation/fetch-options.txt | 3 ++-
 Documentation/git-pull.txt      | 3 +--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index f11940280f..8f716809f9 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -2,10 +2,12 @@ fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
 	unconditionally recurse into submodules when set to true or to not
-	recurse at all when set to false. When set to 'on-demand' (the default
-	value), fetch and pull will only recurse into a populated submodule
+	recurse at all when set to false. When set to 'on-demand', 
+	fetch and pull will only recurse into a populated submodule
 	when its superproject retrieves a commit that updates the submodule's
 	reference.
+	If not set, it fallbacks to the value of `submodule.recurse`, and
+	if both are not set the default value is 'on-demand'.
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 54871f8213..2a5250cf5c 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -112,3 +112,6 @@ push.recurseSubmodules::
 	is 'no' then default behavior of ignoring submodules when pushing
 	is retained. You may override this configuration at time of push by
 	specifying '--recurse-submodules=check|on-demand|no'.
+	If not set, it fallbacks to the value of `submodule.recurse` (where
+	a 'true' value means 'on-demand'), and if both are not set the
+	default value is 'no'.
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a115a1ae0e..58972b1a05 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -163,7 +163,8 @@ ifndef::git-pull[]
 	value. Use 'on-demand' to only recurse into a populated submodule
 	when the superproject retrieves a commit that updates the submodule's
 	reference to a commit that isn't already in the local submodule
-	clone.
+	clone. By default this uses the fetch.recurseSubmodules value (see
+	linkgit:git-config), and the default value is 'on-demand'.
 
 -j::
 --jobs=<n>::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dfb901f8b8..47bc4a7061 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -86,8 +86,7 @@ OPTIONS
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
 	This option controls if new commits of all populated submodules should
-	be fetched and updated, too (see linkgit:git-config[1] and
-	linkgit:gitmodules[5]).
+	be fetched and updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and linkgit:gitmodules[5]).
 +
 If the checkout is done via rebase, local submodule commits are rebased as well.
 +
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

