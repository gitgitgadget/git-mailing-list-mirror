Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560C71F406
	for <e@80x24.org>; Sat,  6 Jan 2018 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeAFWpE (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 17:45:04 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:38218 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeAFWpD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 17:45:03 -0500
Received: by mail-lf0-f43.google.com with SMTP id d19so284141lfj.5
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 14:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=m+BgCa2rYMzJnE2zDYXtgX8ARNfphYMZu6MB/ucXQ0c=;
        b=sFviTuIwwr4hl78XDevAqYUCYwok+M0vLrtuiCB96GqlrEVfbgB6zvhpNKs1yGATWa
         QYzA6T20zX864DSvriz5O7hTIHUEegi9ggR6XsLpB7yKF14zqnQJeh+UjfZzdpkk/J87
         0L13yk3F56IWDaz7mP1KdkkBNQ/e/mzrA+EX0pKzPK7FcB48swicGOpwRiNhSvmgA5PR
         xrg/sLRNcvCWW8QG/7tX7dsfye/V4c3Uo6aStuYMeC+LORN7h2TiURd+DVmAotdFTJb0
         9fRmYzRNAyMM3MTBwSIr9urEAIzFAQ1tZ34Qzj1ISj+J9q8ICEc15CwHAWNTBLUZzV7N
         0T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m+BgCa2rYMzJnE2zDYXtgX8ARNfphYMZu6MB/ucXQ0c=;
        b=cVG7Xxn/R3bVvtjvyVXEr9qf+alz9YdmMofvxu7WVYhrY80jl36ts9NwEf0lSqU77x
         sSDWpg9/bpRN8pLpgHF4X0d8tzL21+2/yQkKkUy6rOMvuFNGnj2vc81A36ktV7proe02
         nx3b8O8poVfqU93mXQDEJSCfVkQjnJsp82ln2b5KU+RYn7Y/9+HWS+w7wMDh+vkaWLIe
         rF+6NfazhnQYv5FVWEB61lEZSSp+Ued4A08CqbxUzBmynI0CQyw3SStmNTECZV0n/5IM
         UlP2OamSBxH6tgC8c0r5tL/2F636G+kosrDQ3LOoFWnY4CSzpCzj3PVM88UqyFMjy/3Q
         47fQ==
X-Gm-Message-State: AKwxytf0UsUwTMD9jUORPwEHjhNybtkTSjgo+s8R2YITIbHcCQyG1UJt
        +aQDKaH62eVk+X6Tb1fvUuPK6HKj/bQtLDpI86ggKUiM
X-Google-Smtp-Source: ACJfBovD3qqPkJ58fhgu060HNLL+zkW2RfKRcI4HIXR4r+pOS8tDHQgAJF+PNRIkEjnZDtiY6GQaIPZsLXUDPzMPjto=
X-Received: by 10.25.39.193 with SMTP id n184mr1522938lfn.117.1515278701626;
 Sat, 06 Jan 2018 14:45:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.5.88 with HTTP; Sat, 6 Jan 2018 14:45:01 -0800 (PST)
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Sat, 6 Jan 2018 17:45:01 -0500
Message-ID: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
Subject: Bug Report: Subtrees and GPG Signed Commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I've noticed an issue regarding the use of `git subtree add` and `git
subtree pull` when the subtree repository's commit (either HEAD or
whatever commit specified by the subtree command) is signed with GPG.
It seems to work properly if the commit is not signed but previous
commits are.

The gist of the issue is that `git subtree add` does not add the
subree properly and a "fatal: Not a valid object name" error is
thrown. Running `git subtree pull` does not pull any upstream changes
after that ("'subtree' was never added").

I have not done extensive testing, however, below are instructions to
reproduce the issue. This was tested using git version 2.15.1
installed via Homebrew on MacOS. I did not test with the built-in
version of git on MacOS.

Thanks,
Steve

# Create a new repository
mkdir repoA && cd repoA
git init
echo "Test File in Repo A" > FileA
git add -A && git commit -m 'Initial commit in repo A'

# Create a second repository
cd .. && mkdir repoB && cd repoB
git init
echo "Test File in Repo B" > FileB
git add -A && git commit -m 'Initial commit in repo B'

# Create a signed commit in repo B
echo "Signed Commit" >> FileB
git commit -a -S  -m 'Signed commit in repo B'

# Now, add repoB as a subtree of RepoA
cd ../repoA
git subtree add --prefix repoB_subtree/ ../repoB/ master --squash
# Output:
git fetch ../repoB/ master
warning: no common commits
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 6 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (6/6), done.
From ../repoB
 * branch            master     -> FETCH_HEAD
fatal: Not a valid object name gpg: Signature made Sat Jan  6 17:38:31 2018 EST
gpg:                using RSA key 6900E9CFDD39B6A741D601F50999759F2DCF3E7C
gpg: Good signature from "Stephen Robert Guglielmo (Temple University
Computer Services) <srg@temple.edu>" [ultimate]
Primary key fingerprint: 6900 E9CF DD39 B6A7 41D6  01F5 0999 759F 2DCF 3E7C
4b700b1a4ebb9e2c1011aafd6b0f720b38f059a4
# Note, git exits with status 128 at this point.

# FileB was in fact added and staged to repoA, despite the "fatal"
above. Commit it:
git commit -m 'Add repoB subtree'

# Ok, let's make another commit in repoB and try a `subtree pull`
instead of `subtree add`
cd ../repoB
echo "Another Line" >> FileB
git commit -a -S -m 'Another signed commit'
cd ../repoA
git subtree pull --prefix repoB_subtree/ ../repoB master --squash
# Output:
warning: no common commits
remote: Counting objects: 9, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 9 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (9/9), done.
From ../repoB
 * branch            master     -> FETCH_HEAD
Can't squash-merge: 'repoB_subtree' was never added.
# Note, git exits with status 1 at this point.

# RepoB's third commit ('Another signed commit') is not pulled into
the subree in repo A.
# This can be verified by running a diff:
diff -qr --exclude ".git" repoB_subtree ../repoB
# Output:
Files repoB_subtree/FileB and ../repoB/FileB differ
