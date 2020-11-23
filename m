Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FD2C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12A0206A1
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqqHwq+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKWXUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKWXUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:20:12 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99BC061A4D
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:11 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so20454933wrb.9
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hXEJY3v6TTAJzFBcIm7ytbs9WZJxxSVV6Hw7lvdxUkE=;
        b=nqqHwq+D5PHkPhkoAuZalztkBiJLaKRHMDlg7P+5d/VFbbSW6Tq9EIg42WZik3CyIP
         MgMb9pjIGYp1pCpR5iVDtM7Uw6bmd3u9vlupJbwLF4WLseTfykeOmQvxHXfVreDCqN2z
         uHQT9IlE7RoiwmERLusiAH2Y5jsowtLpJj+ThfSs4Q1I20BxrdUTRZrXZPlXCFdCojQk
         nkdlWYS9w9IO2moqICgtSOhNbUuUJTt/TEinlLkorkrqr0u7Lw+dV7PjnlzIkej/siBZ
         RUHDrKqZj3+LhwGq0L4DBSNKkUboy2QEUngNfjlcr6JY2Afz713zIOmeR3lUsewPXTtE
         vEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hXEJY3v6TTAJzFBcIm7ytbs9WZJxxSVV6Hw7lvdxUkE=;
        b=b8bBqtB80CrwyHLGa7lqe4rF4mpng1NskJgh3Ktf1W5PfZfwKSN6dEQMF2mu+zMtyG
         G/qkFAtrkgWhIUwJWi0p1zIFQzcJUtET5Uugosw6MIclaohc7s3Q5U1quHh+ajARZkc/
         C12JAyQYsgjFykMJI7Sx+OEys5FW9rAxHNdU4i63BAo8Ph6YdrHKbOvSfeUGOX7NJuz2
         V7qWmKKHpiqmFB5Hg+rCRsiaATK9YnvL/BDyJJhfaK0u0YxYRmz1YuHo1ukCyBq430LC
         Nnn4HMBs408oUycRE4rRwBPyt8wvJr7KJe7hYYIniM7s5kktEAZoG7d7PxGupAeOfTRy
         83DA==
X-Gm-Message-State: AOAM532SrFeWY8of4QuDXIxgoTupsaAdMgec+8pE8Q4N1bAliV4ozJkQ
        fCdUJnH3OIUWdm5idjlOQDiyxwz87vs=
X-Google-Smtp-Source: ABdhPJxVYCp3sY2pW5Kp0QmILJ1wIDkHO1WMKXf0oIIncwTWUdNExiuUtQKhrsZp5hnxQkOsxmxD6A==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr2185807wrq.210.1606173610122;
        Mon, 23 Nov 2020 15:20:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm22047294wru.82.2020.11.23.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:20:09 -0800 (PST)
Message-Id: <483e490349165223a80a0bdf7716c5189560c977.1606173607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 23:20:04 +0000
Subject: [PATCH v2 1/4] init: document `init.defaultBranch` better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Our documentation does not mention any future plan to change 'master' to
other value. It is a good idea to document this, though.

Initial-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-init.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 59ecda6c17..2b399cb73d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -20,8 +20,9 @@ DESCRIPTION
 
 This command creates an empty Git repository - basically a `.git`
 directory with subdirectories for `objects`, `refs/heads`,
-`refs/tags`, and template files.  An initial `HEAD` file that
-references the HEAD of the master branch is also created.
+`refs/tags`, and template files.  An initial branch without any
+commits will be created (see the `--initial-branch` option below
+for its name).
 
 If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
@@ -73,8 +74,10 @@ If this is reinitialization, the repository will be moved to the specified path.
 -b <branch-name>::
 --initial-branch=<branch-name>::
 
-Use the specified name for the initial branch in the newly created repository.
-If not specified, fall back to the default name: `master`.
+Use the specified name for the initial branch in the newly created
+repository.  If not specified, fall back to the default name (currently
+`master`, but that will be changed in the future; the name can be customized
+via the `init.defaultBranch` configuration variable).
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-- 
gitgitgadget

