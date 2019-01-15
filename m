Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F52C1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbfAOTVj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:21:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39781 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfAOTVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:21:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so2944211lfh.6
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=GsfBAnk4ceB7+dSIdZukmnm44Kw6J1BA0oHlIfPTVSQ=;
        b=lO2Va4LmqI/2UGK3bVpQ3TVEZXQFuNUH+58e/k3nvYNMiLSupPJZqExKe9o2yRd1rg
         YQCRLkbfvnirGnIbtNpjS8e6kBrmyR8Q1uYSfdfukQXSSBbIE5p0+O0x5zX4nyLj74NR
         i3oO/0Smslzn+hCqe+qwHFWzkoZclQTDvTEcK7/4DiuEB7sNJ8RgvKR2PiEK2uds/tuc
         ZGvQky/ZH4wL9k5WXaLdYariEMQ9WuW8iz2yFOElf5vv0RHUo9sSGVwRA7SF0ZCaR0b6
         rARSohXEebVnckAyoGFTpxGBe0fzjddfyzrCCILwuwJFewTJbkytk2/VkQr6fH4IpR/U
         Jthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=GsfBAnk4ceB7+dSIdZukmnm44Kw6J1BA0oHlIfPTVSQ=;
        b=pXXywBriFWNY225+D/XxXMvNa24u4zdmfXJ2zX8WDOh+NCEJF5ZNPbzduHXBOYA6SD
         GatWwWBTzW1J4sMaH6yCUhlMIi88QFcrxZKuyN9FF19pqnRNBQkz9n8jo9cC+w/TLcBc
         +EdoTW8Hc/pY51349GlF02bRMpCZMNWHap0vTmAZN53S1/fw+wiVBrS9yoxDQXX725TS
         R6sUz4GvUC36gNusr+yzxcSzult5GoZ3d4eQrjCRL1wSgzqNoosH6Lo3+XbWmBHhz35u
         r+NaDQpzH7xqhVX4sSx5+EXybdmAVscBUgLgN1E0XTJbSG2RpCETPmkTiioClTp0tsNf
         SFFA==
X-Gm-Message-State: AJcUukf+9gZ7tKl5PB7mCXYfEJ4J+olUSjRaS/kG4I3cdmTldJeNULMF
        xN9+gcAkrUfQ90mWeMKFQxO8RARwddM=
X-Google-Smtp-Source: ALg8bN60hxDIhczhaLuiuzNPfDhWOTKpnLL1hrG5ME90231utN0lBDgcdjYip81NK1bFWq1cRSse9A==
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr3878928lfk.78.1547580096571;
        Tue, 15 Jan 2019 11:21:36 -0800 (PST)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id a2-v6sm708216lji.13.2019.01.15.11.21.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 11:21:35 -0800 (PST)
From:   Jacob Kroon <jacob.kroon@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH] gitk: Don't mark files with new time-stamp as modified
Date:   Tue, 15 Jan 2019 20:21:18 +0100
Message-Id: <20190115192118.14072-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Run 'git update-index --refresh' in order to get rid
of false positives about unstaged changes in files.

To reproduce:
1. git status # no local changes
2. touch <file-under-version-control>
3. gitk # file shows up as unstaged modified file
4. git update-index --refresh
5. gitk # file does not show up

See link below for more discussion.

https://public-inbox.org/git/0c4b21c8-996b-3017-a1f9-894ac5b27232@gmail.com/T/#m121ab8bd38196a53a6d7ccb89034a99dcd3a703e

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 gitk-git/gitk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a14d7a16b..016c1d7fe 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -5334,6 +5334,7 @@ proc readdiffindex {fd serial inst} {
     }
 
     # now see if there are any local changes not checked in to the index
+    catch { exec git update-index --refresh }
     set cmd "|git diff-files"
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
@@ -7829,6 +7830,7 @@ proc diffcmd {ids flags} {
 	    }
 	} else {
 	    # comparing working directory with index
+	    catch { exec git update-index --refresh }
 	    set cmd [concat | git diff-files $flags]
 	    if {$j == 1} {
 		lappend cmd -R
-- 
2.11.0

