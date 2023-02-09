Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A0BC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 03:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjBID2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 22:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjBID2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 22:28:35 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672141C338
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 19:26:35 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bd6so619499oib.6
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 19:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pthHjKu/BE32TbGIdJgwyL2kPJvWl5K5g0gFahCZJlU=;
        b=G6lkpJLRi5p8WeN/BHj8Ark4uvUD4BDM9Y0qfpZpOYcbLfwJ3oVqbc9C3LGIhOgus/
         JJGJHSDDpXiA6aUkxxpwOPVCqha+UhajEl0QPdaunim4HUABtHw+0pL/Gx/Yx28D4sDe
         +CjCl+onC1WnlwfsNmFefmG1pqO74VwebcWhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pthHjKu/BE32TbGIdJgwyL2kPJvWl5K5g0gFahCZJlU=;
        b=Z8WUcM8iu7E5br+s9P1INeOTaEeZ4Mb4O25F+KW3A770zL1F7l0yKVrbx02yxiPiMt
         xzhSLeic/NszUgtA3DBSbOS8E81bLApoDePc2XP4oaO0d4CnUaR4Ll3OvyuevcPzEJjt
         mqcl9fRN7go85UJW218FbNy0ejR8AF8o9l8RFiT15UnXZgMAx9lD9w5f/a/RvlTAqeql
         ixziewxCh3dDfHPL+GhYHLxOeQDvDBZ00nhYoS2iXQik+cMflnJV0PrdtpSnLagfsaUZ
         NYvhLVkQ/jNrboeWo13q5qfoecrwDFbYBnRUHbIIYVJRoq/8Y6/vnrvHvF05uTMJxzKI
         bw6w==
X-Gm-Message-State: AO0yUKX+tgezzb5NvZUEfPt41m6IHZhxWN9BKvLU9HaDIHtA/uZJwYcD
        73KNgHTDOfSCJYbDwYbPA7yeTeMnTlKeL93jT7dpC3UTHZ1ufuqduLRsDg==
X-Google-Smtp-Source: AK7set/Fo5rRIKdBRpi0WhDrOYvE5FGQ/r68c8v7NhWdxbCaoo6WuC9//adpr25ubLQsLv2gUJDfiLvvgUFnVSGjy2s=
X-Received: by 2002:a05:6808:90e:b0:378:4bcd:61d5 with SMTP id
 w14-20020a056808090e00b003784bcd61d5mr442253oih.255.1675913194287; Wed, 08
 Feb 2023 19:26:34 -0800 (PST)
MIME-Version: 1.0
From:   Anton Lopyrev <anton@snap.com>
Date:   Wed, 8 Feb 2023 19:26:23 -0800
Message-ID: <CAN6BazqXXkOHLQok_MN8BLmyPD8MFeLNX-CcRb6eC+xx-5GPcQ@mail.gmail.com>
Subject: [git v2.39.1] Strange behavior with fsmonitor on MacOS
To:     git@vger.kernel.org
Cc:     Phil Cohen <pcohen@snap.com>, Sheldon Neuberger <sheldonn@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I work on the developer productivity team at Snap Inc and we
discovered a strange behavior with fsmonitor in git v2.39.1, which
consistently happens in one of our repos. We are unable to reproduce
this issue in any other internal or public repos, but the issue also
doesn=E2=80=99t seem to be reproducible when using the microsoft/git fork
(v2.39.1.vfs.0.0 - we use it for our largest repos). As a result, we
are unsure if we are running into a bug in git or an issue specific to
our repo (or both?). We appreciate any pointers in advance!

What did you do before the bug happened? (Steps to reproduce your issue)
- clone the repo via git clone (all default settings)
- git config core.fsmonitor true
- git status
- git diff-index HEAD

What did you expect to happen? (Expected behavior)
- 'git diff-index HEAD' is expected to return nothing

What happened instead? (Actual behavior)
- 'git diff-index HEAD' around ~44k files, which are all marked as deleted
- Example: ':100755 000000 fdc71572fe4e3ceb9305a8990d9d950e7bac6aa5
0000000000000000000000000000000000000000 D
src/adl/talkcorev3/generate_protos.sh'
- 44k files is amount 60% of the entire repo, there is no clear
pattern in the list of file paths (or attributes)

What's different between what you expected and what actually happened?
- Since the repo was just cloned, there are no changed files, so the
output of git diff-index should be empty.

Anything else you want to add:
- As I mentioned above, if we try using microsoft-git fork
(v2.39.1.vfs.0.0), the issue is no longer reproducible. No re-cloning
is necessary, simply installing v2.39.1.vfs.0.0 and running `git
diff-index HEAD` will return the correct result. Reverting back to
regular git, the issue is reproducible again.
- If you turn off fsmonitor, the issue is no longer reproducible.
- The issue is still reproducible if you switch from built-in MacOS
fsmonitor to watchman.
- A few notes about the repo:
  - it uses git lfs
  - it has around 23 submodules
  - Server-side we use GitHub Enterprise Server 3.5.7
- A few things we have checked, but without any luck:
  - various known problems around file permissions
  - various known problems around line endings

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:03:51
PST 2022; root:xnu-8792.61.2~4/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash
