From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: testsuite problems
Date: Mon, 17 Sep 2007 23:40:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709172337470.28586@racer.site>
References: <20070917211742.GF19019@genesis.frugalware.org>
 <46EEF6A8.1030308@lsrfire.ath.cx> <20070917220408.GG19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPHM-0005Wh-Hi
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875AbXIQWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 18:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756744AbXIQWlQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:41:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:39539 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754705AbXIQWlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:41:15 -0400
Received: (qmail invoked by alias); 17 Sep 2007 22:41:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 18 Sep 2007 00:41:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CcABYvI7CEDNtCQvffKIs/wIYa7GfXOm3HOptDy
	DX8QbNk6AYb5yh
X-X-Sender: gene099@racer.site
In-Reply-To: <20070917220408.GG19019@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58487>

Hi,

On Tue, 18 Sep 2007, Miklos Vajna wrote:

> On Mon, Sep 17, 2007 at 11:50:32PM +0200, Ren? Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> > The failing tests check ZIP file creation, not tar file creation.
> > Perhaps your unzip command works a bit differently from Info-ZIP's?
> 
> $ zip -v
> Copyright (c) 1990-2006 Info-ZIP - Type 'zip "-L"' for software license.
> This is Zip 2.32 (June 19th 2006), by Info-ZIP.
> 
> should this version be ok?
> 
> > Also, what is the difference between t/trash/a and t/trash/d/a after
> > running the test script (that's what test 21 is comparing)?
> 
> $ diff -Naur t/trash/a t/trash/d/a
> diff -Naur t/trash/a/l1 t/trash/d/a/l1
> --- t/trash/a/l1        2007-09-17 23:10:03.000000000 +0200
> +++ t/trash/d/a/l1      2007-09-17 23:10:03.000000000 +0200
> @@ -1 +1 @@
> -simple textfile
> +a
> \ No newline at end of file

Ah, that's my friend GNU diff again... Try running the test with "-i -v", 
and it will pass, if I am right.

I actually made a patch for GNU diff back when this hit me, only to find 
out that it was fixed in CVS.  Apparently, for a short period, during 
which 2.8.1 was released, there was a bug that prevented GNU diff from 
working properly when the output was redirected to a non-tty.

If I'm right, and it is that bug, it might be worthwhile to convert the 
calls to "diff -u" in that test script with calls to "git diff" (possibly 
with --no-index).

Ciao,
Dscho
