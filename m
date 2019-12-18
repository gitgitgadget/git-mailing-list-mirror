Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FFAC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EA82146E
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYwSTvpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLRWEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:04:54 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:50300 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRWEy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 17:04:54 -0500
Received: by mail-wm1-f53.google.com with SMTP id a5so3446599wmb.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 14:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sfKU1aHPgKyO6L84n/Wr8ANe0ErlhiE26FrrEKnK4Ek=;
        b=KYwSTvpjkW0FwStoS93z3QX+AQHQO9ROB5uu7tFRQrVTsY8Cc7iyiwj0HRhZNlYY4O
         +W1g1Dq45YwRHec9SmvlPISv+O0nqqNroXqyhk0u5N1GOYWlLNhgFxQkUBs9J9NRtknx
         2Qx29ZCe6rlB9arpC0Tr6WAMV+hffeXX/j/ypzBRRJsQHTX3tQvNOfCUe3bX32Y6VEZd
         GVqFRZMTcGUeukPZr/HamC45kptrSzT8gpabwcp52YBazlLp0WrheN6yfuHlyJn8kzPW
         o6xxYn4vTEuyCF8BL0zvRpq5V5EioBhptaFo/olZlmiAHDdiyutoZ3xr2N3qsbJrqtjP
         2/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sfKU1aHPgKyO6L84n/Wr8ANe0ErlhiE26FrrEKnK4Ek=;
        b=kLIyWng4kjsQp/Bj3QCeHtIwvdKuvrdfjoty29aBogvaJ7azul9dHGk++KtOi5SheE
         zgJMR3zxII/cE6Sn2jID5FM8nuYDlv4A4ssP2Pby7wuwxYgtcVIFaMxoHH9qX966h5lw
         zLlBHo95Xae2lRnYglg+YJD9DPwZ3APzZS7RDjVXXCxwTg9UsOPEsVj0edlBl3mKsM+k
         i4EzrrVvOas4+V9MRp8FbNVM8nakrkpn9ToxulsYp6oQBbK/WtfIER00NEZn9pnmRlLS
         zsydSzIZ5++EdVjTrTnhHroMsyIOzxYzWxLuFE06EoYtAINr1n1Ml5gIme+MpQMU9bQ7
         k7YA==
X-Gm-Message-State: APjAAAWPbN0Sp8bVxE3gy/ewnzJD8RBiKmxwnVllkstewlpc9lSdc1cV
        w6Sgbt4+6W6pzD+rsYBKbqqT/OgtlHMtEhkbEtRJM2Fd
X-Google-Smtp-Source: APXvYqxgetDicUYlwG5hAvZ3Ng/ZYKUMRXtRq9E6wMB9UwIXlDItXGxqpSm6wkaN2Z+v/F/4BiPtYvB+/vz/aq1689M=
X-Received: by 2002:a05:600c:2c7:: with SMTP id 7mr5561529wmn.87.1576706690858;
 Wed, 18 Dec 2019 14:04:50 -0800 (PST)
MIME-Version: 1.0
From:   Valentina Finocchiaro <valentinafinocchiaro@gmail.com>
Date:   Wed, 18 Dec 2019 23:04:14 +0100
Message-ID: <CA+Kr=1i09cw6o8J==psMiVEk8LaDr7nf2C-b85=TX4z=rV1oQg@mail.gmail.com>
Subject: Bug: Merge commit lost during interactive rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is to report a bug found during interactive rebase.

Bug description

Scenario:
- New commit on top of a Merge Commit.
- Dropping last commit during interactive rebase.
- Merge Commit is lost in history

Steps to reproduce this bug with =E2=80=9Cgit version 2.18.1=E2=80=9D on Ce=
ntos8:

[root@a86e2b632fc2 git-bug-rebase]# git --version
git version 2.18.1

# Creating git repo

[root@a86e2b632fc2 /]# mkdir git-bug-rebase
[root@a86e2b632fc2 /]# cd git-bug-rebase/
[root@a86e2b632fc2 git-bug-rebase]# git init
Initialized empty Git repository in /git-bug-rebase/.git/

# Adding stuff on master branch and first commit

[root@a86e2b632fc2 git-bug-rebase]# touch file1
[root@a86e2b632fc2 git-bug-rebase]# git add .
[root@a86e2b632fc2 git-bug-rebase]# git commit -m "first commit"
[master (root-commit) 39f2f9b] first commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file1
[root@a86e2b632fc2 git-bug-rebase]# git log
commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96 (HEAD -> master)
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:49:21 2019 +0000

    first commit
[root@a86e2b632fc2 git-bug-rebase]# git branch
* master

# Creating another branch: branch2, checkout on it and commit changes

[root@a86e2b632fc2 git-bug-rebase]# git branch branch2
[root@a86e2b632fc2 git-bug-rebase]# git branch
  branch2
* master
[root@a86e2b632fc2 git-bug-rebase]# git checkout branch2
Switched to branch 'branch2'
[root@a86e2b632fc2 git-bug-rebase]# touch file-branch-2
[root@a86e2b632fc2 git-bug-rebase]# git add .
[root@a86e2b632fc2 git-bug-rebase]# git commit -m "commit on branch2"
[branch2 786f836] commit on branch2
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file-branch-2

# Checkout on master and commit something else

[root@a86e2b632fc2 git-bug-rebase]# git checkout master
Switched to branch 'master'
[root@a86e2b632fc2 git-bug-rebase]# touch file3
[root@a86e2b632fc2 git-bug-rebase]# git add .
[root@a86e2b632fc2 git-bug-rebase]# git commit -m "commit on master"
[master e3a957d] commit on master
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file3
[root@a86e2b632fc2 git-bug-rebase]# git log
commit e3a957d99401101b9e2805c2b59459123b2c1883 (HEAD -> master)
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:52:54 2019 +0000

    commit on master

commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:49:21 2019 +0000

    first commit

# Merge two branches:

[root@a86e2b632fc2 git-bug-rebase]# git merge branch2
Merge made by the 'recursive' strategy.
 file-branch-2 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file-branch-2

[root@a86e2b632fc2 git-bug-rebase]# git log
commit 9329daf43321d1b797652abf87106134ca516929 (HEAD -> master)
Merge: e3a957d 786f836
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:53:03 2019 +0000

    Merge branch 'branch2'

commit e3a957d99401101b9e2805c2b59459123b2c1883
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:52:54 2019 +0000

    commit on master

commit 786f836d941c101cb952aa008d10246cb0638e46 (branch2)
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:50:30 2019 +0000

    commit on branch2

commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:49:21 2019 +0000

    first commit

# Commit something after merge commit:

[root@a86e2b632fc2 git-bug-rebase]# touch file-after-merge
[root@a86e2b632fc2 git-bug-rebase]# git add .
[root@a86e2b632fc2 git-bug-rebase]# git commit -m "commit after merge"
[master 1f33710] commit after merge
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file-after-merge

[root@a86e2b632fc2 git-bug-rebase]# git log
commit 1f33710d6f011bb123cd947f82a004812b71f804 (HEAD -> master)
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:53:43 2019 +0000

    commit after merge

commit 9329daf43321d1b797652abf87106134ca516929
Merge: e3a957d 786f836
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:53:03 2019 +0000

    Merge branch 'branch2'

commit e3a957d99401101b9e2805c2b59459123b2c1883
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:52:54 2019 +0000

    commit on master

commit 786f836d941c101cb952aa008d10246cb0638e46 (branch2)
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:50:30 2019 +0000

    commit on branch2

commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:49:21 2019 +0000

    first commit

# Delete last commit through interactive rebase (merge commit is not
shown on list):

[root@a86e2b632fc2 git-bug-rebase]# git rebase -i HEAD~3
Successfully rebased and updated refs/heads/master.
[root@a86e2b632fc2 git-bug-rebase]# git status
On branch master
nothing to commit, working tree clean

# Merge commit is lost:

[root@a86e2b632fc2 git-bug-rebase]# git log
commit 82a34e8b224d8fa9434cc484ed153b519ffa32a5 (HEAD -> master)
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:50:30 2019 +0000

    commit on branch2

commit e3a957d99401101b9e2805c2b59459123b2c1883
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:52:54 2019 +0000

    commit on master

commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
Author: root <valentina.finocchiaro@gmail.com>
Date:   Wed Dec 18 09:49:21 2019 +0000

    first commit


Thanks and Best Regards,
Valentina
