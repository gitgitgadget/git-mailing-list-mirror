Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFA2C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbiHINMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbiHINMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:12:19 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E819036
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:12:11 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id m186so5811581vkb.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uoi/9SwPsGdQBLUrQ+mYBp7LdWy8qbkZWRjboHTBIvo=;
        b=H9XZeHCtuNcBr5mfpK/pBhBmq7TkF9dAU4w5oXqoeaeRVINBOHh4cZRTeHL/K45SEk
         jFNjRu67+LFfe8cEdx+Nkj2XR6MM62D2qewtqajdCrDZjCnrE7UxztJT2HimjMPCvrg0
         OjgrbZB30ENDdsbrmeGTGzYBYB9OTpmu0dhPhi6O7DdTuyujqUUxR9BEHqdaaGre0pSB
         JTX9Ef0uUlXqkMEHCqIW5QNLdEkfrr+4srDch6/wkWrmgvoTRWzsKGv0QV9aH+PuL++7
         FNPMoelpli+LlO05dL95DY8qqIuyU/lm/nlULJQjNbDVzEtFZrGd6MEWB3HURC0a9+wJ
         2Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uoi/9SwPsGdQBLUrQ+mYBp7LdWy8qbkZWRjboHTBIvo=;
        b=vlpIEx3GByJ9AZXmtHaBEJj4XfP58KILCgZUwYZHucVYcRkx6yIAH/J1EFjF18NpLc
         +BeTPPK7l7mCwkA2Y8SEyGbNB0Af54WAglIdeY5T5xrcQ6AkMDyg5lTliQZSbQaVfI4M
         QmSlSzt5DHg/u0M9chb7/R7jCgNEUBel/ikEcHUS1rHXYkNw3GgZz+cw4cQnnuoWWy0I
         RaDDjErmkAJIzec8El5P/HWEb7FPlW2s0YCn8BwVptQNak+hSb7fZ0O5jT0bf508NUJr
         H0boAxVH1suI6VPPQ6tBUAk9zAnW1uB9JxeZzcKxwV3W+0TSex19trc6MNtrQj0YAsUE
         72XQ==
X-Gm-Message-State: ACgBeo2No5L/1jYYAyODz/0KJa/lTFnRTHfO35cdEN5UNi0L3ieST+F+
        zybgpKArj8V/RLqvIFa8h0cqtGNEqY0dE1R5kaS5EtL2RBIcww==
X-Google-Smtp-Source: AA6agR7e7zarZCxRR5BbtAwphfW2rfR6pX8AZgKdg9WCd2cC3eV2FOu4iQFi2S+IDqL64z+SoYEYWubhJBwOoPeTgBQ=
X-Received: by 2002:a1f:2b96:0:b0:379:2112:40d0 with SMTP id
 r144-20020a1f2b96000000b00379211240d0mr2876490vkr.37.1660050730526; Tue, 09
 Aug 2022 06:12:10 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Meshcheryakov <alexander.s.m@gmail.com>
Date:   Tue, 9 Aug 2022 17:11:44 +0400
Message-ID: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
Subject: [BUG] Unicode filenames handling in `git log --stat`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
touch Kyiv.txt Odesa.txt
git add -A
git commit -m 'Proper column widths'
touch =D0=9A=D0=B8=D1=97=D0=B2.txt =D0=9E=D0=B4=D0=B5=D1=81=D0=B0.txt
git add -A
git commit -m 'Improper unicode width'
git log --stat

What did you expect to happen? (Expected behavior)
Stats column for added/removed lines should be properly aligned.

What happened instead? (Actual behavior)
Only changes for ASCII filenames are properly aligned.
Here is how stats look for ASCII filenames:
Kyiv.txt  | 0
Odesa.txt | 0

Compare with unicode filenames. I change actual letters to ASCII X to
avoid the issue in letter formatting:
XXXX.txt   | 0
XXXXX.txt | 0

What's different between what you expected and what actually happened?
See above

Anything else you want to add:
Looks like width of unicode strings is incorrectly calculated when
formatting log --stat output. It considers number of bytes as number
of characters in the string, but this is not correct for unicode
strings.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-40-generic #43-Ubuntu SMP Wed Jun 15 12:54:21 UTC
2022 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
