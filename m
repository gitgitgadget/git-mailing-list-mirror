Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C94C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A8261152
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbhJGVl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhJGVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:41:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3219C061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:39:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m22so23377730wrb.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=zuS217l7Jj14/TC5bE6Uud8T70TzB5BgHfbF6kfDw/8=;
        b=UP4SgdX/F1vuEGcZ/lFv8dCCPKiSwTHVGf0zw7ZADZOLkiJF/6B/9JGEyZAkw5rT8K
         vtK7/F2/Ff5buR7Cg3/VKWNSNUAEojjmt/JockEfkQqK8VpfETyndRiDj5M8qL5hIkkf
         VsLUO13k7VqLBqRhNWs6FScxoc2hgR4Vfwn2hobS8kk/aqCKMirXCRUGRcoqRkGpnka8
         QasrDrG7VXSeAGod3OEEBjXPMrmN9tzNPE0urrGJC9N6n9wpNMpvozH802QyH0ziDxgA
         US1QvThqdS9uh6hsGSE2m7tfqNeaM4lIS+36ZhWMygCL46lH3FOKcBXwlzipJIJyv4wc
         rIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zuS217l7Jj14/TC5bE6Uud8T70TzB5BgHfbF6kfDw/8=;
        b=JmD7itw+QGNyzXC5mvUwY3v2cANuuih6HN0JCV5R9WxgfHE3NYHhbGObnailHiHb1s
         N7HbP63vdh+889vau4k/2hi0R+qMsCvEMpJxr79cbaEfavhplNQ2tsZJTiDT08Oge6tQ
         0XVHeXiFRCNgFL5ey8GFfUAYpfU7IgNo4cxaAOcw1XwW/HMm4QhuLjqqnxwWpO824Byb
         X5wr7+W1lWfqn7jTONmZn2Y+jsTBaXeCYHpfcJBK6cwvxOSZZXL5ka53bPd8gmojhWg0
         XUcP5JcF/y8vA/+pCVThbnEvxJ+SPCty2epNb6ONJGwRR5kE1zhKHJ/srB/yc5UYbF/3
         l0sw==
X-Gm-Message-State: AOAM530wbOJpIYFGCZQ2fAN4BrJ3+D4JVOq0Fkucio+15rEGHtGVzGt1
        nV4Q6v1YicrjZ55EU9hQmHQwjLk/9cs=
X-Google-Smtp-Source: ABdhPJwRJpkzIcgYjX3WxbZCSD2UiH5l29GaoJ3pVGX7WGvhydCSeNjS+mAjEg4QSHn+deG7KBeFpg==
X-Received: by 2002:adf:a3d9:: with SMTP id m25mr8460331wrb.27.1633642773408;
        Thu, 07 Oct 2021 14:39:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm492247wrr.90.2021.10.07.14.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:39:33 -0700 (PDT)
Message-Id: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:39:32 +0000
Subject: [PATCH] completion: fix incorrect bash/zsh string equality check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

In the basic `[`/`test` command, the string equality operator is a
single `=`. The `==` operator is only available in `[[`, which is a
bash-ism also supported by zsh.

This mix-up was causing the following completion error in zsh:
> __git_ls_files_helper:7: = not found

(That message refers to the extraneous symbol in `==` ← `=`).

This updates that comparison to use the extended `[[ … ]]` conditional
for consistency with the other checks in this file.

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
    completion: Fix incorrect bash/zsh string equality check
    
    This fixes an error in contrib/completion/git-completion.bash caused by
    the incorrect use of == (vs. single =) inside a basic [/test command.
    Double-equals == should only be used with the extended [[ comparison.
    
    This was causing the following completion error in zsh:
    
    > __git_ls_files_helper:7: = not found
    
    
    That message refers to the extraneous = symbol in ==.
    
    This updates that comparison to use the extended [[ … ]] conditional for
    consistency with the other checks in this file.
    
    Note that there may be some contributing cause to this error related to
    emulation mode inheritance/stickiness, since it seems that the function
    is intended to run with emulate ksh and that does not appear to be
    happening properly. Nevertheless, fixing this comparison fixes this
    particular error in a compatible way, and I have not observed any other
    errors.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1096%2Frwe%2Ffix-completion-sh-eq-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1096/rwe/fix-completion-sh-eq-v1
Pull-Request: https://github.com/git/git/pull/1096

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc87..14de5efa734 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -515,7 +515,7 @@ __gitcomp_file ()
 # argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
-	if [ "$2" == "--committable" ]; then
+	if [[ "$2" == "--committable" ]]; then
 		__git -C "$1" -c core.quotePath=false diff-index \
 			--name-only --relative HEAD -- "${3//\\/\\\\}*"
 	else

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
