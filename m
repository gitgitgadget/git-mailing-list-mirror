Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A6C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2030C611C1
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhKEV7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKEV7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 17:59:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94757C061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 14:56:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d3so15858021wrh.8
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LpW5JoEldapgl/rYJZZNh/UgkWFsAOgcNeS1hXCSe30=;
        b=li2xTUy2q49YVOG0SnD1rXN4hawOdrfLx1LsPcJyHlxbLgG8RHcoirxHxxBxj71d50
         5sh+6O8M355jMDIwG+fnjJ6HpZUCHUgvuE8wh7BqIUONwbaqi3ONWELOvd58whGvdimB
         XgGn+fwXfYH1QHblK1OAQdo1kpIJdlva8OSK6OSsGK9AGz2KPbArroR2oupy2QERWjkH
         V7NI9+8yYXdwOUpOVhypdpw4Fy/CZx/WB1NvmLEVxyCAcMLGO+xofhv3sFiL7te1wvxY
         yXXH8r9V8LgGRI0Shtyn6un/cJ/PlOkoNfbz+6h8EmlCPCCLZMU5+nJWELgHztARm5Y6
         jGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LpW5JoEldapgl/rYJZZNh/UgkWFsAOgcNeS1hXCSe30=;
        b=YsXivrKzEPQlfZoU64cDspxsh0bwZ1eQVKcrUVGec226S9YvFrub4dLnviP0NGND0/
         8SJC7h964TpxIgX19X9PpOsaPYl2yXK6/IoZGabZt4UDbACT7yX6f1dulToUsbJIBvOq
         rIrXA6AC8tDOOCqSV5h+R3IQwqECJ8mLQuptVwoA4GCpQvr/HRTaLS50yMRJX2aTXN7s
         0hl/RwbbNFIAFXT7A2Zj3NfOlyFzBMyHfrtk3FImfmFQicjkdcClTX3Zc5oBtHYK2NkX
         Q7p0gu+voe0gIMqXpoeDFJdAWFDfA12eFGtJtRLRpVgako1iPM/IQZtRzGHDcwkbNKTE
         l59w==
X-Gm-Message-State: AOAM530H+1AnqCA6Sicw33yJ0ox7F++pKGxVoa7M8v5hMC+8Bd7Am6I3
        xteUWvm2y8VkKkwWo2CbS6zkDUU7fgc=
X-Google-Smtp-Source: ABdhPJz6RP1RHSTKBc8yzz8Hd9UTxya4v8fiUBxzcJVtLIXLQmyPqMJ57D6COCoDykNhxEr6RVAnEg==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr69714089wrt.91.1636149401970;
        Fri, 05 Nov 2021 14:56:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 126sm12082793wmz.28.2021.11.05.14.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:56:41 -0700 (PDT)
Message-Id: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Nov 2021 21:56:38 +0000
Subject: [PATCH 0/2] cat-file: force flush of stdout on empty string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When in --buffer mode, it is very useful for the caller to have control over
when the buffer is flushed. Currently there is no convenient way to signal
for the buffer to be flushed. One workaround is to provide any nonexisting
commit to git-cat-file's stdin, in which case the buffer will be flushed and
a "$FOO missing" message will be displayed. However, this is not an ideal
workaround.

Instead, this commit teaches git-cat-file to look for an empty string in
stdin, which will trigger a flush of stdout.

John Cai (2):
  cat-file: force flush of stdout on empty string
  docs: update behavior of git-cat-file --buffer

 Documentation/git-cat-file.txt |  3 ++-
 builtin/cat-file.c             | 11 ++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)


base-commit: 6d82a21a3b699caf378cb0f89b6b0e803fc58480
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1124%2Fjohn-cai%2Fjc%2Fflush-buffer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1124/john-cai/jc/flush-buffer-v1
Pull-Request: https://github.com/git/git/pull/1124
-- 
gitgitgadget
