From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 5 Jan 2010 11:07:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001051102530.4985@pacific.mpi-cbg.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 11:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS6GO-0003YM-1q
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 11:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab0AEKC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 05:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277Ab0AEKC0
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 05:02:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:35981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752205Ab0AEKC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 05:02:26 -0500
Received: (qmail invoked by alias); 05 Jan 2010 10:02:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 05 Jan 2010 11:02:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IFf0vz29ICQt38QWaMy+vhF9Prl3tsJK8VOqBQd
	cXvTBhZgOy/EYV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vi428w0.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136182>

Hi,

On Tue, 5 Jan 2010, Junio C Hamano wrote:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> > Am 04.01.2010 23:29, schrieb Johannes Schindelin:
> > ...
> >> - among other use cases, submodules are recommended for sharing 
> >>   content between two different repositories. But it is part of the 
> >>   design that it is _very_ easy to forget to commit, or push the 
> >>   changes in the submodule that are required for the integrity of the 
> >>   superproject.
> >
> > Definitely (and if i got that right, svn externals have the same 
> > problem).
> >
> > What about checking for every submodule before a push in the 
> > superproject that its HEAD is on a remote branch? I don't think we can 
> > provide full safety here, but we could handle the 99% case of a 
> > forgotten push in the submodule. This could even be done with a rather 
> > simple hook (if we had a pre-push hook that is :-).
> 
> You don't need "pre-push" hook, if the eventual goal is to integrate this
> into "git push" proper; it can notice submodule directories, descending
> into them, check if the remote lacks the necessary commit and invoke "git
> push" via run_command() interface as needed.

That is obvious, _iff_ we make the necessary changes in core Git.  Jens' 
point was that you can do it with hooks, too.

> >> - related are the use cases where it is desired not to have a fixed 
> >>   submodule tip committed to the superproject, but always to update 
> >>   to the current, say, master (like Subversion's externals).  This 
> >>   use case has been wished away by the people who implemented 
> >>   submodules in Git.  But reality has this nasty habit of ignoring 
> >>   your wishes, does it not?
> >
> > Having read up about svn externals in the meantime, what about 
> > something like this:
> > - Add a command like "git submodule forward" (as update is already in 
> >   use) that takes an optional -b <branchname>. It does a fetch in the 
> >   submodule, then tries to fast forward (or rebase) to master or the 
> >   branch given and stages this commit in the superproject. This should 
> >   be the equivalent to doing an "svn update" in a repo with externals.  
> >   Or am i missing something?  (And we could avoid the detached HEAD in 
> >   the fast forward case by really checking out the branch in the 
> >   submodule)
> > - We could also add an option to "git submodule add" to specify the 
> >   default branch name for forward.
> 
> Instead of recording a specific submodule commit in the superproject, we
> could record a branch name (this would need a separate "gitlink" type of
> object we toyed around during the early days of submodule design) to say
> "the tip of the branch".

Yes, and it would be as limited (but in a different way) as the current 
gitlink.

You might argue that "gitlink" in its current form has not raised too many 
complaints.  But that is only because next to nobody uses submodules 
unless forced to.

> But there is a difference between a distributed system and a centralized 
> one like Subversion.  When you say "tip of the branch", you have to say 
> "which repository".  If your position is that _any_ repository will do 
> as long as the commit is at the tip of the named branch, that is like 
> saying you don't care what commit it really is, as you are free to muck 
> with branch heads in your copy of submodule repository, by adding 
> commits, or resetting new ones away.  For that matter, your 'master' 
> branch in the submodule repository may not build-on/fork-from the 
> 'master' branch in the upstream of it, so even "tip of the branch by 
> _this name_" is still fuzzy.
> 
> I am not saying "any commit will do" is necessarily a bad position to 
> take.  But people who claim they want to say "this branch" need to 
> realize what they are really saying: whatever you record in the 
> superproject commit is immaterial.  In other words, "this superproject 
> will work no matter which version of submodule is checked out at its 
> location".
> 
> Thatv actually is a very valid thing to say in some situations (Dscho
> mentioned different versions of artwork checked out as a submodule in a
> developer's superproject to build an app).  Interestingly enough, some
> people seem to think that we place too much importance on not having to
> check out submodules, but it indeed is a very natural extention of "any
> commit will do".  If the configuration you chose for your build does not
> depend on any files from there, it will truly be "any commit will do",
> including "nothing checked out there is just fine".

Come on Junio, do not insult my intelligence.

You know all too well about scenarios where a superproject tracks a 
3rd-party project which the superproject's developers do not contribute 
to.

"nothing checked out there is just fine".  Pfff.  That's ridiculous.  
You'll have to try much harder than that.

Ciao,
Johannes
