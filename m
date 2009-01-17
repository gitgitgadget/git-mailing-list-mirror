From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v3 2/6] reflog: refactor log open+mmap
Date: Sat, 17 Jan 2009 06:40:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901170636280.3586@pacific.mpi-cbg.de>
References: <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <1232163011-20088-2-git-send-email-trast@student.ethz.ch> <1232163011-20088-3-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 06:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO3vb-0003oB-0J
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 06:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbZAQFj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 00:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbZAQFj1
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 00:39:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:60927 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751404AbZAQFj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 00:39:26 -0500
Received: (qmail invoked by alias); 17 Jan 2009 05:39:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 17 Jan 2009 06:39:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gHqdGW3ugGjD4XOkpvf2poDIFdDbJ46D9ApyN56
	+mH7P4W9CL8tHt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232163011-20088-3-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106028>

Hi,

On Sat, 17 Jan 2009, Thomas Rast wrote:

> +static char *open_reflog(const char *ref, size_t *mapsz, const char **logfile)
> +{
> +	struct stat st;
> +	int logfd;
> +	char *map;
> +
> +	*logfile = git_path("logs/%s", ref);

That is dangerous.  git_path() returns a pointer to a static buffer.  
Before your patch, logfile was a local variable, and one could be 
relatively sure that git_path() was not called during the lifetime.  Now 
the lifetime of logfile is no longer as clear-cut, and it is much easier 
to overlook that git_path() must not be called while logfile holds a 
reference to its static buffer.

Ciao,
Dscho
