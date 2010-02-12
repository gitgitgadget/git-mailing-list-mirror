From: Ron Garret <ron1@flownet.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 14:39:05 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-5EFFD7.14390512022010@news.gmane.org>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com> <ron1-62D136.13570812022010@news.gmane.org> <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 23:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng4Ap-0003XB-Pu
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812Ab0BLWjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:39:32 -0500
Received: from lo.gmane.org ([80.91.229.12]:58429 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757746Ab0BLWj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:39:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ng4AX-0003ID-FG
	for git@vger.kernel.org; Fri, 12 Feb 2010 23:39:25 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 23:39:25 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 23:39:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139759>

In article <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com>,
 Brian Gernhardt <benji@silverinsanity.com> wrote:

> On Feb 12, 2010, at 4:57 PM, Ron Garret wrote:
> 
> > That would require a separate branch for every snapshot, no?  I want 
> > this to be lightweight.  It's not so much the creation of a zillion 
> > branches that bothers me, but having to come up with a new name every 
> > time would be a real hassle.
> 
> Ahhhh...  You could just use the stash and use some kind of recognizable 
> message: git stash Failed: fooed the bar badly
> 
> Or you could make a stash-like snapshot branch?  The following sequence does 
> something like that:
> 
>   git add .
>   git commit -m "Ooops"
>   git branch -f
>   git reset --hard HEAD^
> 
> After a few failures like that, you can look over all the snapshots with
> 
>   git log -g snapshots
> 
> By default they will be kept around for 30 days, or the current setting of 
> gc.reflogexpireunreachable.  If you want to keep a snapshot around for more 
> than 30 days, you probably want to give it a real branch anyway.
> 
> You could either create a script that uses the above commands or a patch that 
> makes git-stash take a --ref= argument and then set:
> 
>   alias.snapshot = stash --ref=refs/snapshots


Yes, I think the right answer is going to be something like this:

git symbolic-ref HEAD refs/heads/snapshots
git rm --cached -r .
git commit --allow-empty -m 'Snapshot branch'

Then, to take a snapshot:

git branch snapshot
git checkout master -- path
git add path
git commit -a -m 'Snapshot of [path]'
git checkout master

(All of that will be in a script of course.)

And to rollback:

git checkout snapshot-[n] -- path

Or something like that.  I haven't actually tried this yet, but it seems 
like it ought to work.

Am I right that 'git checkout branch' changes branches, but 'git 
checkout branch -- path' doesn't?  That's very confusing.  Useful, but 
confusing :)

rg
