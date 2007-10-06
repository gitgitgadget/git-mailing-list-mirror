From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning
	after svn dcommit
Date: Sat, 6 Oct 2007 10:15:52 +0200
Message-ID: <20071006081552.GF4797@xp.machine.xx>
References: <20071005001528.GA13029@midwinter.com> <20071005082110.GA4797@xp.machine.xx> <47066255.6080500@midwinter.com> <20071005164912.GE4797@xp.machine.xx> <470678ED.8050407@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 10:16:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ie4pO-000094-Ke
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 10:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbXJFIPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 04:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXJFIPu
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 04:15:50 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:38780 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752642AbXJFIPt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2007 04:15:49 -0400
Received: (qmail 29617 invoked by uid 0); 6 Oct 2007 08:15:47 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 6 Oct 2007 08:15:47 -0000
Content-Disposition: inline
In-Reply-To: <470678ED.8050407@midwinter.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60140>

On Fri, Oct 05, 2007 at 10:48:29AM -0700, Steven Grimm wrote:
> Peter Baumann wrote:
>> That's new to me. Glancing over git-commit.sh, I could only find a
>> 'git-gc --auto', but no prune. I am not against doing a 'git gc --auto',
>> but I am against the --prune, because this could make shared
>> repositories unfunctional.
>>   
>
> Does anyone run "git svn dcommit" from a shared repository? That is the 
> only command that will trigger this code path.
>
> Given that you lose all the svn metadata if you do "git clone" (or "git 
> clone -s") on a git-svn-managed repository, it's not clear to me that 
> anyone would ever be bitten by this. Counterexamples welcome, of course.
>
> How would you feel about a separate config option to specifically enable 
> auto-pruning, and having "git svn clone" set that option by default? 
> Presumably anyone who is setting up a shared git-svn repository will be up 
> to the task of disabling the option.
>

Sorry, I looked at 'git commit' (as you said in your mail) and not
'git-svn dcommit'. Looking now at git-svn, I could see the there is only
done a git-repack if the user *explicitly* asked for it on the cmdline
specifying --repack. For this repack run, the default parameter includes
-d and no --prune, so I do not think that we are doing a --prune run if
we where not _explicitly_ asked for it. As I said, I am totaly fine with
doing a 'git-gc --auto', but I am a little worried about the --prune.

We advertise everywhere that GIT adds only new content/objects/data to the
repository and *never* deletes anything itself in the repo and now you
want to do a --prune, wich obviously *does* delete data behind the users
back in a dcommit/fetch operation, which no one would think of that these
commands do have anything in common with deleting data. And this worries me.

-Peter
