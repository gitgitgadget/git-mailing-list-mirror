Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FDCC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhKWPaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKWPaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 10:30:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74884C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 07:26:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r8so39544050wra.7
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=b7Irs1He/BN6NYLci+H+eA5tEbP6odOwKUZz8FYPGrk=;
        b=Kgk4nsdbPE8q1uK2IaErq4i+inEeqAjTKOR8xPHOv+K4b9FLi1cv18c+/8vnmd4Y1E
         uPdwDadChIX8ZlqeYjVjqy/EqwKAmfHENzMfiEc+wctkpSIFjRC0P/6EFzX0IXTNAShW
         9aD84YC9gxHp84MDWT/U6NZwyKBXX9A2QEkT+Q2oJwMFDYTtlPCjaXM47mli18UTA4f4
         JzOxAxLfji9Q7BnfboShtj+xE4Rf3tNazo4eWdCwzSaXc5LQApAoNMwjC/g1X/1bjlev
         HbnQq++/d0zcIBsH6IPIb7tAXqvUUY8pe0jWnPqTtDBBtdp08+gwswe+tm9O1ZX+fTBT
         0E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=b7Irs1He/BN6NYLci+H+eA5tEbP6odOwKUZz8FYPGrk=;
        b=BDPS/9eMvgOVK9xGGU19XTesG58qwq0sq8FvMGQUaaK1LcoRJf4KmHFCs8v+IQOV/2
         mkgaZ3GXu6k1wMvIlO6lYlZtvr9CrHQ/yughV99TvBmj0yImJzmGBzTVWzZROloX58Em
         CwiQ3bzyL+ldC/UdHRJcFNpBggoNHr1bRFffJR2Xpiqg3D79QhjRbK5vArTVquY8oC9O
         /tPixKrN0hPE0/GxlE7NUihwVZg+35bvFpOJfgz9oIDShrGXdf/LNQJ64jYeaFUp54VW
         UWpKRlVZQZVwnMArZAma1Z9riRtSBAYFOH+pvsJbIqTgrSf7VAh7nrTSS8wFVJ8hipsW
         2P7g==
X-Gm-Message-State: AOAM530aNBGkRa8e6/8qxgSbgNJcP7c62F0oNgNPYDSlqidhFxRzOTtH
        qwICzWcQBIZdBegN0zvTJC+0h0+qOug=
X-Google-Smtp-Source: ABdhPJzEDcKACEh8CNA7sfflnJtqiFZ9Fi6VNZdlPZ0oRppPSw5JE2/4YxltMYQ+xHrXKXoOBGvg1g==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr8851354wrv.106.1637681216786;
        Tue, 23 Nov 2021 07:26:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm1801959wms.10.2021.11.23.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:26:56 -0800 (PST)
Message-Id: <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 15:26:52 +0000
Subject: [PATCH v11 0/2] am: support --empty=(die|drop|keep) option to handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

----------------------------------------------------------------------------

Changes since v9:

 1. imitate the signed name format of
    https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@gmail.com
    .

cc: René Scharfe l.s.r@web.de cc: Phillip Wood phillip.wood123@gmail.com cc:
Aleen 徐沛文 pwxu@coremail.cn

cc: Aleen 徐沛文 pwxu@coremail.cn

徐沛文 (Aleen) (2):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches

 Documentation/git-am.txt           |  8 +++++
 Documentation/git-format-patch.txt |  6 +++-
 builtin/am.c                       | 55 +++++++++++++++++++++++++++---
 t/t4150-am.sh                      | 49 ++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 6 deletions(-)


base-commit: f8b28837226f3932b867ca88a4f830bf203d2afe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v11
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v10:

 1:  59bce7131da ! 1:  3d7e96ce2b3 doc: git-format-patch: describe the option --always
     @@
       ## Metadata ##
     -Author: Aleen <aleen42@vip.qq.com>
     +Author: 徐沛文 (Aleen) <aleen42@vip.qq.com>
      
       ## Commit message ##
          doc: git-format-patch: describe the option --always
 2:  5025ad30ba7 ! 2:  6051ad9440a am: support --empty=<option> to handle empty patches
     @@
       ## Metadata ##
     -Author: Aleen <aleen42@vip.qq.com>
     +Author: 徐沛文 (Aleen) <aleen42@vip.qq.com>
      
       ## Commit message ##
          am: support --empty=<option> to handle empty patches

-- 
gitgitgadget
