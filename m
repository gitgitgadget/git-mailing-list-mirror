From: david@lang.hm
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 13:17:46 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810151314110.7808@asgard.lang.hm>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm> <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0810151240220.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151247560.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCp3-0003AV-5y
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbYJOURH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbYJOURG
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:17:06 -0400
Received: from mail.lang.hm ([64.81.33.126]:38365 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410AbYJOURF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 16:17:05 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9FKH1h2006941;
	Wed, 15 Oct 2008 13:17:01 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.2.00.0810151247560.3288@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98316>

On Wed, 15 Oct 2008, Linus Torvalds wrote:

> On Wed, 15 Oct 2008, david@lang.hm wrote:
>>
>> I see it fairly frequently when switching between different branches of a
>> project.
>
> So, at least for any normal switch, assuming file 'a' doesn't exist in the
> other branch, you really should have a few different cases:
>
> - you have a dirty file, and git should say something like
>
> 	error: You have local changes to 'file'; cannot switch branches.
>
>   because it refuses to modify the file to match the other branch (which
>   includes removing it) if it doesn't match the index.
>
>   So this case shouldn't leave anything behind.
>
> - You have that extra file, but it's not in the index.
>
>   If it's in your current HEAD, we should still notice it with something
>   like:
>
> 	error: Untracked working tree file 'tree' would be removed by merge.
>
>   because now it's untracked (not in the index), but the switching
>   between branches tries to essentially "apply" the difference between
>   your current HEAD and the new branch, and finds that the difference
>   involves removing a file that git isn't tracking.

one place that I know I've run into it frequently is in an internal 
project that I did not properly setup .gitignore and did "git add ." and 
"git commit -a" to. that projects repository contains the compiled 
binaries and I frequently get these errors when switching trees.

that sounds like the first case.

I've seen discussion of a new sequencer functionality, would it allow me 
to define a .gitignore file and re-create the repository as if that file 
had existed all along?

David Lang

> See?
>
> HOWEVER.
>
> If you're used to doing "git checkout -f" or "git reset --hard", both of
> those checks are just ignored. After all, you asked for a forced switch.
>
> And at least in the second case, what I think happens is that git won't
> remove the file it doesn't know about, so you'll have a "turd" left
> around.
>
> So yes, you can certainly get these kinds of left-overs, but they really
> should be only happening if you "force" something. Do you do that often?
>
> 			Linus
>
