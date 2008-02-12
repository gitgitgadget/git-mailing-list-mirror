From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 13:08:30 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121303450.2920@woody.linux-foundation.org>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home> <alpine.LSU.1.00.0802101640570.11591@racer.site> <alpine.LSU.1.00.0802101845320.11591@racer.site>
 <alpine.LSU.1.00.0802122036150.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2Oc-0007Sn-O6
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761751AbYBLVJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760884AbYBLVJm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:09:42 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47175 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760621AbYBLVJl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 16:09:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CL8V6G008311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 13:08:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CL8UOk022274;
	Tue, 12 Feb 2008 13:08:30 -0800
In-Reply-To: <alpine.LSU.1.00.0802122036150.3870@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.738 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73691>



On Tue, 12 Feb 2008, Johannes Schindelin wrote:
> 
> I made the window much smaller (512 megabyte), and it still runs, after 27 
> hours:

I'd suggest making the memory window smaller yet. 

512MB is a *big* amount of memory, if you fill it up, and end up using an 
O(n**2) algorithm on the objects within the window (which it is: the 
repacking algorithm is O(n) in _total_ objects, but the constant part is 
basically O(winsize^2).

I'd suggest that a reasonable window memory limit is around just a few 
megabytes (eg 4MB to maybe 64MB). If you have "normal" source files, 
you're still going to be limited by the window _count_ size (assume normal 
source files are in the few tens of kB), and for those occasional large 
files, you'd better hope that the sort heursistics are good enough.

			Linus
