From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Some documentation...
Date: Wed, 20 Apr 2005 13:15:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201311300.6467@ppc970.osdl.org>
References: <42668C8D.3000209@dgreaves.com> <Pine.LNX.4.61.0504201321380.2630@cag.csail.mit.edu>
 <426692D1.20304@dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "C. Scott Ananian" <cscott@cscott.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 22:10:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOLVd-0004Hy-0W
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 22:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDTUNa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 16:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVDTUNa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 16:13:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:43670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261798AbVDTUN0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 16:13:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KKDLs4029816
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 13:13:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KKDKBn025648;
	Wed, 20 Apr 2005 13:13:21 -0700
To: David Greaves <david@dgreaves.com>
In-Reply-To: <426692D1.20304@dgreaves.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, David Greaves wrote:
> 
> So maybe it's left as documented behaviour and higher level tools must 
> manage the data they feed to it...

That was the plan.

I agree that "find . -type f | xargs update-cache --add --" in _theory_ is
a nice thing to do. But in practice, you want to make sure that find 
doesn't incldue the ".git" directory and that we always use the canonical 
names for all files etc etc.

I could do it in the low-level tools (ie do pathname cleanup there), and
indeed I did exactly that in the original code sequence. However, it very
quickly became obvious that the low-level code really doesn't want to
care, and that it's a lot easier to just do it at a higher level when 
necessary.

For example, if you have to add a sed-script or something that just 
removes '^./' and "^.git/", then that's trivial to do, and it leaves the 
core tools with a very clear agenda in life.

		Linus
