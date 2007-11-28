From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Wed, 28 Nov 2007 17:18:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281717460.27959@racer.site>
References: <20071128165837.GA5903@laptop>  <Pine.LNX.4.64.0711281703470.27959@racer.site>
 <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:19:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQZ3-0001PX-8i
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760910AbXK1RSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 12:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760733AbXK1RSq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:18:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:46059 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752723AbXK1RSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:18:44 -0500
Received: (qmail invoked by alias); 28 Nov 2007 17:18:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 28 Nov 2007 18:18:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8dA9O+RS8pFU3G7RPFbvG+hlkYt8XQqxkFbX3yr
	OvWqFVNBQ4cm9M
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66389>

Hi,

On Thu, 29 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Nov 29, 2007 12:05 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 28 Nov 2007, Nguyen Thai Ngoc Duy wrote:
> >
> > > @@ -246,8 +246,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
> > >                       static char buffer[1024 + 1];
> > >                       const char *retval;
> > >
> > > -                     if (!work_tree_env)
> > > -                             return set_work_tree(gitdirenv);
> > > +                     if (!work_tree_env) {
> > > +                             retval = set_work_tree(gitdirenv);
> > > +                             /* config may override worktree */
> > > +                             check_repository_format();
> > > +                             return retval;
> > > +                     }
> > > +                     check_repository_format();
> >
> > Why not move this check before the if?  Other than that, ACK.
> 
> If so it would be called twice if work_tree_env is not set.

Well, I would have left the original

			if (!work_tree_env)
				return set_work_tree(gitdirenv);

alone...

If that is not possible, it might be good to add a comment as to why.

Ciao,
Dscho
