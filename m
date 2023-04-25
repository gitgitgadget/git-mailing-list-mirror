Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C74C7618E
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 00:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjDYABK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjDYABG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 20:01:06 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7949FD
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:01:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b980e16b27bso3790549276.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682380865; x=1684972865;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A+rRqLLEKDPfUchgepwEChkvv4T9+TTlSXCB/2+HcfE=;
        b=DQ9QMzqb+oK2fxuiYXnXhqOazg+O9G10zEgsGp6pr76ms/YmBSLmJSFgTgMzRfpQsR
         uPDtPRnBJtUDV/xwDFXKbUHFMcVkc3ZR1zquhGh7KGTNIgZmAMKhqL3mFf0jpzm1Or3a
         +vfgGVWeXNvYt1RxIKOKsLny17CrJ8Q8ZXRIPv03tHVMwWZ/SOHIPqBxIjkC7TYy5bDQ
         nbJEBwPM4ZgZfT0ekQQhjWSB23V+ivqVqmranOsDps1GPiYF6kU3WeGYKUsdmV/sCRGN
         onfHIhmTprAtstDx0eQs8RaB2RAPpmW81wE3K/r+3g3hM/yNF4E08V0jtYlso6DRMgy3
         DMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682380865; x=1684972865;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+rRqLLEKDPfUchgepwEChkvv4T9+TTlSXCB/2+HcfE=;
        b=T4V5fEr+i0rgo759FSTtMfmY6Of7f4B8v39FpNRXIXXazqkfvdHBoGCY76vX5s6X6W
         7cacHvNTP9i/T7GeBqMsJhk6cmOVX4eeXPP6DDg2SFIBI5BxAjYNj5JXat1IfNUC+3IM
         5IQleGMLr4nxkqahGljBda7GI0kj+stszkVj1Rv81/Gqt1KTaS/80s2Cndrjczh9wRHA
         YDaEAVtq8SQTl8Nw0SmigMkjUxfbBY0fryq8G1/HOe0TOT58D+EMfePb2ELbDUMbXEXf
         WNz+Ok0DJu5CCjtEw3ytNw0Fu03aUvqJ5erLsmRApMhjaoY75UiYN98JC7Kkdr+jWzOC
         M1/w==
X-Gm-Message-State: AAQBX9eA3YoeaoEyGeqao+xFOOBjf387FoiKR9uVlkvkQRyAbMmcatCz
        fzh6RN+nZRCApkdQa0+CZxmZsYI+JCkA7VxUuJxdm17cPwFIPA==
X-Google-Smtp-Source: AKy350aCvoqcw7IX81jxd3rKzpYsMww1HyedXWFzaqIcDQaQOcRI/aVDHfxs4zMK4tW3m7WtD+aPf7BW33yk/5Qepvg=
X-Received: by 2002:a81:6655:0:b0:555:f33e:e32e with SMTP id
 a82-20020a816655000000b00555f33ee32emr9345926ywc.51.1682380863509; Mon, 24
 Apr 2023 17:01:03 -0700 (PDT)
MIME-Version: 1.0
From:   Blyxyas <blyxyas@gmail.com>
Date:   Tue, 25 Apr 2023 02:00:27 +0200
Message-ID: <CAGeanHfxL9e_OHPFzBjLjgVU=QLvwYS9QVCGHC1JHSkApRAwgQ@mail.gmail.com>
Subject: Inconsistent names in `git shortlog`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git shortlog` (specifically talking about `git shortlog -sn`, but
applies to the whole subcommand) produces a list of names based on the
contributors to a Git repository.
But it turns out that the output of the shortlog is very inconsistent
in that sometimes it uses the username and other times the full name.
This can happen even in the same repo.

This isn't a big deal on its own, but there are some external tools
(like thanks.rust-lang.org) that use the output of `git shortlog` to
thank contributors, and it has some cases of people going just by
their first name (no surnames), or people appearing multiple times,
once with their username and one with their real name.

There should be a convention established. I would personally prefer
using usernames, as the huge impact of Github would mean that it's
easier to go to their profile just by copy-pasting their shortlog
name. Maybe add a `--realname` / `-r` flag to the command to show the
real names and show usernames by default?
