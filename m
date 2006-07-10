From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix linking for not-so-clever linkers.
Date: Mon, 10 Jul 2006 14:34:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101429460.5623@g5.osdl.org>
References: <Pine.LNX.4.63.0607101340080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64i5b1am.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 23:35:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03PP-0006vI-KQ
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWGJVev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWGJVeu
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:34:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965247AbWGJVet (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 17:34:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6ALYhnW008595
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 14:34:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6ALYgPI021062;
	Mon, 10 Jul 2006 14:34:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64i5b1am.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23656>



On Mon, 10 Jul 2006, Junio C Hamano wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On one of my systems, the linker is not intelligent enough to link with
> > pager.o (in libgit.a) when only the variable pager_in_use is needed. The
> > consequence is that the linker complains about an undefined
> > variable.
> 
> I do not understand this quite yet -- which executable is your
> linker building when it does this?
> 
> Maybe we need ranlib?

Shouldn't be needed, since we use "$(AR) rcs", where that "s" should do 
the equivalent of the old-fashioned "ranlib" call.

However, that said, I think Johannes' patch is worth applying regardless, 
since it's kind of sad to link in pager.o just because of a variable that 
ends up never mattering (ie any program that uses "diff.c" but isn't 
built-in).

Of course, once/if everything is built-in, this doesn't matter, but in the 
meantime this isn't the first time we've re-organized things so that you 
don't have to link in files that you don't need. After all, that was the 
whole reason environment.c ended up existing in the first place..

			Linus
