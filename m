From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: name-rev --stdin is slow
Date: Thu, 19 Jun 2008 19:00:31 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806191849540.19665@iabervon.org>
References: <485ACB34.2020901@gmail.com> <alpine.LNX.1.00.0806191755510.19665@iabervon.org> <485AD90E.6000309@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9T8C-0001Fd-GS
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbYFSXAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbYFSXAd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:00:33 -0400
Received: from iabervon.org ([66.92.72.58]:36348 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbYFSXAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:00:32 -0400
Received: (qmail 15954 invoked by uid 1000); 19 Jun 2008 23:00:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 23:00:31 -0000
In-Reply-To: <485AD90E.6000309@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85558>

On Fri, 20 Jun 2008, Lea Wiemann wrote:

> Daniel Barkalow wrote:
> > Actually, I think it's the reverse: without --stdin, name-rev can do a first
> > pass that lets it eliminate a lot of data from consideration; with --stdin,
> > it doesn't know if an item it hasn't seen is going to need some data, and so
> > it's conservative and doesn't eliminate anything,
> 
> Are you sure that's the case?  time git-name-rev --stdin < /dev/null gives the
> same high startup time without looking up anything.

Ah, okay. There's a startup pass that goes through all of the refs (tags 
in particular), and does stuff with them, but only if they aren't filtered 
out.

> Anyways, it would be great if someone could try to fix that, since a 6-second
> startup time on a repository like linux-2.6 makes the --stdin option unusable
> for applications like gitweb (for which it would actually be quite useful to
> reduce the number of forks).

It might be possible to collect all of the input, set up the filter, and 
do the (now cheaper) initial pass, but I don't think that would offer any 
real advantage over just collecting them in the caller and calling 
name-rev with a long command line.

	-Daniel
*This .sig left intentionally blank*
