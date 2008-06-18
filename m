From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: cvs2git with  modules?
Date: Wed, 18 Jun 2008 15:24:37 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302389ACB@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794302389AC6@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Kelly F. Hickel" <kfh@mqsoftware.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K94Dn-0000am-Fo
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 22:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbYFRUYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 16:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbYFRUYk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 16:24:40 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:41869 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbYFRUYj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 16:24:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302389AC6@emailmn.mqsoftware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cvs2git with  modules?
Thread-Index: AcjQkTtiSN6+/yO9TTuO2nov+zYP9wA7LorwAADCcCA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85410>



> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Michael Haggerty
> Sent: Tuesday, June 17, 2008 10:45 AM
> To: Kelly F. Hickel
> Cc: git@vger.kernel.org
> Subject: Re: cvs2git with modules?
> 
> [I see you sent essentially the same question to both the git and the
> cvs2svn mailing lists.  I am replying on the git list with bcc to the
> cvs2svn list.  Followups please to git@vger.kernel.org.]
> 
> Kelly F. Hickel wrote:
> > I'm trying to use cvs2svn in cvs2git mode to convert a repo with a
> > number of modules.  Can anyone tell me how to keep that module
> > structure in the new git repo? So, if in cvs there are two modules,
> > ModA and ModB, I want to see those two as top level directories in
> the
> > git repo.
> >
> > I've tried putting adding the projects in my options file as below,
> > but it puts the files ModA/* and ModB/* at the top level in the git
> repo.
> >
> > run_options.add_project(
> >     r'/home/foo/cvsrepo/ModA,
> >     trunk_path=ModA',
> >     [...]
> >     )
> >
> > run_options.add_project(
> >     r'/home/foo/cvsrepo/ModB,
> >     trunk_path=ModB',
> >     [...]
> >     )
> 
> I assume that what you mean is that the CVS repository contains
> directories like ModA/a, ModA/b, ModB/c, and ModB/d, but the resulting
> git repository has only /a, /b, /c, and /d.  That is because cvs2git
> completely ignores the trunk_path argument to add_project().
> 
> It is strange that the code allows you to add multiple projects,
> considering that the cvs2git documentation[1] states that cvs2git only
> supports converting single projects at a time.  I guess I forgot to
> build that check in.
> 
> You can get the result you want by treating ModA and ModB not as two
> separate projects, but simply as two separate subdirectories within a
> bigger project; i.e.,
> 
> run_options.add_project(
>     r'/home/foo/cvsrepo,
>     [...]
>     )
> 
> .  This is assuming that ModA and ModB are the only subdirectories
> within /home/foo/cvsrepo/; otherwise, make a copy of your CVS repo and
> remove the other subdirectories from the copy before the conversion.
> 
> Please note that when cvs2git is run this way, it treats tags and
> branches as being global.  If you tagged your projects simultaneously,
> then this is probably what you want.  But if you tagged your projects
> separately, then tag names that happen to be the same across projects
> will be considered the same.
> 
> It would be possible to add cvs2git support for multiproject
> conversions, but I was under the impression that it doesn't make much
> sense to put multiple projects into a single git repository.  But I'm
a
> novice git user, so I could very well be wrong about that.
> 
> Michael
> 

Thanks Michael, this looks like what I want, I'll give it a try, but it
takes a week to do our import.

As far as making sense, it depends on whether you think of them as
projects or cvs modules.  Our projects are made up of multiple cvs
modules, for various reasons, so it makes sense for us.

-Kelly
