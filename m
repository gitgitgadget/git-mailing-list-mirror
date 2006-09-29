From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 23:17:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609282307220.3952@g5.osdl.org>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org> <7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281458420.3952@g5.osdl.org> <7vr6xvp7jm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609282252430.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 08:17:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTBgY-0005Ao-2S
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 08:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWI2GRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 02:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWI2GRT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 02:17:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964904AbWI2GRS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 02:17:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8T6HEnW031836
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 23:17:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8T6HENA006044;
	Thu, 28 Sep 2006 23:17:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0609282252430.3952@g5.osdl.org>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28094>



On Thu, 28 Sep 2006, Linus Torvalds wrote:
> 
> because the only reason strtoul() warns now is that C type-rules don't 
> allow the (obviously safe - but pointers migth have strange 
> representations) conversion of "char **" into "const char **", even though 
> "char *" can be converted into "const char *".

I phrased that badly. 

IF C pointer conversion allowed implicit addition of "const" past the 
top-most level, ANSI C would have just done "strtoul()" as 

	unsigned long strtoul(const char *n, const char **p, int);

ie they could just have added the "const" not just to the first argument, 
and legact programs (without const) would still have worked fine.

But _because_ that's not how C type rules work, we have the current 
situation where the first argument is a "const char *", and the second 
argument _logically_ should be a pointer to such an entity, but because 
that would have caused bogus warnings for any code that just used a 
regular "char **" without any const at all, that wasn't an option.

So that explains why ANSI C has insane imbalances like this. It's easy to 
add a "const" to a _first-level_ pointer to say "we allow both const and 
regular pointers to this thing", but sadly you can't do it for a pointer 
to such a pointer.

			Linus
