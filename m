Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D6EC33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA1C2080D
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="oCF/IjX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbgALUpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 15:45:16 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:56175 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbgALUpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 15:45:16 -0500
Received: by mail-pj1-f53.google.com with SMTP id d5so3265315pjz.5
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 12:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ub1wLt+VixX8ATuNClnY8lK28Gbue9YQt+kpeXLXnvA=;
        b=oCF/IjX9Au4DNQT1xdpugb0O0vU8ObZ2Yx7Mvb65JyjP4qw4cZWjar+PNlvPem7bXL
         GjXgddeR9JS27ayKDz67cpZ4JV9oI6xvOne1cAHIaD3vI7hDhdFL2r8tEQDMtv0ptClv
         hgTLqQXyxk2M0Ddnze1AsXfEh3yGn30WE89fZCrFNdykkUsn7qnwrEGeDXbZSj8LDUfH
         5IRQZognbI56pnIgrkqBqr5i76xt6DgG011sUW2opccxbr0vAtBfIB77sOS+LtkDWPXH
         YQ6+GCxGb9UgcPKraJ4J34BtJ5PxwlOUHCGQ0aESvTXcEE1inWVnDeaZcX+4Nly0B7i5
         7+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ub1wLt+VixX8ATuNClnY8lK28Gbue9YQt+kpeXLXnvA=;
        b=cEi5zXjMgNlnQ8f9Uibk2OWYuYM2N1Lls7Wg3qYpGd7FRBZYr7flx8kF4td1Tv2FhE
         bHldDS8AfEYgEv7bdeZpuqsztfyx+NLPR/ekIN8gg2YPZO50rE//1KLJTrfpfbP+osL1
         m6GsXDxaAvA/SQolzXOw/DpjgzLYOGBuRgRjZHkrPQlIBHX0g8XtckslkpgRRx78Xafd
         DhmNzACu0UGCiAeF5SOUkcZ2Z0Iqwu6sfN7u9eb/kQslJ2NzCFWnK3CK5WWK807MAwyN
         bc1SAAwoI3RVXJ7xic9mq6wr8SGIaFR/a9NXPDS3E94zPgamhgz/Mm4/9kKPGN9aT+dL
         OkkA==
X-Gm-Message-State: APjAAAX9x5t0koBUW6rrryGeOMlQeMnDYbClatxUGVC1x/gi+w4tjKmh
        9dUBHjH/Kswn2iUrzoT52gY3og==
X-Google-Smtp-Source: APXvYqxsBMIW2yrFxPkZFsBVYiH0224UfpOSLY0lsWYxvjTJ8fK3CJVvLVDjdub2LKSfI/DqwNBtvw==
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr17212067plm.83.1578861915633;
        Sun, 12 Jan 2020 12:45:15 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:d560:1b2f:941c:2907])
        by smtp.gmail.com with ESMTPSA id z30sm11409774pfq.154.2020.01.12.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 12:45:15 -0800 (PST)
Date:   Sun, 12 Jan 2020 12:45:11 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        1234dev <1234dev@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] An easier way of rebasing if you just want to
 "force send" a file back to a previous commit
Message-ID: <20200112204511.GA4400@syl.local>
References: <jvRjyPq1IXAbIqfIOfEu2KxNKCMq9ktnAlVF9jGrccIvlPt22V62Ic8j0dHvLDOS31YrHZ2_t8ldgUTgJQHGdsMiYhnpYJJmOlJQFwiif_8=@protonmail.com>
 <20200112195646.GQ6570@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200112195646.GQ6570@camp.crustytoothpaste.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 12, 2020 at 07:56:46PM +0000, brian m. carlson wrote:
> On 2020-01-12 at 19:42:46, 1234dev wrote:
> > Hello!
> >
> > I'm pretty new to all of this, but I was wondering. Is there an easier way of rebasing if you just want to force send a file back to a previous commit? Rebasing can get quite tiresome in the long run. It's like 7 steps, and that's without the merge conflicts someone with my luck is guaranteed to run into.
> >
> > For instance, say I've made changes to a file. Those changes are too tiny and insignificant to make a new commit out of - they actually ought to be part of a commit I made last night.
> >
> > If there just was a way to cheat :) I'm aware it would rewrite my entire history but that's okay, I haven't shared my repo with anybody yet. Maybe something along the lines of "git rebase --off-she-goes <file> <hash>"?
> >
> > As opposed to "git stash && git rebase --interactive '<hash>^' && <change pick => edit> && <apply changes manually> && git add <file> && git commit --amend && git rebase --continue && git stash pop && <merge conflict that requires manual intervention> && git rebase --continue && git stash pop && <still a conflict> && rm <file> && git checkout <file> && <repeat the whole process> && <still a conflict> && <go to IRC and ask for help>
>
> The way I usually handle this is something like the following, although
> I have some helper aliases that wrap this:
>
>   git add <file>
>   git commit --fixup <hash>
>   git stash # if necessary
>   GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash
>
> That does use the interactive machinery to apply the fixup commit, but
> it also avoids prompting you to edit the interactive TODO list.  It
> doesn't avoid the merge conflicts which can occur, but it is (IMO) the
> easiest way to go about it.

I couldn't quite tell one way or the other, but I think that the
original poster was asking about the case in which one wants to move
some hunks out of one commit and into an earlier one.

I usually go about this with something like:

  h="$(git rev-parse HEAD)"
  git reset HEAD^
  git add <file[s]> # re-stage the files that you want to move "up"
  git commit --fixup <hash>
  git add --all .
  git commit -C "$h" # "re-apply" the commit that you were moving out of
  GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash

> If I'd like to edit the message, I use "git commit --squash" to add the
> comments I'd like to add and I'm only prompted to squash together those
> messages.

My preference is usually to allow 'git rebase -i' to open my "$EDITOR"
and change the todo list to "reword" for any commit(s) for which I want
to change the message.

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

Thanks,
Taylor
