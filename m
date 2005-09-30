From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Support SPARSE in Makefile, better SPARSE_FLAGS
Date: Fri, 30 Sep 2005 09:41:02 -0400
Message-ID: <1128087662.14543.14.camel@dv>
References: <1128026765.24397.46.camel@dv>
	 <7vek779kg0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 15:43:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELL8l-0003fM-2w
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 15:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVI3NlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 09:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVI3NlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 09:41:09 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:50867 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030298AbVI3NlG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 09:41:06 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ELL8L-00032w-0y
	for git@vger.kernel.org; Fri, 30 Sep 2005 09:41:05 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1ELL8I-00072U-5i; Fri, 30 Sep 2005 09:41:02 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek779kg0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9559>

On Thu, 2005-09-29 at 22:46 -0700, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > +# explicitly what architecture to check for.
> > +SPARSE = sparse
> > +SPARSE_FLAGS = -D__$(shell uname -i)__
> 
>         : siamese; uname --version
>         uname (coreutils) 5.2.1
>         Written by David MacKenzie.

Apparently my uname 5.2.1 was heavily patched by Fedora.  Note that
"uname -m" is not good enough, as it would give us i686 when i386 is
really needed.

>         Copyright (C) 2004 Free Software Foundation, Inc.
>         This is free software; see the source for copying conditions.
>         There is NO
>         warranty; not even for MERCHANTABILITY or FITNESS FOR A
>         PARTICULAR PURPOSE.
>         : siamese; uname -i
>         Try `uname --help' for more information.
> 
> Better alternatives?

I hate to say that, but a better alternative is to fix sparse to act
like the native compiler by default (possibly with options to imitate
other architectures or to be fully arch-neutral).

I have some hacks in mind, but I don't really like them:

Not good for i686 with unpatched uname:
SPARSE_FLAGS = __$(shell uname -i 2>/dev/null || uname -m)__

gcc specific:
SPARSE_FLAGS = __$(shell $CC -dumpmachine | sed 's/-.*//')__

bash specific:
SPARSE_FLAGS = __$(shell echo $$HOSTTYPE)__

In any case, having SPARSE variable would be convenient.

-- 
Regards,
Pavel Roskin
