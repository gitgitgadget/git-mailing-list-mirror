From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 11:04:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509271058110.3308@g5.osdl.org>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
 <20050926212536.GF26340@pasky.or.cz> <4338F3F6.8040401@michonline.com>
 <Pine.LNX.4.58.0509270821590.3308@g5.osdl.org> <20050927173445.GC23034@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 20:06:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKJoX-0007w4-1q
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 20:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVI0SEX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 14:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVI0SEW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 14:04:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965035AbVI0SEW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 14:04:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8RI4I4s031160
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Sep 2005 11:04:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8RI4HXK024085;
	Tue, 27 Sep 2005 11:04:17 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050927173445.GC23034@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9412>



On Tue, 27 Sep 2005, Ryan Anderson wrote:
> 
> $ cat .git/refs/tags/v2.6.13-rc4
> 7eab951de91d95875ba34ec4c599f37e1208db93
> $ git-rev-parse v2.6.13-rc4
> 7eab951de91d95875ba34ec4c599f37e1208db93
> $ git-rev-parse v2.6.13-rc4^0
> 63953523341bcafe5928bf6e99bffd7db94b471e
> $ git-rev-parse 63953523341bcafe5928bf6e99bffd7db94b471e^0
> 63953523341bcafe5928bf6e99bffd7db94b471e

The point being that if you want to test whether you have the thing the 
tag _points_ to, you should verify it.

And that's where the "--verify" flag comes in:

	[torvalds@g5 linux]$ git-rev-parse v2.6.11^0 ; echo $?
	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
	v2.6.11^0
	0

and if the object the tag points to didn't exist at _all_ in your object
store, you'd have silently gotten

	[torvalds@g5 linux]$ git-rev-parse v2.6.11^0 ; echo $?
        v2.6.11^0
        0

but if you used "--verify", you'd have at least gotten

	[torvalds@g5 linux]$ git-rev-parse --verify v2.6.11^0 ; echo $?
	fatal: Needed a single revision
	1

which is what you want, I thought.

		Linus
