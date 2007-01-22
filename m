From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make sure git_connect() always give two file descriptors.
Date: Sun, 21 Jan 2007 17:47:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211744140.14248@woody.osdl.org>
References: <17843.29798.866272.414435@lisa.zopyra.com> <ep00nl$mop$1@sea.gmane.org>
 <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org> <17843.55730.456139.247155@lisa.zopyra.com>
 <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
 <Pine.LNX.4.64.0701211554450.14248@woody.osdl.org> <7v3b63zx0k.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 02:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8oHG-0003b0-RQ
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbXAVBrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbXAVBrN
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:47:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49300 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbXAVBrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:47:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0M1lAhB010213
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 17:47:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0M1l9fe014226;
	Sun, 21 Jan 2007 17:47:09 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b63zx0k.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.66 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37381>



On Sun, 21 Jan 2007, Junio C Hamano wrote:
>
> Earlier, git_connect() returned the same fd when the destination
> was remote (i.e.  we used socket to communicate with it) and two
> separate fds when the destination was local (i.e. we used
> pipe(2)).

Actually, to be strictly correct, we returned the same fd when

 - we used git:// and were not proxying

and we returned two different fd's for all other cases (ie local, ssh, 
proxy-git).

So it's not really about "remote" vs "local", since ssh in particular is 
mostly remote too, but since we used pipes to connect with ssh, it acted 
the same way as the local case (which also used pipes to connect to the 
local processes).

And git:// with proxy support also ended up using pipes (for the proxy 
process), which is why you _only_ saw this with the raw direct TCP git:// 
case.

Or something like that.-

		Linus
