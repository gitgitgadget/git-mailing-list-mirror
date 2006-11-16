X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 20:14:11 -0500
Message-ID: <20061116011411.GB10512@thunk.org>
References: <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 03:47:12 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31554>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkYDL-0006VM-Sr for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031092AbWKPDqy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031093AbWKPDqy
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:46:54 -0500
Received: from THUNK.ORG ([69.25.196.29]:5076 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1031092AbWKPDqx (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:46:53 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1GkYGP-0005ca-61; Wed, 15 Nov 2006 22:50:10 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GkVpT-00060C-Cw; Wed, 15 Nov 2006
 20:14:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 10:03:18AM -0800, Linus Torvalds wrote:
> So the reason for using "git pull" is
> 
>  - bk did it that way, and like it or not, bk was the first usable 
>    distributed system. hg is totally uninteresting.

Yes, "bk pull" had an implied merge.  But, the reason why bk pull was
never really a problem with Bitkeeper is because it didn't really have
support for multiple branches active within the same repository ---
what Larry called "lines of development".  Or rather, Larry started
down the path of implementing lines of development, and then never
fully supported it, mainly because making it easy for people to use
was the tricky part.   

So with Bitkeeper, with "bk pull" there was never any question about
which branch ("line of development") you would be merging into after
doing a "bk pull", since there was only one LOD, and given that BK had
the rule that a within a LOD only one tip was allowed, a "bk pull"
_had_ to do do a merge operation.   

The moment you start supporting multiple unmerged tips in a repository
i.e., branches, it raises the question, "which branch should the pull
operation merge onto"?  And git's answer, "the current branch", is
often not the right one.  *That's* why always doing a merge isn't
always the right answer, and so in the git world, people are told, use
"git fetch" instead, and in the hg world, "hg pull" doesn't do the
merge.  IMO, it's a fundamental result of the fact that both git and
hg have chosen to support mulitple LOD's, whereas BK punted on the
concept.

If you are operating on your local development branch, the reality is
that merging is probably not the right answer in the general case,
which is why the hg world have omitted doing the merge.  And by
telling people, use "git fetch" instead, that's also an implicit
admission that merging onto the current branch is often not the Right
Thing.

The problem is that "pull" is a very evocative word, especially given
the existence "push", and so in the git world we are reduced to
telling people, "you really don't want to use pull, trust me".  

Is this a major issue?  Not really; I can think of a number of other
issues that make git hard to learn, and why hg has a more gentle
learning curve, and the "don't use pull" is probably a relatively
minor annoyance in the grand scheme of things.

If people are looking for a simple way out, maybe it would be enough
to have an option where if "git pull" is called from an interactive
terminal, and the "novice user" option is enabled, "git pull" returns
a warning message, "You probably want to use 'git fetch' instead; are
you sure?"  If people are saying that we shouldn't be teaching "git
pull" until fairly late in the game, maybe we should have a way of
discouraging novices from using, simply because they they are used to
seeing "pull" from other distributed SCM's.

