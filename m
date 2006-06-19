From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Q] what to do when waitpid() returns ECHILD under signal(SIGCHLD,
 SIG_IGN)?
Date: Mon, 19 Jun 2006 16:57:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606191654590.5498@g5.osdl.org>
References: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 01:57:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsTce-0007XC-NY
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 01:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWFSX5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 19:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWFSX5e
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 19:57:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932557AbWFSX5d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 19:57:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5JNvTgt019387
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Jun 2006 16:57:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5JNvSwn018839;
	Mon, 19 Jun 2006 16:57:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22148>



On Mon, 19 Jun 2006, Junio C Hamano wrote:
>
> Somebody I met last week in Japan reported that the socks client
> he uses to cross the firewall to connect to git:// port from his
> company environment seems to do signal(SIGCHLD, SIG_IGN) before
> spawning git.

Ok, that sounds pretty broken of it.

> We could work this around by having signal(SIGCHLD, SIG_DFL)
> upfront in git.c::main(), but I am wondering what the standard
> practice for programs that use waitpid() call.

We need the status return, so failing on getting ECHILD is absolutely the 
right thing to do, because it implies that we don't know what the status 
could have been.

So we need to reset SIGCHLD back to SIG_DFL (or catch it explicitly).

Whether we want to do that in the main() routine or when we actually do 
the fork() or whatever is a different issue.

		Linus
