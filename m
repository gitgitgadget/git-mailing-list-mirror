From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 13:35:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141327240.20368@woody.linux-foundation.org>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <Pine.LNX.4.64.0702140958440.3604@woody.linux-foundation.org>
 <17875.31600.643352.808533@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRmq-0007hG-9f
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbXBNVfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbXBNVfc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:35:32 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47122 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbXBNVfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:35:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1ELZShB016888
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 13:35:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1ELZRPN009936;
	Wed, 14 Feb 2007 13:35:28 -0800
In-Reply-To: <17875.31600.643352.808533@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.408 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39757>



On Wed, 14 Feb 2007, Bill Lear wrote:
> 
> No NFS, but I checked /var/log/messages.  I see segfaults from git,
> that I missed somehow (don't remember seeing anything awry on the
> terminal):
> 
> Feb 14 10:05:07 lisa kernel: git[21648]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4
> Feb 14 10:05:43 lisa kernel: git[21710]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4
> Feb 14 10:06:28 lisa kernel: git[21858]: segfault at 0000000000000000 rip 0000003f5eb709d0 rsp 0000007fbfffc158 error 4
>
> 10:05 is just before I posted my first note of this to the git list, and
> the first instance of a segfault that I see.

Ok, this is almost certainly what's up. For some strange reason your git 
binary segfaults on the clone. The scary thing is, it left your cloned 
repo in a bad state without even telling you. That's not good.  Normally 
we should always die() and give a _reason_ for a failure.

If you have that particular git binary, doing a

	gdb git

and then at the gdb prompt doing

	x/5i 0x0000003f5eb709d0

will at least tell where the SIGSEGV happened, but it doesn't give a 
backtrace so unless it's obvious, it can be a bit hard to debug remotely..

			Linus
