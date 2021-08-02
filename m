Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE2C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF5861102
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhHBRrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHBRrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:47:15 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64681C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 10:47:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k65so7928834yba.13
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 10:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Rcv4SiTW6p2gkTqWAVUtaw44JvNbLn9f5//eKnfK5iA=;
        b=EvuzahRuIOJwfEWw6+yujWBMBwuT6oS40uJF94kLy1M+NQ/YhZCI9YJfTxDQ23wnoQ
         15imG5fEj08+3ppMiRayM+ouwwabuzwVPCVDhrkHzLkMt4Djg32et75URae/5evo8ZrU
         IfRNmcaDfa5Tkc/CwZnlYKNs8wiI1niTVo9Uw08yHTW1U9UMW+1ZrhDSKqCJ/ZGl9OqH
         ljTjwOwF/Qo02Fit+Cw7oNQJzzVLHEQEUlRWFHHloB1WfrXj9vfEVzUm+q583fYGgKj8
         8R6WfnShNau4yRo9w4u8e+EtX9Q0JK9qTJIJxnG6RI9p6OggkJavOzcceDAQ5UDBcOqA
         HPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Rcv4SiTW6p2gkTqWAVUtaw44JvNbLn9f5//eKnfK5iA=;
        b=qLsA34FoBi9wJcdqkp5qifPfDKso/Jb6pe987EMtgfTdpm4ZQjguwZBY7I1SIVMR/C
         Dv+gt5VJxD+JM+Vsy7jieLZtgiOuge56AaN4DPihTOpVd9wJf0clPXvN9d0INCcIru0u
         tb5JDz6x2itLPf7giZWRUK+EiRzLFzCa3LBGdc6vx2187JXnN9cpKdaNxjqLRmNgvCD3
         FhGtE243tRmiptvjXCWDT+wjESui4OjpO2Sg3QosfC+X+7DG9pYTWYuZVQ0PzxoLsru0
         X87Jfg2CoKAWdcoJhveEYJESVZKx3YausiIe7YkKZ8DDvcdKu0nXMU/NJh+I8TUQAq5W
         ac/g==
X-Gm-Message-State: AOAM53294ggEPOjUIP7uMcMncsyd66GRsZvlELiqRnGYFS8up6BkWDZY
        9b7C1e+/fY/5cCf0Y1daspwlnNaRh3pYBXadPglh/dUHAjLlKA==
X-Google-Smtp-Source: ABdhPJxGH7z4m5G659HdUr0WGmfetOu8TdZFNpBkh5NO2KQUddXcFPrwhBLJlX4NNdKzOtAYoz1V+ctalL1pcyqvVwk=
X-Received: by 2002:a25:dcd1:: with SMTP id y200mr22088060ybe.92.1627926424125;
 Mon, 02 Aug 2021 10:47:04 -0700 (PDT)
MIME-Version: 1.0
From:   Joseph Jenne <joseph.jenne15@gmail.com>
Date:   Mon, 2 Aug 2021 10:46:53 -0700
Message-ID: <CAB5AetcMK6=yZh4OY-0A6x6vs7X+0_1APfp4cCP_MSK_TO46ow@mail.gmail.com>
Subject: BUG: git log dies to SIGPIPE
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
used `git log`, exiting the viewer (`less`) before reading the entire
commit history of the project
What did you expect to happen? (Expected behavior)
normal exit with status code 0
What happened instead? (Actual behavior)
git log dies to SIGPIPE after `less` exits
What's different between what you expected and what actually happened?
git does not exit normally as would be expected
Anything else you want to add:



[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.0-8-amd64 #1 SMP Debian 5.10.46-2 (2021-07-20) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/zsh
