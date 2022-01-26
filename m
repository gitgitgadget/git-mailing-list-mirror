Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B47FC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiAZIlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAZIlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 03:41:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73295C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso3276487wma.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YCjhIS1u6fKdU9ntkob3Haygjno10BmNwmCwQEbXHG8=;
        b=h/5etJp2yXFJLTJkEg85qkjps2O+IfsIx+wu8uPVSp9jShaJnhpDH0XqXUe7T1m2mB
         vfjAHZ1WfshgsPOXI+mjp0Ow1Gsju9zrkL8gXKIiW0Wx8G0jywhJ6Z2SAcsKuk5Afdq9
         q4Qzognf9xpm5on9lT9I3uSglKaF9H5TXs4/zNbh49fLCJ0+pRHeliVr3xISR/jCC1JX
         SI18vfrWIvJ0fm2TxyNP/hx9QjMFq5K+JVaYBvyoDKj+BG+QMkCFIuOj4kSiq4/QdD5b
         GHm5tScjUeXqDA2OOTQsss1o3R/Kqv5PGgznyzSeHNCtGAyeLB8gSNIHgjJaYVNSaRvX
         MesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YCjhIS1u6fKdU9ntkob3Haygjno10BmNwmCwQEbXHG8=;
        b=4t/tC+IfYIfpAgpAmwTYNpOq2SyDKCEQywLySukFFdtrRKTR2H6igFcV+3wRSMJUes
         PxnTuqq7A0dgnS7z5xTCtz7DgayTqeuy3+B7XIH2e7sGYX+sL58WjYluoyuvG5ZKdaYd
         1vVLySUn5zK5hCHJ184tR44qM9ExiNuUTMmFBFSmgdDaG8iVZ2BOI1NiGV7dJ0+ZPS6J
         GHSVESIi1hiO3tu+9MplKYalReHbjNJgM2pd/Eimvfmz1HJEYLBjCxf5smMDUk3iNFXG
         7gLYzB5Ozme+xt7n0Ez3eZVxzvkjByOf2dUlaV94jEkeyqfjDZNGf3v6K0R170Hx41Xd
         LWjg==
X-Gm-Message-State: AOAM533p3FU5MZ56oOId8bOKM12Xgeavx6ne9UMbVkCzstV4K+6TXVou
        i9myE7y9FyK71j1WZ6oQiy5KLbpW0HE=
X-Google-Smtp-Source: ABdhPJzX0RKv/TkzDLkxnT6qB9cNyG3MByuyGqfrO94GpzAt7NH86jKHuVRkscO+2fPGOi+nYFHLlg==
X-Received: by 2002:a05:600c:1911:: with SMTP id j17mr6144194wmq.143.1643186509772;
        Wed, 26 Jan 2022 00:41:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay29sm2634446wmb.38.2022.01.26.00.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 00:41:49 -0800 (PST)
Message-Id: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 08:41:42 +0000
Subject: [PATCH 0/5] scalar: implement the subcommand "diagnose"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the course of the years, we developed a sub-command that gathers
diagnostic data into a .zip file that can then be attached to bug reports.
This sub-command turned out to be very useful in helping Scalar developers
identify and fix issues.

Johannes Schindelin (3):
  Implement `scalar diagnose`
  scalar diagnose: include disk space information
  scalar diagnose: show a spinner while staging content

Matthew John Cheetham (2):
  scalar: teach `diagnose` to gather packfile info
  scalar: teach `diagnose` to gather loose objects information

 contrib/scalar/scalar.c          | 336 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  12 ++
 contrib/scalar/t/t9099-scalar.sh |  17 ++
 3 files changed, 365 insertions(+)


base-commit: ddc35d833dd6f9e8946b09cecd3311b8aa18d295
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1128%2Fdscho%2Fscalar-diagnose-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1128/dscho/scalar-diagnose-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1128
-- 
gitgitgadget
