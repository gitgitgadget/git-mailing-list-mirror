Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4249020248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCLSOb (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:14:31 -0400
Received: from ikke.info ([178.21.113.177]:56154 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfCLSOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:14:30 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 9052E4400BB; Tue, 12 Mar 2019 19:14:28 +0100 (CET)
Date:   Tue, 12 Mar 2019 19:14:28 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
Message-ID: <20190312181428.GA6993@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 01:22:51PM -0400, Robert P. J. Day wrote:
> 
>   never noticed this before ... when i do a regular "git commit" and
> enter my "vi" edit session and change my mind, i can bail with ":q!",
> regardless of what i've set up as a commit message, and i'll see:
> 
>   Aborting commit due to empty commit message.
> 
> however, i was just playing with "git revert" and, after i ran:
> 
>   $ git revert <commit SHA>
> 
> i was dumped into another vi edit session:
> 
> Revert "HTTP->HTTPS"
> 
> This reverts commit 2965b41fd84a1a76f56984ecdf6c123d1992730f.
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> #
> # On branch master
> # Your branch is up to date with 'rpjday/master'.
> #
> # Changes to be committed:
> #       modified:   book/01-introduction/sections/installing.asc
> #
> 
>   again, simulating that i changed my mind, i just typed ":q!", but
> the revert went ahead, anyway. i tried again, this time completely
> deleting all the lines from the commit msg (as the template
> suggested), but the revert *still* completed after typing ":q!".
> 
>   it was only after deleting all the lines and using ":wq" that the
> revert was cancelled:
> 
>   Aborting commit due to empty commit message.
> 
> that seems ... inconsistent. am i misunderstanding something?
> 
> rday

The only reason why `:q!` works just for comitting is because there is
no default message, so the final message ends up empty.

When you do things like git revert or git ocmmit --amend, there is
already a commit message, which you are then editing. When you quit
without saving, the existing message remains and git uses that.

vim has a command to let it exit with an error return code: `:cq`. This
makes git something went wrong with editing the message, causing git to
abort the commit.
