From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git push bug?
Date: Sat, 20 Oct 2007 13:52:05 +0200
Message-ID: <001601c8130f$a3174eb0$5267a8c0@Jocke>
References: <5513C211-DE33-411C-8EE6-2259B41DC3EA@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Steffen Prohaska'" <prohaska@zib.de>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 14:17:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjDD4-00014O-R4
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 14:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbXJTLwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 07:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbXJTLwU
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:52:20 -0400
Received: from mail.transmode.se ([83.241.175.147]:56516 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753154AbXJTLwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 07:52:19 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 20 Oct 2007 13:52:09 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <5513C211-DE33-411C-8EE6-2259B41DC3EA@zib.de>
Thread-Index: AcgS8zLgGKSgzl6aSzqwU10EZYr4iQAGzsUw
X-OriginalArrivalTime: 20 Oct 2007 11:52:09.0682 (UTC) FILETIME=[A52F0B20:01C8130F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61825>

 

> -----Original Message-----
> From: Steffen Prohaska [mailto:prohaska@zib.de] 
> Sent: den 20 oktober 2007 10:30
> To: Johannes Schindelin
> Cc: Joakim Tjernlund; git
> Subject: Re: git push bug?
> 
> 
> On Oct 18, 2007, at 11:58 PM, Johannes Schindelin wrote:
> 
> >
> > On Thu, 18 Oct 2007, Steffen Prohaska wrote:
> >
> >> On Oct 18, 2007, at 6:21 PM, Johannes Schindelin wrote:
> >>
> >>> On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> >>>
> >>>> Seems like it is a bit too easy to make mistakes here. 
> Why can I  
> >>>> delete
> >>>> a branch with :linus but not create one with linus:linus?
> >>>
> >>> I wonder why you bother with the colon at all.  Just
> >>>
> >>> 	git push <remote> linus
> >>>
> >>> and be done with it.  The colon is only there to play 
> interesting  
> >>> games,
> >>> not something as simple as "push this branch" or "push this tag".
> >>
> >> But you need a full refspec starting with 'refs/heads/' if you  
> >> want to
> >> create a new branch on the remote side.
> >
> > No.  Not if the name is the same on the local side.
> 
> You're right. The documentation of git-send-pack says what you're
> saying:
> 
> '''
> When one or more <ref> are specified explicitly, it can be either a  
> single pattern, or a pair of such pattern separated by a colon  
> ":" (this means that a ref name cannot have a colon in it). A single  
> pattern <name> is just a shorthand for <name>:<name>
> '''
> 
> Here it says that <name> is a shorthand for <name>:<name>.
> An later it states
> 
> '''
> If <dst> does not match any remote ref, either
>     * it has to start with "refs/"; <dst> is used as the destination  
> literally in this case.
>     * <src> == <dst> and the ref that matched the <src> must not  
> exist in the set of remote refs; the ref matched <src> locally is  
> used as the name of the destination.
> '''
> 
> If <src> == <dst> then <dst> will be created even if it didn't exist.
> 
> I think the current implementation though is a bit different.
> It will created a new branch for a colon-less refspec, that is
> 
>     git push origin work/topic
> 
> will create a new ref on the remote. But
> 
>     git push origin work/topic:work/topic
> 
> will _not_.
> 
> 
> Until you corrected me, I believed that new branches will never
> be created on the remote side unless a full ref is used. That is
> I expected that only
> 
>     git push origin refs/heads/work/topic
> 
> would work.
> 
> I thought this would be another safety net -- kind of a reminder
> not to push the wrong branch by accident.
> 
> I still like the idea, but apparently git didn't ever support what
> I thought it would.
> 
> Maybe adding some command line flags making the different tasks
> explicit could help:
> 
>      git push --create origin work/new-topic
>      git push --delete origin work/old-topic
>      git push --non-standard origin refs/funny/ref

This makes much more sense than the current method, thanks.

 Jocke
