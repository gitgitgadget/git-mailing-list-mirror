From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 23:47:54 +0200
Message-ID: <20070522214754.GD30871@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 23:48:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcD4-0002Pl-OA
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbXEVVr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbXEVVr6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:47:58 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:18497 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbXEVVr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:47:58 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (mrclete mo2) (RZmta 6.5)
	with ESMTP id M042cbj4MJnVS9 ; Tue, 22 May 2007 23:47:55 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 20508277BD;
	Tue, 22 May 2007 23:47:55 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id EA4F1D195; Tue, 22 May 2007 23:47:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48118>

Junio C Hamano, Tue, May 22, 2007 01:02:42 +0200:
> >
> > So here it is. On top of the previos patch regarding chdir before
> > exec. Junio, if needed, I can resend that first patch about chdir.
> 
> Both of them in a row would be good, so yes, resend is
> appreciated.

Will be resent.

> > @@ -76,6 +76,10 @@ int start_command(struct child_process *cmd)
> >  		if (cmd->dir && chdir(cmd->dir))
> >  			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
> >  			    cmd->dir, strerror(errno));
> > +		if (cmd->env) {
> > +			for (; *cmd->env; cmd->env++)
> > +				putenv((char*)*cmd->env);
> > +		}
> >  		if (cmd->git_cmd) {
> >  			execv_git_cmd(cmd->argv);
> >  		} else {
> 
> I had a feeling that some callers needed to be able to unsetenv
> some.  How would this patch help them, or are they outside of
> the scope?
> 

Others already discussed the issue. Just to be sure, I reimplemented
that comfortable putenv with unsetenv: if an environment entry ends
with a "=" it will be unset.
