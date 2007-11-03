From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add missing inside_work_tree setting in setup_git_directory_gently
Date: Sat, 3 Nov 2007 12:16:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031211520.4362@racer.site>
References: <20071103100323.GA25305@laptop>  <Pine.LNX.4.64.0711031138150.4362@racer.site>
 <fcaeb9bf0711030457se2f5f5bpd9aa463e878cd621@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-193754112-1194092190=:4362"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHwc-0005k6-Gp
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbXKCMR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbXKCMR1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:17:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:39337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753420AbXKCMR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:17:26 -0400
Received: (qmail invoked by alias); 03 Nov 2007 12:17:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp002) with SMTP; 03 Nov 2007 13:17:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u4q4veEjuSjF362Vtepznn4vwpYZkht3K6SfPTv
	y/cx0aVj9Q/BNy
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711030457se2f5f5bpd9aa463e878cd621@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63250>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-193754112-1194092190=:4362
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 3 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On 11/3/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sat, 3 Nov 2007, Nguyễn Thái Ngọc Duy wrote:
> >
> > > Without this, work_tree handling code in setup_git_directory will be 
> > > activated. If you stay in root work tree (no prefix), it does not 
> > > harm. It does if you work from a subdirectory though.
> > >
> > > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > > ---
> > >  Turns out my patch on NEED_WORK_TREE is fixing a wrong place.
> > >
> > >  setup.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/setup.c b/setup.c
> > > index 145eca5..6f8f769 100644
> > > --- a/setup.c
> > > +++ b/setup.c
> > > @@ -240,6 +240,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
> > >                       if (chdir(work_tree_env) < 0)
> > >                               die ("Could not chdir to %s", work_tree_env);
> > >                       strcat(buffer, "/");
> > > +                     inside_work_tree = 1;
> >
> > I really have to wonder why this is needed, as it should be deduced
> > (correctly!) when you ask is_inside_work_tree().
> 
> Because setup_git_directory() does not? From what I see,
> setup_git_directory() calls setup_git_directory_gently() then check
> for inside_work_tree variable almost immediately
> (check_repository_format() does not seem to ask
> is_inside_work_tree()).

Ah, I see the problem.

>From your commit message I assumed that you fixed the wrong spot... Which 
you did not.  It would have helped me if the message had read:

	When both GIT_DIR and GIT_WORK_TREE are set, and 
	setup_git_directory_gently() changes the current working 
	directory accordingly, it should also set inside_work_tree = 1.

Your fix is the proper one, but it not only fixes setup_git_directory(), 
but all callers of setup_git_directory_gently().

Thanks,
Dscho

--8323584-193754112-1194092190=:4362--
