From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Tue, 21 Oct 2008 11:17:30 -0400
Message-ID: <48FDF28A.9060606@xiplink.com>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 17:19:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsJ0V-0005AN-Ie
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 17:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbYJUPRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 11:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbYJUPRh
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 11:17:37 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:47617 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYJUPRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 11:17:37 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id C7B401C712E;
	Tue, 21 Oct 2008 11:17:35 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 5C3D21C6758;
	Tue, 21 Oct 2008 11:17:35 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <48FDA5A0.8030506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98790>

Michael J Gruber wrote:
>
>> clone/$ git config remote.origin.fetch \
>>          '+refs/remotes/ThingOne/*:refs/remotes/ThingOne/*'
> 
> If you want to fetch main's local branches also, use option "--add" here
> so that you don't override the default fetch refspec (forgot last time,
> sorry).

Okay, got it.

> I thought you wanted to avoid pulling directly from ThingOne to clone?

Ah, I see (part of) our disconnect here -- sorry for not explaining it
clearly before!

Yes, indeed, I do want to pull directly from ThingOne into the clone.

The scenario is that there's a bunch of us sharing the main repo, and
when some upstream changes happen in ThingOne I'd like for one of us to
be able to clone the main repo, pull the changes from ThingOne into the 
clone (fixing any conflicts; remember that we have our own changes in 
ThingOne's code), then push the merged changes back to main for everyone 
else to grab.

> If you pull directly you might as well set up the same remote config as
> on main: for the correct pull line you need to know the same info as for
> the correct remote config.

Yes, I see that -- it's why I'm basically satisfied with being able to do

	clone/$ git pull -s subtree /path/to/ThingOne master

from the clone, and all I'm doing now is kvetching about having to 
remember the location and branch of ThingOne when that was already 
configured in main (and thanks for being patient with my kvetching!).

> git fetch
> git merge -s subtree remotes/ThingOne/master
> 
> should do the trick.

AFAICT that only refers to the clone's local branch for the ThingOne 
repo.  The above git-config command doesn't add the ThingOne repo's URL 
to the clone, so I'm still stuck having to use that URL directly to pull 
changes from ThingOne into the clone.  (And when I use the URL directly, 
I have to use a branch name that's defined in the ThingOne repo.  I'd 
like to also be able to use whatever branch name got set up in main when 
"git remote add" was run.)

> If that works you can set up things so that pulling
> from origin (pulling when you're in your integration branch) does that
> merge automatically, using branch.integrationbranch.remote=origin,
> branch.integrationbranch.merge=remotes/ThingOne/master (untested ;) ).
> 
> To be clear: The idea here is that main decides which ThingOne branch to
> store in remotes/ThingOne/master and where to get it from; clones always
> pull that one.

I think that "where to get it from" part is what I'm going on about. 
There doesn't seem to be a way for the main repo to tell the clone where 
the ThingOne repo is, so that the clone can pull in ThingOne changes 
directly.

>> I just feel that there are some 
>> situations where you want the origin's remotes in your clone, and some 
>> where you don't, and git should let you decide.
> 
> Well, it let's you decide: It tracks local branches by default, and
> using additional "git config" you can track remotes as well. You can
> also use the "--mirror" option to "git clone" or "git remote add", but
> that has other side effects.

I think we're mis-communicating, mainly because I'm not yet able to 
express things well in git-speak.  Let me give it another stab...

I believe git lets you track the origin's _branches_ not the origin's 
_remotes_.  I don't think --mirror does what I'm looking for, because 
(side effects aside) it only deals with branches, not remotes.

I find myself getting confused, and I think it's because the files in 
.git/refs/remotes/ are indeed tracking branches on remote repositories. 
  So I think our conversation gets a bit circular because our ideas of a 
"remote" differ.

"git remote add" does two things (maybe more?): It adds a [remote] 
section to the .git/config file, and it adds a branch reference in 
.git/refs/remotes/.  I think what I'd like is for the clone to be able 
to obtain both these things from the origin.  The reason I think it's 
useful is that it would let the clone pull directly from the origin's 
remote repositories, without having to directly specify the remote 
repository's URL and branch name.

Fundamentally, I'm looking to do exactly

	clone/$ git pull -s subtree /path/to/ThingOne master

i.e. pull stuff from one of main's remotes directly into the clone.  But 
I want to replace the "/path/to/ThingOne master" part with something 
that means "use whatever URL and branch name was defined in the origin 
for this remote".

My questions are:  Am I right in thinking this is desirable?  Is there 
already some way to do this?  If not, is it something worth 
implementing?  (I'm happy to roll up my own sleeves here...)

I hope that clarifies things.  Sorry for taking so long to get here!

		Marc
