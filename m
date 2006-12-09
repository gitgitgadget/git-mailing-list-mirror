X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 9 Dec 2006 10:04:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612090957360.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
 <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com>
 <200612091251.16460.jnareb@gmail.com> <457AAF31.2050002@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 18:05:15 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457AAF31.2050002@garzik.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33826>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt6ZQ-0001iS-22 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 19:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761809AbWLISE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 13:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761811AbWLISE6
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 13:04:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37509 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1761809AbWLISE5
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 13:04:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB9I4BID029038
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 9
 Dec 2006 10:04:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB9I4AZ9032469; Sat, 9 Dec
 2006 10:04:10 -0800
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org



On Sat, 9 Dec 2006, Jeff Garzik wrote:
> 
> It is.  At least for kernel.org, the issue isn't that CGI is expensive, its
> that I/O is expensive.

Note that if we had a new gitweb, we could also used the packed refs. 
Those help CPU usage, but they actually help IO patterns more, exactly 
because they avoid all the seeking around in the filesystem.

So with packed refs, there's no need to go from directory lookup to inode 
lookup to data lookup to object lookup for *each* ref - you can do the 
"packed-refs" lookup _once_ (which obviously does the dir->inode->data), 
and you don't need to do the object lookup at all.

Of course, gitweb will then end up doing the object lookup anyway (because 
of getting the dates etc for refs), but if you have packed-refs and a 
reasonably packed repository, that should still really cut down on IO in a 
big way.

So there's probably tons of room for making this more efficient: using a 
newer gitweb, packing refs, using the cgi cache thing.. It sounds like 
what it really needs is just somebody with the competence and time to be 
willing to step up and maintain gitweb on kernel.org...

