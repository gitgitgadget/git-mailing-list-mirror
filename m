Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6AFEB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 11:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFVLJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFVLJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 07:09:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30371BD6
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 04:09:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3110ab7110aso7174607f8f.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687432158; x=1690024158;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSBH5oaPfINT9jJ5oOaDZJvepORup4jCbSq9ycub1yE=;
        b=WKcpeTJndbhI6EKvPU1B8bpII1sv7E6sFIPRPgUHUclwX+++kuQSCsxwt8cAOSud0m
         yr5ZlvSKgUlhM5FPEhUmi1AdhtYdRRkN/RqMR4EBDg21Wo0k++8f5nRS4Iims1IvMWvA
         SiRc1PTjmxaW2gQgLBFnRvNCIxlPeGe/RFnG3lk7YCu/D5VuiaMweKRtEmMOrMQfil6i
         dgt2g6kQUMPJQINkmHmtLkzlBhQsZ1A/Q2/DhdEwjNBY3ul226NJobLTWVdwF7EI2Okv
         SFJW9S9wrBTA7TMvXlT6WcvE2S+6ZX6OMrk4eninQ9gYA86nfdbFKgVEZSmtL8UKpjPn
         Dfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687432158; x=1690024158;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSBH5oaPfINT9jJ5oOaDZJvepORup4jCbSq9ycub1yE=;
        b=KZi1iTD1RZFkfPAGJj4MrhcjX9QHdNPp3M2FXwn4b77FwBCnHaMhYSPo51we7K5UwK
         B4Icve2ZMwfMUItPp91DUfLhHrD970xr7dHvtlZ45ynijyVfmE89B9g36LRb28FEKnLS
         WEBYw7fT7D2MeTn0NI0gJnK10jVt3goScI+A8zVO3Lnitu47ceHIL2uawUKPugMJLY+6
         IGGIEnL4PRG6fV/7D6cHPfNgiI2MXZqQIV9UftgOKlhRDUeveqIVLuN1wV7nm37aBgx1
         VqPKWc14AE8q6zXe0HapJ6uCEUe1m/Jjzjgt3jJ7YmxAt13Pqkqqu8jbVRkXKBWesORY
         hnQw==
X-Gm-Message-State: AC+VfDyPOiJZkRXOdUJ1EaArA8TNHDchzlUr+IyzWbSSNc/bQZtNF7vE
        DAOp4TC5sllOtbNlBuWn2nos3y7qsw==
X-Google-Smtp-Source: ACHHUZ7gyT4YSWrtecAUbwhVSsHPz79H3P2wVAl8JqBsx1MMoTYvdFgr5MnP65CaNXx4csCdAKQH9A==
X-Received: by 2002:adf:f488:0:b0:311:1b0b:2ec8 with SMTP id l8-20020adff488000000b003111b0b2ec8mr16164360wro.52.1687432157903;
        Thu, 22 Jun 2023 04:09:17 -0700 (PDT)
Received: from pweza (i59F50ED2.versanet.de. [89.245.14.210])
        by smtp.gmail.com with ESMTPSA id m13-20020adff38d000000b003113ed02080sm6803830wro.95.2023.06.22.04.09.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:09:17 -0700 (PDT)
Date:   Thu, 22 Jun 2023 13:09:07 +0200
From:   Sergei Golubchik <vuvova@gmail.com>
To:     git@vger.kernel.org
Subject: bug: submodule update fails to fetch
Message-ID: <ZJQr0_aC-NlLXDgj@pweza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sometimes (my local repository has lots of branches) after switching
branches

  git submodule update --init --recursive

fails with something like

  fatal: transport 'file' not allowed
  fatal: Fetched in submodule path 'wsrep-lib', but it did not contain e238c0d240c2557229b0523a4a032f3cf8b41639. Direct fetching of that commit failed.

the submodule transport is not 'file' (it's https) and the direct
fetching of the commit actually works:

  cd wsrep-lib
  git fetch origin e238c0d240c2557229b0523a4a032f3cf8b41639
  git checkout e238c0d240c2557229b0523a4a032f3cf8b41639
  cd ..

after that

  git submodule update --init --recursive

succeeds. This happens deterministically, but depends on the old and new
commits in the last checkout. As a workaround we've had to change our CI to do

  git submodule foreach --recursive 'git fetch origin $sha1;git checkout --force FETCH_HEAD'

This is the bit from `git bugreport`:

[System Info]
git version:
git version 2.39.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.88-gentoo #1 SMP Wed Feb 15 16:42:45 CET 2023 x86_64
compiler info: gnuc: 11.3
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]

Regards,
Sergei
