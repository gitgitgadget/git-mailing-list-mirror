From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 13:35:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704181330050.2828@woody.linux-foundation.org>
References: <11768880622402-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704181247410.12094@racer.site> <20070418153445.GC12888@admingilde.org>
 <alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
 <7vslaxhamd.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
 <7vzm55fqyv.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org>
 <7vk5w9fnjx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGsc-0006Tt-Jn
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992588AbXDRUfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992592AbXDRUfh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:35:37 -0400
Received: from smtp.osdl.org ([65.172.181.24]:45768 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992588AbXDRUfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:35:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IKZ9YC027776
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 13:35:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IKZ5xo002287;
	Wed, 18 Apr 2007 13:35:07 -0700
In-Reply-To: <7vk5w9fnjx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.969 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44941>



On Wed, 18 Apr 2007, Junio C Hamano wrote:
> 
> Yes, but in the case I had trouble with, I know what I want to
> see happen when we DO hit file-level conflict on RelNotes
> symlink.  The ancestor says Documentation/RelNotes-1.5.0.txt,
> the maint branch says Documentation/RelNotes-1.5.0.1.txt, while
> the current branch says Documentation/RelNotes-1.5.1.txt.  The
> logic in merge_file() simply says "we would punt on file-level
> conflicts for symlinks" without giving a chance for low-level
> drivers to interfere.

Ahh, ok. So it really is a file-level conflict, it's just that our 
traditional merger didn't handle them at all, so we said "nobody can do 
it". Fair enough. That does sound like a misfeature, although I would also 
claim that expecting merge strategies to handle symlinks is likely to fail 
horribly.

So maybe each strategy could have "sub-strategies" for other file types.

Ie something like

	[merge "ours"]
		name = pick our own version
		driver = /bin/true
		symlinks = /bin/true

ie we'd use tyhe "driver" name for regular files, and the "symlinks" name 
for symlinks and if no "symlinks" entry exists, we error it out as a 
conflict?

		Linus
