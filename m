Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34B81F404
	for <e@80x24.org>; Tue,  6 Feb 2018 23:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeBFXEy (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 18:04:54 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35986 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeBFXEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 18:04:53 -0500
Received: by mail-vk0-f67.google.com with SMTP id m197so2247382vka.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 15:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FDj4Irx4kvGdRUmSRbhekcNk6AKl3RIhnVPLbRz2n48=;
        b=GUvbb7iXOkpB9AZ7d0+tXget19kP1A/4BCWcVJEBos5atH/78iAAw2oEa1sAN518cm
         t0ZJPg6pC/K2PQkl2fpjlulW6iZ05ftDp1gNIfEzZI19Ybj85CtYvkAG/bIDkgah49p5
         lxRungtXhfkcVczTwqy6FB5v04DD/bZr2O9koHUHILtYTyNvwBrXWR8fDPpv3dk2zVYA
         2qNosmY52gTh/CUOBn0NsX/KCxLi4nBrag2rTz/HLdLnXQ480Pl3RfM5HfdoEfkyumuD
         bQysaQ9C8kM88b6I3fEaJADLKtFWK/C06MyZ3bKCjd8PyZEW2JovWmKnT0cxO8liaSgq
         4yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FDj4Irx4kvGdRUmSRbhekcNk6AKl3RIhnVPLbRz2n48=;
        b=IJbiSsji6eHwe77fFslePpV9dBE8Pc3X5L20CePv0D3qHEjia2lsJTOzQdvqjzOOeE
         7EspTnLAiDvogTbHEaf2jAarlwH/3P+pz1+QEjIpgdjJ267y3e+KERMRdS3Mcn8dRhBl
         l9m4hwl0ohOkD4cUJYROjdy/uGxnXRj4G16WcIHVHmXb74DiWSjjglPENuD5uLm1/lfU
         BfhDGqWposi0dEetkspGw+GueXlcDCRHJTeNR+psfwZnNuekLmiWZNizpAvd/OP0I8Uk
         S+Z7lnk/FrIyl8po9coTj0CPHj2BQr0jlXABbWnOJPigIF9FII7yAz4kKntfAEE7zKLS
         WJOQ==
X-Gm-Message-State: APf1xPAr/GzQoCbz1B3OAVwSn/8vieiLpgbFHeop0w2aDsT/0SYh3Nqn
        Sqwz8NUGXjdIhcLulOQFshpH0NVpv5AWEEjbFG+PSQ==
X-Google-Smtp-Source: AH8x224MSU3BSxuWCXC1TM2gxFkkeOj0YDyDlRaO+0ir1YOU9tkg1ZN/7Q6VcM4oFbpv8nb+zo9QTCH4VtWpXvNI+BI=
X-Received: by 10.31.254.201 with SMTP id l192mr3748625vki.153.1517958292078;
 Tue, 06 Feb 2018 15:04:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Tue, 6 Feb 2018 15:04:51 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 6 Feb 2018 15:04:51 -0800
Message-ID: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
Subject: BUG: fetch in certain repo always gives "did not send all necessary objects"
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I cannot share the local repo and had to modify output of commands
slightly to redact hostnames, branch names, etc.  I think I haven't
messed anything up, but it's possible...]

Two people in the last week have come to me after running into a case
where they could not update their repo because any call to git fetch
or git pull would error out with

  fatal: bad object HEAD
  error: gerrit.server:reponame did not send all necessary objects"

which apparently has been reported before at both of:

https://public-inbox.org/git/CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com/
and

https://public-inbox.org/git/CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com/

but without a resolution and it appears to have been difficult to
reproduce.  I can reproduce reliably with a copy of one of their
repos, and have dug in a little bit and may be able to provide more
info.  The pieces I've found that look relevant:

* Both users were using git-2.16.1 (suggesting they update and try new
things often)
* "git fsck --no-dangling" reports no problem on either client or server.
* The error bisects to commit d0c39a49cc ("revision.c: --all adds HEAD
from all worktrees", 2017-08-23).
* The developer has 3 directories in use corresponding to different
worktrees, but four entries under .git/worktrees, one of which appears
that it was once in use but no longer is
* The unused entry under .git/worktrees has a detached HEAD that
points to an object that doesn't exist; I suspect it was garbage
collected.

More details about the last two items:

$ ls ..
master/  1.0-release/  2.0-release/  3.0-release/

$ for i in ../*/.git; do echo $i $(cat $i/.git 2>&1); done
../master/.git cat: ../master/.git: Is a directory
../1.0-release/.git gitdir: /clone/master/.git/worktrees/1.0-release
../2.0-release/.git gitdir: /clone/master/.git/worktrees/2.0-release
../3.0-release/.git gitdir: /clone/master/.git/worktrees/3.0-release1

$ for i in .git/worktrees/*/gitdir; do echo $i $(cat $i); done
.git/worktrees/1.0-release/gitdir /clone/1.0-release/.git
.git/worktrees/2.0-release/gitdir /clone/2.0-release/.git
.git/worktrees/3.0-release1/gitdir /clone/3.0-release/.git
.git/worktrees/3.0-release/gitdir /clone/3.0-release/.git

$ (cd .git && for i in worktrees/*/HEAD; do echo $i $(git rev-parse
$i^{object}); done)
worktrees/1.0-release/HEAD c483c6806fe19c2fa9bcda892e0ddb470f8e9d65
worktrees/2.0-release/HEAD ab4c699ec9d1eab143c7e8ef51a0a6c451fcd4ea
worktrees/3.0-release1/HEAD 55e52e24b24b2f81484de9c6ea7d4520238c5fd5
fatal: ambiguous argument 'worktrees/3.0-release/HEAD^{object}':
unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
worktrees/3.0-release/HEAD worktrees/3.0-release/HEAD^{object}


So, it appears both worktrees/3.0-release and worktrees/3.0-release1
believe they are used by /clone/3.0-release/, but /clone/3.0-release
uses worktree-3.0-release1.  That leaves worktrees/3.0-release unused,
and in fact its HEAD is some sha1 that does not exist in the repo --
possibly GC'ed.


Also, after the investigation above and based on the hint in one of
the other email threads linked above, we tried 'git worktree prune'
but it didn't remove the unused directory under .git/worktree (perhaps
because it thought something was using it?).  The fetch bug didn't go
away until doing an 'rm -rf .git/worktree/3.0-release'.

I have no experience prior to today with git worktree, and the
developer in question doesn't remember how things got to the current
state.  It was all a while ago.


Does anyone have an idea what may have happened here or how to avoid it?
