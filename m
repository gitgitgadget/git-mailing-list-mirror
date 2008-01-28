From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Mon, 28 Jan 2008 11:59:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281159150.23907@racer.site>
References: <20080128003404.GA18276@lintop> <1201480650-19716-1-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org, j.sixt@viscovery.net
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJSfM-0002mh-BJ
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 13:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbYA1MAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 07:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbYA1MAM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 07:00:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:58739 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750976AbYA1MAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 07:00:10 -0500
Received: (qmail invoked by alias); 28 Jan 2008 12:00:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 28 Jan 2008 13:00:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198Kppk/DB8Popnqgh3TT+4yFIzK4Cyx1dTLnc238
	ca2N5ah8LKY+ou
X-X-Sender: gene099@racer.site
In-Reply-To: <1201480650-19716-1-git-send-email-shawn.bohrer@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71880>

Hi,

On Sun, 27 Jan 2008, Shawn Bohrer wrote:

> In "struct exclude_stack", prep_exclude() and excluded(), the
> convention for a path is to express the length of directory part
> including the trailing slash (e.g. "foo" and "bar/baz" will get
> baselen=0 and baselen=4 respectively).
> 
> The variable current and parameter baselen follow that
> convention in the codepath the following patch touches.
> 
>                 else {
>                         cp = strchr(base + current + 1, '/');
>                         if (!cp)
>                                 die("oops in prep_exclude");
>                         cp++;
>                 }
>                 stk->prev = dir->exclude_stack;
>                 stk->baselen = cp - base;
> 
> is about coming up with the next value for current (which is
> taken from stk->baselen) to dig one more level.
> 
> If base="foo/bar/boo" and current=4 (i.e. we are looking at
> "foo/"), the current code (base + current + 1) will begin scanning
> for the next slash at ar/boo skipping one letter ('b').  This
> patch starts the scanning at bar/boo/
> 
> This only causes a problem when a path component has a length of
> zero which can happen when the user provides an absolute path to
> a file or directory in the root directory (i.e. "/", or "/foo"),
> or if the input is malformed and contains a double-slash such
> as "foo//boo".
> 
> Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>

I'll try to remember even 6 months from now that this was the "git clean 
-n /" problem ;-)

Ciao,
Dscho
