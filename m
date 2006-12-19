X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Mon, 18 Dec 2006 22:51:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org>
 <20061219063930.GA2511@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 06:51:44 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219063930.GA2511@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34790>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwYp6-0005Sc-91 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 07:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752928AbWLSGvd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 01:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbWLSGvd
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 01:51:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59035 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752903AbWLSGvc
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 01:51:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBJ6pLID018791
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 18
 Dec 2006 22:51:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBJ6pJb3025434; Mon, 18 Dec
 2006 22:51:20 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Shawn Pearce wrote:
> 
> Why isn't git-index-pack doing the same?  Is there some hidden glitch
> in some OS somewhere that has a problem with overmapping a file and
> appending into it via write()?  I've done that on Mac OS X, Linux,
> BSDi, Solaris...  never had a problem.

It works on modern systems, but at least old HPUX versions had 
non-coherent mmap() and write(), and POSIX does not guarantee it. And if 
you ever want to port to Windows, I don't think you should do it.

Anyway, try the pread() version first, see if that fixes the OS X problem.

