From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Mon, 20 Jul 2009 22:51:21 +0200
Message-ID: <200907202251.22490.j6t@kdbg.org>
References: <20090718134551.GC16708@vidovic> <200907191301.15533.j6t@kdbg.org> <20090720090937.GA20412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 20 22:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSzpq-0001n1-Br
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 22:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbZGTUve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 16:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbZGTUvc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 16:51:32 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:13581 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbZGTUvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 16:51:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E16B82C400B;
	Mon, 20 Jul 2009 22:51:24 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6532C4260A;
	Mon, 20 Jul 2009 22:51:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090720090937.GA20412@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123633>

On Montag, 20. Juli 2009, Jeff King wrote:
> On Sun, Jul 19, 2009 at 01:01:15PM +0200, Johannes Sixt wrote:
> > Problem is, snprintf was made for very old systems, which typically do
> > not have va_copy. (E.g. Windows, but there the situation *might* have
> > changed with the switch to gcc 4.)
> >
> > The rationale not to use va_copy is that this function is to be used
> > *only* if necessary, i.e. portability is already lacking, and if it
> > can be verified that this function works as is. Portability and
> > correct-by-the-law C code are *not* a goal here. If the function does
> > not work as is, don't use it.
>
> OK, I guess I can buy the "don't use this unless you need it" rationale.
> But two questions:
>
>   1. _Are_ we sure it works under Windows?  That is, do we know for a
>      fact that using a va_list twice is OK there, or are we just going
>      on the fact that nobody has reported the bug?

We are sure (well, I am sure ;) that it worked on Windows with gcc 3. It 
certainly is a reasonable workaround. It remains to confirm that the 
workaround works as expected on the other systems that use it (IRIX, 
HP/UX).  'git branch -v' is a test that calls the system provided vsnprintf 
twice (as long as the branch head commits have moderatly long summary lines).

On Windows, however, today everybody who compiles git is most likely using 
msysgit's gcc 4.4. This version has C99 vsnprintf, and the workaround should 
not be used anymore, although it does not hurt.

-- Hannes
