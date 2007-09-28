From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Merge non-first refs that match first refspec
Date: Fri, 28 Sep 2007 17:38:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709281728310.5926@iabervon.org>
References: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
 <20070928041509.GU3099@spearce.org> <Pine.LNX.4.64.0709280026240.5926@iabervon.org>
 <7vve9vp1zw.fsf@gitster.siamese.dyndns.org> <7vps02o55q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 23:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbNXj-0005VD-Bd
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 23:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbXI1Vic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbXI1Vic
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 17:38:32 -0400
Received: from iabervon.org ([66.92.72.58]:44031 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbXI1Vib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 17:38:31 -0400
Received: (qmail 12123 invoked by uid 1000); 28 Sep 2007 21:38:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 21:38:28 -0000
In-Reply-To: <7vps02o55q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59422>

On Fri, 28 Sep 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> >
> >> Beats me; Junio, what's your test case?
> >
> > I can paste tomorrow (it is a clone of git.git at work).  I do
> > not use .git/config but .git/remotes/origin and explicit four
> > separate Pull: lines and going over http.
> 
> Here are the files.  Note that I use traditional layout and
> always have 'master' checked out when I initiate 'git pull'.
> 
> : xyzzy git.git/master; cat .git/config
> [core]
> 	logallrefupdates = true
> 
> [diff]
> 	color = auto
> 
> [showbranch]
> 	default = --topo-order
> 	default = master
> 	default = next
> 	default = pu
> 
> [alias]
> 	co = checkout
> : xyzzy git.git/master; cat .git/remotes origin
> URL: http://repo.or.cz/r/alt-git.git/
> Pull: master:origin
> Pull: next:next
> Pull: +pu:pu
> Pull: maint:maint
> Pull: todo:todo

The strcmp fails because the config uses an abbreviation and the server 
doesn't. Forget my first attempt, and try replacing the strcmp on line 105 
with "!remote->fetch[0].pattern", which is what we're really checking, 
anyway.

(If this is the first refspec we're on, and we don't have a per-branch 
config, and we got a match, and the refspec isn't a pattern, merge it; 
anything that matches according to get_fetch_map is a satisfactory match, 
even if it doesn't look quite the same.)

I'll do up an actual patch after dinner if nobody beats me to it.

	-Daniel
*This .sig left intentionally blank*
