Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ED6C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196212064E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgI3UgA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 30 Sep 2020 16:36:00 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42735 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Ufq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:35:46 -0400
Received: by mail-ed1-f54.google.com with SMTP id j2so3300372eds.9
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=guqnIX2d5GeGl0HhUjIzMt7+7Wc7ZgTS4aOThM1dolI=;
        b=ggI4aDAV3Q/PjE/BM3ZSTMdsX+GYuXAFtWe2V8a3N1cI/38cWaibmFrciq3DiYDVVl
         VSCWWXeAnqUXcubDZNum3/c7cCXqbgYvlgRaYmxMdGeMox54XsvifpzRdm+E8ijNheEQ
         OByGV9GWFSRYje5n+80AIJ9ODXeMGilmt8/nr4u43t03Kp2NZoZzb/U83w/8RouCxsiJ
         C/FZeFg7n9Ee0Jn6JEKltBM8N6fiW15X1yJbhXT8kQ9F6CTf+ZWjDSSIfjoKRnabgH3m
         CalUN7Nf6/vE96mCxAoujLm2I6jgEmoUTawJCAF7MrGNwTBSXicnrOjW9BZFBO9BjPyu
         ykKQ==
X-Gm-Message-State: AOAM530zabj341yPcC2zz1XM1jq0zRe+5z+2l9wgGJEuUCzx59ZRTF8j
        yJrgClLPrdCpbxosDmXQgr8qmaNonuANkEdH5JreYnUbfPA=
X-Google-Smtp-Source: ABdhPJxASfPL2oIvoJWXmFe3OHMGZXdwNZ7Bbprp5q9IzoPfaswA05lUJOJXJhHJUAXrtA2eqpicx2Rchd0doJ7SEWI=
X-Received: by 2002:a05:6402:17da:: with SMTP id s26mr4759585edy.221.1601498142931;
 Wed, 30 Sep 2020 13:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
 <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com> <335b6e6a-9527-5444-da80-08faf43db606@gmail.com>
In-Reply-To: <335b6e6a-9527-5444-da80-08faf43db606@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Sep 2020 16:35:31 -0400
Message-ID: <CAPig+cSzVVdiH62Gc-ww56OFfPh4-2+3_paWEJf085TgC=nNvg@mail.gmail.com>
Subject: Re: GIT_DIR output from git worktree list
To:     =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 3:34 AM Gabriel Nützi <gnuetzi@gmail.com> wrote:
> Am 30.09.2020 um 07:33 schrieb Eric Sunshine:
> > Because the implementation doesn't really look for or know where the
> > main worktree is. Instead, it's taking the path of the repository and
> > stripping off "/.git" if present, and reporting that as the main
> > worktree. [...]
>
> Ok, it's kind of sad that as far as I understood, there is probably
> always only this heuristic about stripping ".git" because the main
> worktree path is not registered inside the .git dir or somewhere
> else.

This is, of course, an artifact of Git's history. While Git itself is
reasonably old at this point, linked worktrees are a relatively recent
invention, and there had never been a reason to record the path of the
main worktree anywhere. Also, not recording the path allows the
project directory to be relocated easily if needed.

> I mean you can technically name the git directory what ever you want
> and in that case how is that stripping than going to work?  But of
> course when you do so, you probably need to set either GIT_DIR, or
> or use --git-dir

I don't think it's accurate to say that "you can technically name the
git directory what ever you want". The only _blessed_ name for that
directory is `.git/` if you expect any sort of automatic behavior
regarding repository discovery and determination of the top level of a
worktree.

Certainly, you're free to locate the repository elsewhere -- or name
it something else -- but when you do so, you knowingly give up the
convenience of the automatic behaviors, and instead have to rely upon
--git-dir, GIT_DIR and --worktree, GIT_WORK_TREE, and core.worktree,
which is why those exist.

(Rather than --git-dir, --git-work-tree and cousins, you could also
place a "gitfile" named `.git` in the main worktree referencing the
actual repository path, and by doing so regain all the automatic
behaviors. Alternately, `git init --separate-git-dir` could set this
up for you.)

At any rate, the above comments aside, as mentioned previously, a way
forward might be to teach git-worktree to consult --work-tree,
GIT_WORK_TREE, core.worktree when computing the path of the main
worktree. The fact that it doesn't yet do so is merely an oversight, I
think; one of the several such oversights during initial development,
some of which have already been corrected.

> Also what I realized is, isn't the doc a bit inexact about GIT_DIR:
>
> > GIT_DIR is the location of the .git folder.
>
> Shouldn't it read: GIT_DIR is the path of the .git folder. Location
> could mean its the parent folder? Hm...

That might indeed be an improvement. Perhaps submit a patch making
this change?
