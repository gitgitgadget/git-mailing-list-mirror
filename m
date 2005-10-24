From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 10:58:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510241054480.10477@g5.osdl.org>
References: <867jc336f4.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
 <86irvmzyq9.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
 <Pine.LNX.4.64.0510241002180.10477@g5.osdl.org> <435D1963.8070205@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 20:02:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU6am-0006dm-2I
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 19:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVJXR6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 13:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVJXR6b
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 13:58:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751205AbVJXR6a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 13:58:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9OHwQFC005594
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 24 Oct 2005 10:58:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9OHwPMN001987;
	Mon, 24 Oct 2005 10:58:26 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <435D1963.8070205@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10551>



On Mon, 24 Oct 2005, H. Peter Anvin wrote:
> 
> A much more likely cause for problems would be system headers that use the
> isxxx() macros as part of other macros.  That would be in violation of POSIX,
> but is reasonably common.

Hmm.. Yes, that's a good point. I don't see what thing could do it that we 
care about (and since we do actually do a pretty valid ctype 
implementation, it should all work out right regardless), but yes, it 
might be safer to rename the things.

Especially if we then continue to make sure _not_ to include <ctype.h> 
ourselves, so that only systems with broken headers (like the ones on 
OpenBSD ;) could ever use the standard names anyway. That way we'd not 
have to worry whether somebody uses them by mistake..

Btw, nobody ever replied to my question whether we might be using 
something else that is locale-specific. I'm not actually locate-aware 
enough to even know what else than <ctype.h> might be dangerous to use..

Anybody?

		Linus
