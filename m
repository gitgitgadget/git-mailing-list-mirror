From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal
 bars
Date: Thu, 27 Oct 2005 19:38:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510271933140.4664@g5.osdl.org>
References: <20051027203945.GC1622@pe.Belkin>  <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
 <46a038f90510271816i26389d5cqe136f515007ca057@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 04:39:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVK8i-00073C-TO
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVJ1Cik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVJ1Cik
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:38:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58601 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965059AbVJ1Cij (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 22:38:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9S2cUFC017605
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Oct 2005 19:38:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9S2cM6H011275;
	Thu, 27 Oct 2005 19:38:26 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510271816i26389d5cqe136f515007ca057@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10738>



On Fri, 28 Oct 2005, Martin Langhoff wrote:
>
> On 10/28/05, Junio C Hamano <junkio@cox.net> wrote:
> > > which is pretty slow.  Any suggestions?
> >
> > * do we really want to know the number of lines?
> 
> What about both? And sugar (rename detection) on top! ;-)

Well, if you do full copy detection (and break detection), then 
git-diff-tree will actually have effectively calculated the size of the 
diff of each file. It just doesn't print them (well, it does a percentage 
for the renames/copies).

So you could make git-diff-tree tell you how big the patch was, without 
actually generating a patch at all. It will be quite a bit more expensive 
than just a plain "git-diff-tree -r --name-only", but if you cache the 
result is might be quite acceptable.

Caching the result might be as simple as just telling the caching 
web-server that the result is static and never changes - no need to 
cache things inside of gitweb itself. Just set expiration to "never".

Anybody wants to add a new output format to git-diff-tree that outputs how 
big the changes are in absolute terms (rather than the "similarity index", 
which is obviously relative to the original size of the file in question)?

		Linus
