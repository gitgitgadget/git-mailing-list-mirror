From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Trace into open fd and refactor tracing code.
Date: Thu, 31 Aug 2006 14:14:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608311409470.27779@g5.osdl.org>
References: <20060831084211.28d38764.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 31 23:15:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIts9-0005fN-6C
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 23:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWHaVOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWHaVOp
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 17:14:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751226AbWHaVOp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 17:14:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7VLESnW002279
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 31 Aug 2006 14:14:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7VLEQgS024081;
	Thu, 31 Aug 2006 14:14:27 -0700
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060831084211.28d38764.chriscool@tuxfamily.org>
X-Spam-Status: No, hits=-2.432 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26274>



On Thu, 31 Aug 2006, Christian Couder wrote:
>
> It's now possible to run the tests like this:
> 
> 	GIT_TRACE=9 make test 9>/var/tmp/trace.log

Wouldn't it me _much_ more natural to instead do

	GIT_TRACE=/var/tmp/trace.log make test

and just have git open that file with "O_APPEND | O_CREAT"?

Maybe make the rule be that this only happens if the GIT_TRACE variable 
starts with a '/' character (ie you have to make it an absolute path).

That way, if you want to do the fd thing, you can always just do

	GIT_TRACE=/proc/self/fd/9 make test 9>/var/tmp/trace.log

although I really don't know how well that works across a fork/exec that 
may or may not be closing the file descriptor (I think it's much simpler 
and more obvious to just give the filename directly).

Hmm?

			Linus
