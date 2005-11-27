From: Junio C Hamano <junkio@cox.net>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Sat, 26 Nov 2005 16:38:30 -0800
Message-ID: <7vpsomorg9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<Pine.LNX.4.63.0511202039340.23586@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051126235011.GA22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Nov 27 02:43:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgBYT-0001hQ-DG
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 02:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVK0Blx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 20:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVK0Blx
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 20:41:53 -0500
Received: from main.gmane.org ([80.91.229.2]:26502 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750807AbVK0Blx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 20:41:53 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EgBX6-0000KF-L4
	for git@vger.kernel.org; Sun, 27 Nov 2005 02:40:48 +0100
Received: from ip68-4-9-127.oc.oc.cox.net ([68.4.9.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Nov 2005 02:40:48 +0100
Received: from junkio by ip68-4-9-127.oc.oc.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Nov 2005 02:40:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-4-9-127.oc.oc.cox.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:XG13ryzlAOT962GgmrdDXRnMwpY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12793>

Petr Baudis <pasky@suse.cz> writes:

>> But my thinking went like this: if Pasky and Junio can not agree on one 
>> location and format, and therefore none of the two is deprecated, how 
>> about giving them a way out they both might be able to agree to?
>
> Now, those are just different concepts. Cogito's "branch" concept maps
> single local head to a single remote head, 1:1. GIT's "remote" concept
> maps (possibly not well-defined) bunch of local heads to a remote
> repository (where they have same or different name) or a piece of it...

I agree.  They are simply different things and serve different
audiences.

When you are asked to pull from somebody else (and when you are
playing an integrator role, not an individual developer role,
you will be asked to pull from different people) you may not
want to immediately pull into your master branch.  I usually
either do "git checkout -b throwaway master" and pull into it,
or run "git fetch remote master:throwaway" followed by "git diff
master throwaway" to see what I'll be getting.  When you set up
one "remotes" file is when you realize that you are pulling this
way from the same place number of times, to reduce future
typing.  So as Pasky says, it is exactly "macro" and not "per
branch configuration".  It is just "per remote shorthand".

Cogito "branch" matches very naturally to what an individual
developer might want to do.  You have one branch that you use to
do your work tracking one upstream.  You can of course have more
than one upstream and branch, but the most typical usage would
be traditional CVS style setup to get updates from the central
location (described in branches/* file), fetch and merge from
there and push your changes back.  It is very well designed to
support this pattern of usage.

It may not make much sense for an integrator-role person to have
branches/master file to configure his "master" branch that
points at the URL of only one of his subsystem maintainers.  An
integrator-role person does not need "per branch" configuration
in that sense.  On the other hand "remotes" may help if the
integrator-role person regularly pulls from the same set of
subsystem maintainers.

Of course, an individual developer can set up a single remotes
file that describes the single upstream, fetching
"master:origin" and merging into his "master"; what "remotes"
file used that way does not give us, unlike "branch" of Cogito,
is that it does not say on which local branch that fetching and
merging happens.
