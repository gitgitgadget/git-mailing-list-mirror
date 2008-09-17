From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 13:14:43 +0200
Message-ID: <48D0E6A3.4040703@drmicha.warpmail.net>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>	 <48D0BEF1.10008@drmicha.warpmail.net> <cfd18e0f0809170338v168c2991ma3964392e44e0194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, michael.kerrisk@gmail.com
To: mtk.manpages@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 17 13:15:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfv0k-0005hG-Tm
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYIQLOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbYIQLOr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:14:47 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48931 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751463AbYIQLOq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 07:14:46 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E7112163E78;
	Wed, 17 Sep 2008 07:14:45 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 17 Sep 2008 07:14:45 -0400
X-Sasl-enc: NZgD1q65JR83XbJJLjc4tZCWqNDzQL/6k4OVfIBoJWQj 1221650085
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2A4F12D35B;
	Wed, 17 Sep 2008 07:14:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <cfd18e0f0809170338v168c2991ma3964392e44e0194@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96092>

Michael Kerrisk venit, vidit, dixit 17.09.2008 12:38:
> Hello Michael,
> 
> On Wed, Sep 17, 2008 at 1:25 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Michael Kerrisk venit, vidit, dixit 17.09.2008 00:05:
>>> Hello,
>>>
>>> I'm currently trying to import an svn repository, along with its tags,
>>> into git, and everything seems okay except that after the import I
>>> expect to have the following structure to my checked out repository:
>>>
>>>     [root-dir]
>>>         .git
>>>         <checked-out-files>
>>>
>>> But instead I end up with
>>>
>>>     [root-dir]
>>>         .git
>>>         man-pages               <-- name of my svn project
>>>             <checked-out-files>
>>>
>>> I've tried out a few different command-line flag settings but so far I
>>> haven't managed to get the desired layout.  I guess that I'm missing
>>> something trivial, but I haven't worked out what it is so far.
>>>
>>> The commands I'm using to do the import are:
>>>
>>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches
>>> $ git svn fetch
>>>
>>> The svn tags are getting imported okay, since:
>>>
>>> git branch -a | head
>>>   tags/man-pages-2.00
>>>   tags/man-pages-2.01
>>>   ...
>>>   tags/man-pages-3.08
>>>   tags/man-pages-3.09
>>>   trunk
>>>
>>> The following commands show the layout of my svn repo, which is pretty
>>> much standard:
>>>
>>> $ svn list file:///home/mtk/man-pages-rep
>>> branches/
>>> tags/
>>> trunk/
>>> $ svn list file:///home/mtk/man-pages-rep/trunk
>>> man-pages/
>> That's the part that says that your layout is non-standard. What do your
>>  branches and tags look like? Do they have that superfluous "man-pages"
>> part as well?
> 
> $ svn list file:///home/mtk/man-pages-rep/tags
> man-pages-2.00
> man-pages-2.01
> man-pages-2.02
> man-pages-2.03
> ...
> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.00
> man-pages
> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.01
> man-pages
> [and so on]

Bingo!

> $ svn list file:///home/mtk/man-pages-rep/branches
> $
> (i.e., no branches, since this has been a linear svn repo.)

git-svn converts svn tags into git branches (because they can change).
So you will get a git repo with lots of branches which are subsets (HEAD
commit is in master/trunk) of master/trunk.

>>> $ svn list file:///home/mtk/man-pages-rep/trunk/man-pages
>>> Changes
>>> Changes.old
>>> Makefile
>>> README
>>> man-pages-3.09.Announce
>>> ...
>>> man7/
>>> man8/
>>> scripts/
>>> $ svn list file:///home/mtk/man-pages-rep/tags
>>> man-pages-2.00/
>>> man-pages-2.01/
>>> ...
>>> man-pages-3.08/
>>> man-pages-3.09/
>>>
>>> What 'git svn init' command do I need to get the layout that I want
>>> for my imported git repo?
>> It depends on the structure of your branches and tags. My guess would be
>> that you have something like tags/man-pages-2.00/man-pages/ etc., in
>> which case you would need a special configuration if you want to get rid
>> of the "man-pages" part. Tells us your structure, we'll tell you the
>> config ;)
> 
> Do you now have enough info above?

Yes, thanks. If you use git-svn init -s (which is equivalent to -T trunk
-t tags -b branches) you get an "exact" clone of your svn repo in
reasonable time, as you already noticed.

In order to get rid of the "man-pages" path component you can either:

- remove it after the fact using git filter-branch

or

- remove it during the conversion process

For the latter, do the following:

git svn init -s file:///home/mtk/man-pages-rep/

as usual. Then, before the first fetch, make sure your .git/config svn
section looks as follows:

[svn-remote "svn"]
        url = file:///home/mtk/man-pages-rep/
        fetch = trunk/man-pages:refs/remotes/trunk
        branches = branches/*/man-pages:refs/remotes/*
        tags = tags/*/man-pages:refs/remotes/tags/*

That is, if you used "git svn init -s" you only have to add "/man-pages"
three times on the left hand side of the refspecs. You can also do this
using "git config", of course, if you watch out for the shell quoting.

Cheers,
Michael
