Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D05AEB64DA
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 18:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFSSk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjFSSk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 14:40:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A218D
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 11:40:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-518ff822360so4699773a12.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687200024; x=1689792024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4dHvCVyL++KVcE+z+qSj/yKcJKrh9/yfbcRpFCSW3+o=;
        b=Mk1SV6xJOZUFqoWNke4n7f0d2VIKglKGsQ6xxnr7kR2kc9S3m2qGBjVySTXbFaR+Gk
         xaoWkVD5w+ckT7TfaBKAm1n0SpRiQ8HTcnfoZ3kwFvMv/QIIQJGBNpC2pFaExTsB/occ
         64XN2xHYMBoygpadMcQKPMgYUVW23jAq6ATnZB9CKV8RXE9BjYZjIr6Std3uwWdigUYT
         /QlptD1A8+AvWVG43+KtUoNiSgki59k4TC3Er1aASKYjSLsXLOZ7d0fo0GDj3N74DoZA
         3Fl1IKlvclX/EasGiTNIYiOLmZrQdGow+5lvQyMkGU22sRnsKoNn4YbUO0faAW/i92We
         ppqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687200024; x=1689792024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dHvCVyL++KVcE+z+qSj/yKcJKrh9/yfbcRpFCSW3+o=;
        b=N7uLKM7+ndaq2jck3qRjkh6ThPNS61/bgLC36MdGp9qiEED0zSWv3MZ8/0cqlWeISM
         PIAKK3N3kMzWDUghIvfuKAaXV/r8HIqSNK0H/2TcR8rpvVfinmlmWXwgCenoamCptp+a
         mLVVRy5HnD3Py1lhooFTfi/GcQpenG+VENGvxI6VqBN2hcTtFpKaHz/77JNaM/ZL3Zhs
         HF89NVeiylWGIETW8H/ZuBtawA/JxEyogKXo9gEr9qaHl327IQHZoMEkngXhgUZKKRoa
         WNR9q9aP+4wy2Nt84kMyZYXIx/Tpw0VEg7eIEQtceoiBUirgrzmVwvJ/doY766pOclzz
         fcjQ==
X-Gm-Message-State: AC+VfDw0MamUP2Ni9bNRS279zyOAt0rzQ5z/QTY3tatQ/ZPIpBlQjK85
        AUQEjvlUiqH55HQjTKlW2nirZ+1UI2GbOWjYl8xEZ7EDaH3Siw==
X-Google-Smtp-Source: ACHHUZ6twM8Q71xKfW2IJlK1xPTQZNUsrhRD1Ub4r4P9uISa97J0H+8u3P4s+mZv4ol8yhtsZ60+VZRKgv/gWAQTEGY=
X-Received: by 2002:a17:906:7953:b0:987:52cb:4273 with SMTP id
 l19-20020a170906795300b0098752cb4273mr6625675ejo.14.1687200024000; Mon, 19
 Jun 2023 11:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+3o5aPQ3BkbAn3u6qSMCkAfNgTcpjT+_ikdqAkkc69NBGybpw@mail.gmail.com>
 <kl6lzg5iztzw.fsf@chooglen-macbookpro.roam.corp.google.com> <CA+3o5aNgChKi-m6F_sYr4Sc+VXP-K2BCMpTpY8Km+kH5u9tkCQ@mail.gmail.com>
In-Reply-To: <CA+3o5aNgChKi-m6F_sYr4Sc+VXP-K2BCMpTpY8Km+kH5u9tkCQ@mail.gmail.com>
From:   Fraser Hanson <fraser.hanson@gmail.com>
Date:   Mon, 19 Jun 2023 11:40:12 -0700
Message-ID: <CA+3o5aO8oGnSLwTB52nHPsfCU0tSpkkkDV3dZcZ-8vt=BhoNAA@mail.gmail.com>
Subject: Re: git fetch recursion problem
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I figured out what is going on here.
This problem is caused by the server configuration, but git should
handle this more gracefully because it is easy to hit this problem and
the consequence are severe.

The root cause is that the git server is using the git "dumb http" protocol.
The git server runs apache configured like this:
    <Directory "/srv/git">
        Options +Indexes
        AllowOverride None
        Order allow,deny
        Allow from all
    </Directory>

Apache does not pass requests to git-http-backend.
The server's /srv/git/ dir contains bare git repositories created with
`git clone --mirror`.
The repositories on the server must be prepared before download with
`git update-server-info`.

This is how the bug develops.

### git client requests a partial clone from the server:
$ git clone --filter=blob:none  http://172.20.208.191/git/kmarius/jsregexp.git

### git clone succeeds, but there are no *.promisor files (these
should exist for a partial clone)
$ cd jsregexp
$ find .git -name \*.promisor | wc -l
0

### the cloned repository is still configured as a partial clone
$ cat .git/config
[core]
    repositoryformatversion = 1
    filemode = true
    bare = false
    logallrefupdates = true
[remote "origin"]
    url = http://172.20.208.191/git/kmarius/jsregexp.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    promisor = true
    partialclonefilter = blob:none
[branch "master"]
    remote = origin
    merge = refs/heads/master

### git pull works, as long as there are no new commits added to the
server's git repo
$ git pull
Already up to date.

### Next, add a commit into the server's git repository.
### Then update the server's git repository with this:
server# cd /srv/git/kmarius/jsregexp.git
server# git update-server-info

### Back on the client side, git pull is now broken:

$ GIT_TRACE=1 git fetch 2>&1 | head -20
14:21:03.574765 git.c:460               trace: built-in: git fetch
14:21:03.575455 run-command.c:655       trace: run_command:
GIT_DIR=.git git remote-http origin
http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.578239 git.c:750               trace: exec: git-remote-http
origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.578349 run-command.c:655       trace: run_command:
git-remote-http origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.590589 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
14:21:03.593654 git.c:460               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
14:21:03.594362 run-command.c:655       trace: run_command: git
remote-http origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.597148 git.c:750               trace: exec: git-remote-http
origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.597253 run-command.c:655       trace: run_command:
git-remote-http origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.609592 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
14:21:03.612749 git.c:460               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
14:21:03.613392 run-command.c:655       trace: run_command: git
remote-http origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.616123 git.c:750               trace: exec: git-remote-http
origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.616235 run-command.c:655       trace: run_command:
git-remote-http origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.630921 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
14:21:03.634074 git.c:460               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
14:21:03.634746 run-command.c:655       trace: run_command: git
remote-http origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.636388 git.c:750               trace: exec: git-remote-http
origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.636443 run-command.c:655       trace: run_command:
git-remote-http origin http://172.20.208.191/git/kmarius/jsregexp.git
14:21:03.649168 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
...

This will repeat forever, repeatedly spawning sub-processes.

The impact can be severe.  I discovered this while using Neovim's
lazy.nvim plugin manager within a secure, firewalled environment
without internet access. The editor is configured to pull packages
from an intranet mirror site containing bare clones of GitHub
projects.  The multi-threaded lazy.nvim plugin manager attempts to
update all 30 or so repositories in my configuration simultaneously.
All of the repos with fresh commits on our dumb http mirror server hit
the bug, causes many git processes to spawn very fast.  The system
locks up in seconds, the OOM killer shows up too late to save it.

Git should handle this situation better.  The following would be nice:
* when the http dumb protocol is used for clone or fetch, log an
info-level message which is visible with GIT_TRACE
* when a git partial clone is performed over dumb http protocol, log a
warning-level message explaining that the resulting repo may be broken
* when a 'git fetch' is done from a broken repository, don't
repeatedly spawn git-remote-http processes forever
