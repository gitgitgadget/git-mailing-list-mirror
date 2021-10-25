Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9DCC433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D941660F9D
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhJYJoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:44:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46020 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232688AbhJYJoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 05:44:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B521C1F670;
        Mon, 25 Oct 2021 09:41:39 +0000 (UTC)
Date:   Mon, 25 Oct 2021 09:41:39 +0000
From:   Eric Wong <e@80x24.org>
To:     Daniel Marschall <info@daniel-marschall.de>
Cc:     git@vger.kernel.org
Subject: Re: git-svn bug: Output git directory has uncommitted changes
Message-ID: <20211025094139.GA22377@dcvr>
References: <77aacb3b44523223c7647bdae1702a31@daniel-marschall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77aacb3b44523223c7647bdae1702a31@daniel-marschall.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Marschall <info@daniel-marschall.de> wrote:
> Hello,
> 
> I have found following bug in the latest version of git-svn . I have this
> issue with the old version shipped in Debian stable, as well as with the
> latest version built from source.
> 
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> Extract the following SVN repository to GIT:
> https://svn.viathinksoft.com/svn/filter_foundry/
> The bug ONLY happens with this single SVN repository. All other SVN
> repositories from my server work perfectly.
> 
> $ PERL5LIB=perl/ ./git-svn --authors-file="../../authors.txt" clone
> --trunk="trunk" "https://svn.viathinksoft.com/svn/filter_foundry/" "_test"
> $ cd _test
> $ git status
> 
> What did you expect to happen? (Expected behavior)
> 
> git status should show that nothing needs to be commited.
> 
> What happened instead? (Actual behavior)
> 
> You get a long list of files which need to be committed. The list is
> sometimes longer and sometimes shorter. So, the behavior is not
> deterministic. I have the feeling that the list often contains all files in
> the repo.

It seems like a CRLF vs LF vs CR issue; not something I'm
familiar with (not even in a git-only environment).

Running `git diff --ignore-space-change` says there aren't
non-space changes.

The presence of a .gitattributes file in the repo could be
confusing things, maybe, just a guess, I don't know...

Being a *nix-only person, I've never mucked with eol= attributes
at all.  Maybe somebody else experienced with such issues can
chime in; but eol stuff seems like a minefield of complexity I
don't ever want to step into :x

> Anything else you want to add:
> 
> This SVN repository was cloned from a foreign server to my own server, and
> then continued there. I think this SVN repository has some specific
> properties that cause the bugs.

It's been a while since I've looked at SVN stuff.  From what I
remember, git-svn doesn't check the CRLF property on the SVN side.
