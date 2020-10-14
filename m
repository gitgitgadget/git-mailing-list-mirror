Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C237CC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6623E22201
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2F9l87g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgJNP1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgJNP1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 11:27:33 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280DAC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 08:27:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q9so5621609iow.6
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=cQ/P07H/1Tsm0MGxqk6nzVr2aeVsxc3KDD3Yn2Lgirs=;
        b=C2F9l87gLhe5zVDlHWJBIn296NuIXnjMlSaopm3YuQUCIpRal0NIp6VJLNnKDk9/bG
         XsfNlrWWKyoKFtHolG1fgzUNYrK/QsSbD6x13rmJRhRlFBXNSHp4NnXbvX4ti5bckMfr
         CeAtYIJfRK+Azd5VfBvNwgF7whN5nO8HHaUWphBVsTnDKqXMxHrMoXLMzv7sQ0Q4ii6l
         oB5+knfMJ1Kvumen9xHA20n+8WE019Q98I87kJMgZlAWGBOfdw41fv2cpbOMm2bnZ9qH
         GkV+F73Hs+ihyulG9KLEZP47tkuWDmYYcSu9UMRpY71+gmLEOmopLIXlDJUf7lSlQzuT
         1bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=cQ/P07H/1Tsm0MGxqk6nzVr2aeVsxc3KDD3Yn2Lgirs=;
        b=ujjFS6KpRP6wJP2S9vlFgxgSVwJLsI4uzl/6I5Be+ktyIf6C70Zh0IEZPwllULsZD1
         cKqMzI8E29KwiRmnA32paw26KSIxWRX4XKGwjpGyrhED25HfGvSLSZbcwDC9shumsrj6
         0BCwWYIS9STAAKm5iB7WXgxwHNaQZm3e6geuiQ7KUYlKV9o4ZTKgXyz0/t9e8IPIrWuw
         Lg4Cv2iYFT6wE2WelYMpfLa/1buOoz76UuMS18/sJPFn8a3jHgq0nhUCkxbP9fbirOeK
         BXDnOb44ZYxzNI/RZoVz9v7qCrhhCo4SijD0xxBV//21R9r4Yq9PmsGRXH3VK+xXsJvj
         eIdA==
X-Gm-Message-State: AOAM530njFF0OjQz+Ls201boVy9dpWTnDYw33oXMWYKSWppFJNhpKp7S
        7f468qAwgebeGcCMHRvIXxGLUJ7Gfpi1ig==
X-Google-Smtp-Source: ABdhPJweM9ZLdZT2wxjcI7xYnBX9mecL8bcGVaTiBRb8PKxn5JgMolwUg3U91gBTb8FjkU25DTs7UA==
X-Received: by 2002:a6b:8bd7:: with SMTP id n206mr3199599iod.13.1602689251912;
        Wed, 14 Oct 2020 08:27:31 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id f85sm3239218ilh.68.2020.10.14.08.27.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 08:27:31 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [BUG?] Weird interaction between `git -C`, aliases and worktrees
Date:   Wed, 14 Oct 2020 11:27:27 -0400
Message-Id: <020EB674-6A95-4E53-B2E7-F4EEBD6324C3@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Up to recently I had an alias 'st' for `git status`, i.e. `git config =
alias.st status`.=20
This works well in the main working tree as well as secondary worktrees =
(`git worktree add ...`),
and also shows paths relative to the current directory if I'm not at the =
root of the repo,=20
just like `git status`.

Now I wanted to change my alias so that it ran `git status` and then an =
additional command, i.e.
`git config alias.st '!git status && date'` (for demonstration =
purposes).
This works correctly in the main worktree and secondary worktrees, but =
since aliases
run from the root of the repo, the paths in the output of 'git st' are =
not relative
to the current directory.

So my next attempt was `git config alias.st '!git -C "${GIT_PREFIX}" =
status && date'`,
so that paths would be relative in the output. However, this works in =
the main worktree
but fails badly in the secondary worktree:

```
rm -rf test &&
rm -rf test2 &&
git init test && =20
cd test &&
mkdir folder &&
date>>folder/file &&
git add folder/file &&
git ci -m "commit" &&
git config alias.st '!git -C "${GIT_PREFIX}" status && date' &&
date >>folder/file &&
echo '=3D=3D=3D `git st` in main worktree at root =3D=3D=3D' &&
git st &&
cd folder && =20
echo '=3D=3D=3D `git st` in main worktree in folder =3D=3D=3D' &&
git st &&
git worktree add ../test2 &&
cd ../test2 &&
date >>folder/file &&
echo '=3D=3D=3D `git st` in secondary worktree at root =3D=3D=3D' &&
git st && =20
cd folder &&
echo '=3D=3D=3D `git st` in secondary worktree in folder =3D=3D=3D' &&
git st
```

The last commands ouputs:=20

```
=3D=3D=3D `git st` in secondary worktree in folder =3D=3D=3D
On branch test2
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	deleted:    folder/file

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	file

no changes added to commit (use "git add" and/or "git commit -a")
```

So something is wrong in the automatic worktree path detection...
If I replace the alias with=20

    git config alias.st '!git -C "${GIT_PREFIX}" --work-tree=3D$PWD =
status && date'=20

then it works correctly, but I have a feeling this should not be =
necessary...

I've CC-ed Eric (because of his work on `git worktree`) and Elijah =
(because
I remember he worked on `dir.c` so maybe this is related to that code, =
but I'm
not sure).

Cheers,
Philippe

