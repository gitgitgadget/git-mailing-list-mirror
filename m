From: Jeff King <peff@peff.net>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch
 --tree-filter' on Solaris?
Date: Wed, 17 Oct 2012 18:13:22 -0400
Message-ID: <20121017221322.GB21742@sigill.intra.peff.net>
References: <1109432467.20121017104729@gmail.com>
 <507E5CE0.10002@viscovery.net>
 <1013956402.20121017125847@gmail.com>
 <1665262317.20121017143623@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 00:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TObrt-0001RW-0I
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 00:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2JQWNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 18:13:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56954 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272Ab2JQWNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 18:13:25 -0400
Received: (qmail 30553 invoked by uid 107); 17 Oct 2012 22:14:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Oct 2012 18:14:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2012 18:13:22 -0400
Content-Disposition: inline
In-Reply-To: <1665262317.20121017143623@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207944>

On Wed, Oct 17, 2012 at 02:36:23PM +0400, Ilya Basin wrote:

> The culprit is bad $PATH :
> When git-filter-branch runs, for some reason two new entries precede
> /usr/bin in it:
>      /tmp/777/.ilya-sparc/bin
>      /home/tester/.ilya/opt/SNiFF-3.2.1/bin
>      /export/home/testora/app/testora/product/11.2.0/client_32/bin
>     +/usr/xpg6/bin
>     +/usr/xpg4/bin
>      /usr/bin
>      /home/tester/apache-ant-1.7.1/bin
>      /usr/jdk/instances/jdk1.5.0//bin
> 
> And /usr/xpg6/bin/tr fails to make "AUTHOR" lowercase.

Hmph. Those are controlled by SANE_TOOL_PATH at git's build time, with
the intent that the xpg tools are less terrible than the ones in
/usr/bin on Solaris. But it sounds like that may not be the case. Yuck.

I don't have a Solaris box handy. Is there a way to make sequences like
A-Z work sanely with /usr/xpg6/bin/tr?

Do you have any LANG or locale settings? Sometimes those can affect
sequences. What does:

  echo AUTHOR | LANG=C LC_ALL=C /usr/xpg6/bin/tr '[A-Z]' '[a-z]'

do?

-Peff
