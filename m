From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Thu, 25 Oct 2007 09:26:35 +0200
Message-ID: <20071025072635.GC6069@xp.machine.xx>
References: <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <471FBF29.8030802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:26:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikx7D-0008BK-7l
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 09:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbXJYH0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 03:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756112AbXJYH0j
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 03:26:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:35627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755665AbXJYH0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 03:26:38 -0400
Received: (qmail invoked by alias); 25 Oct 2007 07:26:36 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp038) with SMTP; 25 Oct 2007 09:26:36 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18dMp4d+18dalX8lv+KBVw+DdwKTu9pKxvgaqWtSn
	0s3unNI5x/yr8f
Content-Disposition: inline
In-Reply-To: <471FBF29.8030802@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62282>

On Wed, Oct 24, 2007 at 11:54:49PM +0200, Andreas Ericsson wrote:
> Peter Baumann wrote:
>> On Wed, Oct 24, 2007 at 11:06:24PM +0200, Andreas Ericsson wrote:
>>> J. Bruce Fields wrote:
>>>> On Wed, Oct 24, 2007 at 10:12:29PM +0200, Steffen Prohaska wrote:
>>>>> On Oct 24, 2007, at 9:48 PM, J. Bruce Fields wrote:
>>>>>
>>>>>>> I want git pull to work like git push.
>>>>>> That strikes me as a less complete solution, since it only helps in 
>>>>>> the
>>>>>> case where the other branches all happen to be unmodified locally 
>>>>>> (hence
>>>>>> can be fast-forwarded).  In other cases the "git push" will still emit 
>>>>>> a
>>>>>> spurious error.
>>>>> Well, but then there's something you should really think
>>>>> about.
>>>> Perhaps, but not necessarily; you may have some branches with local
>>>> changes that you're content to leave unpushed (and un-updated).
>>> Sure, but that won't change. The only thing I'm proposing is that
>>> local copies of remote branches are automatically fast-forwarded
>>> on every pull, but only if
>>>
>>> * the branch has no modifications what so ever
>>> * the branch is set up to auto-merge with the particular branch
>>> fetched from the particular remote
>>>
>>> I really don't see any downsides what so ever with this. Those
>>> of you who do, please enlighten me.
>>>
>> You can't check what got added in your pull, e.g you can't review the new
>> code with something like
>> 	gitk next..origin/next
>
> That's what git-fetch is for.
>

If I run git pull <remote> and have a auto-merge setup, I would merge the
remote side into my local branch. Then doing

	gitk ORIG_HEAD..

does the trick for to review what got added _and_ merged into my local
branch. I can't use this for other local branches not checked out. And as
I normally want to merge, your suggested behaviour is fine with me *IFF*
it is configurable _per_ branch.

>> I often do something like this, just to see what got changed. So at least
>> in my opinion you have to add a third point:
>>   * the branch has no modifications what so ever
>>   * the branch is set up to auto-merge with the particular branch
>>     fetched from the particular remote
>> 				AND
>>   * the user set a config option to always autofastfoward if the above
>>     conditions are true! This could be implemented as a global option with
>>     a per branch overwrite.
>
> I'd be fine with that, except I think it's fairly dangerous to have
> different defaults. The two first points are sort of the core of the
> case I've been arguing all along.
>

I aggree. And thats why I think your autofastforward should be set to
"false" per default, so that the distinction between local and remote
branches would still be clearly defined. Changing this would confuse new
users a lot more, me thinks.

But having the option for power users sounds fine!

>> Only if this option is added so a user can mark a branch to never
>> autofastforward (but it is still possible to  have an auto-merge config) 
>> you won't
>> loose valuable information.
>
> Sure. I was thinking something along these lines:
>
> [branch "foo"]
> 	remote = bar
> 	merge = some-branch
> 	autofastforward = false
>

Thats exactlcy what I had in mind. Maybe and a

[core]
	global_autofastforward = true

so you could have a sane default for every branch which is missing the
autofastforward statement. (or make it per [remote "foo"] ?)

> Or use git-fetch. git-pull is "fetch + merge". Conceptually, I don't
> think it'll be any problem what so ever telling anyone that the branches
> that aren't currently checked out get merged automatically only if they
> result in a fast-forward.
>

I'm not so sure about that.

-Peter
