From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 00:17:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807210012480.3305@eeepc-johanness>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com> <1216490252.10694.58.camel@koto.keithp.com> <1216491512.3911.9.camel@pc7.dolda2000.com> <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness> <7v63r0bejy.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807202035090.3305@eeepc-johanness> <7vhcak5o6n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhE9-0002K0-P7
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYGTWRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYGTWRA
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:17:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:37331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752421AbYGTWQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:16:59 -0400
Received: (qmail invoked by alias); 20 Jul 2008 22:16:58 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp019) with SMTP; 21 Jul 2008 00:16:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182XbkCgUw2KYRbMRkyAIUz/gPaxUxEYcKUnCT/yX
	CInjBUcbNqfMh7
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vhcak5o6n.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89246>

Hi,

On Sun, 20 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > How about this instead?
> >
> > -- snipsnap --
> > diff --git a/connect.c b/connect.c
> > index 574f42f..7e7f4d3 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -603,7 +603,8 @@ struct child_process *git_connect(int fd[2], const char *url
> >  
> >  		*arg++ = ssh;
> >  		if (port) {
> > -			*arg++ = "-p";
> > +			const char *opt = getenv("GIT_SSH_PORT_OPTION");
> > +			*arg++ = opt ? opt : "-p";
> >  			*arg++ = port;
> >  		}
> >  		*arg++ = host;
> 
> If you only care only about the ones we currently want to support, I do
> not htink it makes any difference either way, but if we are shooting for
> having a minimum-but-reasonable framework to make it easy to support other
> ones that we haven't seen, it feels very much like an inadequate hack to
> waste an envirnoment variable for such a narrow special case.  With this,
> what you really mean is "Plink uses -P instead of -p", right?

Yeah.  My first attempt was to allow "GIT_SSH='plink.exe -P %p %h'" to 
work, and for that matter, "git config --global transport.ssh 'plink.exe 
-P %p %h'", but I decided that it would be easier to do the patch I 
posted.

Anyway, I think that this issue wasted enough of my time, as I will never 
use plink anyway.  As long as the patch does not have an adverse effect on 
my use case, which happens to be the default case, I will just not bother 
anymore, even if I think that GIT_SSH=wrapper would be better than special 
case rarely exercized ssh programs in the source code.

Ciao,
Dscho
