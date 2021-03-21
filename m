Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2AC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C909161928
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 20:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCUUxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhCUUxT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 16:53:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4DDC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 13:53:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t14so3198320ilu.3
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jwDv8L0qxazTSthY2ZC7+do6qHUgziNJoBIWjxbbouM=;
        b=lHJTZi3iTzlgeZ9agHlz7U1tJ6ukixdCTyU9afzbrHrt2JCfKyNSBa1yVAvwYmbbN1
         kRBvH4criyp0RacNA9qdBRTqGc0tVwsMoxaRroKWnNDxWiUM/LSiq9VkJNMVNwf19WmC
         JyewrljPrd8QRJHnaaOpkTFTIL15lACeCGJHxBp8EITrZ+nrOp9XeM5xxXdXWROQ7r/Y
         YmVJAgAdmFaqWPQTtwbteqoraKRpJJE0La3rnO28xDEy1lEk1tj4cNBbtPo+HH2OoTSR
         uSxtwTuprGsJrrYpKOJKtOx7982nEoYWZTmfshp3gCDa4qB7vB/GD84REAEMXg/Nj6NS
         VbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jwDv8L0qxazTSthY2ZC7+do6qHUgziNJoBIWjxbbouM=;
        b=YfQ5uyUpRc3l4pftm4p7IbF28o3bVYHL3t8svgLb5amlRJp+4iOmonLaP1ADDfAJnG
         liQs5w1/IORPlIdmFwXCnavbVV1im+Uj977wX9OvoK84FD+Ha8id3PrZ2TPTS8z7kfzR
         ntiuEBfGXXRnX3rV+q4nC21BHTbrZRNI3O7K0Ii2VWZNVSZjTQ0YsF9T9B3AIV94S1SD
         GkGgiOeqv04RKDEk9jUxo8mz6SbuCbjflm5wtP2zW3uZ1MvAbnG11fn4iFHDKxomdhxJ
         0PIqUz+4sacEysnFMS9o55nx4P2wLMHt552I2xlXuAZsg7fSyTAnr0Ui/O7Mqf7rPe/s
         wdhA==
X-Gm-Message-State: AOAM5339bLVgU0fMOHGtyj2e7Lnj1Hfn1VHnjVglSPnPjLqOku7Pf6+i
        aARoGV9dXwwxXO9y0dNIlsYur04Co9Aggr86pt+7kY5RlOTmGQ==
X-Google-Smtp-Source: ABdhPJzaX8ZWKGySCILMvSBzfpaOxLwgezFm/6zhyihYsPRNeQYQhkPWbzKAdEHyzzRblCovqzrtAc7zYivM/sKhVqg=
X-Received: by 2002:a92:6b10:: with SMTP id g16mr9503162ilc.26.1616359998261;
 Sun, 21 Mar 2021 13:53:18 -0700 (PDT)
MIME-Version: 1.0
From:   Sean Allred <allred.sean@gmail.com>
Date:   Sun, 21 Mar 2021 15:53:07 -0500
Message-ID: <CABceR4ZFVW=zeSwef7_dP+TWZ29J7BUkmMEB1CzCz=et_yYS9w@mail.gmail.com>
Subject: Bug report: 'filtering content' delayed progress message does not
 respect --quiet
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Submitting the filled-out template from git-bugreport. Let me know if
I can be of any assistance.

Thanks!
-Sean

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

  Called `git clone --quiet git://path/to/private/repo`

What did you expect to happen? (Expected behavior)

  Expected git to be quiet :-)  Did not expect writes to stderr/stdout.

What happened instead? (Actual behavior)

  Received output that looked like

      Filtering content:  --% (--/--), --.-- MiB | --.-- MiB/s

What's different between what you expected and what actually happened?

  `--quiet` should suppress all output, but in actuality, that line
  was still output.

Anything else you want to add:

  Submitting from https://github.com/git-lfs/git-lfs/issues/1270 (re
  https://github.com/git-lfs/git-lfs/issues/1270#issuecomment-461176647).
  Other details may be available there.

  I've verified I can still reproduce on the current version of git
  (listed below) with a private repo (note to self:
  gid://gitlab/Project/2458).

  It looks like we need similar handling from
  index_pack.c:resolve_deltas at entry.c:finish_delayed_checkout.  It
  looks like the necessary state may not be available where it's
  needed, but this is based on about two minutes of reading :-)

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.31.0.windows.1
cpu: x86_64
built from commit: 959b2f0c6fb12f8ba13f9015c4482fa8133b7f9c
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 17763
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show


-- 
-Sean
