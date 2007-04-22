From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] plumber's puzzle
Date: Sun, 22 Apr 2007 16:03:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704221546160.9964@woody.linux-foundation.org>
References: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221341080.9964@woody.linux-foundation.org>
 <7vps5wkph5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 01:03:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfl5u-0006oy-Rw
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 01:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030951AbXDVXD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030952AbXDVXD0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 19:03:26 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:45158 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030951AbXDVXDZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2007 19:03:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3MN3LDP001334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Apr 2007 16:03:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3MN3KBD002930;
	Sun, 22 Apr 2007 16:03:21 -0700
In-Reply-To: <7vps5wkph5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.539 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45286>



On Sun, 22 Apr 2007, Junio C Hamano wrote:
> 
> I should be happy that I figured out what is going on, but I am
> not very happy with this patch.

That actually looks like the right patch.

The "fflush() before fork()" thing is a real issue, and a real bug. Stdio 
is buffered, and yes, fork() will duplicate the buffer if not flushed.

Of course, I'm not 100% sure that is the right _place_ for the fflush() 
call. I wonder if we should just do the fflush() closer to the place that 
generates the data. As it is, we may have other things like that lurking.

Of course, delaying the fflush as long as possible is likely good for 
performance, so doing it just before the fork() (even if it may be ugly 
and somewhat unexpected at that point to have to do it) may just be the 
right thing regardless...

		Linus
