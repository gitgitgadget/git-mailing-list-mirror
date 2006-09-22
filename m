From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: [PATCH] Build on Debian GNU/Hurd
Date: Fri, 22 Sep 2006 18:22:21 +0100
Message-ID: <000001c6de6b$a9994920$c47eedc1@ramsay1.demon.co.uk>
References: <Pine.LNX.4.64.0609211050390.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Gerrit Pape" <pape@smarden.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 19:23:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQojj-0001Ap-7W
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 19:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWIVRWr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 13:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIVRWr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 13:22:47 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:48397 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S964800AbWIVRWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 13:22:46 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with smtp (Exim 4.42)
	id 1GQojZ-000Dhg-2U; Fri, 22 Sep 2006 17:22:42 +0000
To: "Linus Torvalds" <torvalds@osdl.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
In-Reply-To: <Pine.LNX.4.64.0609211050390.4388@g5.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27531>


On Thurs Sept 21 at 18:54, Linus Torvalds wrote:
> On Thu, 21 Sep 2006, Ramsay Jones wrote:
> >
> > IMHO, setting the value in the Makefile, for systems that don't define
> > PATH_MAX, is a much better solution. In fact, that is what I thought was
> > already being done.
>
> Well, considering that we _can_ test defines, why not just do it
> automatically.
>
> In other words, instead of this patch:
>
> > >  -
> > >  -#ifndef PATH_MAX
> > >  -# define PATH_MAX 4096
> > >  -#endif
> > >  +#include <limits.h>
>
> Just make the code read
>
> 	#include <limits.h>
>
> 	/*
> 	 * Insane systems don't have a fixed PATH_MAX, it's POSIX
> 	 * compliant but not worth worrying about, so if we didn't
> 	 * get PATH_MAX from <limits.h>, just make up our own
> 	 */
> 	#ifndef PATH_MAX
> 	# define PATH_MAX 4096
> 	#endif
>
> and after that we can just ignore the issue forever more.

Yes, that would certainly be a solution. (Of course, setting the value in
the Makefile would still be a better solution ;-)
However, ...

>
> The thing is, it's not like we even really _care_ what PATH_MAX is all
> that deeply. We just want to get some random value that is reasonable.
>
> 		Linus
>

... given the above, a better solution is: don't use PATH_MAX.
Simply #define a new symbol in a suitable git header file and globally
replace uses of PATH_MAX with the new symbol. Job done.

All the best,

Ramsay
