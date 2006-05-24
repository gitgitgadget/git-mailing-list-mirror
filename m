From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 12:17:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 24 21:18:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiyrk-0007sq-2v
	for gcvg-git@gmane.org; Wed, 24 May 2006 21:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWEXTRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 15:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWEXTRx
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 15:17:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751270AbWEXTRx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 15:17:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4OJHctH019440
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 12:17:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4OJHaU3028093;
	Wed, 24 May 2006 12:17:37 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20702>



On Wed, 24 May 2006, Junio C Hamano wrote:
> 
> A "have" object is not just has_sha1_file(), but it needs to be
> reachable from one of our tips we have already verified as
> complete

You're right.

And the strange part is that the commit we should give for the tag thing 
_should_ actually be pretty recent, and I wonder why we end up walking the 
whole damn tree history and saying "want" to basically them all. 

IOW, I think there's something more fundamentally wrong with the tag 
following. We _should_ have figured out much more quickly that we have it 
all.

I'm starting to suspect that it's actually a tag-specific problem: we do 
that reachability crud all by commit history, so the tags are a total 
special case, and if we don't send the proper HAVE/WANT for those or mark 
them properly with THEY_HAVE/COMMON etc, maybe the algorithm just gets 
confused.

I need to go pick up my youngest, so I'll be off-line on this for a while. 
Will try to think it through.

		Linus
