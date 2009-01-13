From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git diff --stat" doesn't show added empty file
Date: Tue, 13 Jan 2009 12:27:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901131223010.3586@pacific.mpi-cbg.de>
References: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com> <alpine.DEB.1.00.0901121319210.3586@pacific.mpi-cbg.de> <496B64BA.7000408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 12:28:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMhR8-0003pv-Bw
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 12:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZAML0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 06:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZAML0e
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 06:26:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:59396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752788AbZAML0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 06:26:34 -0500
Received: (qmail invoked by alias); 13 Jan 2009 11:26:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 13 Jan 2009 12:26:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jM7NOZxNj/96PfbJq3rWPymor6ukgJm4nDKvPso
	AYMnIK5N1Gmllj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496B64BA.7000408@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105487>

Hi,

On Mon, 12 Jan 2009, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 01/12/09 13:19:
> 
> > On Mon, 12 Jan 2009, Ping Yin wrote:
> > 
> >> $ git --version
> >> git version 1.6.1.9.g97c34
> >> $ mkdir test && cd test && git init && git commit --allow-empty -m
> >> "Initial commit"
> >> $ touch .gitignore && git add .gitignore && git commit -m "Add empty .gitignore"
> >> $ git diff --stat HEAD^..
> >>  0 files changed, 0 insertions(+), 0 deletions(-)
> >>
> >> May be the following is better?
> >>
> >>  .gitignore |    0 +
> >>  1 files changed, 0 insertions(+), 0 deletions(-)
> > 
> > Have fun coding that.
> 
> Removing 5 lines from diff.c does the job,

I can only think that you mean these lines:

                else if (!data->files[i]->is_renamed &&
                         (added + deleted == 0)) {
                        total_files--;
                        continue;
                }

However, they are also present in the initial stat code in d75f7952:

                } else if (added + deleted == 0) {
                        total_files--;
                        continue;
                }

Now, the fun part is finding out why this code is there.  Are there 
unintended side effects?  If so, are they still there?  Or was it 
introduced due to an explicit request back then?  Was it just sloppy?

Removing the 5 lines is not all you have to do, by _far_.

Lots of fun,
Dscho
