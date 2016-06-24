Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56E22018A
	for <e@80x24.org>; Fri, 24 Jun 2016 20:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcFXUGH (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:06:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46154 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbcFXUGG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 16:06:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F21F52018A;
	Fri, 24 Jun 2016 20:06:03 +0000 (UTC)
Date:	Fri, 24 Jun 2016 20:06:03 +0000
From:	Eric Wong <e@80x24.org>
To:	Jacob Godserv <jacobgodserv@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Cc:	git@vger.kernel.org
Subject: Re: git-svn aborts with "Use of uninitialized value $u" when a
 non-svn-backed branch is present in remote
Message-ID: <20160624200603.GA28498@dcvr.yhbt.net>
References: <CALi1mtc8zmOzk-qv4XAg6N=ENasnMAENdJSLHK7EcpxRUk1nTw@mail.gmail.com>
 <CALi1mtdtNF_GtzyPTbfb7N51wwxsFY7zm8hsgwxr3tHcZZboyg@mail.gmail.com>
 <20160624193548.GA22070@dcvr.yhbt.net>
 <CALi1mtc6Byb39kbAv16vmkUVu3JDdGG4-yVrLroDVraPDxGFng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALi1mtc6Byb39kbAv16vmkUVu3JDdGG4-yVrLroDVraPDxGFng@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Please don't drop Cc:, re-adding git@vger and Christian

Jacob Godserv <jacobgodserv@gmail.com> wrote:
> > Christian (Cc-ed) also noticed the problem a few weeks ago
> > and took a more drastic approach by having git-svn die
> > instead of warning:
> > http://mid.gmane.org/1462604323-18545-1-git-send-email-chriscool@tuxfamily.org
> > which landed as commit 523a33ca17c76bee007d7394fb3930266c577c02
> > in git.git: https://bogomips.org/mirrors/git.git/patch?id=523a33ca17c7
> >
> > Is dying here too drastic and maybe warn is preferable?
> 
> In my opinion this is too drastic. It keeps me from storing
> git-specific data on a git-svn mirror.

I tend to agree, but will wait to see what Christian thinks.

> Here's my setup:
>  - My git-svn mirror uses git-svn to create a git repo that mirrors
> svn history. This repository is then pushed to a clean bare
> repository. So far so good. Only svn-sourced branches exist.
>  - The git-svn mirror script also saves a copy of the git-svn
> configuration used to generate the git mirror repository in an
> "orphaned" branch called something like 'git-svn-conf'. This is
> completely separate from the svn history, and exists only for my
> git-svn purposes.
>  - On the "client" side, another script I wrote knows how to parse the
> git-svn configuration in that 'git-svn-conf' branch to properly
> reconfigure git-svn on the local machine, so I can use 'git svn'
> themselves to commit, etc., and still generate the same hashes so
> there's no forked history during the next mirror fetch.
> 
> Long story short: I have branches which aren't in SVN history for
> automated git-svn purposes.
> 
> It appears that simply skipping the branch in that loop fixes the
> issue. However, I don't know how the metadata is stored and what
> exactly that loop does, so I may be creating hidden side effects I
> have been lucky enough to not trigger yet.
