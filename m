From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Solaris test t5500 race condition
Date: Thu, 13 Apr 2006 22:03:44 -0700
Message-ID: <24787.1144991024@lotus.CS.Berkeley.EDU>
References: <20060414031759.GA9524@bohr.gbar.dtu.dk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 07:04:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUGTQ-0007xT-Bw
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 07:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWDNFDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 01:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWDNFDs
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 01:03:48 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:6561 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S965096AbWDNFDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 01:03:47 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k3E53jgH024792;
	Thu, 13 Apr 2006 22:03:45 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k3E53j4W024791;
	Thu, 13 Apr 2006 22:03:45 -0700 (PDT)
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-reply-to: <20060414031759.GA9524@bohr.gbar.dtu.dk> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18684>

And "Peter Eriksen" writes:
 - I've found a race in t5500-fetch-pack.sh.

Crap.  I ran into this on AIX a while ago; I was hoping no
other systems would see it.  There are no guarantees that 
the two processes' outputs will be mutually line buffered.
Luckily, it's just a cosmetic problem, but it does cause 
that test case to fail.

I know how to fix it (imho), but have no time to implement
it.  There needs to be a separate communication stage after 
negotiating the objects and before dumping the pack.  During
that stage, upload-pack would just send progress notices to 
the caller.  Only the caller would communicate to the terminal.
Some other ideas are in
  http://marc.theaimsgroup.com/?l=git&m=114357528512063&w=2

Jason
