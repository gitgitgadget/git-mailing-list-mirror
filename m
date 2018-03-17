Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892501F404
	for <e@80x24.org>; Sat, 17 Mar 2018 03:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCQD5I (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 23:57:08 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:41634 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeCQD5H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 23:57:07 -0400
Received: by mail-ot0-f182.google.com with SMTP id i28-v6so7667810otf.8
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 20:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=DK2G2SyTZJr1PMmEWlyAjPOFNxHZqsXZ3ZSzgyvaNyM=;
        b=A0b0/+/Tfb4z5+tmDnhJWD5HmluNMn13RkNyION9Ccim/31RCjZCbTWf+L1qY4H3Sm
         hVhX/ZXcYmZYvHbw2zRrjJSK7DGsGP/lmPe3b7VTTj94z7ZVQxBEfsc4TsULZeHsTB6b
         K9QdSPGYfS96IWlxGI1mK0BB7QWSwdy2wDgdrMkiXqcUqcAX4p+ywgJCq7FbJPSTx7L5
         dgGfYhEz8YdsDDORRtuciKo1krj0nGFcEjh7Ct5nNTQqlw9PmD4aE7Pna3u2YTCIzMJy
         EIQhsbBCmBlXIEFsvEQOdj7JCdGzRvfycRtluP70PJIj4VXkph5D5/rPaTBoaRSssmWR
         ygTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DK2G2SyTZJr1PMmEWlyAjPOFNxHZqsXZ3ZSzgyvaNyM=;
        b=jdQwZNlgCL8tfeIu7PPH88O7Uqg6BuWQ0nTJSbuKriU8w1hvkBnTGoqBrNSZd7YMfj
         lUMxqtKFVq8/reTWYfPAu1V0nf3t7MN3K8HE5qyhp7R9re5sT3ruL3yHkepiNs0xnnPz
         yYNRhr9CkysB8czc3eTEmCBu46l9sm+ULMvF2UQe9WrTidm7vaC5Vxwock2cP3g7Ry+w
         ib+yFiov5sMJazNJUjjSKUj9/im0l4k+5OO+vP+YXJlYgpGRyeSI48jr1hkeLyLkvwmo
         DWcX3YjdR0Ss8bdjkQ9KdhPy7yDkw15K1nuhjGHBnNe5LdWUtRrf7JDnVdT4KbwFUfxd
         WiJw==
X-Gm-Message-State: AElRT7Fr+F7vuDmSmcqOg4SQesKqqEb9XZ+2eTCRLfNgVVmQrfNx6AMW
        7nMMfj23FLIbOt4/YeEz+8a0XIWsTl3rXGI2S13x9ywP
X-Google-Smtp-Source: AG47ELs47PjMPepXJenNAsctuJHUFn9juSjjYPU0T5jMNvr4MUmNftuIlqRbQ5AWlaPw5KJtbbWaTpOnzGvY/B6ktXc=
X-Received: by 2002:a9d:3364:: with SMTP id u33-v6mr2950450otd.26.1521259026288;
 Fri, 16 Mar 2018 20:57:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.166.67 with HTTP; Fri, 16 Mar 2018 20:57:05 -0700 (PDT)
X-Originating-IP: [2601:647:5100:1da4::31bc]
From:   Michael Forney <mforney@mforney.org>
Date:   Fri, 16 Mar 2018 20:57:05 -0700
Message-ID: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
Subject: Confusing behavior with ignored submodules and `git commit -a`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In the past few months have noticed some confusing behavior with
ignored submodules. I finally got around to bisecting this to commit
5556808690ea245708fb80383be5c1afee2fb3eb (add, reset: ensure
submodules can be added or reset).

Here is a demonstration of the problem:

First some repository initialization with a submodule marked as ignored.

$ git init inner && git -C inner commit --allow-empty -m 'inner 1'
Initialized empty Git repository in /tmp/inner/.git/
[master (root-commit) ef55bed] inner 1
$ git init outer && cd outer
Initialized empty Git repository in /tmp/outer/.git/
$ git submodule add ../inner
Cloning into '/tmp/outer/inner'...
done.
$ echo 1 > foo.txt && git add foo.txt
$ git commit -m 'outer 1'
[master (root-commit) efeb85c] outer 1
 3 files changed, 5 insertions(+)
 create mode 100644 .gitmodules
 create mode 100644 foo.txt
 create mode 160000 inner
$ git config submodule.inner.ignore all
$ git -C inner commit --allow-empty -m 'inner 2'
[master 7b7f0fa] inner 2
$ git status
On branch master
nothing to commit, working tree clean
$

Up to here is all expected. However, if I go to update `foo.txt` and
commit with `git commit -a`, changes to inner get recorded
unexpectedly. What's worse is the shortstat output of `git commit -a`,
and the diff output of `git show` give no indication that the
submodule was changed.

$ echo 2 > foo.txt
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   foo.txt

no changes added to commit (use "git add" and/or "git commit -a")
$ git commit -a -m 'update foo.txt'
[master 6ec564c] update foo.txt
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git show
commit 6ec564c15ddae099c71f01750b4c434557525653 (HEAD -> master)
Author: Michael Forney <mforney@mforney.org>
Date:   Fri Mar 16 20:18:37 2018 -0700

    update foo.txt

diff --git a/foo.txt b/foo.txt
index d00491f..0cfbf08 100644
--- a/foo.txt
+++ b/foo.txt
@@ -1 +1 @@
-1
+2
$

There have been a couple occasions where I accidentally pushed local
changes to ignored submodules because of this. Since they don't show
up in the log output, it is difficult to figure out what actually has
gone wrong.

Anyway, since the bisected commit (555680869) only mentions add and
reset, I'm assuming that this is a regression and not a deliberate
behavior change. The documentation for submodule.<name>.ignore states
that the setting should only affect `git status` and the diff family.
In terms of my expectations, I would go further and say it should only
affect `git status` and diffs against the working tree.

I took a brief look through the relevant sources, and it wasn't clear
to me how to fix this without accidentally changing the behavior of
other subcommands.

Any help with this issue is appreciated!
