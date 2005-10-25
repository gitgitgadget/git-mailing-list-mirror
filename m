From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 0.99.9 on Saturday next week.
Date: Tue, 25 Oct 2005 10:41:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251033310.10477@g5.osdl.org>
References: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net> <tnx64rlrjux.fsf@arm.com>
 <7virvlh6m5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 19:44:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUSoQ-0002x0-TS
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 19:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVJYRmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 13:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVJYRmL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 13:42:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbVJYRmJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 13:42:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9PHfwFC009486
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 10:41:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9PHfveT020263;
	Tue, 25 Oct 2005 10:41:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virvlh6m5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10603>



On Tue, 25 Oct 2005, Junio C Hamano wrote:
>
> Catalin Marinas <catalin.marinas@gmail.com> writes:
> 
> >>  - Configuration files (Linus).
> >
> > Since the configuration files use the .ini like syntax, is it OK for
> > StGIT to use the same file, with an "[stgit]" section?
> 
> I think that is a reasonable thing to do.

Absolutely. The whole thing was _designed_ to be used that way. Any C user 
should be able to just link against config.o without even bothering with 
the rest of git (the only git-specific thing there should be some naming), 
and any script user can either

 - parse the simple config language by hand (not really a good idea, but 
   it _is_ pretty simple)
 - just run "git-var -l" and parse the output.

ie if you want to track "[stgit]" config options, just do

	git-var -l | sed '/^stgit\./ s/^stgit.//p'

and it will pick up everything starting with "stgit." and remove that 
part.

What remains should be a simple list or "variable=value" pairs.

Oh - and the convention is that 

 (a) we've already done any quote expansion (although I may have to make 
     git-var quote "\n" - I didn't care enough to do so)
 (b) a boolean variable without a "=" means that it was set to "true" 
     (which is different from an _empty_ one, which has a "=" but just 
     doesn't have any value)

The (b) thing is just a special case, so that you can write

	[stgit]
		debug

and it will be the same as

	[stgit]
		debug = true

which just seems to be the sane thing to do.

		Linus
