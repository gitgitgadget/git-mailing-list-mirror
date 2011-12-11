From: Gelonida N <gelonida@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 17:17:14 +0100
Message-ID: <jc2l2a$som$1@dough.gmane.org>
References: <jbvj5o$skt$1@dough.gmane.org> <20111211022218.GA22749@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 17:17:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZm5q-0002qY-Ff
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 17:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1LKQRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 11:17:31 -0500
Received: from lo.gmane.org ([80.91.229.12]:47819 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab1LKQRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 11:17:30 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZm5g-0002n9-3y
	for git@vger.kernel.org; Sun, 11 Dec 2011 17:17:28 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 17:17:28 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 17:17:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <20111211022218.GA22749@sita-lt.atc.tcs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186803>

On 12/11/2011 03:22 AM, Sitaram Chamarty wrote:
> On Sat, Dec 10, 2011 at 01:26:32PM +0100, Gelonida N wrote:
>> Hi,
>>
>> What is the best way to fastforward all fastforwardable tracking
>> branches after a git fetch?
> 
> I dont think there is a single command to do it for *all*
> branches, but for any particular branch, this should work:

A tiny script is fine. I didn't really expect the magic command.

Currently I'm using one script per repository, which hard coded the
branches,
that I want to fast-forward (checking them out and doing a git-pull)

> 
>     git merge --ff-only @{u}
> 
Thanks, '--ff=only @{u}'  is already the first improvement for my script.


> So what you want would boil down to this script (untested):
> 
>     #!/bin/bash
>     git status --porcelain -uno | grep . && {echo dirty tree, exiting...; exit 1; }
> 
>     for b in `git for-each-ref '--format=%(refname:short)' refs/heads`
>     do
>         git checkout $b
>         git merge --ff-only @{u}
>     done



Is there no way to distinguish tracking branches from other branches?
without checking them out?

In order to save time I'd like to avoid checking out local branches.

Ideally I would even like to avoid checking out branches, which don't
need to be forwarded.


I also had to remember on which branch I was in order to avoid, that I
am at a random branch after running the script.

I could imagine something like my snippet below , though I guess,
there's something more elegant.

git stash
mybranch=`git branch | sed -n 's/\* *//p'`
# do_script . . .
git checkout $mybranch
git stash apply
