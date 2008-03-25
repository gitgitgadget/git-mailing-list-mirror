From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] init: show "Reinit" message even in an (existing) empty
 repository
Date: Tue, 25 Mar 2008 10:55:19 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803251052310.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site>
 <alpine.OSX.1.00.0803231428220.13789@cougar> <20080323235610.GB25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803240101220.4353@racer.site> <20080324002302.GD25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803241155300.4353@racer.site> <20080324122153.GF25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241611200.4353@racer.site> <alpine.LSU.1.00.0803241613480.4353@racer.site> <7viqzbmf2h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je5sx-0002AS-Sw
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 10:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbYCYJzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 05:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYCYJzW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 05:55:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:42419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751821AbYCYJzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 05:55:22 -0400
Received: (qmail invoked by alias); 25 Mar 2008 09:55:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp052) with SMTP; 25 Mar 2008 10:55:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19akJgnh0laFEIwvPu8vUDw6yBOqmZ9JCvFNOuuDf
	d0u1saj7wEKvME
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7viqzbmf2h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78166>

Hi,

On Tue, 25 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/builtin-init-db.c b/builtin-init-db.c
> > index 1975910..ceb4727 100644
> > --- a/builtin-init-db.c
> > +++ b/builtin-init-db.c
> > @@ -168,10 +168,9 @@ static int create_default_files(const char *git_dir, const char *template_path)
> >  {
> >  	unsigned len = strlen(git_dir);
> >  	static char path[PATH_MAX];
> > -	unsigned char sha1[20];
> >  	struct stat st1;
> >  	char repo_version_string[10];
> > 	int reinit;
> 
> Here I saw a hand-edit, but that is less of a problem...

Heh, yes.  I originally set reinit = 0, and thought I was clever by patch 
editing.  But I have less experience with that than necessary, and then, I 
am not as clever as I thought, either... ;-)

> >  	int filemode;
> >  
> >  	if (len > sizeof(path)-50)
> > @@ -220,7 +219,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
> >  	 * branch, if it does not exist yet.
> >  	 */
> >  	strcpy(path + len, "HEAD");
> > -	reinit = !read_ref("HEAD", sha1);
> > +	reinit = !access(path, R_OK);
> 
> If this is a HEAD (or .git/HEAD) that is a dangling symlink (we do still
> support them, don't we?) wouldn't this access fail?

Right.  I already saw your commit, and while I would have to think hard if 
it is implementing the correct logic (what does access() do with a 
dangling symlink? Is || correct?), I just trust you.

Although I have to admit that having the authorship of this commit is 
giving me more credit than I deserve.

Thanks,
Dscho
