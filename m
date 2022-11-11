Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA64AC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 16:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiKKQJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 11:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiKKQJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 11:09:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9859B61762
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 08:09:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k5so4782145pjo.5
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJdTmDypjnm/dkCuQLKQm9akQRkSApsWMBckqsXYegg=;
        b=DDYq4/JYuzOsmlsZtvt5iMlzgXKHlnxshq558fZiJw85LecOwh2ehRM704ioLOYKkg
         3aA4M9Pz4dC2HPAyOdXeAVm5uwoylzpG2h1PnEhuHCcumPk5Oo0towkRS9GiWpHvxTdI
         0q6zulb2MKUwIvwxaxQSeXnuMYj4HTl0Ke6rZkLQNFzOaRwOAksOZ/bplMEodC8TWR1m
         +1XpAO/GqG+0f/BY/Be/JIyiyeErVGU2F8BcfqAFYfnfEDmI9rVf7OCYH72B+7l8KIgb
         +bLbNvFqiPT0uf4L5N31AFZdHyd5iJw1trvyvQFtOBm1K4lvQ0sr327/iznPihsPV12u
         CGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJdTmDypjnm/dkCuQLKQm9akQRkSApsWMBckqsXYegg=;
        b=sRwOOECGx2VuxU/sE6EbEV1cKJtfdJVpPXE8jjNb+avoIJL/dg8Y+BvuwUZyKQVurC
         Qh6/Wv1A3SJTDaScyvW2OAaxYxGRhX9cyklpUJJnoICwCbkxQ5uELYFoyedvVyaf1PzU
         JgLecunrsTv62413jG1E6liDMdOAbppmI9c90ihsKdzI35Fe+WeqGm35LKV68ZVRy1x1
         jWi6lKgqkXw2ZsuKFDNcUUSpaDTdsoE+RzHmWQYCJhg82vZIOHshBY920JJ88Sig9gAE
         ZWv0qXIQpFZErWfVHOhG5xq56m96Ke4WE9TTbsSJQ+DIGjBM1aFBJpOSVhWSRFvZqoK+
         Ehfw==
X-Gm-Message-State: ANoB5pkzOFMAMP3KHPqDlkQIIjKE99SqCoB7RFZ2OoMwNSft6JPFluFB
        q/0ojMf3Gscj5j/7jPcdKAENOrSZks4fhUwqS4FXrbQsrYogiQ==
X-Google-Smtp-Source: AA0mqf7Rt8O0i83QZrnbpR7yEm8W9X97PvOASLSvrcDM4TLdbSzKI8EUvd9SCb7aRVY7xP7Qi4qwWqoL5TNUTQowUYs=
X-Received: by 2002:a17:902:864b:b0:180:39c1:e25 with SMTP id
 y11-20020a170902864b00b0018039c10e25mr2855644plt.24.1668182984648; Fri, 11
 Nov 2022 08:09:44 -0800 (PST)
MIME-Version: 1.0
From:   Devin Rhode <devinrhode2@gmail.com>
Date:   Fri, 11 Nov 2022 11:09:33 -0500
Message-ID: <CAG8sxgmHg0CmD9T01NYUmOC7k7fPSwHjwD7rKXOgyBnVQw6v7Q@mail.gmail.com>
Subject: Planting new `update-ref refs/heads/new-branch` lines in
 git-rebase-todo adds semi to end of branch names
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

1. Run `git rebase -i next` with `--update-refs` or the git config
setting `rebase.updateRefs = true`
2. Given `git-rebase-todo`:
```
pick fjr23j3 foo bar
pick j3j413 bar bar
```

3. Add a new update-ref line like so.
```
pick fjr23j3 foo bar
update-ref refs/heads/devin/foo/bar/bar/bar/branch-new-name;

pick j3j413 bar bar
```
`devin/foo/bar/bar/bar/branch-new-name` branch name does not already exist.
The intention here is to create a new branch name at this point in the
history (to create a stacked PR).

3. Complete rebase, see this output:
```
Successfully rebased and updated
refs/heads/devin/foo-821-analytics-for-checkout.
Updated the following refs with --update-refs:
        refs/heads/devin/edit-step-1-copy  // <-- no semi
        refs/heads/devin/edit-step-2-copy  // <-- no semi
        refs/heads/devin/refactor-foolytics;    // <-- Trailing semi
        refs/heads/devin/foo-821-analytics-for-checkout;  // <-- Trailing semi
```
4.
$ git branch
  devin/edit-step-1-copy
  devin/edit-step-2-copy
  devin/refactor-foolytics;
  devin/rename-logAnalyticsEvents;
  devin/foo-731-add-segment-tracking-to-tutorialfoocom
  devin/foo-736-lock-checkout-behind-a-query-param
  devin/foo-779-add-segment-events-for-all-clicksuser
  devin/foo-779-add-segment-events-for-all-clicksuser;
  devin/foo-808-button-to-re-try-failed-checkout
  devin/foo-808-button-to-re-try-failed-checkout;
* devin/foo-821-analytics-for-checkout
  devin/foo-821-analytics-for-checkout;
+ devin/foo-828-add-sentry-to-tutorialfoocom
  devin/sort-tailwind-classes
  fix/crashing-on-falsy-amazonProductID
  main
  refactor-foolytics

5. After rebasing, paste a series of git push commands into vscode's
integrated terminal:
```
git push origin --force-with-lease
devin/edit-step-1-copy:refs/heads/devin/edit-step-1-copy;
git push origin --force-with-lease
devin/edit-step-2-copy:refs/heads/devin/edit-step-2-copy;
```
I wasn't paying perfect attention to the semicolon at the end of these
git push lines.
Some may have included a semi, some not.

I think at some point, I converted a series of `git push` commands
BACK into `update-ref` commands, because I did a weird rebase thing
and the `update-ref` lines didn't appear on the next rebase.

This is probably an error on my part, but `update-ref` lines added to
`git-rebase-todo` should fail if they end with a semicolon, and the
user should be forced to remove them.

[System Info]
git version:
git version 2.38.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Thu Sep 29 20:13:46
PDT 2022; root:xnu-8020.240.7~1/RELEASE_ARM64_T8101 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.102)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

[Environment]
Using arm-native macOS terminal
zsh --version:
zsh 5.8.1 (x86_64-apple-darwin21.0)

[Enabled Hooks]
(none)
