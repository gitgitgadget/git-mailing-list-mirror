From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] parse_object: check if buffer is non-NULL before freeing
 it
Date: Sun, 27 Aug 2006 21:33:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608272131020.27779@g5.osdl.org>
References: <20060828003129.GE20904@diku.dk> <7vsljhtrsv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 06:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHYoV-00037G-0b
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 06:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWH1EdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 00:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWH1EdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 00:33:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46285 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932130AbWH1EdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 00:33:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7S4XHnW008514
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Aug 2006 21:33:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7S4XGLb016659;
	Sun, 27 Aug 2006 21:33:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsljhtrsv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.431 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26138>



On Sun, 27 Aug 2006, Junio C Hamano wrote:
> 
> Eh, free(NULL) should work just fine.  It is "other places" that
> is misguided and needs to be fixed.

Well, some very old libraries will SIGSEGV on free(NULL). 

Admittedly those libraries are either very old or _very_ broken, but if 
you want to be strictly portable, you should not ever pass NULL to free(), 
unless you actually got it from a malloc(0) (and even then, it might be a 
really broken libc that just ran out of memory).

I actually suspect we should wrap all free() calls as "xfree()", which may 
also help us some day if we want to do any memory usage statistics.

		Linus
