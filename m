Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06389C0044D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA705230FE
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404728AbhASOvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389665AbhASK2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 05:28:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626EC061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:28:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 190so15995706wmz.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yZ50s8ARpgVCLLTjxTVySX3MSt1VPPbvJynjO+/kQTA=;
        b=mQV4ZTcTbm9Y5mfKc2r62QxynNZ4x+RPLinZl6FWciknskoX8mMS0y8jCzpAhA54S8
         cxUbExQ9+jVhr1c2zqTaTbO8wmj2upIZN29gibZFnMkidWNTh779rRz1uSzBalet2ei6
         XtBF7KXWixT2oeAADjH9sIec0jxLIP49xjrdWAw4/ruKD6p81KcQrZJRrQAjqtbxO9ew
         Rmv77p9trgIUZk3rsx0SQXZzGxiIVPOxe/R+pvHluvry/07cNJi2KBnbTXDzgyFHjTA2
         oMyZVP+Gxbzr39r+j5NnmXCdwr/F9sqAeYZVALjBS903TpPBljJz7pZ83Ktx71smcPf+
         5LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yZ50s8ARpgVCLLTjxTVySX3MSt1VPPbvJynjO+/kQTA=;
        b=gHmHdVRP34wEaUtChuJsDylEMqP4PFL3mSjXXXJP7z1T9JmmDHTB/TK8qMZMz6d6hs
         uXUwGLPdMN0ElaX8n6zo1Lyjx9rcNUyYZXvNX1UU6ZdS2Fp2rqiptVUjM3xXDrkfnWMX
         x3B/fo4ESG/f0E3omtOZ3gogh2qLUemu+NXaVNeU1Xw8XF+u5dUVLwtXo97RQnmmkooq
         DmP+Zo3GbdsSrc0XszvunpZX0wtfzSvOswiKYjJj4M0qPt/hIpeSVQWezzmmyUmef6oX
         yQgyR5vHULbfYhOhPw1su3Km16KFq7heNMbOdilbJrMbEovZfOd2EUs5mfQwrEvnqO5v
         0m6w==
X-Gm-Message-State: AOAM533h3NBTrxlzVvhoCWgBL2z0XRc79LyfhqW89y1OGZmLyjc5guEY
        rgeZA6Gw5aNX29E+yV4fQxIjeScHlM4ffekp9mKrJFtYa95ypA==
X-Google-Smtp-Source: ABdhPJwW/VnK/pw2/hyuXpPUzA3/EvabNsIECHV6duAVBQ3pNtFOFqjHP7l+tPyiwpy/2P2hUrSY3biufAtFkkKFneQ=
X-Received: by 2002:a05:600c:4ecc:: with SMTP id g12mr3440252wmq.84.1611052082793;
 Tue, 19 Jan 2021 02:28:02 -0800 (PST)
MIME-Version: 1.0
From:   Vang Nguyen <mtb.vang@gmail.com>
Date:   Tue, 19 Jan 2021 11:27:50 +0100
Message-ID: <CAL+53obGBFwA2bscvNF=fHkF5eLLEpL6rSZYygkob9-u1fXkHQ@mail.gmail.com>
Subject: git subtree push could not rev-parse split hash...bug?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We have a parentRepo with a subtreeRepo. When multiple people git
subtree push from the parentRepo to the subtreeRepo origin if you
weren't the last to do the push you get the following error:

git subtree push --prefix=subtreeRepo
git@github.com:projectname/subtreeRepo.git master
git push using:  git@github.com:projectname/subtreeRepo.git master
fatal: ambiguous argument
'f7e47b631c71ccf50c46f8e762dc043bcde4e7c1^0': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions, like this:
'git command [revision...] -- [file...]'
could not rev-parse split hash
f7e47b631c71ccf50c46f8e762dc043bcde4e7c1 from commit
1ce2d3f972571df5e52e97391e0f799b6140ee5b
To github.com:projectname/subtreeRepo.git
 ! [rejected]        7411fe6059e0f7af62df52e38e647b77bcfec151 ->
master (fetch first)
error: failed to push some refs to 'git@github.com:projectname/subtreeRepo.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
Makefile:675: recipe for target 'git-subtree-push-subtreeRepo' failed

The command run to do the push is:

git subtree push --prefix=subtreeRepo
git@github.com:projectName/subtreeRepo.git master

git version 2.17.1

A workaround seems to be to do a
git subtree pull --prefix=subtreeRepo
git@github.com:projectname/subtreeRepo.git master --squash
and then abort the results of the subtree pull with git reset --hard
origin/master.
The the git subtree push works fine.

The message doesn't seem to make sense since the split hash f7e47b631
and commit 1ce2d3f9 are there and it all seems like it should work.

I see that there's a ^0 at the end of the split hash in the error
message. Is that supposed to be there? fatal: ambiguous argument
'f7e47b631c71ccf50c46f8e762dc043bcde4e7c1^0'.

Regards,

Vang
