Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62589C43217
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 04:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbiAGEDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 23:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiAGEDo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 23:03:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11514C061201
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 20:03:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so2180609wme.4
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 20:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=qq6PdCsz26gd1P0Pi1vzCo6eB9GKM0G8s98+FIVVaGs=;
        b=IP2juGNESzS8PFERW7+HlyFN0w600k0lApPiMqUUf7J3A3WWUmZwN5T9AmlXU+yNKv
         1yHIzUDD95/h+QSOnY1VrYfCq3gZBYENZmqRXCwXCFuwqMwxmmDpiq3Skl0Xr8Ld3Hhe
         OD5/pPLypz/TWyiRbFXHqBD1KQqkbPeKzFjioQKHgUdqTf89uRdX9uDh6ytn3nnokCoa
         q6KSOKrb88Rpy1vVTPPmaPMJ0nsAjzOt2DwKzmw3d+171NUMQDrqDo18R4w5LwhByLip
         GrXUsFkIAx6qoshtiVbGN2KZpFONOIA7ZH6pNP+7IeBasIJT7HjCOTjBuh4zFZ9Jh2g6
         +qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qq6PdCsz26gd1P0Pi1vzCo6eB9GKM0G8s98+FIVVaGs=;
        b=Q7FcElmtjF9byzdk/exqytXIVLxFu3KbaowciDPhru71EXqf+4pFy8FSiM1bKJcGCD
         uWmNnGpAPNUDdsZINQCFbwLVaruY5C06ac4V/RszvSvA4lFWkEffgnpn/HjBHdI8b3E3
         TYhwImmaHFTcMbVCgXhbuX36Yx8S5+TmqG6SQ3EJ6X1CTM9Mh71CrTtS4t6MdwDVWtHv
         x/6X7eAewjCWC/7JLuECuWmmzbFMADGZeeguB/OhvqmUcVLYJBIrEqZa7CTdP4FzzUX0
         EjU0Kf3Pe9PoHSe/auvBFKJXtTm1b8WCYY9KcMqFefWFnCRqDgH5xLAAOmCHT/2wcZ6V
         xskA==
X-Gm-Message-State: AOAM532sRnclNlGxPBoXXB8kql7uS3sJqY9Fwe+dKGSbLueFBdgos8BV
        dO6fZB/6MC7T7fHbIZ5xRMGcvP3n9Kg=
X-Google-Smtp-Source: ABdhPJxR1zv7h1TaqyXA73l5Ovs09vaXfMDaOAMtD0l7v+WKcUbFA6ealo2AU1KLadhbIjXUxB9NyA==
X-Received: by 2002:a05:600c:1da5:: with SMTP id p37mr9550550wms.59.1641528222464;
        Thu, 06 Jan 2022 20:03:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm3198869wmr.15.2022.01.06.20.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 20:03:42 -0800 (PST)
Message-Id: <pull.1172.git.git.1641528221530.gitgitgadget@gmail.com>
From:   "Issam Maghni via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Jan 2022 04:03:41 +0000
Subject: [PATCH] hook: test -a|o is not POSIX
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Issam Maghni <issam.e.maghni@mailbox.org>,
        "Issam E. Maghni" <issam.e.maghni@mailbox.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Issam E. Maghni" <issam.e.maghni@mailbox.org>

I faced `test: too many arguments` when building using sbase [1]

This is due to a non-POSIX syntax `test ... -a ...` and `test … -o …`.

> The XSI extensions specifying the -a and -o binary primaries and the
> '(' and ')' operators have been marked obsolescent.
[2]

[1] https://core.suckless.org/sbase/
[2] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

Signed-off-by: Issam E. Maghni <issam.e.maghni@mailbox.org>
---
    shell: test -a|o is not POSIX
    
    I faced test: too many arguments when building using sbase
    [https://core.suckless.org/sbase/]. This is due to a non-POSIX syntax
    test ... -a ... and test … -o ….
    
    > The XSI extensions specifying the -a and -o binary primaries and the
    > '(' and ')' operators have been marked obsolescent.
    
    https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1172%2Fconcatime%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1172/concatime/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1172

 templates/hooks--update.sample | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index c4d426bc6ee..6cc46ebcf3a 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -37,7 +37,7 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
-if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
+if [ -z "$refname" ] || [ -z "$oldrev" ] || [ -z "$newrev" ]; then
 	echo "usage: $0 <ref> <oldrev> <newrev>" >&2
 	exit 1
 fi
@@ -95,7 +95,7 @@ case "$refname","$newrev_type" in
 		;;
 	refs/heads/*,commit)
 		# branch
-		if [ "$oldrev" = "$zero" -a "$denycreatebranch" = "true" ]; then
+		if [ "$oldrev" = "$zero" ] && [ "$denycreatebranch" = "true" ]; then
 			echo "*** Creating a branch is not allowed in this repository" >&2
 			exit 1
 		fi

base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
-- 
gitgitgadget
