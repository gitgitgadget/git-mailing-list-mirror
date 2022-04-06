Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59BC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 22:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiDFWpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiDFWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 18:45:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59601877E4
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 15:43:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e689dfe112so33338737b3.20
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 15:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=DyjZlCLiW9uVFyHfHbu2JEBMupYvsWs+vA8iKOC8ca4=;
        b=X1Z78WP7yLnuE0S9HmsCSZonPTiVcKmyBNdhbOsXtDK1v96PI/f9oTOYgt3bKPIzKx
         OKI/z7025uhTOTqCsgsma1HimL2RY/fsy8+yW98r5C89+UI6c8HpeF4KCu60SvLfFXHk
         qE12lYiN8NWdnXG2Il6DTHiaWmZiLbA9kBWiAqwVSSXlM6VUEZfVpulnX4bSlPbe2Erg
         jBP99cxgVmxWlneYPEV3xFuw5Ft6CubgbdMQ7n2pyOssX+b55h8A9t7MVDtTvIzqENru
         GD2GJajJAK61w7Toi3vP0z3Mp1CroJv4HCb5S74zikI6Dd3JKuGDW84ocIT5//MiizXo
         +ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=DyjZlCLiW9uVFyHfHbu2JEBMupYvsWs+vA8iKOC8ca4=;
        b=k2B2DMTG8xJ+6ZYtkEmflQ8WsQNwCp2ZbZOjMqZvwmldxwIyga/mqqNMiGZqpCezwf
         lCkcR/maOLZ7JEHi1Y6+W7HqcyLmw/wnKk4JnwZ7Pq7DOb5+iBTaVKZ6A0qG41LiQjUF
         WGHIGKGaFBSWaTm7b4TBx1tBjrfJIi2f6uf9XJSEkqyydu5kSNBq2ZXZHvBt737pUVMZ
         U96c3ipIf2ol97n/sF5IhWRL8RO5YeCiSsdESL7g4n/1Yhi0HsEQXgU1jPHR7QW2c9K2
         n8GDxgEyt/4nZFjB779e3KAChDPsk5mtxhvAYQtPyqV8KJiF9tYHayJehoHtjKayILo0
         lG1g==
X-Gm-Message-State: AOAM533ypeZB4buGtNP44pX9FMEso+kY4XzR/D5kcfMZMVPPVShz/tUW
        5OlZn0u8iTMtv10wJPvJZesZ3H88DbePsUbySTK+i029WEkXZuDf+LHjN25iKP4Ulib8kW6ZPeH
        D09F0FiVzFoeupzV8CADFaC52oLqMRINJY0jQRIt8PXhUCL8Pp/00pa3YpppnbTs=
X-Google-Smtp-Source: ABdhPJxR9NIvU+OHzyqkqs3VKLtmwgkYrOBaYhRJlbYVt86GUcao8A4fP7iTWc1KKRxuatsS9ExLx7xzry2L1w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:360f:0:b0:634:7083:12a5 with SMTP id
 d15-20020a25360f000000b00634708312a5mr8505020yba.404.1649284997885; Wed, 06
 Apr 2022 15:43:17 -0700 (PDT)
Date:   Wed, 06 Apr 2022 15:43:08 -0700
Message-Id: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, justin@justinsteven.com,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi all,

My Google colleagues and I would like to address what we think is a securit=
y
risk - namely that Git repositories can contain valid bare repositories in =
their
working trees. This is based on an excellent article by Justin Steven [1] (=
CC-ed
here).

Below is a discussion of:

* The risky behavior - what Git does and why it is risky
* Possible responses to this risk
* A proposed approach

The proposed changes are nontrivial, so I=E2=80=99d really appreciate any f=
eedback here.
Unfortunately, I will be out of the office and won=E2=80=99t respond to ema=
ils for the
next 7 days or so, but there will still be at least one Google Git team mem=
ber
keeping tabs on the discussion :)

=3D TL;DR

Git repositories should not be allowed to contain bare repositories in thei=
r
working trees because:

* Such bare repositories can have maliciously crafted config files that cau=
se
  `git` to execute arbitrary code.
* Git itself can distribute the malicious repo via `git clone`; no need to
  distribute repos out of band e.g. via tarballs [2].
* Many `git` commands can be affected by malicious config files, and many u=
sers
  have tools that will run `git` in the current directory or the subdirecto=
ries
  of a repo. Once the malicious repo has been cloned, very little social
  engineering is needed; the user might only need to open the repo in an ed=
itor
  or `cd` into the correct subdirectory.

=3D Background

(This section is primarily a summary of [1]. I highly, highly recommend rea=
ding
that as it describes the issue in much more detail and is extremely readabl=
e
regardless of Git experience.)

Certain Git configuration options are particularly enticing targets for
attackers, e.g. core.fsmonitor can execute arbitrary commands and is invoke=
d
on many innocuous-looking `git` commands (like `git status`). This is even =
more
risky when one considers that many tools (like shell prompts and IDEs) will=
 run
`git` opportunistically inside a repository - so many users won't even need=
 to
explicitly run `git` to be affected [3].

Since config files are such an enticing target for attackers, Git intention=
ally
avoids distributing config files with repos - a user shouldn't be able to `=
git
clone` a repo with a config file (or really, any files inside .git). Howeve=
r,
one can 'trick' Git into doing this by embedding a bare repository inside o=
f
another, containing repository: a repository can contain subdirectories tha=
t are
valid bare repositories, and any `git` operations run in such a subdirector=
y
will then use the bare repository=E2=80=99s config file instead of the "mai=
n"
repository=E2=80=99s.

An attack might look like this:

* Attacker creates a repository where subdirectory "Documentation/" is a ba=
re
  repository i.e. it contains "HEAD", "refs/" and "objects/" [4]. Attacker
  also adds "config" with a malicious setting for core.fsmonitor.
* Attacker convinces User to read their project's documentation by `git
  clone`-ing their repository and inspecting the "Documentation/" directory=
.
* User cd-s into "Documentation/" and their shell prompt runs `git status`,
  executing the core.fsmonitor command defined by Attacker.

=3D What can we do about it?

Each subsection is an alternative and an analysis (+/- are pros/cons).

=3D=3D 1. Prevent users from checking out bare repos

This is similar to an existing mitigation where we prevent repository entri=
es
that can be confused for ".git" (like ".GIT"). but it requires checking mul=
tiple
entries instead of a single entry. I suspect that we could accomplish this =
in
one of two ways:

a. Prevent bare repos from entering the index.
b. Prevent writing bare repos to the working tree.

+ Relatively robust protection - because the malicious repo never enters th=
e
  working tree, we even protect other tools (e.g. JGit) from doing dangerou=
s
  things in the embedded repo (provided the checkout is done with `git`, of
  course).
- This breaks some 'valid' workflows (e.g. someone embedding a bare repo as=
 a
  more convenient alternative to submodules), but it seems reasonable to le=
t
  users opt out of this behavior.
- (1a) is difficult to do in practice because many code paths add entries t=
o
  the index, and checking a combination of new entry and existing entries i=
s
  much trickier than checking just the new entry.
- (1b) might also be difficult, though not as difficult as 1a because we
  already have a complete list of entries we will write. I don=E2=80=99t th=
ink there
  are existing facilities that do this sort of checking of multiple entries=
.
   =20
=3D=3D 2. Detect and reject bare repos using `git fsck` and `transfer.fsckO=
bjects`.

This entails checking for the markers of a bare repository (HEAD, refs/,
objects/) in tree objects. This shares a precedent with (1), since `git fsc=
k`
will also detect ".GIT".

+ Most reputable hosting sites set `transfer.fsckObjects`, which allows the=
m to
  detect and prevent this kind of transmission.
+ Confers some protection to users even without them doing anything.
+ Easy to visualize and to write.
- This won=E2=80=99t directly protect most users because they don=E2=80=99t=
 typically set
  `transfer.fsckObjects` (in fact, `transfer.fsckObjects` will render many
  projects, like linux.git, uncloneable without additional config)
- Won=E2=80=99t guard against malicious/poorly configured hosts.

=3D=3D 3. Detect that we are in an embedded bare repo and ignore the embedd=
ed bare
 repository in favor of the containing repo.

For example, if setup.c detects that we are in a bare repo, it could then w=
alk
up the directory hierarchy to see if there is a containing repo that tracks=
 the
bare one. If so, setup.c chooses to use the containing repo instead.

+ Extremely robust; this even protects against a checkout by an earlier Git
  version.
+ Users who don=E2=80=99t use bare repos won=E2=80=99t even notice the diff=
erence.
- The change in rules breaks some legitimate workflows e.g. a user with a r=
epo
  at HOME and bare repos underneath.
- Potentially very expensive for bare repo users because setup.c will likel=
y
  walk up to the root directory; we=E2=80=99d be essentially *forcing* thos=
e users to
  set GIT_CEILING_DIRECTORIES.
- Doesn=E2=80=99t protect users who use other tools e.g. JGit.
   =20
=3D=3D 4. Educate users about this risk without making code changes.

Some risks fall into this category e.g. "Avoid unarchiving repositories bec=
ause
.git/config might be poisoned." [2].

+ We don=E2=80=99t break any users.
- Breaks the trust that users have in `git clone`.
- IMO "Inspect every repo in its entirety before cloning it" is too much of=
 a
  burden to put on users.

=3D Next steps

I propose that we prevent repositories from containing bare repositories by
doing the following (in order):

* Implement (2) by adding a new fsck message "embeddedBareRepo".
  * When this is done, hosting sites can hopefully use this capability to
    prevent transmission, and help us understand the prevalence of such att=
acks.
* Implement (1b) by teaching unpack_trees.c to check whether the tree conta=
ins
  an entire bare repo, and die() if so. This will be guarded by a
  defaults-to-true config value.
  * This would only block a bare repo from being written in a single operat=
ion.
    It wouldn=E2=80=99t stop a user from writing a bare repo entry-by-entry=
 using "git
    checkout <path>", but the amount of social engineering required probabl=
y
    renders this attack infeasible.
  * As I noted earlier, I foresee some difficulty actually implementing thi=
s
    because I don=E2=80=99t think we have facilities for checking multiple =
tree entries
    at once.

I am particularly interested in hearing feedback about (1b), namely:

* How to actually teach unpack_trees.c to detect bare repos.
* Whether preventing bare repos in unpack_trees.c is a good enough mitigati=
on
  (e.g. Are there other code paths that should block bare repos? Should we =
be
  checking the index instead of the tree?).

I have a patch that does (2); I will send that out and we can leave feedbac=
k on
that separately.

=3D Demonstration

This is based on a script by Taylor Blau (thanks!). [1] also contains a
demonstration that runs in Docker.

  #!/bin/sh

  rm -fr malicious cloned &&git init malicious &&

  (
  cd malicious &&

  mkdir -p bare &&
  cd bare &&

  echo 'ref: refs/heads/main' >HEAD &&
  cat >config <<-EOF
  [core]
  repositoryformatversion =3D 0
  filemode =3D true
  bare =3D false
  worktree =3D "worktree"
  fsmonitor =3D "echo pwned >&2; false"
  EOF

  mkdir objects refs worktree &&
  touch worktree/.gitkeep &&

  git add . &&
  git commit -m ".gitkeep" &&

  cd .. &&
  git add bare &&
  git commit -m 'initial commit'
  ) &&

  git clone --no-local malicious cloned &&
  cd cloned/bare &&
  git status # pwned

=3D Footnotes

[1] https://github.com/justinsteven/advisories/blob/main/2022_git_buried_ba=
re_repos_and_fsmonitor_various_abuses.md.=20
[2] Archived repositories with malicious .git directories are a known risk.=
 See
 https://lore.kernel.org/git/20171003123239.lisk43a2goxtxkro@sigill.intra.p=
eff.net/
 for an on-list discussion. This is also described in
 https://blog.sonarsource.com/securing-developer-tools-git-integrations
 (referenced in [1]).
[3] We even ship such a tool - contrib/completion/git-prompt.sh. A user can=
 pwn
 themselves with tab completion even if they don=E2=80=99t have a prompt co=
nfigured
[4] Any directory containing these entries will be recognized as a bare rep=
o, so
 an attacker could add arbitrary entries to the directory to obfuscate the =
fact
 that it is a bare repo.
[*] https://offensi.com/2019/12/16/4-google-cloud-shell-bugs-explained-bug-=
3/ is
 similar to [1], but uses hooks instead of core.fsmonitor.
