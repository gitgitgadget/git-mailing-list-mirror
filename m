Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA1C2BA1E
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821EC206F8
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmcTB+5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDEUQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:16:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34512 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgDEUQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 16:16:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id c195so6383188wme.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JZ4W1b0My3gCAzn+gTfP2mQ65yXawb6uxIAPqNeVKM=;
        b=EmcTB+5u2GkURL7CWIzVypMaYXRwf42E/XEYnNWmiXD8TPbGTjMViZpaTDzVU/FJHi
         l4VOHISPw7EfpgQsmqkMOAS7yDTc3HqCbarFpS6dBeSArMKXFb4cW0YQIRoUhJWryjEM
         ZJlcPGNS9PRj9kJHK75v1BM+F5A34ynX4uZv2lR6nrKVin+XrGq9ImGmbpZYiLKDOICg
         Ej0TtoXewOcQiCsucbvferfV7QfcMNjhbvsP04SfWFhPaZL2O0YZWVaf3R0qM1NILakT
         mMxt0W+JTIPSJfEPWUyEQwtjhe4bRdGGZB4FrvjPmL0afjRiOHqrYhzzGJ/TQpqkqSD2
         q0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JZ4W1b0My3gCAzn+gTfP2mQ65yXawb6uxIAPqNeVKM=;
        b=jtgHJ+pv5buxmBNMdHNBsVHzFLh8kZXgClAt0aRf0UoAOXci3u8gJM5fXtA71Vr8Ir
         OZC1GhaSrrgM/SB6FUT7j7WRox01qgQ+rezEIpcvJbvcl5DK053m9EH1UlbOkkgDeVxL
         dyC6Opq+LAjW547UACNTdBa2ls6xvDXjTPS/w7JMW5qwE1e6tEVSq1t48ahgr01KB6eK
         jOaC0Hyr50MibL+Y629EEhv5CmsxTR3uz+rOMUrspgYDEBpzkCrjvZDwCtKOMgZSPPzY
         GCORZvkSeXqvE6c7Py+IsgQYo8GHI8USJTVPFUadX7EihkN7EjPDM09HlGIUJnwl20wB
         88Cw==
X-Gm-Message-State: AGi0PuaYsYWpzO25fNEOUpXQeWQrsA2tfH8/1INXrStyCKLnKQ6qeGa4
        SYeH98hxDoVkm7HDi0WzMEuMZghXLBTLJw==
X-Google-Smtp-Source: APiQypK0q/KxCKB8InNo30hKu1SYS3fANYiNJi4qTrILgU1A3vXWuB9Pf7Oo+bvmpR6c4abEWoqhbw==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr19501997wmg.42.1586117812975;
        Sun, 05 Apr 2020 13:16:52 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id d7sm22468921wrr.77.2020.04.05.13.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 13:16:52 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v5 4/5] doc: be more precise on (fetch|push).recurseSubmodules
Date:   Sun,  5 Apr 2020 22:16:32 +0200
Message-Id: <20200405201633.704987-5-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
References: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
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
 Documentation/config/fetch.txt  | 13 ++++++++-----
 Documentation/config/push.txt   |  2 ++
 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-pull.txt      |  3 +--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index f11940280f..4114af4b3b 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -1,11 +1,14 @@
 fetch.recurseSubmodules::
-	This option can be either set to a boolean value or to 'on-demand'.
+	This option controls whether `git fetch` (and the underlying fetch
+	in `git pull`) will recursively fetch into populated submodules.
+	This option can be set either to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
-	unconditionally recurse into submodules when set to true or to not
-	recurse at all when set to false. When set to 'on-demand' (the default
-	value), fetch and pull will only recurse into a populated submodule
-	when its superproject retrieves a commit that updates the submodule's
+	recurse unconditionally into submodules when set to true or to not
+	recurse at all when set to false. When set to on-demand, fetch and
+	pull will only recurse into a populated submodule when its
+	superproject retrieves a commit that updates the submodule's
 	reference.
+	Defaults to 'on-demand', or to the value of 'submodule.recurse' if set.
 
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
index 00d03ec8c3..833f935cd0 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -163,7 +163,8 @@ ifndef::git-pull[]
 	value. Use 'on-demand' to only recurse into a populated submodule
 	when the superproject retrieves a commit that updates the submodule's
 	reference to a commit that isn't already in the local submodule
-	clone.
+	clone. By default, 'on-demand' is used, unless
+	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
 endif::git-pull[]
 
 -j::
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
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

