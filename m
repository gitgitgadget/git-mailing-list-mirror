From: Bill Lear <rael@zopyra.com>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Thu, 5 Apr 2007 09:07:11 -0500
Message-ID: <17941.655.192938.792088@lisa.zopyra.com>
References: <17940.59514.150325.738141@lisa.zopyra.com>
	<20070405134954.GA18402@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 16:07:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZScg-0001DE-0S
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 16:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766992AbXDEOHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 10:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766997AbXDEOHU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 10:07:20 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61021 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766993AbXDEOHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 10:07:18 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l35E7FC10148;
	Thu, 5 Apr 2007 08:07:15 -0600
In-Reply-To: <20070405134954.GA18402@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43828>

On Thursday, April 5, 2007 at 09:49:54 (-0400) Jeff King writes:
>On Thu, Apr 05, 2007 at 07:15:54AM -0500, Bill Lear wrote:
>
>> I'm trying to explain this behavior to a co-worker, and how to solve
>> it:
>> 
>> % git pull
>> Already up-to-date.
>> 
>> % git push
>> error: remote 'refs/remotes/origin/flexify' is not a strict subset of
>> localref 'refs/remotes/origin/flexify'. maybe you are not up-to-date
>> and need to pull first?
>
>That ref name is a bit suspect...why are you pushing your your remote
>tracking branches? If you are simply pushing to a repository that is a
>pure mirror, maybe your 'push' line in the config file should have a '+'
>at the front?
>
>At any rate, the reason why the pull doesn't fix it is that it is not
>pulling onto flexify, but onto master, which it looks like you guessed:
>
>> So, I'm confused: I would have thought the way you solve the problem
>> in step 2 is by executing step 1.  Would he need to do this:
>> 
>> % git checkout flexify
>> % git pull flexify:flexify
>> % git checkout master
>> % git push
>
>It would need to be:
>  git pull $remote flexify:flexify
>
>I don't think that works, though, because it's _not_ the flexify branch
>that's the problem. It's the refs/remotes/origin/flexify, which
>generally shouldn't be getting pushed at all. Can you show us the
>.git/config?

Here is the config for the remote repository:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
[remote "origin"]
        url = git://source/fusion
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

Here is the local:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = ssh://poire/home/jml/repos/new/fusion
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

Hmm.... I wonder if his remote repo is non-bare... I'll try to find
out.


Bill
