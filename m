Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A34C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 20:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiDGUsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 16:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiDGUru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 16:47:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404A36040F
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 13:40:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d29so9547609wra.10
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzQ2YOdd/XdMoWzGQF92Q2M/ubIVdafy8g51NgnO8yw=;
        b=D7a45gWdgTsZq/oXrjJIu/BHxo5Bkwgh9VgoVF6xdRx5yMMe3HAN2W6Vxb81cWGktr
         Vrg+0T2UpDBPpZCtK/5nR/x/drqXPqInUCyT4KaqOlY5gRr8XnN7g3ZcKpc8dYQxQBou
         FV0DmkyCPqEg+rtSkLv/6HKs1eF1setLx9SqJzDVudbiLT+tYqaiClVlXzsx3reEKcsk
         xMcDwUINOGAI4iRODPI0JCVKwkAGTOKGh1YttUcGemg6cIYMxjY+lgZl9w3R0dsChChK
         juulxQdV1C8UnR3zFZic2p99w32Fv59PQMNQoq1J47TNt/0Drkmmk9AYzssY0VjLqaQ0
         zU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzQ2YOdd/XdMoWzGQF92Q2M/ubIVdafy8g51NgnO8yw=;
        b=DPC8sXR/fcX/rGArgXlUa2tnGGDK/s3pVBb04HhKzuitKTxusG3pYnwcRuwtNsJxOi
         fzNBPYLQXZNx8Y0ooL1zlb+JXaaHrEHinlenaKbL7nxcdXJZVq/2x9JCMq8lC+/9bcH5
         SuogbEfTByLKgp+PvIhumWUSiOIdNBLzahoallD6e/zMUmOM7jeMiC2PG3pITSH0E6RI
         JSjmH4y6AONkgij8dtkzWyO00XHJ/7IbG8DJtEQpbfj1miN0Y4u0uKPvJyRmmHgIektV
         4+LaEKs8kHxw4QXLXk+w87wlNkLRLhvKJc2slIG6kUtHt7qzsT/RP1B7qzLoj0aAmt1U
         2Jjg==
X-Gm-Message-State: AOAM533PTeLK+60eHkkLge+wkr1+Vu0ldyqbZDd4vc0DSGiGsW99CT8w
        99tNrDdATg19iopJLI5TPRyvzUNnMYkUSg==
X-Google-Smtp-Source: ABdhPJxDVyoinEttT4+t2zx1N4Or/ZGyopVh8i37ScojL3jbEGyX+ZIY49RfSXoTp/nzOakejufsZw==
X-Received: by 2002:a05:6000:186f:b0:205:857d:dee8 with SMTP id d15-20020a056000186f00b00205857ddee8mr12278937wri.532.1649364014413;
        Thu, 07 Apr 2022 13:40:14 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0038cc29bb0e1sm10276793wmq.4.2022.04.07.13.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:40:14 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     Matthieu.Moy@univ-lyon1.fr, avarab@gmail.com,
        cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org
Subject: [PATCH v4 1/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Thu,  7 Apr 2022 22:40:01 +0200
Message-Id: <20220407204001.112287-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407204001.112287-1-cogoni.guillaume@gmail.com>
References: <xmqqmtgwu9n7.fsf@gitster.g>
 <20220407204001.112287-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The externalConsole=true setting is broken for many users (launching the
debugger with such setting results in VS Code waiting forever without
actually starting the debugger). Also, this setting is a matter of user
preference, and is arguably better set in a "launch" section in the
user-wide settings.json than hardcoded in our script. Remove the line to
use VS Code's default, or the user's setting.

Add useful links in contrib/vscode/README.md to help the user to
configure VS Code and how to use the debugging feature.

Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 contrib/vscode/README.md | 6 +++++-
 contrib/vscode/init.sh   | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
index 8202d62035..f383c95e1f 100644
--- a/contrib/vscode/README.md
+++ b/contrib/vscode/README.md
@@ -6,7 +6,11 @@ code editor which runs on your desktop and is available for
 [Windows](https://code.visualstudio.com/docs/setup/windows),
 [macOS](https://code.visualstudio.com/docs/setup/mac) and
 [Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
-it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools).
+it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools) with
+[debugging support](https://code.visualstudio.com/docs/editor/debugging)
+
+To get help about "how to personalize your settings" read:
+[How to set up your settings](https://code.visualstudio.com/docs/getstarted/settings)
 
 To start developing Git with VS Code, simply run the Unix shell script called
 `init.sh` in this directory, which creates the configuration files in
diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 27de94994b..f139fd8644 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -271,7 +271,6 @@ cat >.vscode/launch.json.new <<EOF ||
             "stopAtEntry": false,
             "cwd": "\${workspaceFolder}",
             "environment": [],
-            "externalConsole": true,
             "MIMode": "gdb",
             "miDebuggerPath": "$GDBPATH",
             "setupCommands": [
-- 
2.25.1

