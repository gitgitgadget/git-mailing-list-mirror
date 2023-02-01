Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11030C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 08:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBAI0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 03:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBAI0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 03:26:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEC15DC1D
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 00:26:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n13so5025663wmr.4
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 00:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp9OKq8eoUA5PrOMufGUyIc10Fn6Qk03LZP/jC7PWzY=;
        b=Rkn7zu59NXHNtTsAgyImedLbRnpjefR84EA25eH8++aHCfjU/QTcJzGB7eixahEVNX
         O8QCoJQHM9CC4oyqxmdsmagsHTNAzwZ67GDlXanUnmbYP+TZ9pvG16ek2Xx8AKHRTc43
         WZHFwgvlEKsGxNIKCiQ16rh04+Innvx57Xo9ZP5H7carkXEX7CMb9+371llpaMK4nYqZ
         +juXhoKOW/xFBKyhQeYW3SYojmHouIKTdbypPiCpsqBoqSPLYR5ZyCdE+4+G0B/TNHN0
         yCu6E1WjVyfDCMbPqWO+bpblu6yWROSr8gCGcID7uK3Mtk6fUM7+lgY/2F9eSVDNMhKz
         6rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vp9OKq8eoUA5PrOMufGUyIc10Fn6Qk03LZP/jC7PWzY=;
        b=WpTCAd+j9OGe3rDdErg9gkgsMNkwmJA3FXXEzsj0M3XHWQM9L+5a98QHFiv5cVYvAp
         nAJ1i+HVuql2IiokT89aAwAJ6i8lewnrYDu9qxMJCwcY5w38977WjbXTeHIyYgUTec4V
         ekVyGLiQqig9a7gfR+BsbWXCtm+jcpKJe2bL2MRu5IHBt3RaBnC9CFrDgOOjhqNH4HOn
         tmypf09jY9opLHaSd1FfmNi9sOKH+dOflUpTiGGJ8t8YjJs8bvz48VKhidrJi/Y14Bky
         2BV7hrcHq3ttaEKtJEccSmGYNCugpENSwLe2pRQtZXykXon8/IjaNT4rw9ewdob2HAq6
         U/Yg==
X-Gm-Message-State: AO0yUKUY6Kd9JD3IJ3nYkB2UkkITBxR0kdq59LpdA8TExCMdC3HT/7bR
        ePpUBHKt5QkmBV2iesHjbpPuDKKUPm4=
X-Google-Smtp-Source: AK7set+tRSAFOiMOIUGARVO4Ax2vuP16OOqIvGQoghWr8uWmZqlqC0zwhi3PHX+/85YQU2wqWHPoeA==
X-Received: by 2002:a05:600c:b86:b0:3db:eab:a600 with SMTP id fl6-20020a05600c0b8600b003db0eaba600mr1107703wmb.7.1675239968625;
        Wed, 01 Feb 2023 00:26:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003db09692364sm1079057wmq.11.2023.02.01.00.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 00:26:08 -0800 (PST)
Message-Id: <pull.1446.git.git.1675239967804.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 08:26:07 +0000
Subject: [PATCH] git-gui: fix inability to quit after closing another instance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

If you open 2 git gui instances in the same directory, then close one
of them and try to close the other, an error message pops up, saying:
'error renaming ".git/GITGUI_BCK": no such file or directory', and it
is no longer possible to close the window ever.

Fix by catching this error, and proceeding even if the file no longer
exists.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    git-gui: fix inability to quit after closing another instance
    
    If you open 2 git gui instances in the same directory, then close one of
    them and try to close the other, an error message pops up, saying:
    'error renaming ".git/GITGUI_BCK": no such file or directory', and it is
    no longer possible to close the window ever.
    
    Fix by catching this error, and proceeding even if the file no longer
    exists.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1446%2Forgads%2Fgit-gui-no-quit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1446/orgads/git-gui-no-quit-v1
Pull-Request: https://github.com/git/git/pull/1446

 git-gui/git-gui.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 201524c34ed..b00ee691e3b 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2307,7 +2307,7 @@ proc do_quit {{rc {1}}} {
 		#
 		set save [gitdir GITGUI_MSG]
 		if {$GITGUI_BCK_exists && ![$ui_comm edit modified]} {
-			file rename -force [gitdir GITGUI_BCK] $save
+			catch { file rename -force [gitdir GITGUI_BCK] $save }
 			set GITGUI_BCK_exists 0
 		} elseif {[$ui_comm edit modified]} {
 			set msg [string trim [$ui_comm get 0.0 end]]

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
