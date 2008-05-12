From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Verilog/ASIC development support is insufficient in git ,
 help!
Date: Mon, 12 May 2008 19:09:07 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805121733530.19665@iabervon.org>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop> <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, justin0927@hotmail.com
To: Justin Leung <jleung@redback.com>
X-From: git-owner@vger.kernel.org Tue May 13 01:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvh9u-0006Uf-Mi
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 01:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYELXJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 19:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYELXJM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 19:09:12 -0400
Received: from iabervon.org ([66.92.72.58]:47705 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbYELXJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 19:09:10 -0400
Received: (qmail 1496 invoked by uid 1000); 12 May 2008 23:09:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2008 23:09:07 -0000
In-Reply-To: <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81963>

On Sat, 10 May 2008, Justin Leung wrote:

> Hi all,
> 
> * This email probably represent the whole hardware ASIC community about git *
> 
> I'm evaluating Git as the replacement of CVS for the ASIC group in my company,
> but things are moving along very bumpy.
> 
> I (and many others doing the evaluation) love the tool dearly; we love the
> local repository and inter-db sync'ing .
> I see a lot of potential in productivity and changes in work model that helps
> efficiency in ASIC dev.
> 
> BUT, my managers, some veterans, and directors are EXTREMELY concerned about
> the ease-of-use..
> so much that they are going to pick SVN !  uh-oh....i m serious =(
> 
> Alot of people argued, why not SVN ? it's CVS++ and it's ease of use not a
> problem when comparing to Git.

As far as I can tell, wherever SVN is more powerful than CVS, it is 
complicated to use. I think that, if all you want if to rename files and 
directories, you could use SVN. Otherwise, the way SVN implements advanced 
features is more confusing than git.

> here are the things not fitting right in ASIC dev:
> 
> - no incremental revision numbers (they are so scared of the 40hex SHA1)

This is pretty much forced by being able to trade changes without going 
through the central repo combined with the desire to have stable 
identifiers. If I can get from you a version after the fifth version in 
the central repo and before the sixth version there, what number is the 
revision I got?

On the other hand, we should be able to make the sequence of latest 
commits on the central site be marked with numbers in increasing order. 
This is slightly different from a linear order (there will be commits 
without numbers, for example, if a developer does a series of commits and 
then sends in a batch, or does some commits and a merge; only the ends of 
these sets get numbers).

> - Inability to reference without SHA1, they want simple numbering (ie, version
> 100, 120, 120.1, 130.4.5)

Whenever you have an important state, you can tag it with a number. Not 
everything gets numbered that way, but the other things aren't so 
interesting for people working at that level anyway.

> - Inability to refer to a file by a simple number
> (the backend guys will be confused by SHA1; they can't work with anything more
> than 4-5 digits)

I think you'd only want to send the backend guys commits that you'd tag 
with version numbers.

> - Complexity of commands (although we can have warpper, but real git commands
> for non-sw guys is not going to happen)
>
> Most hardware chip designers were using CVS since their first job.
> It suited the purpose very well.
> 
> Most RTL design veterans only use less then 5-6 cvs commands in their whole
> life (LOL, i m serious) :
> 
> $ cvs checkout
> $ cvs update
> $ cvs log
> $ cvs diff (tkdiff)
> $ cvs status
> $ cvs commit

$ git clone / git checkout
$ git pull
$ git log
$ git diff
$ git status
$ git commit -a
$ git push

The main training is:

 - type "git" instead of "cvs"
 - to get a new working directory, you use "clone" (but to revert a 
   working directory file to the committed state, you still use 
   "checkout")
 - "update" is "pull"
 - use "-a" with "commit", unless you're committing only a limited set of 
   paths
 - after "commit", check whether what you did was right, and then do "git 
   push" to publish your changes

> We don't use branches.
> Our model is strict forward with a centralized, one main branch model to avoid
> mistakes .

There are multiple things that branches do.

 - The first is that, whenever you have different revisions in different 
   places, they're always different branches in some sense. That is, 
   there's a "latest state of the project" as checked into the central 
   server, but also a yet-newer state that's each person's working 
   directory contents, and often a trailing state that's the central 
   server state as of the last time the person updated. Each of these is 
   tracked even in CVS, but in CVS they're implicit and qualitatively 
   different, while in git they're explicit and mostly stored the same 
   way.

 - The second is that there can be multiple lines of development in the 
   central location, such that there's a latest checked-in-and-published 
   state for each that's different. This is explicit in CVS, and doesn't 
   work very well, and is also available in git and is much nicer. But, in 
   either case, you don't need to use it. (In fact, git's own development 
   barely uses it, and only for bugfixes to older versions while the 
   current version is under development; aside from that, all of the 
   branches in git development are of other types.)

 - In git, in addition to having a "last seen state of mainline" branch, 
   you can have "last seen states" of other developers' working 
   directories. And you can have branches as ways of putting changes out 
   for other developers to get without the main branch getting them. For 
   example, Junio's "next" branch is all essentially previews of stuff he 
   might commit to the mainline. This is fundamentally just a unified 
   tracking mechanism for the ability to do developer-to-developer 
   transfers of state. This doesn't need to be any more (or less) visible 
   to project managers than the contents of people's CVS working 
   directories are (that is, it'll let them know how close the developers 
   are to having a version they can get into the mainline).

 - in git, you can use branches to work on multiple different changes 
   without having multiple working directories. This is, again, a private 
   matter for the developer, and entirely optional.

> We see branches as evil ; some merges in Verilog codes means another 10+ hours
> of simulation and regression.

Well, you'd also have the same 10+ hours in order to retest your changes 
after a "cvs update" if somebody else commits while you're working on 
something. A merge in the git sense is essentially the same thing, except 
that you can have multiple committed states on the local side, and it 
understands if the same change reaches the mainline by multiple routes 
because people exchanged work directly.

On ther other hand, you can use "git rebase" and it works almost exactly 
like "cvs update" except that you've saved the changes that are from your 
local working directory so that, if you mess up resolving conflicts, you 
can abort and try again.

> I'm a verification engineers for the hardware chips designers, there we use
> Vera and SystemVerilog which requires much in
> depth use of SCM functions.  So, the choice of tools is much more important on
> our side (the designers only checkin and out, diff, and minimal merging)
>
> I m frustrated about the situration, i truly want Git in ASIC world !!!
> (yell out loud... no p4, no svn, no clearcase... or i rather keep cvs)
> 
> Is there a way to specify the use of a simple GIT model in config, or like,
> info/attribute,
> such that (in git main repository model of course) :
> 
> (1) SHA1s are hidden, but replaced by simple numbers
> (2) Simple, incremental numbers (like 'git-5432' ; what we use 'git-describe'
> to generate)
> (3) Reference of simple revision numbers in all git commands and tools like
> gitk, not SHA1

If you have a post-update hook on the central repo that makes a tag of the 
form "r<number>", with <number> counting up, that'll pretty much do it. 
But there will be other commits that don't get tagged because they were 
already historical when they reached the central server. But people 
generally don't have to care about those unless they're already interested 
in doing something complicated.

	-Daniel
*This .sig left intentionally blank*
