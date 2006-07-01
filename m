From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 09:25:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607010921450.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 18:26:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwiIV-00057V-Ro
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 18:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWGAQZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 12:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWGAQZx
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 12:25:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61631 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932383AbWGAQZx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 12:25:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k61GPinW003804
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Jul 2006 09:25:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k61GPhb2003355;
	Sat, 1 Jul 2006 09:25:43 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060701150926.GA25800@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23050>



On Sat, 1 Jul 2006, Rene Scharfe wrote:
> 
> You mean something like the following patch on top of the 'next' branch?
> It also documents the --not switch because I needed it for the example.

Yes. 

However, I think that 90% of the code for the ".." and "..." case are the 
same, as is largely the finding of it.

So why not just do this all inside the already existing

	dotdot = strstr(arg, "..");
	if (dotdot) {
		unsigned char other_sha1[20];
		const char *one = arg;
		const char *two = arg + 2;
		int symmetric = *two == '.';

		*dotdot = '\0';
		two += symmetric;

		if (one == arg)
			one = "HEAD";
		if (!*two)
			two = "HEAD";
		...

because the only difference is really at the very end.

Did you test that it looks correct too?

		Linus
