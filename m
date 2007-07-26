From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use lockfile.c routines in git_commit_set_multivar()
Date: Thu, 26 Jul 2007 19:31:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261926590.14781@racer.site>
References: 7vbqe0cazy.fsf@assigned-by-dhcp.cox.net
 <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE87N-0001N5-In
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711AbXGZSbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbXGZSbT
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:31:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:46482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933692AbXGZSbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 14:31:19 -0400
Received: (qmail invoked by alias); 26 Jul 2007 18:31:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 26 Jul 2007 20:31:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HDMxDmG5HqGVc8tejVNeEcfxvM2KIhGKVE5fIid
	LQdYQ8+pY1wL2m
X-X-Sender: gene099@racer.site
In-Reply-To: <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53854>

Hi,

I like the general idea.  Thanks.


On Thu, 26 Jul 2007, Bradford C. Smith wrote:

> +	/* fd is closed, so don't try to close it below. */
> +	fd = -1;
> +	/*
> +	 * lock is committed, so don't try to roll it back below.
> +	 * NOTE: Since lockfile.c keeps a linked list of all created
> +	 * lock_file structures, it isn't safe to free(lock).  It's
> +	 * better to just leave it hanging around.
> +	 */
> +	lock = NULL;
>  	ret = 0;
>  
>  out_free:
>  	if (0 <= fd)
>  		close(fd);
> +	if (lock)
> +		rollback_lock_file(lock);

Wouldn't it be better to put the rollback_lock_file() into the if clause 
when commit failed?

Besides, I think you can safely call rollback_lock_file(lock) on a 
committed lock_file, since the name will be set to "" by the latter, which 
is checked by the former.

But I am fine with the patch as is (have not tested it, though).

Ciao,
Dscho
