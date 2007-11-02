From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Mention that git-branch -M can cause problems for tracking branches
Date: Fri, 2 Nov 2007 23:04:11 +0100
Message-ID: <20071102220411.GA13666@diku.dk>
References: <20071102091734.GC10141@diku.dk> <7vlk9g1k1q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 23:04:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io4d0-0000X2-Ey
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 23:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759629AbXKBWES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 18:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759418AbXKBWER
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:04:17 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:54022 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758989AbXKBWEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:04:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 0FADB19BD39;
	Fri,  2 Nov 2007 23:04:15 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02420-20; Fri,  2 Nov 2007 23:04:12 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 0622319BD47;
	Fri,  2 Nov 2007 23:04:12 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8658A6DFE7E; Fri,  2 Nov 2007 23:03:59 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id E36B95B8001; Fri,  2 Nov 2007 23:04:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vlk9g1k1q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63181>

Junio C Hamano <gitster@pobox.com> wrote Fri, Nov 02, 2007:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > ---
> >  Documentation/git-branch.txt |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> >  I made a patch to discard the overwritten branch's configuration
> >  section, which Spearce felt was too lossy a behaviour. However, since
> >  it confused me, I think it should at least be mentioned in the manpage.
> >  Maybe the warning message from git should also be added to improve its
> >  "googlability".
> >
> > diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> > index 5e81aa4..def4e85 100644
> > --- a/Documentation/git-branch.txt
> > +++ b/Documentation/git-branch.txt
> > @@ -165,6 +165,11 @@ If you are creating a branch that you want to immediately checkout, it's
> >  easier to use the git checkout command with its `-b` option to create
> >  a branch and check it out with a single command.
> >  
> > +When a branch is renamed so that it overwrites an existing branch unintended
> > +problems can arise. This is because git refuses to discard the configuration
> > +section of the overwritten branch. As a result git can become confused if, for
> > +example, the branches involved were used for tracking two different remote
> > +branches. The only way to fix this is to edit the configuration file manually.
> 
> I do not understand this bit about "refuse".
> 
>  - To "refuse to discard", somebody has to ask to discard ---
>    who asks so and when?

IMO, the user asks when using git-branch -M. And in case it is not clear
the problem arises for the command sequence:

	$ git branch --track o-next origin/next
	$ git branch --track m-next madcoder/next
	$ git branch -M o-next m-next
	$ git remote
	Warning: more than one branch.m-next.remote
	...

>  - Is there a reason to "refuse" when such a removal request is
>    made?  If so, what is it?  If not, why refusal?

Personally, I don't see why we need to refuse, since git-branch -M is
somewhat similar to saying -m (rename) plus adding a "force" flag
meaning: "yes, I know that this will potentially throw away settings for
an already existing branch".

The main reason to "refuse" the removal is that for the general case,
e.g. when using `git-config --rename-section`, this can potentially lead
to loss of valuable config settings. This was pointed out by Shawn in
his reply to my patch[0]. I agreed to this in my follow-up and asked if
it would be acceptable to add an additional flag to so that git-branch
can switch on this request for removal.

[0] http://thread.gmane.org/gmane.comp.version-control.git/61291

-- 
Jonas Fonseca
