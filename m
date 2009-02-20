From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 1/2] git-gui: handle non-standard worktree locations
Date: Fri, 20 Feb 2009 01:44:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902200137390.10279@pacific.mpi-cbg.de>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>  <1235006145-16760-2-git-send-email-giuseppe.bilotta@gmail.com>  <alpine.DEB.1.00.0902190307390.10279@pacific.mpi-cbg.de>
 <cb7bb73a0902191621x4e7a66bcj427095906e5a4078@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJVQ-0002r0-NH
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbZBTAnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbZBTAnL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:43:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:35204 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751194AbZBTAnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:43:10 -0500
Received: (qmail invoked by alias); 20 Feb 2009 00:43:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 20 Feb 2009 01:43:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mWUl+K1JmEdMU/LiOYQjUk/AIlWf7XRm4KxFJkT
	DWO3jqc4luh4Mk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cb7bb73a0902191621x4e7a66bcj427095906e5a4078@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110775>

Hi,

On Fri, 20 Feb 2009, Giuseppe Bilotta wrote:

> Since there is NO practical reason NOT to support these unusual 
> configurations, and since the changes do NOT break standard usage, your 
> personal dislike for abnormal worktree configurations is scarcely a 
> meaning obstacle to patch inclusion.

It is not a personal dislike.  It is based on experience.

> (And please excuse the attitude, but yours is absolutely the worst
> I've ever seen on this mailing list, and yes it has been abundantly
> discussed.(

And what exactly did you want to achieve with that comment?

Really... *sighs with a tired, crooked smile*

> >> +# _gitdir exists, so try loading the config
> >> +load_config 0
> >> +apply_config
> >> +# try to set work tree from environment, falling back to core.worktree
> >> +if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
> >> +     set _gitworktree [get_config core.worktree]
> >> +}
> >>  if {$_prefix ne {}} {
> >> -     regsub -all {[^/]+/} $_prefix ../ cdup
> >> +     if {$_gitworktree eq {}} {
> >> +             regsub -all {[^/]+/} $_prefix ../ cdup
> >> +     } else {
> >> +             set cdup $_gitworktree
> >> +     }
> >
> > It appears as if you redo a the logic laid out in setup.c.  Don't.
> > Instead, teach rev-parse to output the path of the work tree.
> >
> > Oh, wait, --show-cdup already shows that...
> 
> As spearce itself remarked while reviewing the first round of this
> patchset, git-gui is currently backwards compatible as far as git
> 1.5.0. Introducing new features in future versions of git rev-parse is
> not going to help here anyway. (Also, I have no idea if this
> --show-cdup worked in 1.5.0 or not, I just took the existing code and
> adapted it to the possibility of gitworktree being already defined.)

Well, I actually looked.  Not really far, just 1.4.0.  It has --show-cdup.  
It does not have worktree.

> >> @@ -1076,11 +1089,15 @@ if {$_prefix ne {}} {
> >>               error_popup [strcat [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
> >>               exit 1
> >>       }
> >> -     if {[catch {cd [file dirname $_gitdir]} err]} {
> >> +     if {$_gitworktree eq {}} {
> >> +             set _gitworktree [file dirname $_gitdir]
> >> +     }
> >
> > This is certainly wrong in bare repositories.
> 
> It's also totally irrelevant and not less wrong than what the previous
> code did, since it used [file dirname $_gitdir] all across the code to
> do what I do with $_gitworktree now.
> 
> So the current code is correct in all the ways the old code was, plus
> in quite a few more ways where the previous code was wrong. And
> although there might be a couple of cases that the new approach
> doesn't fix, I'd rather prefer you pointed out which cases they where,
> how could they fail, and what possible ways you can suggest to work
> around them.

It would not take all that much effort to address my comment in terms 
of code.

Ciao,
Dscho
