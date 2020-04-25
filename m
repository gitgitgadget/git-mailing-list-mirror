Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EF6C2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 01:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9688B20776
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 01:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Vd6R0ELn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDYBFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 21:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgDYBFs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 21:05:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D238C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 18:05:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b62so12211373qkf.6
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 18:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SwYhEsjStsWOsRbP/Zb7wIpRNeaFxVDA89Db8FuVTOM=;
        b=Vd6R0ELn98KWd174kXDoBnW3Nogi88MWp5unTD86VIT089lPhTHul3Onkt8jy6KbhK
         Tx8/R/MXlcXwq5fbxxiY5b1HvaUJSNd7mqL8hrlZBfrqsVaP7MVr1pnjmnqJdid9JW1h
         honjbSxmSezhbP7NYGny+YwFyF9UDmpcxoYkHyKtUGtcJ2pirTZFQZwyvp13d4b9Tlyf
         5XdHkotVi0mKcKFynh5A0VWxeG7cCYm/Rd1exTe8OBFA1lBKzfLhQjqU+k0PrNZ4n03K
         ZI3hCLvC5pv2PMg0EBes9hK2yWyfb1d3bBPY0WMPwShq9aFWaaK2BHsaS3TAR5irxTFq
         sklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SwYhEsjStsWOsRbP/Zb7wIpRNeaFxVDA89Db8FuVTOM=;
        b=NbEN6ApTYRRD88nXG68cKdd8Dv5riWBM8mmX7aJZTGxqKv47tqHJbTjkA7OMX8fuHD
         DW5n7bHY1XhoLQhjDiJ9/G2hDXJK4JVHS4Wi6O34NwGSoZcFV/Qs6wO6pwKhnV+rIny8
         M8YScAk7bzTKYeV7dwlDn+VAfXlAm0DEAtLX7NdiPWX4kUlhOWs1uttO24IZb20UcuuZ
         OhaMvmjRU+m+nPkJv/1rUiPJX7RQcFVs4NR1s0H9tsIJLEFxoR/zdVmp5PV+5eLK0s3b
         24d8O+S8VPuyn4o6bRUWzjCZL3BwFfwjTy8N3SDdjYRQWklQ+Vbz8uGdyyvIX5XVxELQ
         1Wtw==
X-Gm-Message-State: AGi0PuaUtPAw6hfqsNJBfUoiAs/J/1WfxxunPr27ZgqMp/Zy7mnC3qN0
        OfOPMp9JR2QXLFhn+hQoZwHb2YZlO/Y=
X-Google-Smtp-Source: APiQypIkdTZa9Mj4zBGrC9opGUCuNTmqkizaEAHUClmaqoH7cbaQcscB9I9c2iFuR2H3kC3OVPEsag==
X-Received: by 2002:a05:620a:796:: with SMTP id 22mr12170433qka.247.1587776745248;
        Fri, 24 Apr 2020 18:05:45 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id g3sm4801839qkk.24.2020.04.24.18.05.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 18:05:44 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH] config doc: fix reference to config.worktree info
Date:   Fri, 24 Apr 2020 22:05:38 -0300
Message-Id: <569b5808d64a95369daa4b882e14d9f3ab87871e.1587776525.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

356aea6 ("doc: move extensions.worktreeConfig to the right place",
2018-11-14) moved the explanation of extension.worktreeConfig from
config.txt to technical/repository-version.txt. However, the former
still contains a reference to the removed paragraph. We could fix it
referencing the gitrepository-layout man page, which contains the moved
explanation. But the git-worktree man page has additional information
and recommendations for the worktree config file, so let's reference it
instead.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Note: git diff --word-diff should only show the following change:

...
`config.worktree` (see [-`extensions.worktreeConfig` below)-]{+the "CONFIGURATION FILE" section of+}
{+linkgit:git-worktree[1])+} in each repository are used to store the
...

 Documentation/config.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 74009d5402..ef0768b91a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3,11 +3,12 @@ CONFIGURATION FILE
 
 The Git configuration file contains a number of variables that affect
 the Git commands' behavior. The files `.git/config` and optionally
-`config.worktree` (see `extensions.worktreeConfig` below) in each
-repository are used to store the configuration for that repository, and
-`$HOME/.gitconfig` is used to store a per-user configuration as
-fallback values for the `.git/config` file. The file `/etc/gitconfig`
-can be used to store a system-wide default configuration.
+`config.worktree` (see the "CONFIGURATION FILE" section of
+linkgit:git-worktree[1]) in each repository are used to store the
+configuration for that repository, and `$HOME/.gitconfig` is used to
+store a per-user configuration as fallback values for the `.git/config`
+file. The file `/etc/gitconfig` can be used to store a system-wide
+default configuration.
 
 The configuration variables are used by both the Git plumbing
 and the porcelains. The variables are divided into sections, wherein
-- 
2.26.1

