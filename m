From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/3] t3700: avoid racy git situation
Date: Thu, 8 Nov 2007 15:16:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081511440.4362@racer.site>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
 <Pine.LNX.4.64.0711081414160.4362@racer.site> <47331E65.9010209@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq97Z-00087Z-Js
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702AbXKHPQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbXKHPQZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:16:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:48078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753417AbXKHPQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:16:24 -0500
Received: (qmail invoked by alias); 08 Nov 2007 15:16:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 08 Nov 2007 16:16:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xdRkzXQnxOaYMgfLHG9ZQ9O93rB11OzXEH1o7WC
	QNtFK9w795DpZp
X-X-Sender: gene099@racer.site
In-Reply-To: <47331E65.9010209@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64038>

Hi,

On Thu, 8 Nov 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > Wow, the builtin commit is fast.  It sometimes triggers a racy
> > situation in the test case for "git add --refresh -- foo".
> > 
> > So when that test fails, simply sleep one second and try again.
> 
> [/me looks at the calender - no, it's not April Fool's day]

No. The builtin commit is really that fast.

> Wouldn't it be better to fix git-commit (or git-add)? I would like to 
> help, but you already seem to have done the analysis, so...

The problem is that the index has the same timestamp as the file "foo".

Therefore, git cannot tell if "foo" is up-to-date in the index, since it 
could have been modified (and indeed is) just a fraction of a second later 
than the index was last updated.

And since diff-index, as called from the test script, does not generate a 
diff, but really only determines if the index information suggests that 
the files are up-to-date, there is not really much you can do.

This is our good old friend, the racy git problem.

NOTE: other scms do not have this problem, mostly because they are too 
slow to trigger it.

Ciao,
Dscho
