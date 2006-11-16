X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 06:12:40 +0100
Message-ID: <20061116051240.GV7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 05:12:56 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31560>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkZYN-0000Gt-2V for gcvg-git@gmane.org; Thu, 16 Nov
 2006 06:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031002AbWKPFMn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 00:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031004AbWKPFMn
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 00:12:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7359 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031002AbWKPFMm (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 00:12:42 -0500
Received: (qmail 18524 invoked by uid 2001); 16 Nov 2006 06:12:40 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, Nov 14, 2006 at 11:36:19PM CET, Junio C Hamano wrote:
> Commenting on the messages in this thread:
> 
>  - "resolve / resolved" are both confusing, when you are talking
>    about "mark-resolved" operation.

Well that's what "resolved" is saying. But speaking of which, it took me
_weeks_ of regular (though not extensive) usage to train my fingers to
write "stg resolved" and not "stg resolve".

>  - "pull/push/fetch" have undesired confusion depending on where
>    people learned the term.  I'd perhaps vote for replacing
>    fetch with download and push with upload.

It's too long. :-(

I think if some people have a real problem with something it's "pull",
not push or fetch. Without "pull" name, there's no confusion about
merging or not merging; and without it, there's also no confusion about
"push" and the fetch/push duality. I'm not saying that this is enough an
argument to ditch pull from Git at this point.

>  - I think it would be sensible to make remote tracking branches
>    less visible.  For example:
> 
> 	git diff origin
> 
>    where origin is the shorthand for your upstream (e.g. you
>    have .git/remotes/origin that records the URL and the branch
>    you are tracking) should be easier to understand than
> 
>    	git diff remotes/origin/HEAD
> 
>    The latter is an implementation detail.

Hmm, wait. I didn't start using refs/remotes/ yet for obvious reasons,
but wasn't it generally agreed when implementing them that what you
wrote above would work? (That a ref not found in refs/{heads,tags}/ is
looked up in remotes and if it's a directory, /HEAD is appended.) So it
doesn't for some reason?

>    I could imagine we might even want to allow
> 
> 	git diff origin#next
> 
>    to name the branch of the remote repository.  The notion of
>    "where the tips of remote repository's branches are" is
>    probably be updated by "git download" (in other words, the
>    above "git diff" does not automatically initiate network
>    transfer).

Yes, that little syntax extension would be cute to have.

> Of course, it could even be "cg" ;-).

So, here is an arbitrary list of random reasons why cg commands are not
part of git yet:

(i) Naming issues. Example: "pull" vs. "update".

(ii) Namespace issues. Big selling point of Cogito is that it's
_simple_. A very important part of that is that your command set is
limited, so that even someone who wants to fully grok Cogito is not
overwhelmed and has just few commands in front of him. I think we're
doing pretty good here, and I very carefully weight adding another
command to the set (I'm actually pondering removing some now). The
similar applies to actual commands' usage, though certainly not so
heavily; and there are few warts here.

But overally, I think this point is pretty much unsolvable and this is
where I actually think the main "incompatibleness" of Cogito and Git
with its free mix of high- and mid- and low- level commands lies. I
don't think the thread provided any solution to this either.

(ii) Behaviour issues. Example: Cogito tries to deal with uncommitted
local changes in your repository when doing stuff. It didn't shine at it
before recent improvements (post-v0.18), but it tried to preserve your
local uncommitted changes during various operations (merging,
fast-forwarding, switching branches, seeking, ...). I think historically
Git's stance to this was negative (it'd rather block the operation), I'm
not sure what the current situation is, though.

(iii) Output format issues. Example: "status" in Git and Cogito
has a completely different format in both. I'm a die-hard fan of
Cogito's format but there're surely die-hard fans of Git's.

(iv) Control issues. I'm reluctant to give up a final word on how the UI
looks like, mostly for the reason of enforcing (ii) and proper
documentation. But this is not a blocker point.

(v) Library issues. Cogito has a pretty neat shell library which it
prices; but that could be carried around. Also, Cogito requires
/bin/bash, but mostly for performance reasons (using builtins instead of
forking for external commands at some points); Git has the advantage of
simply putting that part in C, which is though something I should've
been doing more frequently too.

(vi) Coding issues. This is probably very subjective, but a blocker for
me. I have no issues about C here, but about the shell part of Git.
Well, how to say it... It's just fundamentally incompatible with me. I
*could* do things in/with it, but it's certainly something I wouldn't
_enjoy_ doing _at all_, on a deep level. I think the current shell code
is really hard to read, the ancient constructs are frequently strange at
best, etc. It's surely fine code at functional level and there'll be
people who hate _my_ style of coding and my shell code which isn't
perfect either, but it's just how it is with me.


Now, it would be absolutely awesome if we could start to bridge at least
some of these points, shuffle some functionality around and overally
reduce the code duplication, increase features count and improve general
level of world happiness.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
