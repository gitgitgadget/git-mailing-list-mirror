Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C17C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 16:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbiESQ0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiESQ01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 12:26:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4F5DBF3
        for <git@vger.kernel.org>; Thu, 19 May 2022 09:26:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k30so7928829wrd.5
        for <git@vger.kernel.org>; Thu, 19 May 2022 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=zdKTy58n9yJ6BeL1kTYbTzLaLeklFeGTR7kmxqNyt34=;
        b=JWkNnnMXPQjLG5fMkc3zorAPFUK/yZoD7ZYT4kiiHuDZNxAqGPdNnIoxp25DIcyARx
         /7S3wQ0LU0wdbLu5XiS4m2f6K52yb7iKrdAkCgbHYQy9+TyK9bW0I7TibQmkk3qCJ/cZ
         TGvc6DaSwYWVmveNKsNZFwKtyLzjjeYX8dgPZfVCQOvXRE7KiEdH9ZJYrDW5Ll4iE20y
         8i4ipAY0+gViWiDvgln4dgik5Q1GljXZPBTXRTLMGlBEqQ5ZlNAiy0D7a/EWcel3dMqH
         P7HEnU3zU376qWaeEA42Jj1Ty1ENJM9KRe2bwDEbGZADd0KrBUEmK3FUfPmdGrT/EDdJ
         ba+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zdKTy58n9yJ6BeL1kTYbTzLaLeklFeGTR7kmxqNyt34=;
        b=F/UPY9Zz1QG6sihJXpV1TY0a2OiKeDCQqzWX4lro4g6ajz5MGb+p3c9Dy6LV79WOG1
         CNHyNgJylGdIX724yrr6xkEJHWV3aA4odysridJ8mN9Yg4epbU3fl5I9Sj/JwQSQMPSN
         RhRnvQmYiTLBDvHCfdHDgnF+dBs0uFr8M4d3S4oNI6tq29yNxpQ5x+q3zYUtPakT4t18
         hHKDc1GCslVagJdRR16Lw8fNqhSG6Emgjd3KC0/kudGpYROTm0ooieWX+nWabrNE5Oyr
         dpTiP9OzX7jXERcaiIFfIkxApI/zVjs9ojVN5byd2Xj6GESHcwSv7Z8zCtgmAA/twklu
         Ao3A==
X-Gm-Message-State: AOAM531FfwiGE3vNiITU7l7x6NlTAtnxgCgW5R72W3vuYFRrBK61bt4+
        wWPWDFmW+nZeOkmGuJqQwOhS+3aZmGs=
X-Google-Smtp-Source: ABdhPJywsLTvbylcBnXx9OoUpVlTBMsyR3+8PhgmqX0bKUNtNxhIKCmoRQgwKQrkDdqYGS522ONJ+w==
X-Received: by 2002:a05:6000:1e1a:b0:20c:565d:ca1c with SMTP id bj26-20020a0560001e1a00b0020c565dca1cmr4592251wrb.643.1652977583635;
        Thu, 19 May 2022 09:26:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c42cb00b003942a244ec8sm26325wme.13.2022.05.19.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:26:22 -0700 (PDT)
Message-Id: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 16:26:20 +0000
Subject: [PATCH 0/2] Fix merge restore state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A simple series to fix restore_state() in builtin/merge.c, fixing the issue
reported by ZheNing Hu over here:
https://lore.kernel.org/git/CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com/

Elijah Newren (2):
  merge: remove unused variable
  merge: make restore_state() do as its name says

 builtin/merge.c        | 12 ++++++------
 t/t7607-merge-state.sh | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100755 t/t7607-merge-state.sh


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1231%2Fnewren%2Ffix-merge-restore-state-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1231/newren/fix-merge-restore-state-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1231
-- 
gitgitgadget
