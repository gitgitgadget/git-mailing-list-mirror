From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git annoyances
Date: Wed, 9 Apr 2008 22:41:49 +0200
Message-ID: <20080409204149.GC18968@elte.hu>
References: <20080409101428.GA2637@elte.hu> <alpine.LNX.1.00.0804091442190.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjh86-0004Xv-TO
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbYDIUmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbYDIUmF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:42:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40189 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbYDIUmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:42:04 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1Jjh79-0006ll-LH
	from <mingo@elte.hu>; Wed, 09 Apr 2008 22:42:01 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 1F5FE3E21D8; Wed,  9 Apr 2008 22:41:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0804091442190.19665@iabervon.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79135>


* Daniel Barkalow <barkalow@iabervon.org> wrote:

> > also, the first natural thing i did was to just type:
> > 
> >  $ git-merge ~/linux-2.6-x86.git/
> > 
> > which i naively assumed would sort things out for me and provide 
> > some reasonable default behavior - but instead it just gave an 
> > annoyingly unhelpful error message:
> > 
> >  /home/mingo/linux-2.6-x86.git/ - not something we can merge
> > 
> > there should really be a consciously established "route of failure 
> > resolution" - directing people towards relevant sources of 
> > information or commands when the git command-line utilities return 
> > some error due to user incompetence. Otherwise users just guess 
> > around and get frustrated.
> 
> I'm not sure we can figure out what the user actually meant in this 
> case; there's just too much overlap in namespaces to determine 
> reliably that you were giving it a remote repository on the local 
> filesystem rather than anything else.

well, current git got to /home/mingo/linux-2.6-x86.git/ which is a local 
path. (it is printing it in the error message above) So i think it was 
rather unambiguous what i meant and Git knew about it, right?

but even if it _was_ ambiguous, i think tools should generally default 
to a minimal amount of hassle for new users and should try to pick 
reasonable "action" versus any "inaction". (as long as the behavior is 
still deterministic and reasonable even to the long-time user)

but more importantly, i think this whole problem area has to be handled 
with a slightly different kind of mindset than other, more technical 
aspects of Git.

Humans, and in particular males, when they see or learn new things, are 
very emotion-driven. The first 1-2 minutes (often just the first few 
seconds) have a very strong influence on whether that person 'likes' a 
new topic, tool or gizmo he is checking out - or not. Males often think 
of themselves as being objective when shopping new items - while in 
reality more than 90% of their purchasing decisions are emotion-driven 
and it's all set and done in the first 10 seconds of visual contact. 
(this ration is far higher than for females)

Command-line tools like Git are at heavy natural disadvantage compared 
to say GUI tools because the "first impression" is so minimalistic and 
relatively unremarkable. A GUI can get people hooked by making the first 
10% look easy just via old-fashioned, dishonest visual deception.

so basically for 90% of the new users, we've got 2-3 shots or we lose 
their "sympathy". Starting with an error message is bad. Being 
uninformative about what happened is bad. Making the user wait without 
signalling why he is waiting is bad. Etc. etc. I think this experience 
of mine was a reasonable simulation of a first-time user reaction (by 
virtue of me having forgotten certain Git details).

And the moment a negative first-time impression has settled in it's very 
hard to overcome that emotional mindset and barrier. People might still 
think "Git is quirky" even if we do all things perfectly from that point 
on. The same holds for the other direction: a positive first-time 
impression is harder to destroy, even if it turns out to be not that 
simple later on.

A tool's reaction back to first-time users is like a decision tree: 
every negative reaction, every error message, every unreasonable wait, 
every uninformative output is a way for the user to exit our ecosystem 
and to never discover the true strengths of Git.

So i really think that maintaining this aspect of Git and in essence 
Huffman-optimizing the interface and the learning curve for first-time 
Git users is perhaps the most important thing. Especially since some 
users like me will often re-learn Git details that they use rarely.

Getting these details right is _extremely hard_, because the people who 
are capable of fixing these details have long forgotten the first-time 
annoyances they had! (if they had any - often developers are 
statistically lucky and never hit any pitfalls.)

It's doubly hard because Git developers work on Git exactly because they 
_like_ it, so one's own positive experience has to be contrasted to the 
prospect of negative first-time experience.

It's triple hard because it might also mean changing some things that 
have been done in Git since the start of the project. A negative 
experience that isnt some technical problem in the strict sense - it's 
an emotional thing that is much harder to define and much harder to 
agree on and improve.

So i think it's really hard mentally - and i'm positively surprised by 
the many constructive and positive reactions that my mail generated.

Improving this area is perhaps even harder than adding new functionality 
- but i think it's a key and extremely strategic aspect of Git, because 
it affects the very heart of the Git project: it maximizes the influx of 
new users (who also include future Git developers btw.) and minimizes 
outflux of existing users.

	Ingo
