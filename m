Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8A31FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 23:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbcL2XiV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 18:38:21 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:36487 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbcL2XiU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 18:38:20 -0500
Received: by mail-it0-f47.google.com with SMTP id 75so207236088ite.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 15:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5cl/cGWxtSAcwcUrIkeIb78UGoElg145hF8AedUsanI=;
        b=PHB/I7WvJkR4OxVF6GpTtCo/+mSUNNFJ+bdIr7wrKu4+C1okvG6VRDWBHu0mTW2n8t
         GsI4kki0YIiVgWf6r78sJXNnh4NPQt/nqgWdBX8VbydjoD4zFFnQqyoCSE+CQQlOZPy9
         kvBE4dQxx4bNs23Z9EGFm+c2wJEFFyZ5nG7wSyxk8QzwpXGNFBEjRcROsO8MS/l/j9bC
         VYh4rLg/TH4bLs6jT+EaA+jdj9s5krMBc2u/2Pe39MUwfOOz3S6mfxTNtBinV3XtzbOz
         xOkHtoGnXlMlR50ReGQNhg+IoiqW37PUkZoqQ4hzhNFXVv/j+e44/zUg6o2QMM6jcwee
         EMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5cl/cGWxtSAcwcUrIkeIb78UGoElg145hF8AedUsanI=;
        b=hnUk7jQT/c2vNo5wIh7ApgaKuuDlsBw972VdiOXInrJGt1U4g7ZioUhmR/pfyNTKmt
         T2BjoUgd4RRuF3rCWXr1X1LY5mDkvR8rTlj3rtlGgL4IKs1Hz+EtWSCRwlF2hqCo292Y
         2+8R/85IGqcm1JO5hQwtw8721D+ZKchsqUAEbww88LegG1AgYFuyxoF8l5gqC9AgF1mx
         mNOWRNH2LI/7GB2xgDwczXKL9LEId7sXuEjeJNb9bl/P1Eu4bve7j1288ZWYaWei0AuN
         ifg6LFtDpXKiMILr9oOJqRHBMH0yVf3GT7V1r7EsrujHb/O5f6k06MksmGKyfg4XLZCD
         RbXw==
X-Gm-Message-State: AIkVDXJLawyoNnBUTiewFh8wMX1+iu6KcvIbot7zPJQpy+t+eCefKzXNJC5OaZWXN9s8x7QsvOLwf9NYgBnBIg==
X-Received: by 10.36.238.139 with SMTP id b133mr33116905iti.81.1483054699157;
 Thu, 29 Dec 2016 15:38:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.224 with HTTP; Thu, 29 Dec 2016 15:37:58 -0800 (PST)
From:   Rafal W <kenorb@gmail.com>
Date:   Thu, 29 Dec 2016 23:37:58 +0000
Message-ID: <CANmdXCEGTxgj8BuQZkaBQaktOBrGmLETcQJg9xfV27Kn-0aLGA@mail.gmail.com>
Subject: Bug: Assertion failed: function prefix_pathspec, file pathspec.c,
 line 317.
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following error happens when I'm running "git add ." in the submodule dir:

$ GIT_TRACE=1 git add .
23:25:18.313575 git.c:350               trace: built-in: git 'add' '.'
Assertion failed: (item->nowildcard_len <= item->len && item->prefix
<= item->len), function prefix_pathspec, file pathspec.c, line 317.
Abort trap: 6

Then git crashes, so I've to remove index.lock manually
(.git/modules/Foo/index.lock).

This is what I did before it start doing this:
1. I've renamed GitHub repository to different name.
2. Created new repository in place of the old one (which consist other
submodules).
3. In previously cloned submodule dir (which was pointing to previous
repo before rename) I did: git fetch origin
4. Then I did: git reset origin/master --hard
5. 'git status' looks ok
6. Moved some of the files into submodule dir of the current submodule
and entered that dir.
7. From now on, the git add crashes with trap 6:  git add .

Probably there are some easier steps to reproduce the issue, but this
is what I did.

OS: macOS Sierra
git version 2.8.4

(lldb) bt
* thread #1: tid = 0x2338e, 0x00007fffbe6a1dda
libsystem_kernel.dylib`__pthread_kill + 10, queue =
'com.apple.main-thread', stop reason = signal SIGABRT
  * frame #0: 0x00007fffbe6a1dda libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x00007fffbe78c797 libsystem_pthread.dylib`pthread_kill + 90
    frame #2: 0x00007fffbe607440 libsystem_c.dylib`abort + 129
    frame #3: 0x00007fffbe5ce8b3 libsystem_c.dylib`__assert_rtn + 320
    frame #4: 0x00000001000d83f9 git`parse_pathspec + 2917
    frame #5: 0x0000000100002ded git`cmd_add + 991
    frame #6: 0x0000000100001e64 git`handle_builtin + 357
    frame #7: 0x0000000100001877 git`main + 288

Other people could reproduce the same thing, also on Mac, see:
http://stackoverflow.com/q/23205961

Kind regards,
kenorb
