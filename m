From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Sat, 10 Mar 2007 14:46:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703101443411.10330@woody.linux-foundation.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org>
 <Pine.LNX.4.64.0703092145550.10832@woody.linux-foundation.org>
 <20070310060144.GA3223@spearce.org> <20070310223251.GA20726@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anton Tropashko <atropashko@yahoo.com>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 23:47:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQAL7-0004FU-Sl
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 23:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbXCJWqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 17:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXCJWqz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 17:46:55 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58170 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932306AbXCJWqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 17:46:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2AMkao4027846
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Mar 2007 14:46:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2AMka9H032119;
	Sat, 10 Mar 2007 14:46:36 -0800
In-Reply-To: <20070310223251.GA20726@admingilde.org>
X-Spam-Status: No, hits=-0.488 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41887>



On Sat, 10 Mar 2007, Martin Waitz wrote:
> 
> On Sat, Mar 10, 2007 at 01:01:44AM -0500, Shawn O. Pearce wrote:
> > Its very likely this did fit in just under 4 GiB of packed data,
> > but as you said, without O_LARGEFILE we can't work with it.
> 
> but newer git version can cope with it:
> 
> -r--r--r-- 1 martin martin 3847536413 18. Feb 10:36 pack-ffe867679d673ea5fbfa598b28aca1e58528b8cd.pack

Are you sure you're not just running a 64-bit process?

64-bit processes don't need O_LARGEFILE to process files larger than 2GB, 
since for them, off_t is already 64-bit.

Grepping for O_LARGEFILE shows nothing.

Oh, except we have that 

	#define _FILE_OFFSET_BITS 64

which is just a horrible hack. That's nasty. We should just use 
O_LARGEFILE rather than depend on some internal glibc thing that works 
nowhere else.

		Linus
