From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git annoyances
Date: Thu, 10 Apr 2008 10:08:08 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804091830590.19665@iabervon.org>
References: <20080409101428.GA2637@elte.hu> <alpine.LNX.1.00.0804091442190.19665@iabervon.org> <20080409204149.GC18968@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 10 16:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjxSV-0003Ck-8X
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 16:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619AbYDJOIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 10:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755985AbYDJOIL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 10:08:11 -0400
Received: from iabervon.org ([66.92.72.58]:51542 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589AbYDJOIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 10:08:10 -0400
Received: (qmail 3032 invoked by uid 1000); 10 Apr 2008 14:08:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Apr 2008 14:08:08 -0000
In-Reply-To: <20080409204149.GC18968@elte.hu>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79214>

On Wed, 9 Apr 2008, Ingo Molnar wrote:

> 
> * Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> > > also, the first natural thing i did was to just type:
> > > 
> > >  $ git-merge ~/linux-2.6-x86.git/
> > > 
> > > which i naively assumed would sort things out for me and provide 
> > > some reasonable default behavior - but instead it just gave an 
> > > annoyingly unhelpful error message:
> > > 
> > >  /home/mingo/linux-2.6-x86.git/ - not something we can merge
> > > 
> > > there should really be a consciously established "route of failure 
> > > resolution" - directing people towards relevant sources of 
> > > information or commands when the git command-line utilities return 
> > > some error due to user incompetence. Otherwise users just guess 
> > > around and get frustrated.
> > 
> > I'm not sure we can figure out what the user actually meant in this 
> > case; there's just too much overlap in namespaces to determine 
> > reliably that you were giving it a remote repository on the local 
> > filesystem rather than anything else.
> 
> well, current git got to /home/mingo/linux-2.6-x86.git/ which is a local 
> path. (it is printing it in the error message above) So i think it was 
> rather unambiguous what i meant and Git knew about it, right?

Actually, your shell did that. I don't think git can tell that the user 
typed something different and the shell converted it because it's a local 
path.

> but even if it _was_ ambiguous, i think tools should generally default 
> to a minimal amount of hassle for new users and should try to pick 
> reasonable "action" versus any "inaction". (as long as the behavior is 
> still deterministic and reasonable even to the long-time user)

It's hard to evaluate proposals for extending cases from inaction to some 
action because in trying to keep it deterministic, you have to decide 
whether future, possibly more compelling, extensions might want to overlap 
the space of commands. It's more conservative to have the command suggest 
some things the user might have meant, even if that's sometimes a list of 
one, so that the user doesn't come to rely on behavior that is only 
deterministic within a vaguely-delineated area.

> but more importantly, i think this whole problem area has to be handled 
> with a slightly different kind of mindset than other, more technical 
> aspects of Git.
> 
> Humans, and in particular males, when they see or learn new things, are 
> very emotion-driven. The first 1-2 minutes (often just the first few 
> seconds) have a very strong influence on whether that person 'likes' a 
> new topic, tool or gizmo he is checking out - or not. Males often think 
> of themselves as being objective when shopping new items - while in 
> reality more than 90% of their purchasing decisions are emotion-driven 
> and it's all set and done in the first 10 seconds of visual contact. 
> (this ration is far higher than for females)
> 
> Command-line tools like Git are at heavy natural disadvantage compared 
> to say GUI tools because the "first impression" is so minimalistic and 
> relatively unremarkable. A GUI can get people hooked by making the first 
> 10% look easy just via old-fashioned, dishonest visual deception.
> 
> so basically for 90% of the new users, we've got 2-3 shots or we lose 
> their "sympathy". Starting with an error message is bad. Being 
> uninformative about what happened is bad. Making the user wait without 
> signalling why he is waiting is bad. Etc. etc. I think this experience 
> of mine was a reasonable simulation of a first-time user reaction (by 
> virtue of me having forgotten certain Git details).

I think that it's far enough along before a user types "git merge ..." 
that we've got a chance to give a suggestive error message instead of just 
doing something, particularly if the thing we might do might be wrong and 
either annoying to clean up or slow. (OTOH, "git clone ..." had better 
work, and I think it does)

And I agree strongly with the need for the error messages in the cases 
where the user was closer to be clear and suggest the right thing.

> So i really think that maintaining this aspect of Git and in essence 
> Huffman-optimizing the interface and the learning curve for first-time 
> Git users is perhaps the most important thing. Especially since some 
> users like me will often re-learn Git details that they use rarely.

On the other hand, there's a conflict between having git do what the user 
seems to want it to do and having git's commands delineated by concepts 
that users need to know, such that users will be assisted in learning 
those concepts (and therefore have an easier time getting the results they 
expect from git consistantly). For example, "merge" works on information 
you have within the repository, and "fetch" brings information into the 
repository. In some cases, we could guess that the user has typed "merge" 
but wants to bring information into the repository, but we won't always be 
right, and we want the user to learn how to tell git unambiguous things.

> Getting these details right is _extremely hard_, because the people who 
> are capable of fixing these details have long forgotten the first-time 
> annoyances they had! (if they had any - often developers are 
> statistically lucky and never hit any pitfalls.)
> 
> It's doubly hard because Git developers work on Git exactly because they 
> _like_ it, so one's own positive experience has to be contrasted to the 
> prospect of negative first-time experience.
> 
> It's triple hard because it might also mean changing some things that 
> have been done in Git since the start of the project. A negative 
> experience that isnt some technical problem in the strict sense - it's 
> an emotional thing that is much harder to define and much harder to 
> agree on and improve.
> 
> So i think it's really hard mentally - and i'm positively surprised by 
> the many constructive and positive reactions that my mail generated.
> 
> Improving this area is perhaps even harder than adding new functionality 
> - but i think it's a key and extremely strategic aspect of Git, because 
> it affects the very heart of the Git project: it maximizes the influx of 
> new users (who also include future Git developers btw.) and minimizes 
> outflux of existing users.

I think the market segment that most git developers would really like to 
get is the projects that they work on aside from git. There's a 
substantial itch to make git sufficiently compelling that nobody would 
make them use CVS/SVN/Perforce/ClearCase/etc. This has a significant 
usability-to-new-users component, and so there's more attention to that 
than in projects where use of the project doesn't require getting 
particular other people to use it.

	-Daniel
*This .sig left intentionally blank*
