From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5500-fetch-pack: ignore output from git init
Date: Sun, 24 May 2009 12:48:26 -0400
Message-ID: <20090524164826.GD22792@coredump.intra.peff.net>
References: <1243107282-9259-1-git-send-email-bebarino@gmail.com> <20090524164329.GC22792@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 18:49:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8GsW-0001Zd-4k
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 18:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbZEXQs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 12:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbZEXQs0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 12:48:26 -0400
Received: from peff.net ([208.65.91.99]:57919 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476AbZEXQs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 12:48:26 -0400
Received: (qmail 29276 invoked by uid 107); 24 May 2009 16:48:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 24 May 2009 12:48:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 May 2009 12:48:26 -0400
Content-Disposition: inline
In-Reply-To: <20090524164329.GC22792@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119842>

On Sun, May 24, 2009 at 12:43:30PM -0400, Jeff King wrote:

> > +++ b/t/t5500-fetch-pack.sh
> > @@ -97,7 +97,7 @@ pull_to_client () {
> >  (
> >  	mkdir client &&
> >  	cd client &&
> > -	git init 2>> log2.txt &&
> > +	git init 2>> log2.txt > /dev/null &&
> >  	git config transfer.unpacklimit 0
> >  )
> 
> Why not:
> 
>   test_expect_success 'setup client repo' '
>     mkdir client &&
>     (cd client &&
>      git init 2>>log2.txt &&
>      git config transfer.unpacklimit 0
>     )
>   '

Actually, taking a closer look at the script, I think you could probably
ditch the '2>>log2.txt' bit entirely. The log file is never read and
appears to be completely for debugging. Putting the code into the test
harness means that output will respect --verbose properly, which means a
separate log is unnecessary.

-Peff
