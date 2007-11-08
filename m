From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [NEW REPLACEMENT PATCH] git-checkout: Add a test case for relative
 paths use.
Date: Thu, 8 Nov 2007 14:32:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081427450.4362@racer.site>
References: <11945276321726-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8RY-0000SH-PE
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbXKHOc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbXKHOc7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:32:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:52185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751158AbXKHOc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:32:59 -0500
Received: (qmail invoked by alias); 08 Nov 2007 14:32:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 08 Nov 2007 15:32:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193AldEjMt3ulzMigqq7LxtoPUZoIOkudj4Yy6Gxk
	XFAoUZl9Eh9gf/
X-X-Sender: gene099@racer.site
In-Reply-To: <11945276321726-git-send-email-dsymonds@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64029>

Hi,

just a few nitpicks:

On Fri, 9 Nov 2007, David Symonds wrote:

> +test_expect_success setup '
> +
> +	echo base > file0 &&
> +	git add file0 &&
> +	mkdir dir1 &&
> +	echo hello > dir1/file1 &&
> +	git add dir1/file1 &&
> +	test_tick &&

please move the test_tick directly in front of the commit.  Readers might 
assume that it has an effect on mkdir otherwise.

> +	mkdir dir2 &&
> +	echo bonjour > dir2/file2 &&
> +	git add dir2/file2 &&
> +	git commit -m "populate tree"
> +
> +'

Please lose the empty line before the closing quote.  (This applies to all 
tests.)

> +test_expect_success 'remove and restore with relative path' '
> +
> +	cd dir1 &&
> +	rm ../file0 &&
> +	git checkout HEAD -- ../file0 && test -f ../file0 &&
> +	rm ../dir2/file2 &&
> +	git checkout HEAD -- ../dir2/file2 && test -f ../dir2/file2 &&
> +	rm ../file0 ./file1 &&
> +	git checkout HEAD -- .. && test -f ../file0 && test -f ./file1 &&
> +	rm file1 &&
> +	git checkout HEAD -- ../dir1/../dir1/file1 && test -f ./file1
> +
> +'
> +
> +test_expect_failure 'checkout with relative path outside tree should fail (1)' \
> +	'git checkout HEAD -- ../file0'

Maybe do that with an existing file?  Since the test script lives in t/, 
and the test is run in t/trash/, we can test for "../Makefile".

Also, I would shorten the message to "relative path outside tree should 
fail".

> +test_expect_failure 'checkout with relative path outside tree should fail (2)' \
> +	'cd dir1 && git checkout HEAD -- ./file0'

I am not convinced that this should fail.

> +test_expect_failure 'checkout with relative path outside tree should fail (2)' \
> +	'cd dir1 && git checkout HEAD -- ../../file0'

Please add some other test like

test_expect_success 'checkout with empty prefix' '
	rm file0 &&
	git checkout HEAD -- file0 &&
	test base = "$(cat file0)"
'

Thanks,
Dscho
