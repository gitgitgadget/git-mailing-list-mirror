From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix diff-delta bad memory access
Date: Wed, 10 May 2006 10:18:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605101015060.3718@g5.osdl.org>
References: <Pine.LNX.4.64.0605101216360.24505@localhost.localdomain>
 <Pine.LNX.4.64.0605100953090.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 10 19:20:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdsMR-0003ia-HZ
	for gcvg-git@gmane.org; Wed, 10 May 2006 19:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWEJRUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 13:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWEJRUX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 13:20:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965018AbWEJRUV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 13:20:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4AHIXtH005304
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 May 2006 10:18:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4AHIUNk019311;
	Wed, 10 May 2006 10:18:30 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605100953090.3718@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19890>



On Wed, 10 May 2006, Linus Torvalds wrote:
> 
> Yeah, that was totally bogus. It would re-allocate _part_ of an 
> allocation, but that allocation contained not just the index, but all the 
> hashes and the hash entries too!

Actually, no, you got that part right. Mea culpa. It really only ended up 
being a problem when the area was moved, since the pointers into that area 
weren't updated.

The alignment issue is real, but looking at the different structures, 
they'll all have pointers that end up being the real (and only) alignment 
constraint, so as a result, on any reasonable machine they all have the 
same alignment and things are fine.

Junio - pls apply Nico's patch asap. It's correct, and fixes a really 
nasty problem. And I'll withdraw my other worries as "not consequential".

		Linus
