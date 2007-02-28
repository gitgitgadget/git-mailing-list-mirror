From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 08:34:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org>
 <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com>
 <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRkx-00010D-CW
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbXB1QeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXB1QeB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:34:01 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60677 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156AbXB1QeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:34:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1SGXvhB020147
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Feb 2007 08:33:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1SGXuCv019989;
	Wed, 28 Feb 2007 08:33:56 -0800
In-Reply-To: <17893.43522.511785.121778@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.44 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40958>



On Wed, 28 Feb 2007, Bill Lear wrote:
> 
> Well, I went ahead and did that.  Here are the results:
> 
> % git clone --bare ~/devel/project
> [...]
> Resolving 2210 deltas.
> fatal: cannot pread pack file: Success [obj[0].offset=39393; obj[1].offset=39602; n=305; obj->size=0; rdy=0; len=207]
> fatal: index-pack died with error code 128

What's "n"? Is that the return value from pread? Or was that "rdy"?

We expect the return value of pread() to be exactly the size we asked for, 
namely "len". Anything else would be an error, and we know you're not 
getting a negative return value (since strerror() says "success") unless 
your pread() is *really* buggered.

But getting a return value of 0 would indicate that your pack-file is 
seriously corrupt (in particular, it would likely be truncated). And 
getting a return value of 305 is also weird beyond belief, since we only 
asked for 207 bytes.

One thing to do (maybe you did already) is to just verify that what you're 
cloning looks fine:

	cd ~/devel/project
	git fsck --full

just to be safe.

		Linus
