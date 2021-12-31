Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E8BC433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 06:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhLaG3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 01:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLaG3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 01:29:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916CC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:29:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso14317316wmk.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+i+G9xa9YRMcM03Fa/OoE8L5oSmwCg0mk8L0ok85LXQ=;
        b=fHKDOTsa/Yu0egnfysPzJWwgRbgMaCV0AmauWBkovMF9ZwLVFAijW9d4Y2oLVxDWM+
         3KBKvUSJFmmFZUBf4hZkvJm3994GKXgCxDxrwvebCGQ9bwoxQxlh1UQe5jlJ5Gl6pM29
         MVjKNUyxIjfJoGkROr8LsJljJ6XqP6rVTX9VB3sxswDlJ74IgK1bWeiuFLHuCwFcRRSr
         Qfi70RXf+xHYSQvGbUMeqjZ9cl++18QMaZ19FFeKVR9Es90NJQ3H5AKUj5nO+wkRQexr
         Mhl5r+TMsSbCz3sBm3ktJmZ+zLN0m79eDS3RyoblE5zXrqEMYtGF+vjPxnQVNIP8Ulh1
         XJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+i+G9xa9YRMcM03Fa/OoE8L5oSmwCg0mk8L0ok85LXQ=;
        b=YowauNKOzCor6pHgKNfymWfjSP3wEAmfplvwX9IY9vMulCddia4Qwvqay7cizhOMr/
         Tx7bcuCaa/t8ONT9deIQosq+kVbVDWHuiWlxe7ibK2J14eLPHvhT0TnoJKgtH6JgaLxQ
         EQY0eNkR7KrIGF7Lackf8PBS6oxcLrXrLND0E9oi/5+enCTCPHPI361xyj0ugxga0o/T
         4cYWuJQq3Xi0Yi8HQ9GQ2jXzVt3lMl6H1wxbSdH899FQX74PvpVUSoS5G4sbuAAPDkeH
         QF09lrLFrabU8NrnYlPXnJqF/xiHdoHkWzt9YNr+Y0tX3ldMHav1bexUM7Mk8szpvl7j
         iFsQ==
X-Gm-Message-State: AOAM53233COW4+Q+2wE+R1SCX3592rK3div+fzArvoP4daX4Swm/9IkQ
        3EnQU3C/S1o6sNBsvX0WYSXYnA8N4t4=
X-Google-Smtp-Source: ABdhPJyItwMFqrMwP9yL7ggiQI33V7Gyr+pXcTrUW6KthyjeEdCQtTZJUWJzOpDf8A0b/4IYQbIU8A==
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr28188102wme.143.1640932153051;
        Thu, 30 Dec 2021 22:29:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s22sm28976289wmc.1.2021.12.30.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 22:29:12 -0800 (PST)
Message-Id: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 06:29:09 +0000
Subject: [PATCH 0/2] reflog.c: switch to use parse-options API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch out manual argv parsing for the reflog expire subcommand to use the
parse-options API. This reduces code redundancy by consolidating option
parsing logic.

John Cai (2):
  builtin/reflog.c: use parse-options for expire subcommand
  builtin/reflog.c: switch to use parse-options API for delete
    subcommand

 builtin/reflog.c | 122 +++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 62 deletions(-)


base-commit: 55b058a8bbcc54bd93c733035c995abc7967e539
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1175%2Fjohn-cai%2Fjc%2Freflog-switch-to-option-parse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1175/john-cai/jc/reflog-switch-to-option-parse-v1
Pull-Request: https://github.com/git/git/pull/1175
-- 
gitgitgadget
