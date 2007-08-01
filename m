From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Add functions get_relative_cwd() and is_inside_dir()
Date: Wed, 1 Aug 2007 12:38:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011218420.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site> <Pine.LNX.4.64.0708010129090.14781@racer.site>
 <7vy7gvdgtn.fsf@assigned-by-dhcp.cox.net> <7vwswfbywq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 13:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGCY4-0007RJ-Tp
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 13:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758952AbXHALjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 07:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758864AbXHALjY
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 07:39:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:33811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758693AbXHALjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 07:39:23 -0400
Received: (qmail invoked by alias); 01 Aug 2007 11:39:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 01 Aug 2007 13:39:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/x7jgoUdXxVp4CtNHXFShCohwBsza8h/rStWJ/sX
	Rokh8XpadRwl7k
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwswfbywq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54429>

Hi,

On Tue, 31 Jul 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> The function get_relative_cwd() works just as getcwd(), only that it
> >> takes an absolute path as additional parameter, returning the prefix
> >> of the current working directory relative to the given path.  If the
> >> cwd is no subdirectory of the given path, it returns NULL.
> >> ...
> >> +/*
> >> + * get_relative_cwd() gets the prefix of the current working directory
> >> + * relative to 'dir'.  If we are not inside 'dir', it returns NULL.
> >> + * As a convenience, it also returns NULL if 'dir' is already NULL.
> >> + */
> >> +char *get_relative_cwd(char *buffer, int size, const char *dir)
> >> +{
> >> +	char *cwd = buffer;
> >> +
> >> +	if (!dir || !getcwd(buffer, size))
> >> +		return NULL;
> >
> > When is it not a fatal error if get_relative_cwd() is called
> > with a NULL dir parameter, or getcwd() fails?
> >
> > If there is no valid such cases, I would rather have this
> > die(), former with "BUG" and the latter with strerror(errno).
> 
> Heh, it turns out that there is this lazy or clever (depending
> on the viewpoint) caller that passes the return value of
> get_git_work_tree() to this function and expect this to return
> NULL when no work tree is found.

Right.  I thought I had said that (something along the lines: it is more 
convenient not having to check the directory), but I probably did not.

> The callers of the is_* functions are much cleaner and in that sense the 
> series is a definite improvement, but this one particular obscurity 
> makes me wonder if it is replacing one unholy mess with a smaller but 
> still unholy mess.
> 
> Will apply on "master" and will be part of -rc4, but we probably would 
> want to have a longer pre-final freeze than usual to really make sure 
> this one is good.

I'll provide a patch which makes the callers of get_relative_cwd() holy, 
and skip the check in get_relative_cwd(), okay?

Ciao,
Dscho
