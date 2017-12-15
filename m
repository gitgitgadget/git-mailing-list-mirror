Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7CF71F406
	for <e@80x24.org>; Fri, 15 Dec 2017 10:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755072AbdLOKaP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 05:30:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:44401 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754319AbdLOKaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 05:30:10 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1ePnFp-0000FU-6X; Fri, 15 Dec 2017 11:30:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id E2048120192; Fri, 15 Dec 2017 11:27:59 +0100 (CET)
Date:   Fri, 15 Dec 2017 11:27:59 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
Message-ID: <20171215102759.GB18542@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <005801d3751f$859f6c50$90de44f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005801d3751f$859f6c50$90de44f0$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your answer, Randall,

On Thu, Dec 14, 2017 at 04:07:15PM -0500, Randall S. Becker wrote:
> 
> You might want to consider a slight modification to your approach as
> follows. 
> Instead of using git pull, use git fetch.
> Have each system on its own branch (sys1 = my-sys1-branch, for example) so
> you can track who has what.
> In your scripts, consider:
> git fetch
> if nothing changed, done
> git status
> if no changes, git merge --ff  master && git push origin my-sys1-branch &&
> done
> if changes, send an email whining about the changes
> your script could then (depending on your environment) git commit -a && git
> merge && git push origin my-sys1-branch && done

The scripts never commit. In fact, they only have read access to the remote
repository. Commits are only ever done by humans manually.

So it's going to be something like this:

  git fetch origin
  if [ git diff -s master origin/master ]
    git stash
    git merge -ff master
    git stash pop
  fi

Unfortunately, the return code of git-diff don't seem to indicate whether they
have diverged. And git-status don't seem to have an option to specify "remote
is ahead of me". How would I properly check whether a merge is actually needed?

-- 
Josef Wolf
jw@raven.inka.de
