Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55215C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 08:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A26061181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 08:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhJOIhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhJOIhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 04:37:07 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A85C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 01:35:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w2so8202368qtn.0
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxonly.nl; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=+dQ/ojiJWwX5k3wNMlrHz2cUIWs6z/BIRMwoBjs0s8U=;
        b=k7bliLjDeyvDuACAXb0RJsMAavgAho4vSXFUUw8Yy9CN0fmEGjLoWwULiroBw3e+xy
         w7b34lxBI4FhgvSLwgJQgblCF0ZlaqTowScr1NsiMYIMSFHiCJwdmrNugSP3aNm9akDJ
         YKGXxVnM6f0H70hwQiqYN0F0HeHS39Ve0NuxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+dQ/ojiJWwX5k3wNMlrHz2cUIWs6z/BIRMwoBjs0s8U=;
        b=HQEqciuz8VF6Nz+tfMOqpKKayQ//u3ECXcEC6ojUPwoTU64E1IRPEpr55yB6QIeVxx
         kl0mawuyeLEzqHoXvg91sNOnrHFDtb2J6zEaKdfQAT+fltzzb1yfQfypF1H1hvWI/MkV
         W+n0hzea5AhGAwhk+RMiVyFL3S3hOYgeXdYycDpTofv7aclgo5MtGfKlxL+Te6M3CYJq
         OkP2Z0ntN7EmC/OQqWMXpH0li69U/oNXpx8lgWeweRj2066MNDFj7TMVb2ikZo96tUVp
         ruokl+m4H7CWcVtFHRepxTzTf8kcKQR32iaJtPsdDRdilM19pPfm3R41IF31FWKalz7a
         pXOw==
X-Gm-Message-State: AOAM532Lwp/poLUFABg2LB8aAC9J7G3E8MBj7W1aO6E3tBwvfEfTVM1Z
        0M4+XmFHxM79JLFNdd+EOCpIJcBwuhv3Ww==
X-Google-Smtp-Source: ABdhPJw1Ugcr2a16S16Y7cSZx1iSqHlawDQeJ8oKV5mgmHjqTwJw0Op4lKV2zfcAN1Z44GH/ppvQSg==
X-Received: by 2002:ac8:1e9e:: with SMTP id c30mr11937385qtm.238.1634286900962;
        Fri, 15 Oct 2021 01:35:00 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id w17sm2431563qts.53.2021.10.15.01.35.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:35:00 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id y10so7859892qkp.9
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 01:35:00 -0700 (PDT)
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr8813460qkc.321.1634286900522;
 Fri, 15 Oct 2021 01:35:00 -0700 (PDT)
MIME-Version: 1.0
From:   Sjoerd Langkemper <sjoerd-2021@linuxonly.nl>
Date:   Fri, 15 Oct 2021 10:34:49 +0200
X-Gmail-Original-Message-ID: <CAA1vfca+kPSsitsZad-bmrd+o1ay60NXZrH2zGLpwN69Px-rtw@mail.gmail.com>
Message-ID: <CAA1vfca+kPSsitsZad-bmrd+o1ay60NXZrH2zGLpwN69Px-rtw@mail.gmail.com>
Subject: Git submodule update remote keeps using previous default branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am having trouble with git 2.33.1 checking out the wrong branch for
submodules for which the default branch has changed. `git submodule
update --remote` seems to remember the branch name to retrieve, while
I expect it to use the remote HEAD every time. This causes unexpected
behaviour when the remote HEAD starts pointing to another branch.

I create a new git project and add a submodule, with `git submodule
add git@host:foo/testproject.git`.

This checks out the default branch, `master` in this case. `git remote
show origin` also shows that `master` is the HEAD branch. Running `git
submodule update --remote` updates the submodule to the latest master.

Now I change the default branch on the remote (using Gitlab's web
interface) to `newmaster`.

`git remote show origin` now correctly shows `newmaster` as the
remote's HEAD branch. However, running `git submodule update --remote`
still updates the submodule to the latest `master` branch, while I
expect it to update to the lastest `newmaster` branch.

There's no branch specified in .gitmodules or .git/config. I am not
sure how git remembers the branch. When switching `testproject` to
`newmaster` manually and then running `git submodule update --remote`,
it is reset to `master` again.

Is this a bug? Can I change the branch somehow?

Regards,

Sjoerd Langkemper
