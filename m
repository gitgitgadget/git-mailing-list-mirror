Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FEDEB64DA
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 10:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGSKtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 06:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGSKtC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 06:49:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2EE5
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 03:48:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso11002095e87.3
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689763715; x=1692355715;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWqZ0eUt6JP8ocMwVHM/1ruqUwRoc595RsjSsAV+Vik=;
        b=C4in7UVJ3bdGYpi50vRgnAuRdsEso6dwxbvPgDAIehY9luCuSqs3s2wQhGz93Sp5nw
         AKvExBSwHpAu9LSZMHE1TY8N5qVfqskGhHw7z8+BPRegUV7G0kUbe7pOA2aaSJ2Esb0J
         L7OhfHVRvd3RSIXwySmQCVYour4db6KPZR6kpJD6e5mzN7Tp4gzKDYJhPLc6H/WZjsrF
         vszj+Wiikciwlh+W6tM7nU2K76JuhTETQsI/1vuiVmcEBMg7shF0lFujn4xODi5t4rVh
         JrGF7JXViWMeiIwop4K30i+j+DlrKEwdhOte4Sf2FDH32RFGee5rhwS6FIdsVXWQhic6
         FZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689763715; x=1692355715;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWqZ0eUt6JP8ocMwVHM/1ruqUwRoc595RsjSsAV+Vik=;
        b=CDnl/J4IgToCEcxpmBcPgJLvP4EMpkHZPMuL326ERe/OQucmVL5arPxHDZUEmmvfpN
         SvG7QffuZLhZLaCJ9HmRRTuVuhIwq02y8KQKRT6WehggoSOJhxVfce+2JYyCLqozgT/O
         HFCtz2+Su4YmOcmBkwerf+NavuOE8vgH7yiZpM1UC9wEX6hoG+dr6vEvWP/h4iQeAsR1
         4gwQffVZyly4c0Nei5nhMRNaSFkPktzR5j6U6VZO8yc/fzdLI5dZ9twbrQ1x6POiVF6v
         OYlu2CRK/POxbOqr5MRwDpQhCLDcZ84v+xNV/ZydOuhGP0VWGUPXZ07qJayT5zlkC/Wo
         xo6w==
X-Gm-Message-State: ABy/qLY9FGfoy786+dY3uAw//fPkGGAyf083pd6v6t0UXUKbou+mgRKd
        yDF5IF6tnbwDvWwW6tjZf3+voqGL8kCxlnL6cKEP5hWNaP9U7gLD
X-Google-Smtp-Source: APBJJlGen6oC6jjjC1Hx0E+kxEFgl9IWAXB4P9KGwUKO4iUhxsM9Fd8lQsZCzH5GbDXzIgp3UuXv4uUztNe3mUSJY1o=
X-Received: by 2002:a19:4f1b:0:b0:4f7:6966:36fb with SMTP id
 d27-20020a194f1b000000b004f7696636fbmr10967224lfb.12.1689763714673; Wed, 19
 Jul 2023 03:48:34 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Jul 2023 03:48:34 -0700
From:   =?UTF-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
Mime-Version: 1.0
Date:   Wed, 19 Jul 2023 03:48:34 -0700
Message-ID: <CAG1j3zFps5yKwu=DEgkfmZDrzVoRkdeRFMFbq16ZmyOaTXxWeQ@mail.gmail.com>
Subject: [PATCH] blame: allow --contents to work with bare repo
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --contents option can be used with git blame to blame the file as if
it had the contents from the specified file. Since
1a3119ed06c8fbb1c00a6aa3615299252575abab ("blame: allow --contents to
work with non-HEAD commit"), the --contents option can work with
non-HEAD commit. However, if you try to use --contents in a bare
repository, you get the following error:

=C2=A0=C2=A0=C2=A0 fatal: this operation must be run in a work tree

This is because before trying to generate a fake working tree commit,
we always call setup_work_tree. But in a bare repo, work tree is not
available. The call to setup_work_tree is used to prepare the reading
of the blamed file in the work tree, which isn't neccessary if we are
reading the contents from the specific file instead of the file in the
work tree.

Add a check in setup_scoreboard to skip setup_work_tree if we are
reading from the file specified in --contents.

This enables us to use --contents in a bare repo. This is a nice
addtion on top of 1a3119ed06c8fbb1c00a6aa3615299252575abab, having a
working tree to use --contents is optional.

Add test for the --contents option with bare repo to the
annotate-tests.sh test script.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
Before commit 1a3119ed06c8fbb1c00a6aa3615299252575abab using
--contents in a bare repo will lead to

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 fatal: cannot use --contents with final co=
mmit object name

even without specify a revision, this is because in a bare repo, HEAD
is seem as a passed revision. After
1a3119ed06c8fbb1c00a6aa3615299252575abab, git will try to
setup_work_tree as long as --contents is passed. So we still cannot
use --contents on a bare repo.

I was comparing files between a bare repo on the server and my local
partial cloned repo. It is convenient for me to be able to use
--contents option on a bare repo, because the project is very large
and would occupy a lot of disk space if fully cloned on local machine.

With this change I can upload my local file to the server and get the
blame result without keeping a full clone of the repo on my local
machine.

=C2=A0blame.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 +++-
=C2=A0t/annotate-tests.sh | 9 +++++++++
=C2=A02 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/blame.c b/blame.c
index d12bd9f97b..0b6703d636 100644
--- a/blame.c
+++ b/blame.c
@@ -2806,7 +2806,9 @@ void setup_scoreboard(struct blame_scoreboard *sb,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 parent_oid =3D &head_oid;
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 setup_work_tree();
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (!sb->contents_=
from) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 setup_work_tree();
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 }
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sb->final =3D=
 fake_working_tree_commit(sb->repo,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 &sb->revs->diffopt,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 sb->path,
sb->contents_from,
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 2ef70235b1..5e21e84f38 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -83,6 +83,15 @@ test_expect_success 'blame with --contents' '
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_count --contents=3Dfile A 2
=C2=A0'

+test_expect_success 'blame with --contents in a bare repo' '
+ =C2=A0 =C2=A0 =C2=A0=C2=A0 git clone --bare . bare-contents.git &&
+ =C2=A0 =C2=A0 =C2=A0=C2=A0 (
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 cd bare-contents.g=
it &&
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 echo "1A quick bro=
wn fox jumps over the" >contents &&
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 check_count --cont=
ents=3Dcontents A 1
+ =C2=A0 =C2=A0 =C2=A0=C2=A0 )
+'
+
=C2=A0test_expect_success 'blame with --contents changed' '
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "1A quick brown fox jumps over the" =
>contents &&
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "another lazy dog" >>contents &&
--
2.40.0
