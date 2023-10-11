Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88940CDB47F
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjJKTOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJKTOg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:14:36 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B31792
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:14:35 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dd4eed487dso76159fac.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697051674; x=1697656474; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=im4cUy+23dPUi7cxLTZ6lZZugFwqR7vACLRon27gLvM=;
        b=u+TzEOLhYfPe5aUzhtrvZFNkUzLbFvsNvzFIpbh3BZxpBUD39RDifEQ3X+F2f5pfhn
         Pj4/kuTX57zICVlQtFnfu0q1HI2tMM3EykO7mIDWKnEM07P8gfoWa2pEKBzu2O+lj4ps
         E79MzuGmJNrApqzdLADfJbOS2EFOkFn0qDxdthCNxJz9euOny23zaEQVlUzeOKh5c2jH
         fK3iaoo/UcrGxL1f30AV0zNawVTalDqDp2i/DQeiBrLKOue/SHmmMWfuM736GcUbuBn/
         6sp7bRTorSnUIFxB/qDg7lzoKXFGdfIp8pF528HB2l8AnHLsCRZkH+ohiofpbbDZYk8z
         eBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051674; x=1697656474;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=im4cUy+23dPUi7cxLTZ6lZZugFwqR7vACLRon27gLvM=;
        b=fMjt9TktOwoaAy8k3EecdxopVUNNav7W4tobNUOq5ZAU4q5A3wEPB8R3Rugrh+hhMP
         e2L76gXkNyPC0d35LmBz0AlSmTalh90yYbhEWiwkodKuz9oQrUWWCbfWlUMrHavA7S/l
         xOkWHvqLojP4vTY1v3PGHRFlLszicuOqVbY8dNtdO0SORrNJpe9q0hTpHvQfkeICuOcB
         Hs8l8ENpdEJzYgOx+eKHwKtz1tlQ7QGfi0iOvLp+QRET8bd1/1+u4lGUKsSuqybBqspW
         qxaStCLu+2rjBGXgDXRr+frrZU4Pc2ptjpbMel85/mZkEdEYgEGhynlRAixJdVez9Plf
         siyQ==
X-Gm-Message-State: AOJu0Yw9n2YsIp2NvYc6MHEPNk73dJt1WRx0Z6foX8gU7ruIpdI6xW08
        iFh6l310hyK7lddezXdfVLLsRraP12PmiPHVgZnCXRb5wMSfRO41ciR0YaNW
X-Google-Smtp-Source: AGHT+IGfbDosr0fyGbA1x1rW2zhW6Wl5hbliGKiFFQqqp4E49DxiNNVZGfa4KTA1Epzo4epuVjCCAna8D8kU+KOu0B8=
X-Received: by 2002:a05:6870:f103:b0:1d5:8e6c:1794 with SMTP id
 k3-20020a056870f10300b001d58e6c1794mr24115089oac.58.1697051673896; Wed, 11
 Oct 2023 12:14:33 -0700 (PDT)
MIME-Version: 1.0
From:   Joanna Wang <jojwang@google.com>
Date:   Wed, 11 Oct 2023 15:14:22 -0400
Message-ID: <CAMmZTi-0QKtj7Q=sbC5qhipGsQxJFOY-Qkk1jfkRYwfF5FcUVg@mail.gmail.com>
Subject: Bug: `git stash push ':(attr:<somevalue>)' attr magic does not get
 parsed correctly
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
run the following with a debugger: `git stash push ':(attr:<somevalue>)'`
check the resulting pathspec after parse_pathspec()

What did you expect to happen? (Expected behavior)
the resulting pathspec should contain ':(attr:<somevalue>)'.

What happened instead? (Actual behavior)
The resulting pathspec is ':(attr,prefix:0)'
This is due to parse_pathspec in git-stash being called with
PATHSPEC_PREFIX_ORIGIN as a flag.

':(attr:<somevalue>)' gets parsed into ':(attr,prefix:0)' because prefix_magic()
https://github.com/git/git/blob/master/pathspec.c#L112 does not take
into account
that some magic can have values in addition to their magic names
specified in the pathspec.

What's different between what you expected and what actually happened?
Resulting pathspec is ':(attr,prefix:0)' when it should be
':(attr:<somevalue>,prefix:0)'

Anything else you want to add:
attr pathspec magic is currently blocked for git stash by GUARD_PATHSPEC
https://github.com/git/git/blob/master/dir.c#L2176
But, it looks like it can be unblocked, once prefix_magic() is fixed.

Also add-interactive also uses PATHSPEC_PREFIX_ORIGIN as a flag and
the resulting pathspec from parse_pathspec
shows the same bug.  But `git add -i ':(attr:<somevalue>'` behaves as
expected and I'm not sure why. It may be using different parts of the
pathspec struct down the line to filter out files.

[Enabled Hooks]
commit-msg
pre-commit
prepare-commit-msg
