Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73127C43333
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4048720658
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9m0WFBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCTVia (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54090 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgCTVi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id 25so8070053wmk.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICGPqAgZ3WgI5emnR6dJxumcZBHe2UJAAqEmNjga70k=;
        b=s9m0WFBujGM77tW5sLaK1fAkCw4N6vVJvotE9PegsRciwXuKYRu6FW/JipOC+8Z34j
         ffUqiPuIIepgxhAE4bkLm5V1AsRCuiqIIqYhumOBoQb03CCSCfZH3meBEoHYqMT4lS26
         MQATZDBfTU7DjG6Z+X0ZWe6IzJgOuOdGu8ZA6wU3Jfd6qErfdwWFMOIGN4vYePbRW87c
         UqKZKRhV8hyV1vLmmW+YI10gWf8my3uYh/yL3QwVwb1QewzB5ddwi77yeZvMApgmxSGn
         M9Ae0OojNKVsmk4VgCPX7+HhmEW335pEPSPhyivZAIqFkhpWIM0PfeRrdQdOJs+peK6N
         j6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICGPqAgZ3WgI5emnR6dJxumcZBHe2UJAAqEmNjga70k=;
        b=ax2iSX/ZPr/Z3IievPKFFIWPTEw0BH9a89C6PTL482au1EWGWhxYscRNuXoOjxwsg+
         w5wnxyi64cmLX2xobkz0HvFpuBWug5DKAwqEUVUB0bJ8TfVhdnJsUpccnruoBxBMnlWH
         6RBtVoASIpy3EA6IKMoXRDxrJUnYgtk2ni14MpYYNDPaDGYkt5puQIX611VDa+2MS1Ut
         onobZM6WD2zZlhDyLsdVzt8Qmzcx8LRn8ZDZcTIaaOQLP9gy10K/B7+Ulya34VGJji9n
         gHjIXwwJc69y55/dShYhuBS1F4l8a7ivdqhev5OmTWb2BJN+JmeBZEbP4I20gdiJXYB0
         yldA==
X-Gm-Message-State: ANhLgQ1XAdyq4hzVLF6DZAeTwj26Zj/xS8lQ3Tkg5VMfOntMDb0EDdyK
        PL0oRz8bU9awtuJ2GzCbgscFY9kqt3U=
X-Google-Smtp-Source: ADFU+vuGdmuOPoiLBe7l3bjKK0rj5cn2tTKBgzMg7Zt1zrXQHDPmHETAIJDzbWi0G4XnEf57cGgf5Q==
X-Received: by 2002:a05:600c:2315:: with SMTP id 21mr12512032wmo.72.1584740307129;
        Fri, 20 Mar 2020 14:38:27 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id i1sm9742407wrq.89.2020.03.20.14.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:38:26 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v3 4/5] doc: be more precise on (fetch|push).recurseSubmodules
Date:   Fri, 20 Mar 2020 22:37:28 +0100
Message-Id: <20200320213729.571924-5-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default value also depends on the value of submodule.recurse.
Use this opportunity to correct some grammar mistakes in
Documentation/config/fetch.txt signaled by Robert P. J. Day.

Also mention `fetch.recurseSubmodules` in fetch-options.txt. In
git-push.txt, `push.recurseSubmodules` is implicitly mentioned (by
explaining how to disable it), so no need to add it there.

Lastly add a link to `git-fetch` in `git-pull.txt` to explain the
meaning of `--recurse-submodules` there.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/fetch.txt  | 10 ++++++----
 Documentation/config/push.txt   |  2 ++
 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-pull.txt      |  3 +--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index f11940280f..8778a99fa6 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -1,11 +1,13 @@
 fetch.recurseSubmodules::
-	This option can be either set to a boolean value or to 'on-demand'.
+	This option can be set either to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
-	unconditionally recurse into submodules when set to true or to not
-	recurse at all when set to false. When set to 'on-demand' (the default
-	value), fetch and pull will only recurse into a populated submodule
+	recurse unconditionally into submodules when set to true or to not
+	recurse at all when set to false. When set to 'on-demand',
+	fetch and pull will only recurse into a populated submodule
 	when its superproject retrieves a commit that updates the submodule's
 	reference.
+	If not set, 'on-demand' is used by default, unless
+	'submodule.recurse' is set.
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 0a7aa322a9..f5e5b38c68 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -112,3 +112,5 @@ push.recurseSubmodules::
 	is 'no' then default behavior of ignoring submodules when pushing
 	is retained. You may override this configuration at time of push by
 	specifying '--recurse-submodules=check|on-demand|no'.
+	If not set, 'no' is used by default, unless 'submodule.recurse' is
+	set (in which case a 'true' value means 'on-demand').
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a115a1ae0e..b1058d63bc 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -163,7 +163,8 @@ ifndef::git-pull[]
 	value. Use 'on-demand' to only recurse into a populated submodule
 	when the superproject retrieves a commit that updates the submodule's
 	reference to a commit that isn't already in the local submodule
-	clone.
+	clone. By default, 'on-demand' is used, unless
+	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
 
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
Patched on top of v2.26.0-rc2-27-gbe8661a328 (git version 2.25.2)

