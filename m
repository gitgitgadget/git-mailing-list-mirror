From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: [PATCH] Build on Debian GNU/Hurd
Date: Thu, 21 Sep 2006 10:53:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609211050390.4388@g5.osdl.org>
References: <000001c6dda4$ad0b1ec0$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 19:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQSkY-0004mY-Bw
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 19:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWIURyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 13:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIURyI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 13:54:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751392AbWIURyG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 13:54:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8LHrsnW007564
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Sep 2006 10:53:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8LHrrQ9016949;
	Thu, 21 Sep 2006 10:53:54 -0700
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
In-Reply-To: <000001c6dda4$ad0b1ec0$c47eedc1@ramsay1.demon.co.uk>
X-Spam-Status: No, hits=-2.49 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.152 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27500>



On Thu, 21 Sep 2006, Ramsay Jones wrote:
> 
> IMHO, setting the value in the Makefile, for systems that don't define
> PATH_MAX, is a much better solution. In fact, that is what I thought was
> already being done.

Well, considering that we _can_ test defines, why not just do it 
automatically.

In other words, instead of this patch:

> >  -
> >  -#ifndef PATH_MAX
> >  -# define PATH_MAX 4096
> >  -#endif
> >  +#include <limits.h>

Just make the code read

	#include <limits.h>

	/*
	 * Insane systems don't have a fixed PATH_MAX, it's POSIX
	 * compliant but not worth worrying about, so if we didn't
	 * get PATH_MAX from <limits.h>, just make up our own
	 */
	#ifndef PATH_MAX
	# define PATH_MAX 4096
	#endif

and after that we can just ignore the issue forever more.

The thing is, it's not like we even really _care_ what PATH_MAX is all 
that deeply. We just want to get some random value that is reasonable.

		Linus
