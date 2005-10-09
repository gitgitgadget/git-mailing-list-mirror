From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Seeing various mode changes on cygwin
Date: Sat, 8 Oct 2005 19:19:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
 <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 04:20:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOQmz-0006yV-Qm
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 04:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVJICTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 22:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVJICTq
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 22:19:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932204AbVJICTq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 22:19:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j992Jc4s029014
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 8 Oct 2005 19:19:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j992JZWG022604;
	Sat, 8 Oct 2005 19:19:37 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9858>



On Sat, 8 Oct 2005, Junio C Hamano wrote:
>
> Alex Riesen <raa.lkml@gmail.com> writes:
> > These are not real attributes, cygwin emulates them from the names,
> > like .exe will always be 0755, for example.
> 
> Ouch.  Is this true in general, or only on FAT-derived
> filesystems?
> 
> We may need to worry about this on the core side after all.
> Some people need to mount FAT even on Linux systems, 

I think we might want to have a flag that says "don't care about 
filesystem modes". That should be pretty easy, I think we'd get most of 
them by just adding some logic to "ce_match_stat()".

Then add a "git chmod" to set the mode in the index (which should end up 
being just a wrapper around the regular "git-update-index" using the 
"--cacheinfo" flag, I think).

Those parts should be trivial.

The more interesting issue is how to set the _flag_ that we should do 
this. We may have to add a config file, and it should be per-repository 
(ie something like ".git/config" or ".git/info/config"). Or do we just do 
yet another environment variable?

		Linus
