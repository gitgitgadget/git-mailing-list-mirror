Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51943C2BA1E
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28903233EB
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msfT684H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgDFN5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:57:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38503 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgDFN5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:57:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id f20so6909673wmh.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPO2vDRes8YxqNfSk7uyDHr9evzs8ZPUVyod5PSrKCU=;
        b=msfT684HUgcDWNsing2iEXKaj3o8km4rU8Q+OH5yF5Wfd9aLTD90fgG9BT3neF3v4H
         dRMF3jm1z9UfuqDpFR4KkNIpX4gAtRW0noBSjhwZBLhCbBy0jbKq/INuYFaLuQ53vWzg
         cSG5726YK5GEcwnOZp9Kcct2jK73AcEubBzHETpkn/XaJ7qudRCnYKlJph01U4aaC68s
         F2ZEPlk6UehdIMndHS9BrUeYek1WUFPtzV4srGs/ATNhERnzEiVnTKvOiHK8GWEoP3qv
         i9PJfTn1gJY/3REe53oUe77xIDK21OU7qd1+h69i3uZsAEpQ9XFmJPDPHotvZIRQajxT
         FjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPO2vDRes8YxqNfSk7uyDHr9evzs8ZPUVyod5PSrKCU=;
        b=fFkNc6iOeNb8tcAdAa0OPcAvA6VM4Bkz4ygvENvUmej+g0ZrzVOIK96cCVH/8R0Eec
         M0Z3KqcfMwznV2TDvQ76e2mGiZp/0HK/sMHZnhOy0r09ZCoDpK1bBCB8fT4/IbHwOntt
         WNusPusDON6X29psN4P2scR5hfYmGFD3FWj2sldKelXf7Y//qtAjDSC3TDf/xwFOJxVX
         /OqG7xVraQIdO9EsK52ZbnrROYc7CINkU0SJXNd0yeIIEmPNX6mjSmxtfyd3W0Xy0zrX
         rlbOxqlXi5ejZymUzIw0jURmon4G1pxhsRolNtTC8FMbSm5EcU/Fw2XnQ2FsBeH246g+
         4+BQ==
X-Gm-Message-State: AGi0PuaWxIz0ChTCuSIbYXiC9IgcUGoSvFd9NYYAvZ3l0a4+KdGOyW7t
        NBtmMOoko1lp9Dp2fEQjXOm9uHbu61Y=
X-Google-Smtp-Source: APiQypKgK2hpbNKhxfNc9Y+y3/KD3VewgHrau6APhVldolMe9B3AO9Kn1k738E4CBAGAlw4w9dFteg==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr21846304wml.44.1586181458420;
        Mon, 06 Apr 2020 06:57:38 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id s13sm10414149wrw.20.2020.04.06.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:57:37 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v6 4/5] doc: be more precise on (fetch|push).recurseSubmodules
Date:   Mon,  6 Apr 2020 15:57:08 +0200
Message-Id: <20200406135709.60041-5-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
References: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
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
index f11940280f..b1a9b1461d 100644
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
+	recurse at all when set to false. When set to 'on-demand', fetch and
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

