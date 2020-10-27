Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCD5C388F9
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FE322202
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bakanov-su.20150623.gappssmtp.com header.i=@bakanov-su.20150623.gappssmtp.com header.b="u5EqTx42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJ1Bi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35698 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832984AbgJ0XOR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 19:14:17 -0400
Received: by mail-io1-f68.google.com with SMTP id k6so3415793ior.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bakanov-su.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPHV1UmE2oNwCW7SahoQzzxJw65xZi8939VN7Hgzptg=;
        b=u5EqTx42vjl4OlYS1Q7m/M2tF6ZamEZnHwO1ZGBjvyar7YASZ3SljTFR4m2+C4mCpQ
         0FIy65+hMbA640ROoGRIE/tOcCCFe27epwMbXLeWubbBOMKTjOQWiFNaqC0VHKc0W+tb
         Qe+y0dn4Ogbm5Pk1UTQR5gYPpk5sxDxOFNpwi7wuamxCENRckf/HjlXMF+ReUjy7DbiE
         664bRug/W0K/58ljWWoZx/mvpY+L4Bld9AdBeIIs4QJ2QxOaj5B68lXYMMNDQsOH13qe
         ehwqFLipSNmTK5Z9QM72csOIC45002VTj7EDEvjV8sjBDnK4jfM+FuIQyMeM9FtuyZVo
         TaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPHV1UmE2oNwCW7SahoQzzxJw65xZi8939VN7Hgzptg=;
        b=rw5tXqJWVNfWxgL2Jd02t/Ep+JciZVjyPyZyp1gekzIffGAjKWa//qI7QvjukuQviT
         CJ2NYrcqkYudZ1t3aPmGuPsRcGnwLW+8pymwQX/VTJG59U+KQOOH4ItY3EDxcsHzxLTd
         4Z2KjxNJtL8GFAsWfYHP2bBNKwDMl2IhJt/tv2dlE3SuviSV2sElXrLXD0tVGLNA5Enj
         6QiVa9vl3Bu+LjbCVTYUNon0mR4BgsryjNjzNpwwc3jx3Le8MkCIYu+OiaWKSIXst/h/
         q/l7T/wRH2JwpcXJ82QHFgCcJzOkmAKCurNTdB6EiQWbKKO5cSOpnacgOQY1j1Frtk8d
         6X7g==
X-Gm-Message-State: AOAM532vHxf+GPBp3TA5wcIrV9xWoWgbFXLs6kH7krzwzRn14/YwekGG
        kp5tx5rsJuNmIOPbIq3kNvxnNTlmIEd7il7GFzZCGg==
X-Google-Smtp-Source: ABdhPJwgfPXj6YmjBtqVqkxXD5JIoigY8uS8+GxI4hLCX3bWx4qk4Ty5Tsft8SLfatrXadODLTMY2gtx5qfmPGLK0rw=
X-Received: by 2002:a6b:8ec7:: with SMTP id q190mr4099841iod.42.1603840456086;
 Tue, 27 Oct 2020 16:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
 <xmqqblgnbea5.fsf@gitster.c.googlers.com> <20201027215638.GI5691@mit.edu>
 <CAAdniQ4vx4z9KnfvG7thzxf1xBa=P_nnbY1G=RTFUBb4Zxqeaw@mail.gmail.com> <20201027225403.GJ5691@mit.edu>
In-Reply-To: <20201027225403.GJ5691@mit.edu>
From:   Filipp Bakanov <filipp@bakanov.su>
Date:   Wed, 28 Oct 2020 02:14:05 +0300
Message-ID: <CAAdniQ7o2greovkG-RP-FLwW2OH3YuiORwB+QKgqy=_0aJ4XkQ@mail.gmail.com>
Subject: Re: Proposal: "unadd" command / alias.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's the matter of UX. If many users have to make an alias for the
same unclear command, at least it's a point to think about making this
particular command more convenient. As far as I remember, some aliases
were already added to git by default.
What's bad with adding a popular (among many users) aliases, if they
improve UX and make life easier?

On Wed, 28 Oct 2020 at 01:54, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 28, 2020 at 01:02:11AM +0300, Filipp Bakanov wrote:
> > >> Indeed, I have a similar alias in my ~/.gitconfig
> >
> > Why not just add it to git by default for everybody? revert-file is
> > also ok, anything except `checkout HEAD --` will be good.
>
> Because everyone may have their own favorite aliases?  Just because
> *I* have the following aliases doesn't mean that everyone else would
> find them useful.
>
> [alias]
>         new = !gitk --all --not ORIG_HEAD
>         dw = diff --stat --summary
>         di = diff --stat --summary --cached
>         dc = describe --contains
>         revert-file = checkout HEAD --
>         l  = log --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>         lr = log --reverse --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>         rl  = log -g --pretty=format:'%Cred%h%Creset %gd %gs %Cgreen(%gr)%Creset %s' --abbrev-commit
>         rl1  = log -g --date=relative --pretty=format:'%Cred%h%Creset %gs %Cgreen%gd%Creset %s' --abbrev-commit
>         lg  = log --graph --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>         lgt = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>         rlt = log -g --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>         lgt-nc = log --graph --pretty=format:'%h -%d %s (%cr)' --abbrev-commit
>         st = status -s
>         recent = for-each-ref --count=15 --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'
>         gerrit-clone = !bash ggh gerrit-clone
>         start = !bash ggh start
>         upload = !bash ggh upload
>         prune-branches = !bash ggh prune-branches
>         fixes = log -1 --pretty=fixes
>
> I have a huge number of bash aliases, and that doesn't mean everyone
> else should have those bash aliases.  For that matter, I have the
> following in ~/bin/git-rp-ext4 so that I can type "git rp-ext4
> tags/ext4_for_linus".  But that doesn't mean this script is right for
> everyone....
>
> Cheers,
>
>                                         - Ted
>
> #!/bin/sh
>
> START=origin
> URL=git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
> END=""
>
> print_help ()
> {
>     PROG=$(basename "$0")
>     echo "Usage: $PROG [-n] [--start <START COMMIT>] [--url <URL] [<END COMMIT>]"
>     exit 1
> }
>
> while [ "$1" != "" ]; do
>     case $1 in
>         --start) shift
>                  START="$1"
>                  ;;
>         --url) shift
>                URL="$1"
>                ;;
>         -n) NO_ACTION="echo" ;;
>         -*) print_help ;;
>         *)
>             if test -n "$END"
>             then
>                 print_help
>             else
>                 END="$1"
>             fi
>             ;;
>     esac
>     shift
> done
>
> $NO_ACTION git request-pull "$START" "$URL" "$END"
>
