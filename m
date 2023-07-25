Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275EC001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 19:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGYTtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 15:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGYTta (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 15:49:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E51BCC
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 12:49:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so3280a12.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690314567; x=1690919367;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sEv6Nm0z40x/Arv7azNjyJhayDfPyC4bG74YCQgqp94=;
        b=1bzOndABa/unuK/PPnQlllzZ1WGo0VvUJGDlsQcCdAJ3yw6DEMrgYQWldwj1DYnY00
         JzeRAoseeXZF8VQrGwcX+vuXoo9X31tYekECkaXjFWxJK045LqC7CrUeeCccaKLSfPjL
         9Jd9Ah3PrtAjFBKX1JqxjSizFVgE9mqRZ0pl2ucsDbW9c/fUy9PoQfdeOSohV151WCfp
         IqpqcJnw8KMwGIa74IbJsgsRmdfJ3uJhBTRf0itVsxBByj7n5Ovw6WgKwjOo7QrvmEuw
         unrAt+TAXb6pOQHjyKZyOqYJRCQmLniXXhiI7B5UVg26VcSEv56pKVihy1Ehhi1mAAYY
         uqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314567; x=1690919367;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEv6Nm0z40x/Arv7azNjyJhayDfPyC4bG74YCQgqp94=;
        b=NUNpfNtmYgCLxkhEK5M4PuWbzVd2J6XxKApvyxAmoVLF8UZtY7fbWAQ0OAyXw5HL5q
         dBDkxvwHV/hIHO6bN7PNtRHTgHf3bi77+FklNDi8dkvDWpA+YeJpyd9DkcrnOBYWC9IR
         /fsbnAHJmhuovo9/qny1gLSEgHsW8zc0Cm2Sgh2MR608bmtBLG9N5xD8CpEXf+RK8vnw
         JDOX/pwU8r7HlbQLDrX3JgfXf3OwwgCN2q4nNqkZRTybGVCpUVmMbcJMPLaCwOJzRjNj
         X017hLf55By9gIEy2kaC/d6n6Bz/T9jfscxm2hH18gJn59oLmn7gG8wSHkidG0nwFJ2a
         bSRw==
X-Gm-Message-State: ABy/qLahoaa0Sa3JWOp0E6KJF/qtZo0y18PE4HKU/m4Esl9OpcwkyLt2
        5nxyFinzRzWZ2cyOsTkoNm3c9az2cq9mFEYNHT4WTRg0jkXbN4j1kvv9dA==
X-Google-Smtp-Source: APBJJlFdULvoBDqjmqIeFcJod8hP8RCAYTUfsS89JMzCwu2gnHPv6eAfKMAcRUpYLbfngguHcLZOWyVu1ffWEH8bD/4=
X-Received: by 2002:a50:a6dd:0:b0:522:28a1:2095 with SMTP id
 f29-20020a50a6dd000000b0052228a12095mr144734edc.3.1690314567035; Tue, 25 Jul
 2023 12:49:27 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 25 Jul 2023 21:49:15 +0200
Message-ID: <CABb0KFF1vqMLa5DLYd_c9sQeZbhkhQ=Q0bE7W41nmMFmNWB4tg@mail.gmail.com>
Subject: includeIf not matching during `git rebase`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* What did you do before the bug happened? (Steps to reproduce your issue)

With ~/.gitconfig having:

[includeIf "onbranch:pr/"]
        path = .gitconfig.for-upstream

where the included config changes commit-msg hook,

git checkout pr/zzz # has multiple commits over upstream
git rebase -i
> 'edit' first commit
(modify it)
git rebase --continue

* What did you expect to happen? (Expected behavior)

The commit messages are unchanged.

* What happened instead? (Actual behavior)

The rebased commits had messages modified by default commit-msg hook.

* What's different between what you expected and what actually happened?

I'd expect includeIf to match and in effect prevent the default commit
message modifications.

[System Info]
git version:
git version 2.41.0.487.g6d72f3e995-goog
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
pre-commit
prepare-commit-msg
