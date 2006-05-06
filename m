From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_pathspec(): free() old buffer if rewriting
Date: Sat, 6 May 2006 15:37:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605061532190.16343@g5.osdl.org>
References: <Pine.LNX.4.63.0605070003430.6357@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun May 07 00:37:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcVP5-0002jQ-7f
	for gcvg-git@gmane.org; Sun, 07 May 2006 00:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWEFWh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 18:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWEFWh1
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 18:37:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932091AbWEFWh0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 18:37:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k46MbKtH031474
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 May 2006 15:37:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k46MbJ3k007885;
	Sat, 6 May 2006 15:37:20 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605070003430.6357@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19679>



On Sun, 7 May 2006, Johannes Schindelin wrote:
> 
> This might be the wrong way to do it, but as it is without this patch,
> get_pathspec() is leaking memory.

I'm not at all convinced we want to do somethng like this.

get_pathspec() is a one-time event. It doesn't "leak" memory. To me, 
"leaking" is when you continually lose a bit of memory, and you eventually 
run out. I don't see that happening here.

It's like saying that calling an initialization routine "leaks" memory, 
because it doesn't free the memory that contains the function that is now 
no longer ever used. It's clearly leaving that memory unused, "dangling".

But the fact is, the OS will free the memory for us when we exit, and 
simplicity is often much more powerful than trying to be overly careful.

So there's a difference between "don't care" and "leak memory". It sounds 
like you may be using some automated tool that warns because it simply 
doesn't understand that difference.

			Linus
