From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 07:47:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702280744150.12485@woody.linux-foundation.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org>
 <20070228044719.GA6068@spearce.org> <7vbqje3jx9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMR1M-0006xA-Pa
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbXB1PrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXB1PrK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:47:10 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58594 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbXB1PrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:47:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1SFkwhB018519
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Feb 2007 07:46:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1SFkvAN018764;
	Wed, 28 Feb 2007 07:46:57 -0800
In-Reply-To: <7vbqje3jx9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.442 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40948>



On Tue, 27 Feb 2007, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> 
> >> I think the pread() in get_data_from_pack of index-pack is wrong,
> >> it really should be looping until we fill the buffer in case the
> >> OS doesn't fully satisfy our read request the first time.
> 
> The patch looks correct, even if this was not the problem Bill
> is suffering from.

Ack. 

Although I would almost prefer it if we just did it like we do a lot of 
the other cases: call it "xpread()" instead, and have the loop there.

The reason I didn't do that in the first place is that a file access is 
supposed to be fully satisfied anyway, but yeah, NFS with an interruptible 
mount will break that posix guarantee, so the loop is definitely the right 
thing to do.

		Linus
